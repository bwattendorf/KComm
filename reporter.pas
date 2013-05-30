unit reporter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Menus, Buttons;

type

  { TfrmReporter }

  TfrmReporter = class(TForm)
    btnShowSpot: TSpeedButton;
    HistPopupMenu: TPopupMenu;
    lbStatus: TLabel;
    lbSpots: TListBox;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    mnuCopy: TMenuItem;
    mnuSaveToFile: TMenuItem;
    mnuSelectAll: TMenuItem;
    pnStatus: TPanel;
    SaveHistoryDialog: TSaveDialog;
    Timer: TTimer;
    procedure btnShowSpotClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuCopyClick(Sender: TObject);
    procedure mnuSaveToFileClick(Sender: TObject);
    procedure mnuSelectAllClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure SendSpot(call, mode: string; freq: extended; flag: DWORD);
  end;

var
  frmReporter: TfrmReporter;

implementation

uses
  Main, Utils, Config, PSKReporter, PSKBrowser, TimeZone, Clipbrd;

type
  PSpot = ^TSpot;
  TSpot = record
    spot_time: TDateTime;
    spot_call: string;
  end;

var
  SpotList: TList;

const
  dupinterval = 30; // duplicate interval in minutes

{ TfrmReporter }

procedure TfrmReporter.FormCreate(Sender: TObject);
var
  rep_host, rep_port: string;
begin
  Font := frmMain.Font;
  if InitPSKReporter then
  begin
    rep_host := GetValueFromConfigFile(sConfigRoot,'PSK31_Reporter_Host','report.pskreporter.info');
    rep_port := GetValueFromConfigFile(sConfigRoot,'PSK31_Reporter_Port','4739');
    StartPSKReporter(rep_host, rep_port);
    if pskreporterready then
    begin
      lbStatus.Caption := Format('Connected to %s:%s',[rep_host,rep_port]);
      SetPSKReporterLocalInfo(mycall,myloc,'KComm',sVerNo);
      Timer.Enabled := true;
    end
    else
      lbStatus.Caption := Format('Connection to %s:%s failed',[rep_host,rep_port]);
  end;
end;

procedure TfrmReporter.FormHide(Sender: TObject);
begin
  SaveFormPositionToConfigFile(sConfigRoot,'PSKReporterWinPos',frmReporter);
  if Assigned(frmPSKBrowser) then
    frmPSKBrowser.cbSpotHist.Checked := false;
end;

procedure TfrmReporter.FormShow(Sender: TObject);
begin
	GetFormPositionFromConfigFile(sConfigRoot,'PSKReporterWinPos',frmReporter);
end;

procedure TfrmReporter.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caHide;
end;

procedure TfrmReporter.SendSpot(call, mode: string; freq: extended; flag: DWORD);
var
  i: integer;
  timenow, dupthresh: extended;
  aspot: PSpot;
begin
  if call = mycall then Exit;
  timenow := Now+TimeZoneBias;
  dupthresh := timenow - (dupinterval / 1440.0);
  while (SpotList.Count > 0) and (PSpot(SpotList.Items[0])^.spot_time < dupthresh) do
  begin
    Dispose(PSpot(SpotList.Items[0]));
    SpotList.Delete(0);
  end;
  i := 0;
  while (i < SpotList.Count) and (PSpot(SpotList.Items[i])^.spot_call <> call) do
    inc(i);
  if i = SpotList.Count then
  begin
    New(aspot);
    aspot^.spot_time := timenow;
    aspot^.spot_call := call;
    SpotList.Add(aspot);
    if pskreporterready then
    begin
      SendPSKReporterSpot(call,mode,Format('%7.0f',[freq*1000.0]),flag);
      ReporterTickle;
    end;
    lbSpots.Items.Add(FormatDateTime('yyyy/mm/dd hh:nn',timenow)+Format('%8.3f %-10s %s',[freq/1000.0,call,mode]));
    if lbSpots.Count > 1 then
      lbSpots.TopIndex := lbSpots.Count - 1
  end;
end;

procedure TfrmReporter.btnShowSpotClick(Sender: TObject);
begin
  OpenURL('http://www.pskreporter.info/pskmapn.html?'+Lowercase(mycall));
end;

procedure TfrmReporter.mnuCopyClick(Sender: TObject);
var
  i: integer;
  seltext: string;
begin
  seltext := '';
  for i := 0 to lbSpots.Count - 1 do
    if lbSpots.Selected[i] then
      seltext := seltext + lbSpots.Items[i]+#9;
  Clipboard.AsText := seltext;
end;

procedure TfrmReporter.mnuSaveToFileClick(Sender: TObject);
var
  fn: string;
begin
  SaveHistoryDialog.InitialDir := GetValueFromConfigFile(sConfigRoot,'Spot_History_Dir','');
  if SaveHistoryDialog.Execute then
  begin
    fn := SaveHistoryDialog.FileName;
    lbSpots.Items.SaveToFile(fn);
    fn := ExtractFilePath(fn);
    Delete(fn,Length(fn),1);
    SaveValueToConfigFile(sConfigRoot,'Spot_History_Dir',fn);
  end;
end;

procedure TfrmReporter.mnuSelectAllClick(Sender: TObject);
begin
  lbSpots.SelectAll;
end;

procedure TfrmReporter.TimerTimer(Sender: TObject);
var
  stats: TREPORTER_STATISTICS;
  lcall: string;
begin
  if not pskreporterready then Exit;
  ReporterTickle;
  if ReporterGetStatistics(stats,sizeof(stats)) = 0 then
  begin
    lcall := WideCharToString(stats.last_callsign_queued);
    if lcall <> '' then lcall := 'Last call: '+lcall;
    lbStatus.Caption := Format('Sent: %d  Queued: %d  Rejected: %d  %s',
      [stats.callsigns_sent,stats.callsigns_buffered,stats.callsigns_discarded, lcall]);
  end;
end;

var
  i: integer;

initialization
  {$I reporter.lrs}
  SpotList := TList.Create;

finalization
  i := SpotList.Count;
  while i > 0 do
  begin
    Dec(i);
    Dispose(PSpot(SpotList.Items[i]));
  end;
  SpotList.Destroy;

end.

