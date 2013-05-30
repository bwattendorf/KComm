unit WFPalette;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Windows;

var
  palette: array[0..255] of TColor;

procedure ResetDefaultPalette;
procedure LoadPaletteFromFile(filename: string);

implementation

procedure ResetDefaultPalette;
var
  i, v: integer;
begin
  for i := 0 to 255 do
  begin
    v := i div 2;
    v := (v * v * v) div 2048;
    if v > 255 then v := 255;
    palette[i] := RGB(0, v, 0);
  end;
end;

procedure LoadPaletteFromFile(filename: string);
var
  i, r, g, b, p: integer;
  line: string;
  f: TStringList;
begin
  if FileExists(filename) then
  begin
    f := TStringList.Create;
    try
      f.LoadFromFile(filename);
      if f.Count >= 256 then
        for i := 0 to 255 do
        begin
          line := Trim(f.Strings[255-i]);
          p := Pos(' ',line);
          if p > 0 then
          begin
            r := StrToIntDef(Copy(line,1,p-1),0);
            Delete(line,1,p);
          end;
          line := Trim(line);
          p := Pos(' ',line);
          if p > 0 then
          begin
            g := StrToIntDef(Copy(line,1,p-1),0);
            Delete(line,1,p);
          end;
          line := Trim(line);
          b := StrToIntDef(line,0);
          palette[i] := RGB(r,g,b);
        end;
    finally
      f.Destroy;
    end;
  end;
end;

initialization

  ResetDefaultPalette;

finalization

end.

