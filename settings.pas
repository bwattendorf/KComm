unit settings;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 - 2012 Julian Moss, G4ILO  (www.g4ilo.com)                    //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  {$IFDEF WINDOWS}
  Windows, PSK31Core,
  {$ENDIF}
  Classes, SysUtils, LResources, LCLType, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ExtCtrls;

type

  { TfrmSettings }

  TfrmSettings = class(TForm)
    btnBrwse1: TButton;
    btnBrwse2: TButton;
    btnBrwse4: TButton;
    btnBrwseMRP40: TButton;
    btnBrwseFldigi: TButton;
    btnFontDefault: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    btnBrwse: TButton;
    btnFont: TButton;
    btnDXBrwse: TButton;
    btnBrwse3: TButton;
    edLookupHint2: TEdit;
    edLookupURL2: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    LookupDefBtn1: TButton;
    cbAutoParse: TCheckBox;
    cbComPort: TComboBox;
    cbContest: TCheckBox;
    cbFldigiOnTop: TCheckBox;
    cbPSKWaterfall: TCheckBox;
    cbPSKCenterFreq: TComboBox;
    cbDecodePSK: TCheckBox;
    cbDecodePSK1: TCheckBox;
    cbeQSLAuto1: TCheckBox;
    cbIncExch: TCheckBox;
    cbRadio: TComboBox;
    cbTxSoundCard: TComboBox;
    cbSpeed: TComboBox;
    cbBackupLog: TCheckBox;
    cbRpts: TCheckBox;
    cbRev204: TCheckBox;
    cbUseMRP40: TCheckBox;
    cbUseFldigi: TCheckBox;
    cbUseSoundcard: TCheckBox;
    cbRxSoundCard: TComboBox;
    cbUseCWSkimmer: TCheckBox;
    cgAlerts: TCheckGroup;
    cbCommTrace: TCheckBox;
    cbCWWaterfall: TCheckBox;
    cbCWRev: TCheckBox;
    cbCWCenterFreq: TComboBox;
    cbEncoding: TComboBox;
    cbMRP40OnTop: TCheckBox;
    cbUseK3DSP: TCheckBox;
    cbShowInfo: TCheckBox;
    cbPowerMate: TCheckBox;
    cbAutoEQSL: TComboBox;
    cbLargeWaterfall: TCheckBox;
    cbSpotCW: TCheckBox;
    cbAutoSpot: TCheckBox;
    edBackupFile: TEdit;
    edCWSkimmer: TEdit;
    edContestStartDate: TEdit;
    edContestStartTime: TEdit;
    edLookupURL1: TEdit;
    edLookupHint1: TEdit;
    edMRP40Path: TEdit;
    edFldigiPath: TEdit;
    edPwr: TEdit;
    edAnt1: TEdit;
    edAnt2: TEdit;
    edPort: TEdit;
    edPassword: TEdit;
    edUserID: TEdit;
    edEQSLUser: TEdit;
    edEQSLPassword: TEdit;
    edHost: TEdit;
    edWebBrowser: TEdit;
    edMyCall: TEdit;
    edLogFile: TEdit;
    edLocator: TEdit;
    GroupBox12: TGroupBox;
    Label28: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    lbPSKPalette: TLabel;
    lbEQSLUpdateStatus: TLabel;
    LookupDefBtn2: TButton;
    MRP40Dialog: TOpenDialog;
    FontDialog: TFontDialog;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
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
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    BrowserDialog: TOpenDialog;
    SelectPaletteDialog: TOpenDialog;
    SkimmerDialog: TOpenDialog;
    rgDuplicates: TRadioGroup;
    FldigiDialog: TOpenDialog;
    TabSheet10: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    LogFileDialog2: TSaveDialog;
    PageControl: TPageControl;
    LogFileDialog: TSaveDialog;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    procedure btnBrwse1Click(Sender: TObject);
    procedure btnBrwse2Click(Sender: TObject);
    procedure btnBrwse3Click (Sender: TObject );
    procedure btnBrwse4Click(Sender: TObject);
    procedure btnBrwseFldigiClick(Sender: TObject);
    procedure btnBrwseClick(Sender: TObject);
    procedure btnBrwseMRP40Click(Sender: TObject);
    procedure btnDXBrwseClick (Sender: TObject );
    procedure btnFontClick(Sender: TObject);
    procedure btnFontDefaultClick(Sender: TObject);
    procedure cbBackupLogChange(Sender: TObject);
    procedure cbContestClick(Sender: TObject);
    procedure cbRadioChange(Sender: TObject);
    procedure cbUseCWSkimmerClick (Sender: TObject );
    procedure cbUseFldigiClick(Sender: TObject);
    procedure cbUseK3DSPClick(Sender: TObject);
    procedure cbUseMRP40Click(Sender: TObject);
    procedure cbUseSoundcardClick (Sender: TObject );
    procedure edContestStartDateExit(Sender: TObject);
    procedure edContestStartTimeExit(Sender: TObject);
    procedure edEQSLUserExit(Sender: TObject);
    procedure edLocatorExit(Sender: TObject);
    procedure edMyCallKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    fntchanged: boolean;
    cwcntrfrq: integer;
    pskcntrfrq: integer;
  end;

