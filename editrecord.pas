unit editrecord;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 - 2013 Julian Moss, G4ILO  (www.g4ilo.com)                    //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, LCLType;

type

  { TfrmEditRec }

  TfrmEditRec = class(TForm)
    btnSendeQSL: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    cbMode: TComboBox;
    cbeQSLRcvd: TCheckBox;
    cbQSLSent: TCheckBox;
    cbQSLRcvd: TCheckBox;
    cbeQSLSent: TCheckBox;
    edCall: TEdit;
    edCustom: TEdit;
    edDomain: TEdit;
    edCounty: TEdit;
    edQSLMgr: TEdit;
    edDate: TEdit;
    edExchr: TEdit;
    edExchs: TEdit;
    edFreq: TEdit;
    edGrid: TEdit;
    edIOTA: TEdit;
    edName: TEdit;
    edNotes: TEdit;
    edQTH: TEdit;
    edRSTr: TEdit;
    edRSTs: TEdit;
    edTime: TEdit;
    edTimeEnded: TEdit;
    pnInfo: TPanel;
    txLookup: TLabel;
    txLookup2: TLabel;
    txSending: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label9: TLabel;
    procedure btnSendeQSLClick(Sender: TObject);
    procedure cbeQSLSentChange(Sender: TObject);
    procedure edCallKeyPress(Sender: TObject; var Key: char);
    procedure edDateExit(Sender: TObject);
    procedure edFreqExit(Sender: TObject);
    procedure edGridExit(Sender: TObject);
    procedure edGridKeyPress(Sender: TObject; var Key: char);
    procedure edIOTAExit(Sender: TObject);
    procedure edNameKeyPress(Sender: TObject; var Key: char);
    procedure edRSTsExit(Sender: TObject);
    procedure edTimeExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txLookupClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmEditRec: TfrmEditRec;

implementation

{ TfrmEditRec }

uses
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  Main, Utils, eQSL, Config;

procedure TfrmEditRec.FormCreate(Sender: TObject);
begin
  cbMode.Items := frmMain.cbMode.Items;
end;

procedure TfrmEditRec.FormShow(Sender: TObject);
begin
	GetFormPositionFromConfigFile(sConfigRoot,'EditRecWinPos',frmEditRec);
  txLookup.Hint := frmMain.txLookup.Hint;
  txLookup2.Hint := frmMain.txLookup2.Hint;
  pnInfo.Font.Style := [fsBold];
  txSending.Caption := '';
  cbeQSLSentChange(Sender);
end;

procedure TfrmEditRec.txLookupClick(Sender: TObject);
var
  url, defaulturl, n: string;
begin
  if Sender = txLookup then
  begin
    n := 'LookupURL1';
    defaulturl := surldef1;
  end
  else
  begin
    n := 'LookupURL2';
    defaulturl := surldef2;
  end;
  url := GetValueFromConfigFile(sConfigRoot,n,defaulturl)+edCall.Text;
  try
	  OpenURL(url);
  except
  end;
end;


procedure TfrmEditRec.cbeQSLSentChange(Sender: TObject);
begin
  btnSendeQSL.Enabled := (eqsluser <> '') and (not cbeQSLSent.Checked);
end;

procedure TfrmEditRec.edCallKeyPress(Sender: TObject; var Key: char);
begin
  frmMain.edCallKeyPress(Sender, Key);
end;

procedure TfrmEditRec.btnSendeQSLClick(Sender: TObject);
var
  result: boolean;
  timestarted: TDateTime;
begin
  result := false;
  btnSendeQSL.Enabled := false;
  txSending.Caption := 'Sending...';
  Application.ProcessMessages;
  try
    timestarted := EncodeDate(StrToInt(Copy(edDate.Text,1,4)),StrToInt(Copy(edDate.Text,6,2)),StrToInt(Copy(edDate.Text,9,2)))
      + EncodeTime(StrToInt(Copy(edTime.Text,1,2)),StrToInt(Copy(edTime.Text,4,2)),0,0);
  except
    Application.MessageBox('Data format error','Error',MB_ICONEXCLAMATION);
  end;
  result := SendEQSL(eqsluser, eqslpass, edCall.Text, timestarted, StripAll(DecimalSeparator,edFreq.Text)+'000', cbMode.Text, edRSTS.Text);
  cbeQSLSent.Checked := result;
  btnSendeQSL.Enabled := not result;
  if result then
    txSending.Caption := 'Sent'
  else
    txSending.Caption := '';
end;

procedure TfrmEditRec.edDateExit(Sender: TObject);
begin
  if not ValidDate(edDate.Text) then
    Application.MessageBox('Date format invalid',PChar(Application.Title),MB_ICONERROR);
end;

procedure TfrmEditRec.edFreqExit(Sender: TObject);
begin
  if not ValidFreq(edFreq.Text) then
    Application.MessageBox('Frequency format invalid',PChar(Application.Title),MB_ICONERROR);
end;

procedure TfrmEditRec.edGridExit(Sender: TObject);
var
  lat,lon,range,bearing: extended;
begin
  try
    if (ValidLocator(edGrid.Text)) then
    begin
      LocatorToGeog(edGrid.Text,lat,lon);
      if (lat <> 0.0) and (lon <> 0.0) then
      begin
        PathCalc(mylat,mylon,lat,lon,false,range,bearing);
        edCustom.Text := Format('QRB: %4.0fkm',[range]);
      end;
    end;
  except
  end;
end;

procedure TfrmEditRec.edGridKeyPress(Sender: TObject; var Key: char);
begin
  frmMain.edGridKeyPress(Sender, Key);
end;

procedure TfrmEditRec.edIOTAExit(Sender: TObject);
begin
  if (edIOTA.Text <> '') and (not ValidIOTA(edIOTA.Text)) then
    Application.MessageBox('IOTA format invalid (should be XX-nnn)',PChar(Application.Title),MB_ICONERROR);
end;

procedure TfrmEditRec.edNameKeyPress(Sender: TObject; var Key: char);
begin
  frmMain.edNameKeyPress(Sender, Key);
end;

procedure TfrmEditRec.edRSTsExit(Sender: TObject);
begin
  if not ValidRpt(TEdit(Sender).Text,cbMode.Text) then
    Application.MessageBox('Report invalid',PChar(Application.Title),MB_ICONERROR);
end;

procedure TfrmEditRec.edTimeExit(Sender: TObject);
begin
  if not ValidTime(TEdit(Sender).Text) then
    Application.MessageBox('Time format invalid',PChar(Application.Title),MB_ICONERROR);
end;

procedure TfrmEditRec.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveFormPositionToConfigFile(sConfigRoot,'EditRecWinPos',frmEditRec);
end;

initialization
  {$I editrecord.lrs}

end.

