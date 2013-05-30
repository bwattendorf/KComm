unit dxcluster;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Tlntsend, ExtCtrls, Grids, Spin, Buttons;

type

  { TfrmClusterClient }

  TfrmClusterClient = class (TForm )
    btnFilters: TButton;
    btnPin: TSpeedButton;
    btnShowMsg: TSpeedButton;
    btnChat: TSpeedButton;
    cb10m: TCheckBox;
    cb12m: TCheckBox;
    cb15m: TCheckBox;
    cb160m: TCheckBox;
    cb17m: TCheckBox;
    cb20m: TCheckBox;
    cb2m: TCheckBox;
    cb30m: TCheckBox;
    cb40m: TCheckBox;
    cb4m: TCheckBox;
    cb60m: TCheckBox;
    cb6m: TCheckBox;
    cb70cm: TCheckBox;
    cb80m: TCheckBox;
    cbAllBands: TCheckBox;
    cbAllModes: TCheckBox;
    cbCW: TCheckBox;
    cbData: TCheckBox;
    cbSSB: TCheckBox;
    cbAllSpots: TCheckBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    StatusBar: TLabel;
    seDistance: TSpinEdit;
    pnStatusBar: TPanel;
    sgCluster: TStringGrid;
    Timer: TTimer;
    procedure btnChatClick(Sender: TObject);
    procedure btnPinClick(Sender: TObject);
    procedure btnShowMsgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFiltersClick(Sender: TObject);
    procedure cbAllModesClick (Sender: TObject );
    procedure cbAllSpotsClick(Sender: TObject);
    procedure cbBandFilterClick (Sender: TObject );
    procedure cbAllBandsClick (Sender: TObject );
    procedure cbModeFilterClick (Sender: TObject );
    procedure FormClose (Sender: TObject; var CloseAction: TCloseAction );
    procedure FormShow (Sender: TObject );
    procedure sgClusterClick (Sender: TObject );
    procedure sgClusterDblClick (Sender: TObject );
    procedure TimerTimer (Sender: TObject );
  private
    { private declarations }
    cluster: TTelnetSend;
    formmode: integer;
    showinfo: boolean;
    loginmsg: string;
    procedure FormState(m: integer);
  public
    { public declarations }
    inupdate: boolean;
    function Login(host, port, userid, passwd: string): Boolean;
    procedure SendSpot(freq, call, cname, mode, rsts, grid : string);
  end; 

var
  frmClusterClient: TfrmClusterClient;

implementation

{ TfrmClusterClient }

uses
  {$IFDEF WINDOWS}Windows,{$ENDIF}
  Main, Config, Countries, Utils, Fldigi, DXClusterMsg, DXClusterSpot;

procedure TfrmClusterClient.FormClose (Sender: TObject;
  var CloseAction: TCloseAction );
begin
  Timer.Enabled := false;
  while inupdate do
    Application.ProcessMessages;
  if Assigned(cluster) then
  begin
    cluster.Logout;
    cluster.Destroy;
  end;
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_All',cbAllBands.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_160m',cb160m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_80m',cb80m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_60m',cb60m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_40m',cb40m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_30m',cb30m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_20m',cb20m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_17m',cb17m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_15m',cb15m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_12m',cb12m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_10m',cb10m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_6m',cb6m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_4m',cb4m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_2m',cb2m.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_70cm',cb70cm.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_All_Modes',cbAllModes.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_CW',cbCW.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_Data',cbData.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Show_Phone',cbSSB.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_All_Spots',cbAllSpots.Checked);
  SaveValueToConfigFile(sConfigRoot,'DXCluster_Local',seDistance.Value);
  SaveFormPositionToConfigFile(sConfigRoot,'DXClusterWinPos',frmClusterClient);
  SaveValueToConfigFile(sConfigRoot,'DXClusterWin_FormState',formmode);
  CloseAction := caFree;
  frmClusterClient := nil;
end;

