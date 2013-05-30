unit eqsl;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 - 2013 Julian Moss, G4ILO  (www.g4ilo.com)                    //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  {$IFDEF UNIX}
  CThreads,
  {$ENDIF}
  Classes, SysUtils;

type
  TEQSLSentEvent = procedure of object;

  TSendEQSLThread = class(TThread)
  protected
    procedure Execute; override;
  public
    userid: string;
    userpwd: string;
    call: string;
    starttime: TDateTime;
    freq: string;
    mode: string;
    rst: string;
    OnEQSLSent: TEQSLSentEvent;
    constructor Create;
  end;

function SendEQSL(eqsluser, eqslpasswd, call: string; timestarted: TDateTime; qsofreq, mode, rst: string): boolean;

var
  SendEQSLThread: TSendEQSLThread;

implementation

uses Forms, LCLType, Utils, HTTPSend;

function SendEQSL(eqsluser, eqslpasswd, call: string; timestarted: TDateTime; qsofreq, mode, rst: string): boolean;
var
	logdata, url, response: string;
  res: TStringList;

  procedure AddData(const datatype, data: string);
  begin
    if data <> '' then
      logdata := logdata + Format('<%s:%d>%s',[datatype,Length(data),data]);
  end;

  function UrlEncode(s: string): string;
  var
    i: Integer;
  begin
    Result := '';
    for i := 1 to Length(s) do
      case s[i] of
        ' ':
          Result := Result + '+';
        '0'..'9','A'..'Z','a'..'z','*','@','.','_','-','$','!',#$27,'(',')':
          Result := Result + s[i];
      else
        Result := Result + '%' + IntToHex(Ord(s[i]),2);
      end;
  end;

begin
  Result := false;
	// build log data
  logdata := 'KComm v2.0 <ADIF_VER:4>1.00';
  AddData('EQSL_USER',eqsluser);
  AddData('EQSL_PSWD',eqslpasswd);
  logdata := logdata+'<EOH>';
  // record
  AddData('CALL',call);
  AddData('QSO_DATE',FormatDateTime('yyyymmdd',timestarted));
  AddData('TIME_ON',FormatDateTime('hhnnss',timestarted));
  AddData('BAND',FreqToBand(qsofreq));  //** qsofreq must be integer Hz ** //
  AddData('MODE',ADIFmode(mode));
  AddData('RST_SENT',rst);
  AddData('LOG_PGM','KComm');
  logdata := logdata+'<EOR>';
  // generate http call
	url := 'http://www.eqsl.cc/qslcard/importADIF.cfm?ADIFData='+URLEncode(logdata);
  // send data
  res := TStringList.Create;
  try
    try
      if HTTPGetText(url,res ) then
      begin
        response := res.Text;
        while (res.Count > 0) and (UpperCase(Trim(res.Strings[0]))<>'<BODY>') do
          res.Delete(0);
        while (res.Count > 0) and (UpperCase(Trim(res.Strings[0]))='<BODY>') do
          res.Delete(0);
        while (res.Count > 0) and (Trim(res.Strings[0])='') do
          res.Delete(0);
        if res.Count > 0 then response := Trim(StripStr('<BR>',res.Strings[0]));
        Result := Pos('records added',response) > 0;
        if not Result then
          Application.MessageBox(PChar('Server replied: '+response),'eQSL error',MB_ICONEXCLAMATION);
      end
      else
        Application.MessageBox('Data transmission error','eQSL error',MB_ICONEXCLAMATION);
    except
      Application.MessageBox('Unexpected event','eQSL error',MB_ICONEXCLAMATION);
    end;
  finally
    res.Destroy;
  end;
end;

constructor TSendEQSLThread.Create;
begin
	FreeOnTerminate := true;
  OnEQSLSent := nil;
  inherited Create(true);
end;

procedure TSendEQSLThread.Execute;
begin
  if SendEQSL(userid, userpwd, call, starttime, freq, mode, rst) then
    if Assigned(OnEQSLSent) then
      Synchronize(OnEQSLSent);
end;

end.

