unit psk31core;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

//  Supports using PSK31 Core DLL for PSK31 TX/RX.   ** WINDOWS ONLY **         //

// *** IMPORTANT ************************************************************** //
// This unit requires LCL to be rebuilt with PassWin32MessagesToLCL defined     //
// This allows the use of user messages greater then WM_USER + 32               //
//                                                                              //
// * In Tools -> Configure "Build Lazarus" -> Advanced Build Options            //
// * set option: -dPassWin32MessagesToLCL                                       //
// * select Clean and Build                                                     //
// * click Build                                                                //
// **************************************************************************** //

interface

{$IFDEF WINDOWS}
uses
  Windows, Classes, SysUtils;
{$ENDIF}

function InitPSK31Core: boolean;
procedure UnInitPSK31Core;

{$IFDEF WINDOWS}
type
	// Data types used by the DLL
	TFFTData = array[0 .. 1023] of integer;
  PFFTData = ^TFFTData;

  TVectorData = array[0 .. 15] of integer;
  PVectorData = ^TVectorData;

  TSyncData = array[0 .. 15] of integer;
  PSyncData = ^TSyncData;

	TRawData = array[0 .. 2047] of integer;
  PRawData = ^TRawData;
  
  // exported functions
  TGetDLLVersion = function():integer; stdcall;
  TGetErrorString = procedure(ErrorStr: PChar); stdcall;
  //  Initialization / shutdown functions
  TStartSoundCard = function(h_Wnd: hWnd; cardnum, numRXchannels: integer): integer; stdcall;
  TStartRXTXSoundCard = function(h_Wnd: hWnd; RXcardnum, TXcardnum, numRXchannels: integer): integer; stdcall;
  TStopSoundCard = procedure(); stdcall;
  //	Receive functions
  TEnableRXChannel = function(channel: integer; enable: boolean): integer; stdcall;
  TSetRXFrequency = procedure(freq, range, channel: integer); stdcall;
  TSetRXPSKMode = procedure(mode, chan: integer); stdcall;
  TGetRXFrequency = function(channel: integer): integer; stdcall;
  TSetFFTMode = procedure(ave, maxscale, mode: integer); stdcall;
  TGetFFTData = function(DataArray: PFFTData; startpos, endpos: integer): boolean; stdcall;
  TGetSyncData = procedure(SyncArray: PSyncData; channel: integer); stdcall;
  TGetVectorData = procedure(VectorArray: PVectorData; channel: integer); stdcall;
  TGetRawData = function(DataArray: PRawData; startpos, endpos: integer): integer; stdcall;
  TSetAFCLimit = procedure(limit, channel: integer); stdcall;
  TSetSquelchThreshold = procedure(thresh, mode, channel: integer); stdcall;
  TGetSignalLevel = function(channel: integer): integer; stdcall;
  TRewindInput = procedure(blocks: integer); stdcall;
  //  Transmit functions
  TStartTX = procedure(mode: integer); stdcall;
  TStopTX = procedure(); stdcall;
  TAbortTX = procedure(); stdcall;
  TSetTXFrequency = procedure(freq: integer); stdcall;
  TSetCWIDString = procedure(lpszIDStrg: PChar); stdcall;
  TSetCWIDSpeed = procedure(speed: integer); stdcall;
  TSendTXCharacter = function(txchar, cntrl: integer): integer; stdcall;
  TSendTXString = procedure(lpszTXStrg: PChar); stdcall;
  TGetTXCharsRemaining = function():integer; stdcall;
  TClearTXBuffer = procedure(); stdcall;
  TSetComPort = function(portnum, mode: integer): boolean; stdcall;
  TSetClockErrorAdjustment = procedure(ppm: integer); stdcall;
{$ENDIF}

{$IFDEF WINDOWS}
const
	// Windows messages sent by the DLL
	MSG_DATARDY = WM_USER+1000;					// Sent whenever FFT or raw data available from the soundcard
  MSG_PSKCHARRDY = WM_USER+1001;			// Sent whenever a character has been received or sent
  MSG_STATUSCHANGE = WM_USER + 1002;  // Sent whenever a status change occurs in the DLL
  MSG_IMDRDY = WM_USER + 1003;				// Sent when an IMD reading has been calculated
  MSG_CLKERR = WM_USER + 1004;				// Sent when a sound card clock error has been calculated
{$ENDIF}