procedure TfrmClusterClient.FormShow (Sender: TObject );
begin
	GetFormPositionFromConfigFile(sConfigRoot,'DXClusterWinPos',frmClusterClient);
  Delay(50);
  FormState(GetValueFromConfigFile(sConfigRoot,'DXClusterWin_FormState',0));
  cbAllBands.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_All',true);
  cb160m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_160m',true);
  cb80m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_80m',true);
  cb60m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_60m',true);
  cb40m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_40m',true);
  cb30m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_30m',true);
  cb20m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_20m',true);
  cb17m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_17m',true);
  cb15m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_15m',true);
  cb12m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_12m',true);
  cb10m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_10m',true);
  cb6m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_6m',true);
  cb4m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_4m',true);
  cb2m.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_2m',true);
  cb70cm.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_70cm',true);
  cbAllModes.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_All_Modes',true);
  cbCW.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_CW',true);
  cbData.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_Data',true);
  cbSSB.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_Show_Phone',true);
  cbAllSpots.Checked := GetValueFromConfigFile(sConfigRoot,'DXCluster_All_Spots',true);
  seDistance.Value := GetValueFromConfigFile(sConfigRoot,'DXCluster_Local',1000);
  seDistance.Enabled := not cbAllSpots.Checked;
  showinfo := GetValueFromConfigFile(sConfigRoot,'DX_Cluster_ShowInfo',false);
end;

procedure TfrmClusterClient.FormState(m: integer);
var
  sticktobottom: boolean;
begin
  sticktobottom := (Self.Top + Self.Height + 30) >= (Screen.DesktopHeight - 10);
  case m of
  0:  begin
        // filters hidden
        GroupBox1.Visible := false;
        frmClusterClient.Height :=  sgCluster.Top + sgCluster.Height + 30;
        btnFilters.Caption := 'v';
        btnFilters.Hint := 'Show filter settings';
      end;
  1:  begin
        frmClusterClient.Height :=  GroupBox1.Top + GroupBox1.Height + 30;
        Delay(20);
        GroupBox1.Visible := true;
        btnFilters.Caption := '^';
        btnFilters.Hint := 'Hide filter settings';
      end;
  end;
  Application.ProcessMessages;
  if sticktobottom or ((Self.Top + Self.Height) >= Screen.DesktopHeight) then
    Self.Top := Screen.DesktopHeight - Self.Height - 30;
  formmode := m;
end;

procedure TfrmClusterClient.btnFiltersClick(Sender: TObject);
var
  m: integer;
begin
  if btnFilters.Caption = '^' then
    m := formmode - 1
  else
    m := formmode + 1;
  FormState(m);
end;

procedure TfrmClusterClient.FormCreate(Sender: TObject);
begin
  Font := frmMain.Font;
  if Font.Name <> '' then
  begin
    sgCluster.Font.Name := Font.Name;
    sgCluster.Font.Size := Font.Size;
  end;
end;

procedure TfrmClusterClient.btnPinClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,
    SWP_NOREDRAW or SWP_NOMOVE or SWP_NOSIZE);
  {$ENDIF}
end;

procedure TfrmClusterClient.btnChatClick(Sender: TObject);
begin
  with frmMain do
    SendSpot(Format('%4.1f',[curr_f]),edCall.Text,edName.Text,cbMode.Text,edRSTS.Text,edGrid.Text);
end;

