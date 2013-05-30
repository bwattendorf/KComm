unit pskbrowser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Grids, ExtCtrls, StdCtrls, Buttons, Menus;

const
  numPSKChannels = 24;

type

  { TfrmPSKBrowser }

  TfrmPSKBrowser = class(TForm)
    cbPSKReporter: TCheckBox;
    cbSpotHist: TCheckBox;
    StatusBar: TLabel;
    pnStatus: TPanel;
    sgBrowser: TStringGrid;
    Timer: TTimer;
    procedure cbPSKReporterClick(Sender: TObject);
    procedure cbSpotHistClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgBrowserClick(Sender: TObject);
    procedure sgBrowserDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { private declarations }
    chantxt: array[1..numPSKChannels] of string;
    chancall: array[1..numPSKChannels] of string;
    chanfrq: array[1..numPSKChannels] of integer;
    chanact: array[1..numPSKChannels] of integer;
    sbcnt: integer;
    procedure InitChannel(channel: integer; delta: integer = -50);
  public
    { public declarations }
    procedure InitAllChannels;
    procedure AddChar(ch: char; channel: integer);
  end;

var
  frmPSKBrowser: TfrmPSKBrowser;

implementation

{ TfrmPSKBrowser }

uses
  Config, PSK31Core, Utils, Main, Countries, Reporter, PSKReporter;

procedure TfrmPSKBrowser.FormCreate(Sender: TObject);
begin
  Font := frmMain.Font;
end;

procedure TfrmPSKBrowser.FormShow(Sender: TObject);
begin
	GetFormPositionFromConfigFile(sConfigRoot,'PSKBrowserWinPos',frmPSKBrowser);
  sgBrowser.RowCount := numPSKChannels;
  sgBrowser.Selection := TGridRect(Rect(-1, -1, -1, -1));
  cbPSKReporter.Checked := GetValueFromConfigFile(sConfigRoot,'PSK31_Reporter',false);
  Delay(10);
  cbSpotHist.Enabled := cbPSKReporter.Checked;
  if cbPSKReporter.Checked then
    cbSpotHist.Checked := GetValueFromConfigFile(sConfigRoot,'Spot_History',false);
  InitAllChannels;
end;

procedure TfrmPSKBrowser.sgBrowserClick(Sender: TObject);
var
  channel: integer;
  call,prefix,country,continent,cqzone,ituzone: string;
  lat,lon,range,bearing: extended;
begin
  channel := sgBrowser.Row + 1;
  call := chancall[channel];
  if not ValidCall(call) then Exit;
  if ctydatavailable then
  begin
    if FindCountry(call,prefix,country,continent,cqzone,ituzone,lat,lon) then
    begin
      PathCalc(mylat,mylon,lat,lon,false,range,bearing);
      StatusBar.Caption := Format('%s: %s (%s) CQ: %s ITU: %s QRB: %4.0fkm  QTF: %3.0f%s',[prefix,country,continent,cqzone,ituzone,range,bearing,sDeg]);
      StatusBar.Hint := StatusBar.Caption;
      sbcnt := 10;
    end;
  end;
end;

procedure TfrmPSKBrowser.sgBrowserDblClick(Sender: TObject);
var
  channel: integer;
begin
  channel := sgBrowser.Row + 1;
  fnSetRXFrequency(fnGetRXFrequency(channel),0,0);
  with frmMain do
  begin
    cbTXLock.Checked := false;
    cbTXLock2.Checked := false;
    edCall.Text := chancall[channel];
    if chancall[channel] <> '' then
    begin
      edName.Text := '';
      edQTH.Text := '';
      edGrid.Text := '';
      edNotes.Text := '';
      edCallExit(Sender);
    end;
  end;
  fnRewindInput(40);
end;

procedure TfrmPSKBrowser.InitChannel(channel: integer; delta: integer = -50);
var
  f: integer;
const
  df = 30;
