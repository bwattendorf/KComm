unit stats;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls;

type

  { TfrmStats }

  TfrmStats = class(TForm)
    btnClose: TButton;
    btnRefresh: TButton;
    cbFilterType: TComboBox;
    cbExtraType: TComboBox;
    edFilterValue: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sgStats: TStringGrid;
    procedure btnRefreshClick(Sender: TObject);
    procedure cbFilterTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgStatsDblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    firstrec: integer;
    lastrec: integer;
    function FreqToIndex(freq: string): integer;
    function FmtZone(zone: string): string;
    procedure GenStats;
  end;

var
  frmStats: TfrmStats;

implementation

{ TfrmStats }

uses
  Main, Details, Countries, Utils;

var
  c,r: integer;
  s: array[1..7,0..18] of TStringList;
  aband: array[0..18] of integer;
  extra: array[0..18] of integer;

const
  bands: array[0..18] of string = ('','2190m','160m','80m','60m','40m','30m',
    '20m','17m','15m','12m','10m','6m','4m','2m','1.25m','70cm','23cm','All');

procedure TfrmStats.FormCreate(Sender: TObject);
begin
  // create the string lists for the results
  for c := 1 to 7 do
    for r := 0 to 18 do
      s[c,r] := TStringList.Create;
  // initialize
  cbFilterType.ItemIndex := 0;
  cbExtraType.ItemIndex := 0;
end;

procedure TfrmStats.cbFilterTypeChange(Sender: TObject);
begin
  Label3.Enabled:= (cbFilterType.ItemIndex > 0) and (cbFilterType.ItemIndex < 8);
  edFilterValue.Enabled:= (cbFilterType.ItemIndex > 0) and (cbFilterType.ItemIndex < 8);
end;

procedure TfrmStats.btnRefreshClick(Sender: TObject);
begin
  GenStats;
end;

procedure TfrmStats.FormDestroy(Sender: TObject);
begin
  // free the string lists for the results
  for c := 1 to 7 do
    for r := 0 to 18 do
      s[c,r].Destroy;
end;

procedure TfrmStats.FormShow(Sender: TObject);
begin
  GenStats;
end;

procedure TfrmStats.sgStatsDblClick(Sender: TObject);
begin
  with frmDetail do
  begin
    lbDetails.Clear;
    lbDetails.Items.Text := s[sgStats.Col,aband[sgStats.Row]].Text;
    ShowModal;
  end;
end;

function TfrmStats.FreqToIndex(freq: string): integer;
var
  f: double;
begin
  Result := 0;
  try
    f := StrToFloat(freq) / 1000000;
    if (f >= 0.136) and (f <=	0.137) then Result := 1
    else if (f >= 1.8) and (f <= 2.0) then Result := 2
    else if (f >= 3.5) and (f <= 4.0) then Result := 3
    else if (f >= 5.25) and (f <= 5.4) then Result := 4
    else if (f >= 7.0) and (f <= 7.3) then Result := 5
    else if (f >= 10.0) and (f <= 10.15) then Result := 6
    else if (f >= 14.0) and (f <= 14.35) then Result := 7
    else if (f >= 18.0) and (f <= 18.168) then Result := 8
    else if (f >= 21.0) and (f <= 21.45) then Result := 9
    else if (f >= 24.0) and (f <= 24.99) then Result := 10
    else if (f >= 28.0) and (f <= 29.7) then Result := 11
    else if (f >= 50) and (f <= 54) then Result := 12
    else if (f >= 70) and (f <= 71) then Result := 13
    else if (f >= 144) and (f <= 148) then Result := 14
    else if (f >= 222) and (f <= 225) then Result := 15
    else if (f >= 420) and (f <= 450) then Result := 16
    else if (f >= 1240) and (f <= 1300) then Result := 17;
  except
  end;
end;

function TfrmStats.FmtZone(zone: string): string;
var
  x: integer;