procedure TfrmClusterClient.SendSpot(freq, call, cname, mode, rsts, grid : string);
begin
  frmClusterSpot := TfrmClusterSpot.Create(Self);
  frmClusterSpot.Font := Font;
  frmClusterSpot.Label11.Font.Name := Font.Name;
  frmClusterSpot.Label12.Font.Name := Font.Name;
  frmClusterSpot.Label13.Font.Name := Font.Name;
  frmClusterSpot.name := cname;
  frmClusterSpot.mode := mode;
  frmClusterSpot.rsts := rsts;
  frmClusterSpot.grid := grid;
  with frmClusterSpot do
  begin
    edFreq.Text := freq;
    edCall.Text := call;
    if ShowModal = mrOK then
      cluster.Send(Trim(Format('dx %s %s %s',[edFreq.Text,edCall.Text,edComment.Text]))+#13#10);
  end;
  frmClusterSpot.Destroy;
  frmClusterSpot := nil;
end;

procedure TfrmClusterClient.btnShowMsgClick(Sender: TObject);
begin
  frmClusterMsg := TfrmClusterMsg.Create(Self);
  frmClusterMsg.Font := Font;
//  frmClusterMsg.Memo1.Font := ????;
  frmClusterMsg.Memo1.Text := loginmsg;
  frmClusterMsg.ShowModal;
  frmClusterMsg.Destroy;
  frmClusterMsg := nil;
end;

procedure TfrmClusterClient.sgClusterClick (Sender: TObject );
var
  call,prefix,country,continent,cqzone,ituzone: string;
  lat,lon,range,bearing: extended;
begin
  if inupdate then Exit;
  call := sgCluster.Cells[1,sgCluster.Row];
  if not ValidCall(call) then Exit;
  if ctydatavailable then
  begin
    if FindCountry(call,prefix,country,continent,cqzone,ituzone,lat,lon) then
    begin
      PathCalc(mylat,mylon,lat,lon,false,range,bearing);
      StatusBar.Caption := Format('%s: %s (%s) CQ: %s ITU: %s QRB: %4.0fkm  QTF: %3.0f%s',[prefix,country,continent,cqzone,ituzone,range,bearing,sDeg]);
      StatusBar.Hint := StatusBar.Caption;
    end;
  end;
end;

procedure TfrmClusterClient.sgClusterDblClick (Sender: TObject );
var
  call, freq: string;
  bnd, md, p: integer;
begin
  if inupdate then Exit;
  call := sgCluster.Cells[1,sgCluster.Row];
  freq := sgCluster.Cells[2,sgCluster.Row];
  try
    BandMode(freq, bnd, md);
    p := Pos('.',freq);
    if p > 0 then
    begin
      Delete(freq,p,1);
      Insert(DecimalSeparator,freq,p-3);
      if frmMain.connected then
        frmMain.SetFrequency(freq,md,'')
      else if fldigiactive then
      begin
        Fldigi_SetFrequency(StrToFloat(freq)*1000000.0);
        if (md = 3) or (md = 7) then
          Fldigi_SetMode('CW')
        else if (md = 6) or (md = 9) then
          Fldigi_SetMode('BPSK31');
      end;
      Delay(1000);
      frmMain.SetFocus;
      frmMain.InsertText(call);
    end;
  except
  end;
end;

var
  btmp: boolean = false;

procedure TfrmClusterClient.cbAllBandsClick (Sender: TObject );
begin
  if btmp then Exit;
  cb160m.Checked := cbAllBands.Checked;
  cb80m.Checked := cbAllBands.Checked;
  cb60m.Checked := cbAllBands.Checked;
  cb40m.Checked := cbAllBands.Checked;
  cb30m.Checked := cbAllBands.Checked;
  cb20m.Checked := cbAllBands.Checked;
  cb17m.Checked := cbAllBands.Checked;
  cb15m.Checked := cbAllBands.Checked;
  cb12m.Checked := cbAllBands.Checked;
  cb10m.Checked := cbAllBands.Checked;
  cb6m.Checked := cbAllBands.Checked;
  cb4m.Checked := cbAllBands.Checked;
  cb2m.Checked := cbAllBands.Checked;
  cb70cm.Checked := cbAllBands.Checked;
  if not cbAllBands.Checked then
    sgCluster.RowCount := 1;
end;

procedure TfrmClusterClient.cbModeFilterClick (Sender: TObject );
begin
  if not TCheckBox(Sender).Checked then
  begin
    btmp := true;
    cbAllModes.Checked := false;
    Application.ProcessMessages;
    sgCluster.RowCount := 1;
    btmp := false;
  end;
end;

procedure TfrmClusterClient.cbBandFilterClick (Sender: TObject );
begin
  if not TCheckBox(Sender).Checked then
  begin
    btmp := true;
    cbAllBands.Checked := false;
    Application.ProcessMessages;
    sgCluster.RowCount := 1;
    btmp := false;
  end;
end;

procedure TfrmClusterClient.cbAllModesClick (Sender: TObject );
begin
  if btmp then Exit;
  cbCW.Checked := cbAllModes.Checked;
  cbData.Checked := cbAllModes.Checked;
  cbSSB.Checked := cbAllModes.Checked;
  if not cbAllModes.Checked then
    sgCluster.RowCount := 1;
end;

procedure TfrmClusterClient.cbAllSpotsClick(Sender: TObject);
begin
  seDistance.Enabled := not cbAllSpots.Checked;
end;

procedure TfrmClusterClient.TimerTimer (Sender: TObject );
var
  s, de, dx, freq, comment, time, sband, smode, str: string;
  infostr, newstr, wkdstr, cname, qth, grid, s1, s2, s3, s4, s5: string;
  p, r, band, mode: integer;
  delat, delon, dist, b: extended;
  showspot: boolean;
begin
  if cluster.Sock.LastError <> 0 then
  begin
    Close;
    Exit;
  end;
  inupdate := true;
  while cluster.Sock.WaitingData > 0 do
  begin
    s := Trim(cluster.RecvTerminated(#13));
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
          comment := Trim(Copy(s,40,30));
          time := Copy(s,71,4);
          if ValidCall(dx) then
          begin
            showspot := cbAllSpots.Checked and cbAllBands.Checked and cbAllModes.Checked;
            if not showspot then
            begin
              case band of
              1:  begin showspot := cb160m.Checked; sband := '160m'; end;
              3:  begin showspot := cb80m.Checked; sband := '80m'; end;
              5:  begin showspot := cb60m.Checked; sband := '60m'; end;
              7:  begin showspot := cb40m.Checked; sband := '40m'; end;
              10: begin showspot := cb30m.Checked; sband := '30m'; end;
              14: begin showspot := cb20m.Checked; sband := '20m'; end;
              18: begin showspot := cb17m.Checked; sband := '17m'; end;
              21: begin showspot := cb15m.Checked; sband := '15m'; end;
              24: begin showspot := cb12m.Checked; sband := '12m'; end;
              28: begin showspot := cb10m.Checked; sband := '10m'; end;
              50: begin showspot := cb6m.Checked; sband := '6m'; end;
              70: begin showspot := cb4m.Checked; sband := '4m'; end;
              144: begin showspot := cb2m.Checked; sband := '2m'; end;
              432: begin showspot := cb70cm.Checked; sband := '70cm'; end;
              end;
              if not cbAllModes.Checked then
                case mode of
                3, 7: showspot := showspot and cbCW.Checked;
                6, 9: showspot := showspot and cbData.Checked;
                else
                  showspot := showspot and cbSSB.Checked;
                end;
              if not cbAllSpots.Checked then
              begin
                if ValidCall(de) then
                begin
                  FindCountry(de, s1, s2, s3, s4, s5, delat, delon);
                  PathCalc(delat,delon,mylat,mylon,false,dist,b);
                  showspot := showspot and (dist < seDistance.Value);
                end
                else
                  showspot := false;
              end;
            end;
            if showspot then
            begin
              r := sgCluster.RowCount;
              sgCluster.RowCount := r + 1;
              sgCluster.Cells[0,r] := de;
              sgCluster.Cells[1,r] := dx;
              sgCluster.Cells[2,r] := freq;
              sgCluster.Cells[3,r] := comment;
              sgCluster.Cells[4,r] := time;
              // make new row visible
              if sgCluster.RowCount > 15 then
                sgCluster.TopRow := sgCluster.RowCount - 15;
              smode := ModeStr[radio,mode];
              infostr := ''; newstr := ''; wkdstr := '';
              frmMain.ContactInfo(dx, sband, smode, infostr, newstr, wkdstr, cname, qth, grid);
              if Length(wkdstr) > 0 then
              begin
                if contestmode then
                  sgCluster.Cells[3,r] := '*DUP*'
                else if showinfo then
                  sgCluster.Cells[3,r] := wkdstr;
              end
              else
                if (newstr <> '') and showinfo then
                  sgCluster.Cells[3,r] := newstr;
              StatusBar.Caption := infostr;
              StatusBar.Hint := StatusBar.Caption;
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

function TfrmClusterClient.Login( host, port, userid, passwd: string): Boolean;
begin
  Result := false;
  cluster := TTelnetSend.Create;
  try
    cluster.TargetHost := host;
    cluster.TargetPort := port;
    cluster.TermType := 'dumb';
    cluster.Timeout := 5000;
    StatusBar.Caption := Format('Connecting to %s:%s',[host,port]);
    Application.ProcessMessages;
    if cluster.Login then
    begin
      StatusBar.Caption := Format('Logging in as %s',[userid]);
      cluster.WaitFor(':');
      Delay(50);
      cluster.Send(userid+#13+#10);
      if Length(passwd) > 0 then
      begin
        cluster.WaitFor('password:');
        cluster.Send(passwd+#13+#10);
      end;
      loginmsg := cluster.RecvTerminated('>');
      StatusBar.Caption := Format('Connected to %s',[host]);
      btnShowMsg.Enabled := true;
      btnChat.Enabled := true;
      Delay(50);
      inupdate := false;
      Timer.Enabled := true;
      Result := true;
    end
    else
      StatusBar.Caption := Format('Failed to connect to %s:%s',[host,port]);
  except
    StatusBar.Caption := 'Exception occurred during login';
  end;
end;

initialization
  {$I dxcluster.lrs}

end.

