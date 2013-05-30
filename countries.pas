unit countries;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

// look up country info from data file
// uses wf1b.dat created by AD1C (www.country-files.com)
// uses override data file prefix.dat in the same format
// which contains info for countries such as United States
// where wf1b.dat does not contain sufficient distinguishing
// info (e.g. multiple CQ and ITU zones within USA.)

interface

uses
  Forms, Classes, SysUtils;

var
  ctydatavailable: boolean;
  
procedure CtyInit;
function FindCountry(call: string; var prefix, country, continent, cqzone, ituzone: string; var lat, lon: Extended): Boolean;

implementation

uses
  Main, Utils;

var
  ctydat, pfxdat: TStringList;
  ctycnt, pfxcnt: integer;
  
procedure CtyInit;
var
  datfile: string;
begin
  datfile := progpath+'prefix.dat';
  if FileExists(datfile) then
    pfxdat.LoadFromFile(datfile);
  pfxcnt := pfxdat.Count;
  datfile := progpath+'wf1b.dat';
  if FileExists(datfile) then
    ctydat.LoadFromFile(datfile);
  ctycnt := ctydat.Count;
  ctydatavailable := ctycnt > 0;
end;

function FindCountry(call: string; var prefix, country, continent, cqzone, ituzone: string; var lat, lon: Extended): Boolean;
var
  i, l, p: integer;
  line, cline, c, pfx, ccall: string;
  match: boolean;
  dstmp: char;
label
  results;
begin
  Result := ctydatavailable;
  if not ctydatavailable then Exit;
  if Length(call) < 3 then
  begin
    Result := false;
    Exit;
  end;
  ccall := CtryCall(call);
  l := Length(ccall);
  i := 1;
  while (i <= l) and (ccall[i] in ['0'..'9']) do inc(i);
  while (i <= l) and (ccall[i] in ['A'..'Z']) do inc(i);
  while (i <= l) and (ccall[i] in ['0'..'9']) do inc(i);
  prefix := Copy(ccall,1,i-1);
  if Length(prefix) = 0 then
  begin
    Result := false;
    Exit;
  end;
  match := false;
  // first, check the prefix.dat file
  if pfxcnt > 0 then
  begin
    // scan for exact match on call
    i := 0;
    c := ','+call+',';
    repeat
      line := pfxdat.Strings[i];
      if Length(line) > 0 then
      begin
        if line[1] in ['A'..'Z'] then
          // new country line
          cline := line
        else
        begin
          // call / prefix line
          line := ','+Trim(line);
          p := Pos(';',line);
          if p > 0 then
            line[p] := ',';
          match := Pos(c,line) > 0;
        end;
      end;
      inc(i)
    until (i >= pfxcnt) or match;
    if not match then
    begin
      pfx := prefix;
      // scan for match on prefix
      while (Length(pfx) > 0) and not match do
      begin
        i := 0;
        c := ','+pfx+',';
        repeat
          line := pfxdat.Strings[i];
          if Length(line) > 0 then
          begin
            if line[1] in ['A'..'Z'] then
              // new country line
              cline := line
            else
            begin
              // call / prefix line
              line := ','+Trim(line);
              p := Pos(';',line);
              if p > 0 then
                line[p] := ',';
              match := Pos(c,line) > 0;
            end;
          end;
          inc(i)
        until (i >= pfxcnt) or match;
        Delete(pfx,Length(pfx),1);
      end;
    end;
  end;
  if match then goto results;
  // scan for exact match on call
  i := 0;
  match := false;
  c := ','+call+',';
  repeat
    line := ctydat.Strings[i];
    if Length(line) > 0 then
    begin
      if line[1] in ['A'..'Z'] then
        // new country line
        cline := line
      else
      begin
        // call / prefix line
        line := ','+Trim(line);
        p := Pos(';',line);
        if p > 0 then
          line[p] := ',';
        match := Pos(c,line) > 0;
      end;
    end;
    inc(i)
  until (i >= ctycnt) or match;
  if not match then
  begin
    pfx := prefix;
    // scan for match on prefix
    while (Length(pfx) > 0) and not match do
    begin
      i := 0;
      c := ','+pfx+',';
      repeat
        line := ctydat.Strings[i];
        if Length(line) > 0 then
        begin
          if line[1] in ['A'..'Z'] then
            // new country line
            cline := line
          else
          begin
            // call / prefix line
            line := ','+Trim(line);
            p := Pos(';',line);
            if p > 0 then
              line[p] := ',';
            match := Pos(c,line) > 0;
          end;
        end;
        inc(i)
      until (i >= ctycnt) or match;
      Delete(pfx,Length(pfx),1);
    end;
  end;
results:
  if match then
  begin
    p := Pos(':',cline);
    if p > 0 then
    begin
      country := Copy(cline,1,p-1);
      Delete(cline,1,26);
    end;
    p := Pos(':',cline);
    if p > 0 then
    begin
      cqzone := Trim(Copy(cline,1,p-1));
      Delete(cline,1,p);
    end;
    p := Pos(':',cline);
    if p > 0 then
    begin
      ituzone := Trim(Copy(cline,1,p-1));
      Delete(cline,1,p);
    end;
    p := Pos(':',cline);
    if p > 0 then
    begin
      continent := Trim(Copy(cline,1,p-1));
      Delete(cline,1,p);
    end;
    dstmp := DecimalSeparator;
    p := Pos(':',cline);
    if p > 0 then
    begin
      try
        lat := StrToFloat(Trim(Copy(cline,1,p-1)));
      except
      end;
      Delete(cline,1,p);
    end;
    p := Pos(':',cline);
    if p > 0 then
    begin
      try
        lon := StrToFloat(Trim(Copy(cline,1,p-1)));
      except
      end;
      Delete(cline,1,p);
    end;
    DecimalSeparator := dstmp;
  end;
  Result := match;
end;

initialization
  ctydat := TStringList.Create;
  pfxdat := TStringList.Create;
  ctydatavailable := false;

finalization
  ctydat.Destroy;
  pfxdat.Destroy;

end.