var
  frmSettings: TfrmSettings;

implementation

{ TfrmSettings }

uses
  {$IFDEF WINDOWS} soundcards, {$ENDIF}
  Utils, Config, Main, DXClusterSelect, TimeZone;

procedure TfrmSettings.FormCreate(Sender: TObject);
var
  i: integer;
  {$IFDEF WINDOWS}
  names: TNameArray;
  {$ENDIF}
begin
  {$IFDEF WINDOWS}
  // hide the web browser specification box
  GroupBox8.Destroy;
  // make sure logging tab is shown first
  PageControl.ActivePage := TabSheet1;
  // add the drop-down entries for sound card selection
  cbRxSoundCard.Items.Add('Default device');
  cbTxSoundCard.Items.Add('Default device');
  GetNamesOfInputSoundCards(names);
  for i := 1 to MAX_SOUND_DEVICES do
    cbRxSoundCard.Items.Add(names[i]);
  GetNamesOfOutputSoundCards(names);
  for i := 1 to MAX_SOUND_DEVICES do
    cbTxSoundCard.Items.Add(names[i]);
  {$ELSE}
  // hide the CW Software tab sheet
  TabSheet8.Destroy;
  // fix up Fldigi options
  FldigiDialog.DefaultExt := '';
  FldigiDialog.FileName := 'fldigi';
  cbFldigiOnTop.Hide;
  // add the drop-down entries for sound card selection
  cbRxSoundCard.Style := csDropDown;
  cbRxSoundCard.Text := '/dev/dsp';
  cbRxSoundCard.Items.Add('/dev/dsp');
  cbRxSoundCard.Items.Add('/dev/dsp1');
  cbRxSoundCard.Items.Add('/dev/dsp2');
  cbRxSoundCard.Items.Add('/dev/dsp3');
  // hide the Tx sound card options
  Label8.Caption := 'Sound device:';
  Label31.Caption := '';
  cbTxSoundCard.Enabled := false;
  {$ENDIF}
  btnDXBrwse.Enabled := FileExists(progpath+'dxclusters.dat');
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  cbContestClick(Sender);
  cbUseSoundcardClick(Sender);
  cbUseFldigiClick(Sender);
  edEQSLUserExit(Sender);
  {$IFDEF WINDOWS}
  cbUseCWSkimmerClick(Sender);
  {$ELSE}
  cbAutoSpot.Visible := false;
  // hide the PSK Core options
  cbDecodePSK.Visible := false;
  Label18.Visible := false;
  Label19.Visible := false;
  Label30.Visible := false;
  cbPSKCenterFreq.Visible := false;
  cbLargeWaterfall.Visible := false;
  lbPSKPalette.Visible := false;
  btnBrwse4.Visible := false;
  {$ENDIF}
  if cbCWCenterFreq.Text <> '' then
    cwcntrfrq := StrToIntDef(cbCWCenterFreq.Text,800);
  if cbPSKCenterFreq.Text <> '' then
    pskcntrfrq := StrToIntDef(cbPSKCenterFreq.Text,1500);
  cbPSKWaterfall.Enabled := radio = k3;
end;

procedure TfrmSettings.cbRadioChange(Sender: TObject);
begin
  case cbRadio.ItemIndex of
  0:  begin                   // Elecraft K2
        cbSpeed.ItemIndex := 0;
        cbSpeed.Enabled := false;
        cbRev204.Visible := true;
        cbUseK3DSP.Visible := false;
        cbCWRev.Visible := true;
        cbPowerMate.Visible := true;
      end;
  1,                          // Elecraft K3
  2: begin                    // Elecraft KX3
        cbSpeed.Enabled := true;
        cbRev204.Visible := false;
        cbUseK3DSP.Visible := true;
        cbCWRev.Visible := true;
        cbPowerMate.Visible := true;
      end;
  end;
end;

procedure TfrmSettings.cbUseCWSkimmerClick(Sender: TObject );
begin
  {$IFDEF WINDOWS}
  edCWSkimmer.Enabled := cbUseCWSkimmer.Checked;
  btnBrwse3.Enabled := cbUseCWSkimmer.Checked;
  cbSpotCW.Enabled := cbUseCWSkimmer.Checked;
  {$ENDIF}