var
{$IFDEF WINDOWS}
  fnGetDLLVersion: TGetDLLVersion = nil;
  fnGetErrorString: TGetErrorString = nil;
  fnStartSoundCard: TStartSoundCard = nil;
  fnStartRXTXSoundCard: TStartRXTXSoundCard = nil;
  fnStopSoundCard: TStopSoundCard = nil;
  fnEnableRXChannel: TEnableRXChannel = nil;
  fnSetRXFrequency: TSetRXFrequency = nil;
  fnSetRXPSKMode: TSetRXPSKMode = nil;
  fnGetRXFrequency: TGetRXFrequency = nil;
  fnSetFFTMode: TSetFFTMode = nil;
  fnGetFFTData: TGetFFTData = nil;
  fnGetSyncData: TGetSyncData = nil;
  fnGetVectorData: TGetVectorData = nil;
  fnGetRawData: TGetRawData = nil;
  fnSetAFCLimit: TSetAFCLimit = nil;
  fnSetSquelchThreshold: TSetSquelchThreshold = nil;
  fnGetSignalLevel: TGetSignalLevel = nil;
  fnRewindInput: TRewindInput = nil;
  fnStartTX: TStartTX = nil;
  fnStopTX: TStopTX = nil;
  fnAbortTX: TAbortTX = nil;
  fnSetTXFrequency: TSetTXFrequency = nil;
  fnSetCWIDString: TSetCWIDString = nil;
  fnSendTXCharacter: TSendTXCharacter = nil;
  fnSendTXString: TSendTXString = nil;
  fnGetTXCharsRemaining: TGetTXCharsRemaining = nil;
  fnClearTXBuffer: TClearTXBuffer = nil;
  fnSetCWIDSpeed: TSetCWIDSpeed = nil;
  fnSetComPort: TSetComPort = nil;
  fnSetClockErrorAdjustment: TSetClockErrorAdjustment = nil;
{$ENDIF}
  
  psk31coreavailable: boolean = false;  // DLL is available
  psk31coreready: boolean = false;      // DLL is loaded and ready for use
  psk31coreversion: integer = 0;        // DLL version number
  usepsk31core: boolean = false;        // DLL should be used
  
  psk31txmode: integer;                 // 0 - BPSK31; 8 - BPSK63; etc.

//  Function prototypes for the PSKCORE DLL
//  =======================================
//
//  Initialization / shutdown functions
//
//  function fnStartSoundCard(h_Wnd: hWnd; cardnum, numRXchannels: integer): integer; stdcall;
//  function fnStartRXTXSoundCard(h_Wnd: hWnd; RXcardnum, TXcardnum, numRXchannels: integer): integer; stdcall;
//	procedure fnStopSoundCard; stdcall;
//
//	Receive functions
//
//  function fnEnableRXChannel(channel: integer; enable: boolean): integer; stdcall;
//	procedure fnSetRXFrequency(freq, range, channel: integer); stdcall;
//	procedure fnSetRXPSKMode(mode, chan: integer); stdcall;
//	function fnGetRXFrequency(channel: integer): integer; stdcall;
//	procedure fnSetFFTMode(ave, maxscale, mode: integer); stdcall;
//	function fnGetFFTData(DataArray: PFFTData; startpos, endpos: integer): boolean; stdcall;
//  procedure fnGetSyncData(SyncArray: PSyncData; channel: integer); stdcall;
//  procedure fnGetVectorData(VectorArray: PVectorData; channel: integer); stdcall;
//  function fnGetRawData(DataArray: PRawData; startpos, endpos: integer): integer; stdcall;
//  procedure fnSetAFCLimit(limit, channel: integer); stdcall;
//  procedure fnSetSquelchThreshold(thresh, mode, channel: integer); stdcall;
//  function fnGetSignalLevel(channel: integer): integer; stdcall;
//
//  Transmit functions
//
//	procedure fnStartTX(mode: integer); stdcall;
//  procedure fnStopTX; stdcall;
//  procedure fnAbortTX; stdcall;
//  procedure fnSetTXFrequency(freq: integer); stdcall;
//  procedure fnSetCWIDString(lpszIDStrg: PChar); stdcall;
//  function fnSendTXCharacter(txchar, cntrl: integer): integer; stdcall;
//  procedure fnSendTXString(lpszTXStrg: PChar); stdcall;
//  function fnGetTXCharsRemaining: integer; stdcall;
//  procedure fnClearTXBuffer; stdcall;
//  procedure fnSetCWIDSpeed(speed: integer); stdcall;
//  function fnSetComPort(portnum, mode: integer): boolean; stdcall;
//
//  Miscellaneous functions
//  procedure fnSetClockErrorAdjustment(ppm: integer); stdcall;
//  function fnGetDLLVersion: integer; stdcall;



implementation

const
 sPSKCoreDLL = 'PSKCORE.DLL';

{$IFDEF WINDOWS}
var
 FLibHandle: THandle = 0;
{$ENDIF}

