unit export;

//  Copyright (c) 2007 - 2013 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

{$mode objfpc}{$H+}

interface

uses
  Classes, LCLType, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls;

type

  { TfrmExport }

  TfrmExport = class(TForm)
    btnLoadTemplate: TButton;
    btnExportCab: TButton;
    btnClose: TButton;
    btnExportADIF: TButton;
    cbExcContest: TCheckBox;
    cbExcFM: TCheckBox;
    cbExcQSLSent: TCheckBox;
    Label1: TLabel;
    lbExportStatus: TLabel;
    mmTemplate: TMemo;
    OpenTemplateDialog: TOpenDialog;
    PageControl1: TPageControl;
    rgADIFExport: TRadioGroup;
    ADIFExportDialog: TSaveDialog;
    CabrilloExportDialog: TSaveDialog;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnExportADIFClick(Sender: TObject);
    procedure btnExportCabClick(Sender: TObject);
    procedure btnLoadTemplateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    firstrec: integer;
    lastrec: integer;
    procedure ExportToADIF(first,last: integer; filename: string; selection: integer = 3);
    procedure ExportToCabrillo(first,last: integer; filename: string);
  end;

var
  frmExport: TfrmExport;

implementation

{ TfrmExport }

uses
  Main, Utils, TimeZone;

procedure TfrmExport.FormCreate(Sender: TObject);
begin
  rgADIFExport.ItemIndex := 3;
end;

procedure TfrmExport.FormShow(Sender: TObject);
begin
  btnExportCab.Enabled := mmTemplate.Lines.Count > 4;
  ADIFExportDialog.FileName := mycall;
  CabrilloExportDialog.FileName := mycall;
end;

procedure TfrmExport.btnExportADIFClick(Sender: TObject);
begin
    with ADIFExportDialog do
    begin
      if Execute then
        ExportToADIF(firstrec,lastrec,FileName,rgADIFExport.ItemIndex);
    end
end;

procedure TfrmExport.btnExportCabClick(Sender: TObject);
begin
    with CabrilloExportDialog do
    begin
      if Execute then
        ExportToCabrillo(firstrec,lastrec,FileName);
    end
end;

procedure TfrmExport.btnLoadTemplateClick(Sender: TObject);
begin
  with OpenTemplateDialog do
  begin
    if Execute then
    begin
      mmTemplate.Lines.LoadFromFile(FileName);
      btnExportCab.Enabled := mmTemplate.Lines.Count > 4;
    end;
  end;
end;

// GlobalQSL required fields are:
// CALL , DATE, TIME , BAND , MODE , RST_SENT
// Optional: QSL_RCVD = "Y", QSL_VIA.

procedure TfrmExport.ExportToADIF(first,last: integer; filename: string; selection: integer = 3);
var
  i,j: integer;
  err: boolean;
	f: TextFile;
  logdata: string;
  logitems: TLogItems;
  mode,ll: string;

  procedure AddData(const datatype, data: string);
  begin
    if data <> '' then
      logdata := logdata + Format('<%s:%d>%s',[datatype,Length(data),data]);
  end;

  function TimeOff(t1, t2: string): string;
  var
    st, et: TDateTime;
  begin
    st := (StrToIntDef(Copy(t1,9,2),0)*3600+StrToIntDef(Copy(t1,11,2),0)*60+StrToIntDef(Copy(t1,11,2),0)) / 86400;
    et := st + StrToIntDef(t2,0) / 86400;
    Result := FormatDateTime('hhnn',et);
  end;

// Selection type:
//  0 - eQSL fields
//  1 - GlobalQSL fields
//  2 - Contest log fields
//  3 - All fields