end;

procedure TfrmSettings.cbUseFldigiClick(Sender: TObject);
begin
  edFldigiPath.Enabled := cbUseFldigi.Checked;
  btnBrwseFldigi.Enabled := cbUseFldigi.Checked;
  if cbUseFldigi.Checked then
  begin
    cbDecodePSK.Checked := false;
    cbPSKWaterfall.Checked := false;
  end;
end;

procedure TfrmSettings.cbUseK3DSPClick(Sender: TObject);
begin
  if cbUseK3DSP.Checked then
    cbDecodePSK.Checked := false;
end;

procedure TfrmSettings.cbUseMRP40Click(Sender: TObject);
begin
  edMRP40Path.Enabled := cbUseMRP40.Checked;
  btnBrwseMRP40.Enabled := cbUseMRP40.Checked;
end;

procedure TfrmSettings.cbUseSoundcardClick (Sender: TObject );
var
  enable: boolean;
begin
  if (Sender = cbPSKWaterfall) and cbPSKWaterfall.Checked then
  begin
    cbDecodePSK.Checked := false;
    cbUseFldigi.Checked := false;
  end;
  if (Sender = cbDecodePSK) and cbDecodePSK.Checked then
  begin
    cbUseK3DSP.Checked := false;
    cbPSKWaterfall.Checked := false;
    cbUseFldigi.Checked := false;
  end;
  enable := cbUseSoundcard.Checked;
  Label8.Enabled := enable;
  Label30.Enabled := enable;
  Label31.Enabled := enable;
  lbPSKPalette.Enabled := enable;
  Label9.Enabled := enable;
  Label10.Enabled := enable;
  Label18.Enabled := enable;
  Label19.Enabled := enable;
  cbRxSoundCard.Enabled := enable;
  {$IFDEF WINDOWS}
  cbTxSoundCard.Enabled := enable;
  {$ENDIF}
  if not enable then cbCWWaterfall.Checked := false;
  cbCWWaterfall.Enabled := enable;
  cbCWCenterFreq.Enabled := enable and cbCWWaterfall.Checked;
  if not enable then cbPSKWaterfall.Checked := false;
  cbPSKWaterfall.Enabled := enable;
  Application.ProcessMessages;
  {$IFDEF WINDOWS}
  if not enable then cbDecodePSK.Checked := false;
  cbDecodePSK.Enabled := enable and psk31coreavailable;
  cbPSKCenterFreq.Enabled := enable and psk31coreavailable and cbDecodePSK.Checked;
  cbLargeWaterfall.Enabled := cbPSKCenterFreq.Enabled;
  {$ELSE}
  cbDecodePSK.Enabled := false;
  cbPSKCenterFreq.Enabled := false;
  {$ENDIF}
  if cbCWCenterFreq.Enabled and (cbCWCenterFreq.Text = '') then
    cbCWCenterFreq.ItemIndex := cbCWCenterFreq.Items.IndexOf('800');
  if cbPSKCenterFreq.Enabled and (cbPSKCenterFreq.Text = '') then
    cbPSKCenterFreq.ItemIndex := cbPSKCenterFreq.Items.IndexOf('1500');
end;

procedure TfrmSettings.btnBrwseClick(Sender: TObject);
begin
  with LogFileDialog do
  begin
    FileName := edLogFile.Text;
    if Execute then
      edLogFile.Text := FileName;
  end;
end;

procedure TfrmSettings.btnBrwseMRP40Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if MRP40Dialog.Execute then
    edMRP40Path.Text := MRP40Dialog.Filename;
  {$ENDIF}
end;

procedure TfrmSettings.btnDXBrwseClick (Sender: TObject );
var
  p, p2: integer;
  s, s2: string;
begin
  frmClusterSelect := TfrmClusterSelect.Create(Self);
  with frmClusterSelect do
  begin
    if ShowModal = mrOK then
    begin
      s := lbClusterData.Items[lbClusterData.ItemIndex];
      p := Pos(',',s);
      if p > 0 then
      begin
        Delete(s,1,p);
        p := Pos(',',s);
        if p > 0 then
        begin
          s2 := Copy(s,1,p-1);
          repeat
            p2 := Pos('"',s2);
            if p2 > 0 then
              Delete(s2,p2,1);
          until p2 = 0;
          edHost.Text := s2;
          Delete(s,1,p);
        end;
        p := Pos(',',s);
        if p > 0 then
        begin
          s2 := Copy(s,1,p-1);
          repeat
            p2 := Pos('"',s2);
            if p2 > 0 then
              Delete(s2,p2,1);
          until p2 = 0;
          edPort.Text := s2;
        end;
      end;
    end;
    frmClusterSelect.Destroy;
  end;
