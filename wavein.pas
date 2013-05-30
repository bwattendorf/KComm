unit wavein;

// Attempt at threaded version. Requires CThreads.
// Waterfall update worked OK but error occurred

{*
  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details
*}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLType,
  {$IFDEF WINDOWS}
    MMSystem, Windows, Messages,
  {$ELSE}
    BaseUnix, ExtCtrls, CThreads,
  {$ENDIF}
  Forms, Dialogs;

const
  NUM_SAMPLES = 1024;             // Size of buffer for signal samples
  DSP_BITS = 8;                   // bits per sample ** ONLY 8 BITS SUPPORTED **
  NUM_CHN = 1;                    // mono

type
  {$IFDEF WINDOWS}
  EWaveIn = Class(Exception);
  {$ENDIF}
  TBufferFullEvent = procedure(Data : Pointer; Size:longint) of object;
  TSampleBuffer = array[0..NUM_SAMPLES-1] of Integer;
  PSampleBuffer = ^TSampleBuffer;
  TSampleBufferCount = 2..64;

  {$IFNDEF WINDOWS}
  TInputThread = class(TThread)
  protected
    procedure Execute; override;
  public
    DSP_Dev: integer;
    pSamp_Buf: PSampleBuffer;
    OnBufFull: TBufferFullEvent;
    constructor Create;
    procedure BufFull;
  end;
  {$ENDIF}

type
  TWaveIn = class(TObject)
  private
    {$IFDEF WINDOWS}
    FWaveDevice: Integer;
    FWaveIn: HWaveIn;
    FWindowHandle: HWnd;
    FBufferList: TList;
    FBufferSize: DWord;
    FNumBuffers: TSampleBufferCount;
    {$ELSE}
    FDSPDevice: string;
    FDSPIn: integer;
    InputThread: TInputThread;
    FStopInput: boolean;
    FSampleBuffer: TSampleBuffer;
    {$ENDIF}
    FNumSamples: integer;
    FActive: boolean;
    FError: Boolean;
    FOnBufferFull: TBufferFullEvent;
    {$IFDEF WINDOWS}
    procedure DoBufferFull(Header : PWaveHdr);
    procedure SetBufferSize(const Value: DWord);
    procedure SetNumBuffers(const Value: TSampleBufferCount);
    {$ENDIF}
  protected
    FSampleRate: Integer;
    {$IFDEF WINDOWS}
    function  NewHeader: PWaveHdr;
    procedure DisposeHeader(Header: PWaveHdr);
    procedure WndProc(Var Message: TMessage);
    procedure RaiseException(const aMessage: string; Result : integer);
    {$ELSE}
    procedure ThreadTerminated(Sender: TObject);
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    function Open: boolean;
    function Start: boolean;
    procedure Stop;
    procedure Close;
    {$IFDEF WINDOWS}
    property SoundCard: integer read FWaveDevice write FWaveDevice;
//    property BufferSize: DWord   read FBufferSize write SetBufferSize;
//    property NumBuffers: TSampleBufferCount read FNumBuffers write SetNumBuffers;
    {$ELSE}
    property DSPDevice: string read FDSPDevice write FDSPDevice;
    {$ENDIF}
    property SampleRate: integer read FSampleRate write FSampleRate;
    property NumSamples: integer read FNumSamples;
    property Active: boolean read FActive write FActive;
    property Error: boolean read FError;
    property OnBufferFull: TBufferFullEvent read FOnBufferFull write FOnBufferFull;
  end;

implementation

{$IFDEF WINDOWS}
// Utility window for callback messages
var
  UtilWindowClass: TWndClass = (
    style: 0;
    lpfnWndProc: @DefWindowProc;
    cbClsExtra: 0;
    cbWndExtra: 0;
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'LazUtilWindow');

function AllocateHWnd(Method: TWndMethod): HWND;
var
  TempClass: TWndClass;
  ClassRegistered: Boolean;
begin
  UtilWindowClass.hInstance := HInstance;
  ClassRegistered := GetClassInfo(HInstance, UtilWindowClass.lpszClassName,
    TempClass);
  if not ClassRegistered or (TempClass.lpfnWndProc <> @DefWindowProc) then
  begin
    if ClassRegistered then
      Windows.UnregisterClass(UtilWindowClass.lpszClassName, HInstance);
    Windows.RegisterClass(UtilWindowClass);
  end;
  Result := CreateWindowEx(WS_EX_TOOLWINDOW, UtilWindowClass.lpszClassName,
    '', WS_POPUP, 0, 0, 0, 0, 0, 0, HInstance, nil);
  if Assigned(Method) then
    SetWindowLong(Result, GWL_WNDPROC, Longint(MakeObjectInstance(Method)));
end;

procedure DeallocateHWnd(Wnd: HWND);
var
  Instance: Pointer;