begin
	AssignFile(f,filename);
	Rewrite(f);
	WriteLn(f,'Data exported by KComm '+sVerNo);
  WriteLn(f,'<ADIF_VER:4>2.00');
  WriteLn(f,'<LOG_PGM:5>KComm');
	WriteLn(f,'<EOH>');
  i := first;
  while i <= last do
  begin
    err := false;
    ParseLogLine(Log.Strings[i],logitems);
    if (selection <> 1)
      or not ((cbExcContest.Checked and (logitems[12]<>''))
      or (cbExcFM.Checked and (StrToIntDef(logitems[6],999000000) > 144000000) and (logitems[9] = 'FM'))
      or (cbExcQSLSent.Checked and (logitems[4]<>''))) then
    begin
      lbExportStatus.Caption := 'Exporting record '+IntToStr(i);
      Application.ProcessMessages;
  		logdata := '';
  		AddData('CALL',logitems[1]);
      if (selection = 1) and (logitems[18] <> '') then
        AddData('QSL_VIA',logitems[18]);
  		AddData('QSO_DATE',Copy(logitems[2],1,8));
  		AddData('TIME_ON',Copy(logitems[2],9,4));
      if selection > 0 then
      begin
    		AddData('TIME_OFF',TimeOff(logitems[2],logitems[3]));
  	  	AddData('FREQ',ShowFreq(logitems[6])+'000');
      end;
  		AddData('BAND',FreqToBand(logitems[6]));
      mode := ADIFmode(logitems[9]);
      if mode = '' then
      begin
        Application.MessageBox(PChar(Format('%s - Invalid ADIF mode: %s',[logitems[1],logitems[9]])),PChar(Application.Title),MB_ICONEXCLAMATION+MB_OK);
        err := true;
      end;
      AddData('MODE',mode);
  		AddData('RST_SENT',logitems[10]);
      if selection > 1 then
      begin
    		AddData('RST_RCVD',logitems[11]);
    		AddData('STX',logitems[12]);
    		AddData('SRX',logitems[13]);
        if selection > 2 then
        begin
      		AddData('NAME',logitems[14]);
      		AddData('QTH',logitems[15]);
          AddData('CNTY',logitems[19]);
          if ValidIOTA(logitems[20]) then
            AddData('IOTA',logitems[20]);
          if ValidLocator(logitems[21]) then
      		  AddData('GRIDSQUARE',logitems[21]);
      		AddData('COMMENT',logitems[16]);
          AddData('QSL_VIA',logitems[18]);
          AddData('QSLSDATE',logitems[4]);
          AddData('QSLRDATE',logitems[5]);
        end;
      end;
      if (selection = 1) and (logitems[5] <> '') then
        AddData('QSL_RCVD','Y');
  		logdata := logdata + '<EOR>';
      if not err then
      begin
     		WriteLn(f,logdata);
        if selection < 2 then
        begin
          case selection of
          0:  logitems[23] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);    // set eQSL sent date
          1:  logitems[4] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);     // set QSL sent date
          end;
        end;
        // build log line
        ll := '';
        for j := 0 to 25 do
          ll := Trim(ll+logitems[j]+';');
        log.Strings[i] := ll;
        logchanged := true;
      end;
    end;
    Inc(i);
  end;
	CloseFile(f);
  lbExportStatus.Caption := 'Finished';
  if logchanged then
    log.SaveToFile(LogFileName);
  logchanged := false;
end;

procedure TfrmExport.ExportToCabrillo(first,last: integer; filename: string);
var
  i,p,ti: integer;
  invalid, done, qso: boolean;
	f: TextFile;
  logdata, templine, strtmp: string;
  logitems: TLogItems;
  
  procedure StrReplace(token,str: string; rightjustify: boolean = false; zerofill: boolean = false);
  var
    p: integer;
    tmp, fill: string;
  begin
    if zerofill then
      fill := '          00'
    else
      fill := '            ';
    p := Pos(token,logdata);
    if p > 0 then
    begin
      Delete(logdata,p,Length(token));
      if Length(str) = Length(token) then
        Insert(str,logdata,p)
      else if rightjustify then
      begin
        tmp := fill+str;
        Insert(Copy(tmp,Length(tmp)-Length(token)+1,Length(token)),logdata,p)
      end
      else
        Insert(Copy(str+fill,1,Length(token)),logdata,p);
    end;
  end;

  function FreqToFCab(freq: string): string;
  var
    f: integer;
  begin
    Result := '';
    try
      f := StrToInt(freq) div 1000;
      if (f < 50000) then
        Result := IntToStr(f)
      else
      begin
        if (f >= 50000) and (f <= 54000) then Result := '50'
        else if (f >= 70000) and (f <= 71000) then Result := '70'
        else if (f >= 144000) and (f <= 148000) then Result := '144'
        else if (f >= 222000) and (f <= 225000) then Result := '222'
        else if (f >= 420000) and (f <= 450000) then Result := '432'
        else if (f >= 1240000) and (f <= 1300000) then Result := '1.2G';
      end;
    except
    end;
  end;
  
  function ModeToMCab(mode: string): string;
  begin
    case Pos(Trim(Copy(mode,1,3)),modes) of
    1,4,7:              Result := 'PH';
    10:                 Result := 'CW';
    22:                 Result := 'FM';
    else
      Result := 'RY';   // all digital modes are RTTY
    end;
  end;

  function DateToCabDate(dtstr: string): string;
  var
    d: string;
  begin
    d := Copy(dtstr,1,8);
    Insert('-',d,7);
    Insert('-',d,5);
    Result := d;
  end;

  function DateToCabTime(dtstr: string): string;
  begin
    Result := Copy(dtstr,9,4);
  end;