end;

procedure TfrmSettings.btnFontClick(Sender: TObject);
begin
  with FontDialog do
  begin
    FontDialog.Font := frmSettings.Font;
    if Execute then
    begin
      frmSettings.Font := FontDialog.Font;
      fntchanged := true;
      SaveFontToConfigFile(sConfigRoot,'Font',FontDialog.Font);
    end;
  end;
end;

procedure TfrmSettings.btnFontDefaultClick(Sender: TObject);
{$IFDEF WINDOWS}
var
	NonClientMetrics: TNonClientMetrics;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
	// set window font to default system message text font
	NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
	if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
		Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
  {$ENDIF}
  fntchanged := true;
  DeleteValueFromConfigFile(sConfigRoot,'Font');
end;

procedure TfrmSettings.btnBrwse1Click(Sender: TObject);
begin
  with LogFileDialog2 do
  begin
    FileName := edBackupFile.Text;
    if Execute then
      edBackupFile.Text := FileName;
  end;
end;

procedure TfrmSettings.btnBrwse2Click(Sender: TObject);
begin
  with BrowserDialog do
  begin
    FileName := edWebBrowser.Text;
    if Execute then
      edWebBrowser.Text := FileName;
  end;
end;

procedure TfrmSettings.btnBrwse3Click (Sender: TObject );
begin
  {$IFDEF WINDOWS}
  if SkimmerDialog.Execute then
    edCWSkimmer.Text := SkimmerDialog.Filename;
  {$ENDIF}
end;

procedure TfrmSettings.btnBrwse4Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if SelectPaletteDialog.Execute then
  begin
    lwpalette := SelectPaletteDialog.Filename;
    lbPSKPalette.Caption := lwpalette;
  end
  else
  begin
    lwpalette := '';
    lbPSKPalette.Caption := 'default';
  end;
  {$ENDIF}
end;

procedure TfrmSettings.btnBrwseFldigiClick(Sender: TObject);
begin
  if FldigiDialog.Execute then
    edFldigiPath.Text := FldigiDialog.Filename;
end;

procedure TfrmSettings.cbBackupLogChange(Sender: TObject);
begin
  if cbBackupLog.Checked then
  begin
    edBackupFile.Enabled := true;
    btnBrwse1.Enabled := true;
  end
  else
  begin
    edBackupFile.Enabled := false;
    btnBrwse1.Enabled := false;
  end;
end;

procedure TfrmSettings.cbContestClick(Sender: TObject);
begin
  Label14.Enabled := cbContest.Checked;
  edContestStartDate.Enabled := cbContest.Checked;
  edContestStartTime.Enabled := cbContest.Checked;
  rgDuplicates.Enabled := cbContest.Checked;
  cgAlerts.Enabled := cbContest.Checked;
  cbIncExch.Enabled := cbContest.Checked;
  if cbContest.Checked and (edContestStartdate.Text = '') then
  begin
    edContestStartDate.Text := FormatDateTime('yyyy/mm/dd',Now + TimeZoneBias);
    edContestStartTime.Text := FormatDateTime('hh:nn',Now + TimeZoneBias);
  end;
end;

procedure TfrmSettings.edContestStartDateExit(Sender: TObject);
begin
  if (Length(edContestStartDate.Text) > 0) and not ValidDate(edContestStartDate.Text) then
    Application.MessageBox('Invalid date format',PChar(Application.Title),MB_ICONEXCLAMATION);
end;

procedure TfrmSettings.edContestStartTimeExit(Sender: TObject);
begin
  if (Length(edContestStartTime.Text) > 0) and not ValidTime(edContestStartTime.Text) then
    Application.MessageBox('Invalid time format',PChar(Application.Title),MB_ICONEXCLAMATION);
end;

procedure TfrmSettings.edEQSLUserExit(Sender: TObject);
begin
  cbAutoEQSL.Enabled := (edEQSLUser.Text <> '') and (edEQSLPassword.Text <> '');
end;

procedure TfrmSettings.edLocatorExit(Sender: TObject);
begin
  if (edLocator.Text <> '') and not ValidLocator(edLocator.Text) then
    Application.MessageBox('Invalid locator',PChar(Application.Title),MB_ICONEXCLAMATION);
end;

procedure TfrmSettings.edMyCallKeyPress(Sender: TObject; var Key: char);
begin
	if Key in ['a'..'z'] then
  	Key := Chr(Ord(Key) - $20);
end;

initialization
  {$I settings.lrs}

end.