begin
  Instance := Pointer(GetWindowLong(Wnd, GWL_WNDPROC));
  DestroyWindow(Wnd);
  if DWord(Instance) <> DWord(@DefWindowProc) then FreeObjectInstance(Instance);
end;

// End of utility window code

constructor TWaveIn.Create;
begin
 inherited;
 FBufferList := TList.Create;
 FActive := False;
 FWaveDevice := -1;
 FSampleRate := 8000;
 FBufferSize := NUM_SAMPLES;
 FWaveIn := 0;
 FWindowHandle := AllocateHWND(@WndProc);
 FNumBuffers := 4;
end;

procedure TWaveIn.DoBufferFull(Header : PWaveHdr);
var
   Res                        : Integer;
   BytesRecorded              : Integer;
   Data                       : Pointer;
begin
  if Active then
  begin
    Res := WaveInUnPrepareHeader(FWaveIn,Header,sizeof(TWavehdr));
    if Res <>0  then RaiseException('WaveIn-UnprepareHeader', Res);

    BytesRecorded:=Header^.dwBytesRecorded;

    if assigned(FOnBufferFull) then
    begin
      Getmem(Data, BytesRecorded);
      try
        move(header^.lpData^,Data^,BytesRecorded);
        FOnBufferFull(Data, BytesRecorded);
      finally
        Freemem(Data);
      end;
    end;

    header^.dwbufferlength:=FBufferSize;
    header^.dwBytesRecorded:=0;
    header^.dwUser:=0;
    header^.dwflags:=0;
    header^.dwloops:=0;
    FillMemory(Header^.lpData,FBufferSize,0);

    Res := WaveInPrepareHeader(FWaveIn,Header,sizeof(TWavehdr));
    if Res <> 0 then RaiseException('WaveIn-PrepareHeader', Res);

    Res:=WaveInAddBuffer(FWaveIn,Header,sizeof(TWaveHdr));
    if Res <> 0 then RaiseException('WaveInAddBuffer', Res);

  end
  else
    DisposeHeader(Header);
end;

function TWaveIn.Open: boolean;
var
  open_status: MMRESULT;
  aFormat: TWaveFormatEx;
begin
  Result := FActive;
  if FActive then Exit;
  // fill in the TWaveFormatEx structure
  with aFormat do
  begin
    wFormatTag := wave_Format_PCM;
    nChannels := NUM_CHN;
    nSamplesPerSec := FSampleRate;
    wBitsPerSample := DSP_BITS;
    nBlockAlign := (DSP_BITS div 8)*NUM_CHN;
    nAvgBytesPerSec := FSampleRate * nBlockAlign;
    cbSize := SizeOf(TWaveFormatEx);
  end;
  if FWaveDevice < 0 then
  	open_status := WaveInOpen(@FWaveIn,WAVE_MAPPER,@aFormat,FWindowHandle,0,CALLBACK_WINDOW)
	else
  	open_status := WaveInOpen(@FWaveIn,FWaveDevice,@aFormat,FWindowHandle,0,CALLBACK_WINDOW or WAVE_MAPPED);
  if open_status <> MMSYSERR_NOERROR then
  begin
    FError := true;
    RaiseException('WaveIn-Open',open_status);
  end;
  Result := true;
end;

function TWaveIn.Start: boolean;
var
  i: integer;
  start_status: MMRESULT;
begin
  Result := false;
  if FWaveIn = 0 then
    if not Open then Exit;
  for i:= 1 to FNumBuffers do NewHeader;
  start_status := WaveInStart(FWaveIn);
  if start_status <> MMSYSERR_NOERROR then
    RaiseException('WaveIn-Start',start_status);
  FActive := true;
  Result := true;
end;

procedure TWaveIn.Stop;
var
  stop_status: MMRESULT;
begin
  if FActive and (FWaveIn <> 0) then
  begin
    stop_status := waveInStop(FWaveIn);
    if stop_status <> MMSYSERR_NOERROR then
      RaiseException('WaveIn-Stop',stop_status);
    FActive := false;
  end;
end;

destructor TWaveIn.Destroy;
begin
  if Active then Close;
  FBufferList.Free;
  DeAllocateHWND(FWindowHandle);
  inherited;
end;

const
  ACMERR_BASE        = 512;
  ACMERR_NOTPOSSIBLE = (ACMERR_BASE + 0);
  ACMERR_BUSY        = (ACMERR_BASE + 1);
  ACMERR_UNPREPARED  = (ACMERR_BASE + 2);