begin
  x := StrToIntDef(zone,0);
  if (x > 0) and (x < 100) then
    Result := Format('%.2d',[x])
  else
    Result := '';
end;

procedure TfrmStats.GenStats;
var
  i, row, x: integer;
  showband, include: boolean;
  prefix,country,continent,cqz,ituz,extraval: string;
  mycountry,mycontinent,mycqzone,myituzone: string;
  lat, lon, range, bearing: extended;
  logitems: TLogItems;
  
  procedure AddItem(item: string; list: TStringList);
  begin
    if list.IndexOf(item) < 0 then
      list.Add(item);
  end;
  
begin
  Label1.Caption := 'Wait...';
  Application.ProcessMessages;
  // clear the string lists for the results
  for c := 1 to 7 do
    for r := 0 to 18 do
      s[c,r].Clear;
   for r := 0 to 18 do
    extra[r] := 0;
  // clear the grid
  sgStats.RowCount := 1;
  // iterate through the selected records
  for i := firstrec to lastrec do
  begin
    ParseLogLine(Log.Strings[i],logitems);
    if i = firstrec then
    begin
      FindCountry(mycall,prefix,mycountry,mycontinent,mycqzone,myituzone,lat,lon);
      // if using ITU zone, my zone will be in exchange sent
      myituzone := FmtZone(logitems[12]);
    end;
    r := FreqToIndex(logitems[6]);
    if FindCountry(logitems[1],prefix,country,continent,cqz,ituz,lat,lon) then
    begin
      // calculate extra value, if specified
      case cbExtraType.ItemIndex of
      0:  extraval := '';
      1:  begin                                                                 // CQ WW DX contact points
            if mycountry = country then           // contacts in same country score 0
            begin
              x := 0;
              extraval := '0';
            end
            else if mycontinent = continent then  // contacts in same continent score 1 (2 in NA)
            begin
              if mycontinent = 'NA' then
              begin
                x := 2;
                extraval := '2';
              end
              else
              begin
                x := 1;
                extraval := '1';
              end;
            end
            else
            begin                                 // contacts in other continents score 3
              x := 3;
              extraval := '3';
            end;
          end;
      3:  begin                                                                 // CQ WW WPX contact points
            if mycountry = country then           // contacts in same country score 1
            begin
              x := 1;
              extraval := '1';
            end
            else if mycontinent = continent then
            begin
              if r < 7 then                       // contacts in same continent score 2 on low bands
              begin
                x := 2;
                extraval := '2';
              end
              else
              begin                               // and 1 on high bands
                x := 1;
                extraval := '1';
              end;
            end
            else
            begin
              if r < 7 then                       // contacts in other continents score 6 on low bands
              begin
                x := 6;
                extraval := '6';
              end
              else
              begin                               // and 3 on high bands
                x := 3;
                extraval := '3';
              end;
            end;
          end;
      2,5:begin                                                                 // CQ WW DX multipliers
            extraval := logitems[13];             // exch recvd is CQ zone
            if extraval <> '' then
              extraval := FmtZone(extraval);
          end;
      7:  extraval := UpperCase(logitems[13]);
      4:  begin
            extraval := prefix;
          end;
      6:  begin                                                                 // IARU Championship contact points
            ituz := FmtZone(Trim(Copy(logitems[13],1,2)));
            if ituz <> '00' then
            begin
              if myituzone = ituz then              // contacts in same zone score 1
              begin
                x := 1;
                extraval := '1';
              end
              else if mycontinent = continent then  // contacts in same continent score 3
              begin
                x := 3;
                extraval := '3';
              end
              else
              begin                                 // contacts in other continents score 5
                x := 5;
                extraval := '5';
              end;
            end
            else
              extraval := '';
          end;
      8,9:if (Length(logitems[21]) = 6) and (ValidLocator(logitems[21])) then   // QRB (from grid square)
          begin
            LocatorToGeog(logitems[21],lat,lon);
            PathCalc(mylat,mylon,lat,lon,false,range,bearing);
            x := Trunc(range);
            extraval := logitems[1];
          end
          else
            x := 0;
      end;
      case cbFilterType.ItemIndex of
      0:  include := true;
      1:  include := logitems[1] = UpperCase(edFilterValue.Text);
      2:  include := logitems[9] = UpperCase(edFilterValue.Text);
      3:  include := prefix = UpperCase(edFilterValue.Text);
      4:  include := Copy(logitems[21],1,4) = UpperCase(edFilterValue.Text);
      5:  include := UpperCase(country) = UpperCase(edFilterValue.Text);
      6:  include := continent = UpperCase(edFilterValue.Text);
      7:  include := extraval = UpperCase(edFilterValue.Text);
      8:  include := logitems[5] <> '';
      end;
      if include then
      begin
        // add qsos
        s[1,r].Add(logitems[1]);
        s[1,18].Add(logitems[1]);
        // add unique calls
        AddItem(logitems[1],s[2,r]);
        AddItem(logitems[1],s[2,18]);
        // add prefixes
        AddItem(prefix,s[3,r]);
        AddItem(prefix,s[3,18]);
        // add grid squares
        if Length(logitems[21]) >= 4 then
        begin
          AddItem(Copy(logitems[21],1,4),s[4,r]);
          AddItem(Copy(logitems[21],1,4),s[4,18]);
        end;
        // add countries
        AddItem(country,s[5,r]);
        AddItem(country,s[5,18]);
        // add continents
        AddItem(continent,s[6,r]);
        AddItem(continent,s[6,18]);
        // add extra value
        case cbExtraType.ItemIndex of
        1,3,6,8:
            begin
              extra[r] := extra[r] + x;
              extra[18] := extra[18] + x;
            end;
        4:  if Length(extraval) > 0 then AddItem(extraval,s[7,18]);
        2,5:begin
              if cbExtraType.ItemIndex = 2 then // country is multiplier
              begin
                AddItem(country,s[7,r]);
                AddItem(Format('%s (%s)',[country,bands[r]]),s[7,18]);
              end;
              if Length(extraval) > 0 then
              begin
                AddItem(extraval,s[7,r]);         // zone (received) is multiplier
                AddItem(Format('%s (%s)',[extraval,bands[r]]),s[7,18]);
              end;
            end;
        7:  if Length(extraval) > 0 then
            begin
              AddItem(extraval,s[7,r]);
              AddItem(extraval,s[7,18]);
            end;
        9:  if Length(extraval) > 0 then
            begin
              if x > extra[r] then
                extra[r] := x;
              AddItem(Format('%5d km %s',[x,extraval]),s[7,r]);
              if x > extra[18] then
                extra[18] := x;
              AddItem(Format('%5d km %s (%s)',[x,extraval,bands[r]]),s[7,18]);
            end;
        end;
      end;
    end;
  end;
  // display the results
  for r := 1 to 18 do
  begin
    showband := false;
    for c := 1 to 7 do
      if (s[c,r].Count > 0) or (extra[r] > 0) or (r = 18) then showband := true;
    if showband then
    begin
      sgStats.RowCount := sgStats.RowCount + 1;
      row := sgStats.RowCount-1;
      sgStats.Cells[0,row] := bands[r];
      aband[row] := r;
      for c := 1 to 6 do
        if s[c,r].Count > 0 then sgStats.Cells[c,row] := IntToStr(s[c,r].Count);
      case cbExtraType.ItemIndex of
      1,3,6,8:
          sgStats.Cells[7,row] := IntToStr(extra[r]);
      2,4,5,7:
          if s[7,r].Count > 0 then sgStats.Cells[7,row] := IntToStr(s[7,r].Count);
      9:  begin
            if extra[r] > 0 then sgStats.Cells[7,row] := IntToStr(extra[r])+' km';
            s[7,r].Sort;
          end;
      end;
    end;
  end;
  Label1.Caption := 'Double-click a cell for more information';
end;

initialization
  {$I stats.lrs}

end.