begin
	AssignFile(f,filename);
	Rewrite(f);
  ti := 0;
  invalid := false;
  done := false;
  qso := false;
  repeat
    templine := mmTemplate.Lines[ti];
    p := Pos(':',templine);
    if p = 0 then
    begin
      Application.MessageBox(PChar(Format('Invalid line in template: line %d',[ti])),'Export',MB_ICONEXCLAMATION);
      invalid := true
    end
    else
    begin
      qso := Copy(templine,1,p-1) = 'QSO';
      done := Copy(templine,1,p-1) = 'END-OF-LOG';
      if qso then
      begin
        for i := first to last do
        begin
          ParseLogLine(Log.Strings[i],logitems);
          logdata := templine;
          strtmp := FreqToFCab(logitems[6]);
          StrReplace('ffffff',strtmp,true);                       // fffff - frequency
          StrReplace('fffff',strtmp,true);
          StrReplace('mm',ModeToMCab(logitems[9]));               // mm - mode
          StrReplace('dddddddddd',DateToCabDate(logitems[2]));    // dddddddddd - date (yyyy-mm-dd)
          StrReplace('tttt',DateToCabTime(logitems[2]));          // tttt - time (hhmm)
          StrReplace('yyyyyyyyyyyyyy',logitems[0]);
          StrReplace('yyyyyyyyyyyyy',logitems[0]);                // yyyyyyyyyyyyy - mycall
          StrReplace('yyyyyyyyyyyy',logitems[0]);
          StrReplace('sss',logitems[10]);                         // sss - rst sent
          StrReplace('xxxxxx',logitems[12]);                      // xxxxxx - exchange sent
          StrReplace('xxxxx',logitems[12]);
          StrReplace('xxxx',logitems[12]);
          StrReplace('0000x',logitems[12],true,true);
          StrReplace('000x',logitems[12],true,true);              // 000x - zero-padded exchange sent
          StrReplace('00x',logitems[12],true,true);
          StrReplace('0x',logitems[12],true,true);
          StrReplace('cccccccccccccc',logitems[1]);
          StrReplace('ccccccccccccc',logitems[1]);                // ccccccccccccc - his call
          StrReplace('cccccccccccc',logitems[1]);
          StrReplace('rrr',logitems[11]);                         // rrr - rst received
          StrReplace('wwwwww',logitems[13]);                      // wwwwww - exchange received
          StrReplace('wwwww',logitems[13]);
          StrReplace('wwww',logitems[13]);
          StrReplace('www',logitems[13]);
          StrReplace('ww',logitems[13]);
          StrReplace('0000w',logitems[13],true,true);
          StrReplace('000w',logitems[13],true,true);              // 000w - zero-padded exchange rcvd
          StrReplace('00w',logitems[13],true,true);
          StrReplace('0w',logitems[13],true,true);
          StrReplace('gggggg',logitems[21]);                      // gggg - grid square
          StrReplace('gggg',Copy(logitems[21],1,4));
          StrReplace('nnnnnn',logitems[16]);                      // nnnnnn - exchange2 from notes field
          StrReplace('nnnnn',logitems[16]);
          StrReplace('nnnn',logitems[16]);
          StrReplace('nnn',logitems[16]);
          WriteLn(f,logdata);
        end;
      end
      else
        WriteLn(f,templine);
    end;
    Inc(ti)
  until done or invalid or (ti >= mmTemplate.Lines.Count);
  CloseFile(f);
end;

initialization
  {$I export.lrs}

end.