procedure TWaveIn.RaiseException(const aMessage: String; Result: Integer);
begin
  case Result of
    ACMERR_NotPossible : Raise EWaveIn.Create(aMessage + ' The requested operation cannot be performed.');
    ACMERR_BUSY : Raise EWaveIn.Create(aMessage + ' The conversion stream is already in use.');
    ACMERR_UNPREPARED : Raise EWaveIn.Create(aMessage + ' Cannot perform this action on a header that has not been prepared.');
    MMSYSERR_InvalFlag : Raise EWaveIn.Create(aMessage + ' At least one flag is invalid.');
    MMSYSERR_InvalHandle : Raise EWaveIn.Create(aMessage + ' The specified handle is invalid.');
    MMSYSERR_InvalParam : Raise EWaveIn.Create(aMessage + ' At least one parameter is invalid.');
    MMSYSERR_NoMem : Raise EWaveIn.Create(aMessage + ' The system is unable to allocate resources.');
    MMSYSERR_NoDriver : Raise EWaveIn.Create(aMessage + ' A suitable driver is not available to provide valid format selections.');
    MMSYSERR_ALLOCATED : Raise EWaveIn.Create(aMessage + ' The specified resource is already in use.');
    MMSYSERR_BADDEVICEID : Raise EWaveIn.Create(aMessage + ' The specified resource does not exist.');
    WAVERR_BADFORMAT : Raise EWaveIn.Create(aMessage + ' Unsupported audio format.');
    WAVERR_SYNC : Raise EWaveIn.Create(aMessage + ' The specified device does not support asynchronous operation.');
  else
    if Result <> 0 then
      Raise EWaveIn.Create(SysUtils.Format('%s raised an unknown error (code #%d)',[aMessage,Result]));
  end;
end;

procedure TWaveIn.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    MM_WIM_Data: DoBufferFull(PWaveHDR(Message.LParam));
  end;

end;

procedure TWaveIn.Close;
var
  X                           : Integer;
begin
  if not Active then Exit;
  Stop;
  FActive := False;
  WaveInReset(FWaveIn);
  WaveInClose(FWaveIn);
  FWaveIn := 0;
  For X:=FBufferList.Count-1 downto 0 do DisposeHeader(PWaveHDR(FBufferList[X]));
end;

procedure TWaveIn.SetBufferSize(const Value: DWord);
begin
  if Active then exit;
  FBufferSize := Value;
end;

function TWaveIn.NewHeader: PWaveHDR;
var
  Res                         : Integer;
begin
  Getmem(Result, SizeOf(TWaveHDR));
  FBufferList.Add(Result);
  with Result^ do begin
    Getmem(lpData,FBufferSize);
    dwBufferLength := FBufferSize;
    dwBytesRecorded := 0;
    dwFlags := 0;
    dwLoops := 0;
    Res := WaveInPrepareHeader(FWaveIn,Result,sizeof(TWaveHDR));
    if Res <> 0 then RaiseException('WaveIn-PrepareHeader',Res);

    Res := WaveInAddBuffer(FWaveIn,Result,SizeOf(TWaveHDR));
    if Res <> 0 then RaiseException('WaveIn-AddBuffer',Res);
  end;
end;

procedure TWaveIn.SetNumBuffers(const Value: TSampleBufferCount);
begin
  if Active then exit;
  FNumBuffers := Value;
end;

procedure TWaveIn.DisposeHeader(Header: PWaveHDR);
var
  X                           : Integer;
begin
  X := FBufferList.IndexOf(Header);
  if X < 0 then exit;
  Freemem(header^.lpData);
  Freemem(header);
  FBufferList.Delete(X);
end;

{$ELSE}

uses
  IOMacs;

const
  AFMT_U8     = 8;
  F_RDLCK = 0;

constructor TInputThread.Create;
begin
	FreeOnTerminate := true;
  pSamp_Buf := nil;
  OnBufFull := nil;
  inherited Create(true);
end;

procedure TInputThread.Execute;
var
  i, sample_cnt: integer;      // No. of samples read from DSP
  error: boolean;
  buffer: array[0..NUM_SAMPLES-1] of Byte;
begin
  error := false;
  while not (terminated or error) do
  begin
  	// Read audio samples from DSP
  	sample_cnt := FpRead(dsp_dev, buffer, NUM_SAMPLES);
    if sample_cnt = -1 then
    begin
      MessageDlg('Error reading from DSP device (1)',mtError, [mbOK], 0);
      error := true;
      Exit;
    end;
  	if sample_cnt <> NUM_SAMPLES then
    begin
      MessageDlg('Error reading from DSP device (2)',mtError, [mbOK], 0);
      error := true;
      Exit;
    end;
    // Transfer to integer buffer
    for i := 0 to NUM_SAMPLES - 1 do
      pSamp_Buf^[i] := buffer[i];
    if Assigned(OnBufFull) then
      Synchronize(@BufFull);
  end;
end;

procedure TInputThread.BufFull;
begin
  OnBufFull(pSamp_Buf,NUM_SAMPLES);
end;

