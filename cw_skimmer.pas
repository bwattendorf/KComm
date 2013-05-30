unit cw_skimmer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, Tlntsend,
  ExtCtrls;

type

  { TfrmSkimmer }

  TfrmSkimmer = class (TForm )
    lbStatus: TLabel;
    Timer: TTimer;
    procedure FormClose (Sender: TObject; var CloseAction: TCloseAction );
    procedure TimerTimer (Sender: TObject );
  private
    { private declarations }
    skimmer: TTelnetSend;
  public
    inupdate: boolean;
    spotcw: boolean;
    function Login: boolean;
    { public declarations }
  end; 

var
  frmSkimmer: TfrmSkimmer;

implementation

uses Main, Reporter, PSKReporter, Utils, Config, Windows;

function TfrmSkimmer.Login: boolean;
var
  cpath: string;
begin
  Result := false;
  lbStatus.Caption := 'Looking for CW Skimmer';
  Delay(500);
  if FindWindow('TMainForm',PChar(0)) = 0 then
  begin
    lbStatus.Caption := 'Launching CW Skimmer';
    cpath := GetValueFromConfigFile(sConfigRoot,'CW_Skimmer','');
    if (cpath = '') or not FileExists(cpath) then
    begin
      MessageDlg('Path to CwSkimmer.exe is invalid',mtError,[mbOK],0);
      Close;
      Exit;
    end;
    if not RunProgram(cpath,'') then Exit;
		repeat
    	Delay(500);
    until FindWindow('TMainForm',PChar(0)) <> 0;
    Delay(5000);
  end;
  skimmer := TTelnetSend.Create;
  try
    skimmer.TargetHost := 'localhost';
    skimmer.TargetPort := '7300';
    skimmer.TermType := 'dumb';
    skimmer.Timeout := 5000;
    lbStatus.Caption := 'Connecting to CW Skimmer';
    Application.ProcessMessages;
    if skimmer.Login then
    begin
      lbStatus.Caption := 'Logging in';
      Application.ProcessMessages;
      skimmer.WaitFor(':');
      skimmer.Send(mycall+#13+#10);
      skimmer.WaitFor('>');
      lbStatus.Caption := 'Connected';
      inupdate := false;
      Timer.Enabled := true;
      Result := true;
    end
    else
      lbStatus.Caption := 'Failed to connect to CW Skimmer';
  except
    lbStatus.Caption := 'Exception occurred';
  end;
  spotcw := GetValueFromConfigFile(sConfigRoot,'Spot_CW',false);
  Delay(1000);
  if Result then
    Hide;
end;

procedure TfrmSkimmer.FormClose (Sender: TObject;
  var CloseAction: TCloseAction );
begin
  Timer.Enabled := false;
  while inupdate do
    Application.ProcessMessages;
  if Assigned(skimmer) then
  begin
    skimmer.Send('BYE'+#13+#10);
    Delay(1000);
    skimmer.Logout;
    skimmer.Destroy;
  end;
  CloseAction := caFree;
  frmSkimmer := nil;
end;

procedure TfrmSkimmer.TimerTimer (Sender: TObject );
var
  s, de, dx, freq, sband, smode, str: string;
  infostr, newstr, wkdstr, cname, qth, grid: string;
  p, band, mode: integer;
  f: extended;
begin
  if skimmer.Sock.LastError <> 0 then
  begin
    Close;
    Exit;
  end;
  inupdate := true;
  while skimmer.Sock.WaitingData > 0 do
  begin
    s := Trim(skimmer.RecvTerminated(#13));
    if Length(s) > 0 then
    begin
      if (Copy(UpperCase(s),1,5) = 'DX DE') then
      begin
        // Frequency spot
        if Length(s) >= 75 then
        begin
          de := UpperCase(Trim(Copy(s,7,10)));
          p := Pos(':',de);
          if p > 0 then Delete(de,p,1);
          freq := Trim(Copy(s,17,8));
          BandMode(freq, band, mode);
          dx := UpperCase(Trim(Copy(s,27,12)));
          if ValidCall(dx) then
          begin
            smode := ModeStr[radio,mode];
            case band of
            1:  sband := '160m';
            3:  sband := '80m';
            5:  sband := '60m';
            7:  sband := '40m';
            10: sband := '30m';
            14: sband := '20m';
            18: sband := '17m';
            21: sband := '15m';
            24: sband := '12m';
            28: sband := '10m';
            50: sband := '6m';
            70: sband := '4m';
            144: sband := '2m';
            432: sband := '70cm';
            end;
            infostr := ''; newstr := ''; wkdstr := '';
            frmMain.ContactInfo(dx, sband, smode, infostr, newstr, wkdstr, cname, qth, grid);
            if Length(wkdstr) > 0 then
              skimmer.Send(Format('SKIMMER/STATUS %s %s DUPE',[dx,freq])+#13#10)
            else if Length(newstr) > 0 then
            begin
              if Pos('country',newstr) > 0 then
                skimmer.Send(Format('SKIMMER/STATUS %s %s NEWCTY',[dx,freq])+#13#10)
              else
                skimmer.Send(Format('SKIMMER/STATUS %s %s BNDCTY',[dx,freq])+#13#10);
            end;
            // spot to PSK Reporter
            if spotcw then
            begin
              if not Assigned(frmReporter) then
              begin
                frmReporter := TfrmReporter.Create(frmMain);
                if pskreporterready then
                  frmReporter.Show;
              end;
              if pskreporterready then
              begin
                f := StrToFloatDef(freq, 0.0);
                if f > 0.0 then
                  frmReporter.SendSpot(dx,'CW',f,REPORTER_SOURCE_AUTOMATIC);
              end;
            end;
          end;
        end;
      end
      else if (Copy(UpperCase(s),1,17) = 'TO ALL DE SKIMMER') then
      begin
        // CW Skimmer message
        p := Pos('"',s);
        if p > 0 then
        begin
          Delete(s,1,p);
          p := Pos('"',s);
          if p > 1 then
          begin
            str := Copy(s,1,p-1);
            frmMain.InsertText(str);
          end;
        end;
      end;
    end;
  end;
  inupdate := false;
end;

initialization
  {$I cw_skimmer.lrs}

end.

