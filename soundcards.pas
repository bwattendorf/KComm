unit soundcards;

{$mode objfpc}{$H+}

// Thanks for this code to Patrick Lindecker, F6CTE

interface

uses
  Classes, SysUtils, MMSystem;

const
  MAX_SOUND_DEVICES = 15;

type
  TNameArray = array[1..MAX_SOUND_DEVICES] of string;

procedure GetNamesOfInputSoundCards(var table_of_names: TNameArray);
procedure GetNamesOfOutputSoundCards(var table_of_names: TNameArray);
function GetSoundCardIDFromName(name: string; input: boolean): integer;

implementation

procedure GetNamesOfInputSoundCards(var table_of_names: TNameArray);
{il est fourni le number de cartes son en entrée et la procédure fournit les
noms de ces cartes en partant de la première carte (DEVICE ID=0)}
  var counter: Byte;
  var wave_In_caps: PwaveInCaps;
  var devcaps: Word;
  var szPName: Pchar; {product name (NULL terminated string)}
begin
  New(wave_In_caps);
  for counter := 1 to MAX_SOUND_DEVICES do
  begin
    {donne capacités de l'entrée}
    {Arguments de la fonction: 3 entrées et aucune sortie}
    devcaps := waveInGetDevCaps(counter-1,wave_In_caps,SIZEOF(wave_In_caps^));
    if devcaps = 0 then {succès}
    begin
      szPName := wave_In_caps^.szPname;
      table_of_names[counter]:=szPName;
    end
    else
    begin
      table_of_names[counter]:='';
    end;
  end;
  Dispose(wave_In_caps);
end;


procedure GetNamesOfOutputSoundCards(var table_of_names: TNameArray);
{il est fourni le number de cartes son en sortie et la procédure fournit les
noms de ces cartes en partant de la première carte (DEVICE ID=0)}
  var counter: Byte;
  var wave_Out_caps: PwaveOutCaps;
  var devcaps: Word;
  var szPName: Pchar; {product name (NULL terminated string)}
begin
  New(wave_Out_caps);
  for counter := 1 to MAX_SOUND_DEVICES do
  begin
    {donne capacités de la sortie}
    {Arguments de la fonction: 3 entrées et aucune sortie}
    devcaps := waveOutGetDevCaps(counter-1,wave_Out_caps,SIZEOF(wave_Out_caps^));
    if devcaps = 0 then {succès}
    begin
      szPName := wave_Out_caps^.szPname;
      table_of_names[counter]:=szPName;
    end
    else
    begin
      table_of_names[counter]:='';
    end;
  end;
  Dispose(wave_Out_caps);
end;

function GetSoundCardIDFromName(name: string; input: boolean): integer;
var
  i: integer;
  names: TNameArray;
begin
  case input of
    true: GetNamesOfInputSoundCards(names);
    false: GetNamesOfOutputSoundCards(names);
  end;
  Result := -1;
  if name = '' then Exit;
  for i := 1 to MAX_SOUND_DEVICES do
    if names[i] = name then Result := i - 1;
end;

end.