constructor TWaveIn.Create;
begin
  FDSPDevice := '/dev/dsp';
  FDSPIn := 0;
  FSampleRate := 8000;
  FNumSamples := NUM_SAMPLES;
  FError := false;
  InputThread := nil;
  FOnBufferFull := nil;
  FActive := false;
end;

destructor TWaveIn.Destroy;
begin
  Close;
  FActive := false;
  inherited;
end;

function TWaveIn.Open: boolean;
var
	dsp_speed: integer;   // DSP sampling speed as in xdemorse.h
	frag_size: integer;   // DSP buffer (fragment) size in kb
	num_chan: integer;    // Number of channels
	sample_fmt: integer;  // DSP sample format, 8-bit unsigned
	itmp: integer;
  lockinfo: FLock;      // File lock information
begin
  Result := false;
  FError := true;
  // Try to open DSP device
  FDSPIn := FpOpen(PChar(FDSPDevice), O_RDONLY, 0);
  if FDSPIn = -1 then
  begin
    MessageDlg(Format('Cannot open DSP device %s',[FDSPDevice]),mtError, [mbOK], 0);
    Exit;
  end;
  // Try to lock entire DSP device file
  lockinfo.l_type   := F_RDLCK;
  lockinfo.l_whence := SEEK_SET;
  lockinfo.l_start  := 0;
  lockinfo.l_len    := 0;
  // If DSP device is already locked, abort
  if FpFcntl(FDSPIn, F_SETLK, lockinfo) < 0 then
  begin
    MessageDlg(Format('Lock %s: Device is locked by pid %d',[FDSPDevice,lockinfo.l_pid]),mtError, [mbOK], 0);
    Exit;
  end;
  // Set fragment size
  itmp := 1; frag_size := 0;
  num_chan := 1; // only mono supported
  while (itmp shl frag_size) <> NUM_SAMPLES do
    inc(frag_size);
  itmp := itmp + num_chan shl 18;
  if FpIoctl(FDSPIn, _SIOWR('P',10,SizeOf(integer)) {SNDCTL_DSP_SETFRAGMENT}, @frag_size) = -1 then
  begin
    MessageDlg('Failed to set DSP fragment size (1)',mtError, [mbOK], 0);
    Exit;
  end;
  // Set sample format to unsigned 8-bit,
  sample_fmt := AFMT_U8;
  if FpIoctl(FDSPIn, _SIOWR('P',5,SizeOf(integer)) {SNDCTL_DSP_SETFMT}, @sample_fmt) = -1 then
  begin
    MessageDlg('Failed to set DSP format: AFMT_U8 (1)',mtError, [mbOK], 0);
    Exit;
  end;
  if sample_fmt <> AFMT_U8 then
  begin
    MessageDlg('Failed to set DSP format: AFMT_U8 (2)',mtError, [mbOK], 0);
    Exit;
  end;
  // Set stereo/mono mode
  itmp := num_chan;
  if FpIoctl(FDSPIn,  _SIOWR('P',6,SizeOf(integer)) {SNDCTL_DSP_CHANNELS}, @itmp) = -1 then
  begin
    MessageDlg(Format('Failed to set DSP channels: %d',[num_chan]),mtError, [mbOK], 0);
    Exit;
  end;
  // Set DSP sampling speed
  dsp_speed := FSampleRate;
  if FpIoctl(FDSPIn,  _SIOWR('P',2,SizeOf(integer)) {SNDCTL_DSP_SPEED}, @dsp_speed) = -1 then
  begin
    MessageDlg(Format('Failed to set DSP speed: %d (1)',[FSampleRate]),mtError, [mbOK], 0);
    Exit;
  end;
  if dsp_speed <> FSampleRate then
  begin
    MessageDlg(Format('Failed to set DSP speed: %d (2)',[FSampleRate]),mtError, [mbOK], 0);
    Exit;
  end;
  //
  FError := false;
  FActive := false;
  Result := true;
end;

function TWaveIn.Start: boolean;
begin
  Result := false;
  if FDSPIn = 0 then
    if not Open then Exit;
  Result := true;
  FError := false;
  FStopInput := false;
  InputThread := TInputThread.Create;
  with InputThread do
  begin
    DSP_Dev := FDSPIn;
    pSamp_Buf := @FSampleBuffer;
    OnBufFull := FOnBufferFull;
    OnTerminate := @ThreadTerminated;
    FActive := true;
    Resume;
  end;
end;

procedure TWaveIn.Stop;
begin
  if Assigned(InputThread) then
    InputThread.Terminate;
end;

procedure TWaveIn.ThreadTerminated(Sender: TObject);
begin
  FActive := false;
end;

procedure TWaveIn.Close;
begin
  Stop;
  // Release sound devices
  if FDSPIn > 0 then
  begin
	  FpClose(FDSPIn);
  	FDSPIn := 0;
  end;
end;

{$ENDIF}

end.