begin
  f := channel * 100 + 300 + delta;
  if (channel > 1) and ((f - chanfrq[channel - 1]) < df) then f := f + df;
  if (channel < numPSKChannels) and ((chanfrq[channel + 1] - f) < df) then f := f - df;
  fnSetRXFrequency(f, 40, channel);
  chanfrq[channel] := f;
  if delta = -50 then
  begin
    chantxt[channel] := '';
    chancall[channel] := '';
    sgBrowser.Cells[0,channel-1] := '';
    sgBrowser.Cells[1,channel-1] := '';
    sgBrowser.Cells[2,channel-1] := '';
    fnSetRXPSKMode(0, channel);
    fnSetAFCLimit(50, channel);
    fnEnableRXChannel(channel, true);
  end;
end;

procedure TfrmPSKBrowser.InitAllChannels;
var
  n: integer;
begin
  if not Assigned(frmPSKBrowser) then Exit;
  for n := 1 to numPSKChannels do
  begin
    InitChannel(n);
    chanact[n] := 0;
  end;
  sbcnt := 0;
end;

procedure TfrmPSKBrowser.TimerTimer(Sender: TObject);
var
  n, cn: integer;
begin
  for n := 1 to numPSKChannels do
  begin
    cn := chanact[n] + 1;
    chanact[n] := cn;
    if (cn > 15) or ((n > 1) and (Abs(chanfrq[n]-chanfrq[n-1]) < 10)) then
    begin
      InitChannel(n);
      chanact[n] := 0;
    end
    else if ((cn mod 2) = 0) and (chantxt[n] = '') then
      InitChannel(n, ((cn * 30) mod 100 )- 50);
  end;
  Dec(sbcnt);
  if sbcnt = 0 then
    StatusBar.Caption := '';
end;

procedure TfrmPSKBrowser.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
var
  n: integer;
begin
  if not Assigned(frmPSKBrowser) then Exit;
  for n := 1 to numPSKChannels do
    fnEnableRXChannel(n, false);
  SaveValueToConfigFile(sConfigRoot,'PSK31_Reporter',cbPSKReporter.Checked);
  SaveValueToConfigFile(sConfigRoot,'Spot_History',cbSpotHist.Checked);
  SaveFormPositionToConfigFile(sConfigRoot,'PSKBrowserWinPos',frmPSKBrowser);
  CloseAction := caFree;
  frmPSKBrowser := nil;
end;

procedure TfrmPSKBrowser.cbPSKReporterClick(Sender: TObject);
begin
  if not Assigned(frmReporter) then
    frmReporter := TfrmReporter.Create(frmMain);
  cbSpotHist.Enabled := cbPSKReporter.Checked;
end;

procedure TfrmPSKBrowser.cbSpotHistClick(Sender: TObject);
begin
  if Assigned(frmReporter) then
    if cbSpotHist.Checked then
      frmReporter.Show
    else
      frmReporter.Hide;
end;

procedure TfrmPSKBrowser.AddChar(ch: char; channel: integer);
var
  p: integer;
  s, fs, call: string;
  f: extended;
begin
  if channel > numPSKChannels then Exit;
  if ch in[#13,#32..#255] then
  begin
    // calculate and update frequency
    chanfrq[channel] := fnGetRxFrequency(channel);
    f := frmMain.TrueFrequency(chanfrq[channel]);
    fs := Format('%4.6f',[f/1000.0]);
    p := Pos(DecimalSeparator,fs);
    if p > 0 then
      Insert(' ',fs,p+4);
    sgBrowser.Cells[0,channel-1] := fs;
    // update channel text
    if ch = #13 then ch := ' ';
    if ch > #127 then
      s := chantxt[channel]+StrToUTF8(ch,0 {rxcharset})
    else if ch >= #32 then
      s := chantxt[channel]+ch;
    chantxt[channel] := s;
    // parse channel text for call
    if ParseFromText('CQ','DE','DE','DX',s,call,true) and ValidCall(call)
      and (chancall[channel] <> call) then
    begin
      chancall[channel] := call;
      if cbPSKReporter.Checked then
        frmReporter.SendSpot(call,'BPSK31',f,REPORTER_SOURCE_AUTOMATIC);
    end;
    if Length(chantxt[channel]) > 32 then
      Delete(chantxt[channel],1,1);
    if Length(chancall[channel]) > 0 then
      sgBrowser.Cells[1,channel-1] := chancall[channel];
    sgBrowser.Cells[2,channel-1] := chantxt[channel];
    chanact[channel] := 0;
  end;
end;

initialization
  {$I pskbrowser.lrs}

end.