function InitPSK31Core: boolean;
begin
  Result := false;
{$IFDEF WINDOWS}
  if FLibHandle = 0 then
  begin
    FLibHandle := LoadLibrary(sPSKCoreDLL);
    if FLibHandle <> 0 then
    begin
      Pointer(fnGetDLLVersion) := GetProcAddress(FLibHandle, 'fnGetDLLVersion');
      Pointer(fnGetErrorString) := GetProcAddress(FLibHandle, 'fnGetErrorString');
      Pointer(fnStartSoundCard) := GetProcAddress(FLibHandle, 'fnStartSoundCard');
      Pointer(fnStartRXTXSoundCard) := GetProcAddress(FLibHandle, 'fnStartRXTXSoundCard');
      Pointer(fnStopSoundCard) := GetProcAddress(FLibHandle, 'fnStopSoundCard');
      Pointer(fnEnableRXChannel) := GetProcAddress(FLibHandle, 'fnEnableRXChannel');
      Pointer(fnSetRXFrequency) := GetProcAddress(FLibHandle, 'fnSetRXFrequency');
      Pointer(fnSetRXPSKMode) := GetProcAddress(FLibHandle, 'fnSetRXPSKMode');
      Pointer(fnGetRXFrequency) := GetProcAddress(FLibHandle, 'fnGetRXFrequency');
      Pointer(fnSetFFTMode) := GetProcAddress(FLibHandle, 'fnSetFFTMode');
      Pointer(fnGetFFTData) := GetProcAddress(FLibHandle, 'fnGetFFTData');
      Pointer(fnGetSyncData) := GetProcAddress(FLibHandle, 'fnGetSyncData');
      Pointer(fnGetVectorData) := GetProcAddress(FLibHandle, 'fnGetVectorData');
      Pointer(fnGetRawData) := GetProcAddress(FLibHandle, 'fnGetRawData');
      Pointer(fnSetAFCLimit) := GetProcAddress(FLibHandle, 'fnSetAFCLimit');
      Pointer(fnSetSquelchThreshold) := GetProcAddress(FLibHandle, 'fnSetSquelchThreshold');
      Pointer(fnGetSignalLevel) := GetProcAddress(FLibHandle, 'fnGetSignalLevel');
      Pointer(fnRewindInput) := GetProcAddress(FLibHandle, 'fnRewindInput');
      Pointer(fnStartTX) := GetProcAddress(FLibHandle, 'fnStartTX');
      Pointer(fnStopTX) := GetProcAddress(FLibHandle, 'fnStopTX');
      Pointer(fnAbortTX) := GetProcAddress(FLibHandle, 'fnAbortTX');
      Pointer(fnSetTXFrequency) := GetProcAddress(FLibHandle, 'fnSetTXFrequency');
      Pointer(fnSetCWIDString) := GetProcAddress(FLibHandle, 'fnSetCWIDString');
      Pointer(fnSendTXCharacter) := GetProcAddress(FLibHandle, 'fnSendTXCharacter');
      Pointer(fnSendTXString) := GetProcAddress(FLibHandle, 'fnSendTXString');
      Pointer(fnGetTXCharsRemaining) := GetProcAddress(FLibHandle, 'fnGetTXCharsRemaining');
      Pointer(fnClearTXBuffer) := GetProcAddress(FLibHandle, 'fnClearTXBuffer');
      Pointer(fnSetCWIDSpeed) := GetProcAddress(FLibHandle, 'fnSetCWIDSpeed');
      Pointer(fnSetComPort) := GetProcAddress(FLibHandle, 'fnSetComPort');
      Pointer(fnSetClockErrorAdjustment) := GetProcAddress(FLibHandle, 'fnSetClockErrorAdjustment');
      Result := Assigned(fnGetDLLVersion)
        and Assigned(fnGetErrorString)
        and Assigned(fnStartSoundCard)
        and Assigned(fnStartRXTXSoundCard)
        and Assigned(fnStopSoundCard)
        and Assigned(fnEnableRXChannel)
        and Assigned(fnSetRXFrequency)
        and Assigned(fnSetRXPSKMode)
        and Assigned(fnGetRXFrequency)
        and Assigned(fnSetFFTMode)
        and Assigned(fnGetFFTData)
        and Assigned(fnGetSyncData)
        and Assigned(fnGetVectorData)
        and Assigned(fnGetRawData)
        and Assigned(fnSetAFCLimit)
        and Assigned(fnSetSquelchThreshold)
        and Assigned(fnGetSignalLevel)
        and Assigned(fnRewindInput)
        and Assigned(fnStartTX)
        and Assigned(fnStopTX)
        and Assigned(fnAbortTX)
        and Assigned(fnSetTXFrequency)
        and Assigned(fnSetCWIDString)
        and Assigned(fnSendTXCharacter)
        and Assigned(fnSendTXString)
        and Assigned(fnGetTXCharsRemaining)
        and Assigned(fnClearTXBuffer)
        and Assigned(fnSetCWIDSpeed)
        and Assigned(fnSetComPort)
        and Assigned(fnSetClockErrorAdjustment);
    end;
  end
  else
    Result := true;
{$ENDIF}
  psk31coreavailable := Result;
  psk31coreready := Result;
  if Result then
    psk31coreversion := fnGetDLLVersion();
end;

procedure UnInitPSK31Core;
begin
{$IFDEF WINDOWS}
  if FLibHandle <> 0 then
    FreeLibrary(FLibHandle);
  FLibHandle := 0;
{$ENDIF}
  psk31coreready := false;
end;

initialization

finalization
{$IFDEF WINDOWS}
  UnInitPSK31Core;
{$ENDIF}
end.

