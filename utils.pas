unit utils;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 - 2013 Julian Moss, G4ILO  (www.g4ilo.com)                    //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  {$IFDEF WINDOWS}
  Windows,
  {$ELSE}
  lclintf,
  {$ENDIF}
  Forms, LCLType, StdCtrls, Classes, SysUtils, Process;
  
type
  TLogItems = Array[0..25] of string;
  (* LogItems - relationship with ADIF fields
    logitems[0] : OPERATOR or STATION_CALLSIGN
    logitems[1] : CALL
    logitems[2] : DATE,QSO_DATE,TIME_ON   (yyyymmddhhnnss)
    logitems[3] : TIME_OFF       (duration of qso in seconds, may be null)
    logitems[4] : QSLSDATE       (yyyymmdd = ADIF identical)
    logitems[5] : QSLRDATE       (yyyymmdd = ADIF identical)
    logitems[6] : FREQ           (integer Hz)
    logitems[7] : FREQ_RX        (integer Hz, or 0 if no difference)
    logitems[8] :
    logitems[9] : MODE
    logitems[10]: RST_SENT
    logitems[11]: RST_RCVD
    logitems[12]: STX or STX_STRING
    logitems[13]: SRX or SRX_STRING
    logitems[14]: NAME
    logitems[15]: QTH
    logitems[16]: NOTES
    logitems[17]:                (domain)
    logitems[18]: QSL_VIA
    logitems[19]: CNTY, STATE
    logitems[20]: IOTA
    logitems[21]: GRIDSQUARE
    logitems[22]:
    logitems[23]: EQSL_QSLSDATE
    logitems[24]: EQSL_QSLRDATE
    logitems[25]: COMMENT
  *)

{$IFDEF WINDOWS}
type
  TWinVersion = (wvUnknown, wvWin95, wvWin98, wvWin98SE, wvWinNT, wvWinME,
    wvWin2000, wvWinXP, wvWinVista, wvWin7, wvWin8);

const
  WinVerString: array[0..10] of string = (
    'unknown',
    'Windows 95',
    'Windows 98',
    'Windows 98 SE',
    'Windows NT',
    'Windows ME',
    'Windows 2000',
    'Windows XP',
    'Windows Vista',
    'Windows 7',
    'Windows 8' );

  Modes = 'SSBUSBLSBCWRTTBPSKFMAMASCATV4CLOFAXGTOHELHFSJT4JT6MFSMT6OLIPACPKTQPSSTHRTOROSDVDSTARJT9ISCAT';

function GetWinVersion: TWinVersion;
function ForceForegroundWindow(h: Handle): Boolean;
{$ENDIF}

procedure Delay(n: cardinal);
function Upper(c: char): char;

function StripAll(c: char; s: string): string;
function StripStr(t, s: string): string;
function StripTags(s: string): string;
function CleanText(s: string): string;
function CapText(s: string): string;
function ValidDate(d: string): boolean;
function ValidTime(t: string): boolean;
function ValidCall(c: string): boolean;
function ValidFreq(f: string; l: integer = 5): boolean;
function ValidRpt(r, mode: string): boolean;
function ValidLocator(r: string): boolean;
function ValidIOTA(r: string): boolean;
function CtryCall(c: string): string;
function ADIFmode(mode: string): string;
function ShowDate(dtstr: string): string;
function ShowTime(dtstr: string): string;
function ShowFreq(freqstr: string; kHz: boolean = false): string;
function StrToFreq(const freqstr: string): extended;
function FreqToBand(freq: string): string;
procedure BandMode(freq: string; var b, md: integer);
procedure LocatorToGeog(const loc: string; var lat, lon: extended);
procedure PathCalc(tlat,tlon,rlat,rlon: extended; lpath: Boolean; var range,bearing: extended);
function ParseFromText(key1, key2, ignore1, ignore2, str: string; var txt: string; check: boolean): boolean;
procedure ParseLogLine(line: string; var logitems: TLogItems);
procedure OpenURL( url: string );
function GetPath( cmdline: string ): string;
function RunProgram( progpath, args: string ): boolean;
function GetCharEncoding(encoding: string): integer;
function StrToUTF8(s: string; encoding: integer): string;
function UTF8ToStr(s: string; encoding: integer): string;
procedure AddText( memo: TMemo; s: string );
function APos(const needle, haystack: string): integer;  // non case-sensitive Pos function

var
  rxcharset,
  txcharset,
  syscharset: integer;

implementation

uses
  Math, LConvEncoding, Config, Main;

// var
// rd,cnv: extended;

{$IFDEF WINDOWS}
function ForceForegroundWindow(h: Handle): Boolean;
var
  fh: Handle;
  tid1, tid2: Cardinal;
begin
  fh := GetForegroundWindow;
  if h = fh then
    Result := true
  else
  begin
    tid1 := GetWindowThreadProcessId(fh,nil);
    tid2 := GetWindowThreadProcessId(h,nil);
    if tid1 = tid2 then
      Result := SetForegroundWindow(h)
    else
    begin
      AttachThreadInput(tid1,tid2,true);
      Result := SetForegroundWindow(h);
      AttachThreadInput(tid1,tid2,false);
    end;
    if IsIconic(h) then
      ShowWindow(h,SW_RESTORE)
    else
      ShowWindow(h,SW_SHOW);
  end;
end;

function GetWinVersion: TWinVersion;
var
   osVerInfo: TOSVersionInfo;
   majorVersion, minorVersion: Integer;
begin
   Result := wvUnknown;
   osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo) ;
   if GetVersionEx(osVerInfo) then
   begin
     minorVersion := osVerInfo.dwMinorVersion;
     majorVersion := osVerInfo.dwMajorVersion;
     case osVerInfo.dwPlatformId of
       VER_PLATFORM_WIN32_NT:
       begin
         if majorVersion <= 4 then
           Result := wvWinNT
         else if (majorVersion = 5) and (minorVersion = 0) then
           Result := wvWin2000
         else if (majorVersion = 5) and (minorVersion = 1) then
           Result := wvWinXP
         else if (majorVersion = 6) then
           Result := wvWinVista
         else if (majorVersion = 7) then
           Result := wvWin7
         else if (majorVersion = 8) then
           Result := wvWin8;
       end;
       VER_PLATFORM_WIN32_WINDOWS:
       begin
         if (majorVersion = 4) and (minorVersion = 0) then
           Result := wvWin95
         else if (majorVersion = 4) and (minorVersion = 10) then
         begin
           if osVerInfo.szCSDVersion[1] = 'A' then
             Result := wvWin98SE
           else
             Result := wvWin98;
         end
         else if (majorVersion = 4) and (minorVersion = 90) then
           Result := wvWinME
         else
           Result := wvUnknown;
       end;
     end;
   end;
end;
{$ENDIF}

procedure Delay(n: Cardinal);
var
	start: Cardinal;
begin
	start := GetTickCount;
  repeat
    Application.ProcessMessages;
	until (GetTickCount - start) >= n;
end;

function Upper(c: char): char;
begin
  if c in ['a'..'z'] then
    Result := Chr(Ord(c)-$20)
  else
    Result := c;
end;

function StripAll(c: char; s: string): string;
begin
  Result := StringReplace(s,c,'',[rfReplaceAll]);
end;

function StripStr(t, s: string): string;
begin
  Result := StringReplace(s,t,'',[rfReplaceAll]);
end;

function StripTags(s: string): string;
// remove html tags from a string
var
  p, p2: integer;
begin
  Result := s;
  repeat
    p := Pos('<',Result);
    if p > 0 then
    begin
      p2 := Pos('>',Result);
      if p2 = 0 then p2 := p;
      Delete(Result,p,p2-p+1);
    end;
  until p = 0;
end;

function CleanText(s: string): string;
// remove characters you don't want to be in a log record
begin
  Result := StripAll(';',s);
  Result := StripAll('<',Result);
  Result := Trim(StripAll('>',Result));
end;

function CapText(s: string): string;
var
  i: integer;
begin
  Result := LowerCase(s);
  i := 1;
  while i < (Length(Result) - 1) do
  begin
    if (i = 1) or (Result[i-1] = ' ') then
      Result[i] := Upper(Result[i]);
    inc(i);
  end;
end;

function Between(v, min, max: Integer): boolean;
begin
  Result := (v >= min) and (v <= max);
end;

function ValidDate(d: string): boolean;
begin
  Result := (Length(d) = 10)
    and (d[5] = DateSeparator)
    and (d[8] = DateSeparator)
    and Between(StrToIntDef(Copy(d,1,4),-1),1950,2020)
    and Between(StrToIntDef(Copy(d,6,2),-1),1,12)
    and Between(StrToIntDef(Copy(d,9,2),-1),1,31);
end;

function ValidTime(t: string): boolean;
begin
  Result := (Length(t) = 5)
    and (t[3] = TimeSeparator)
    and Between(StrToIntDef(Copy(t,1,2),-1),0,23)
    and Between(StrToIntDef(Copy(t,4,2),-1),0,59);
end;

var
  u_ctrycall: string;

function ValidCall(c: string): boolean;
var
  i, lc, p: integer;
  sc, scp: string;
  cp: char;

  function hasinvalid(s: string): boolean;
  var
    i: integer;
  begin
    Result := false;
    if Length(s) = 0 then Exit;
    for i := 1 to Length(s) do
      if not (s[i] in ['0'..'9','A'..'Z','/']) then
        Result := true;
  end;

  function callvalid(sc: string): boolean;
  begin
    Result := false;
    if Length(sc) <= 2 then exit;
    if (sc[1] in ['0'..'9']) then
    begin
      if not (sc[2] in ['A'..'Z']) then Exit;
      if not (sc[Length(sc)] in ['A'..'Z']) then Exit;
      Delete(sc,1,1);
    end;
    while (Length(sc) >= 1) and (sc[1] in ['A'..'Z']) do
      Delete(sc,1,1);
    if Length(sc) = 0 then Exit;
    while (Length(sc) >= 1) and (sc[1] in ['0'..'9']) do
      Delete(sc,1,1);
    if Length(sc) = 0 then Exit;
    while (Length(sc) >= 1) and (sc[1] in ['A'..'Z']) do
      Delete(sc,1,1);
    Result := Length(sc) = 0;
  end;

begin
  Result := false;
  u_ctrycall := '-';
  lc := Length(c);
  if (lc < 3) or (lc > 16) then Exit;   // call can't be less than 3 chars or more than 16
  sc := Uppercase(c);
  if hasinvalid(sc) then Exit;          // call can only contain '0'..'9','A'..'Z','/'
  p := Pos('/',sc);
  if p = 1 then Exit;                   // call can't start with a slash
  if sc[lc-1] = '/' then        // check for '/P', '/M', 'A' etc
  begin
    cp := sc[lc];
    if (cp in ['P','A','M','0'..'9']) then
    begin
      Delete(sc,lc-1,2);
      lc := Length(c);
    end
    else
      Exit;
  end
  else if sc[lc-2] = '/' then    // check for '/MM', '/AM'
  begin
    scp := Copy(sc,lc-1,2);
    if (scp = 'MM') or (scp = 'AM') then
    begin
      Delete(sc,lc-2,3);
      lc := Length(c);
    end;
  end
  else if (lc > 3) and (sc[lc-3] = '/') then    // check for '/QRP' (if we must!)
  begin
    scp := Copy(sc,lc-2,3);
    if (scp = 'QRP') then
    begin
      Delete(sc,lc-3,4);
      lc := Length(c);
    end;
  end;
  p := Pos('/',sc);
  if p = 0 then
  begin
    Result := callvalid(sc);
    if Result then
      u_ctrycall := sc;
  end
  else
  begin
    scp := Copy(sc,1,p-1);
    Delete(sc,1,p);
    Result := callvalid(sc) or callvalid(scp);
    if Result then
    begin
      if Length(sc) < Length(scp) then
        u_ctrycall := sc
      else
        u_ctrycall := scp;
    end;
  end;

end;

function CtryCall(c: string): string;
begin
  ValidCall(c);
  Result := u_ctrycall;
end;

(* function ValidCall(c: string): boolean;
var
  i: integer;
  hasletters, hasnumbers, hasinvalid: boolean;
begin
	hasnumbers := false;
	hasletters := false;
  hasinvalid := false;
  if (Length(c) > 2) and (Length(c) <= 16) then
  begin
    for i := 1 to Length(c) do
      case c[i] of
    	'0'..'9': hasnumbers := true;
    	'A'..'Z': hasletters := true;
      '/': ;
      else
        hasinvalid := true;
      end;
  end;
  Result := hasletters and hasnumbers and (not hasinvalid);
end;        *)

function ValidFreq(f: string; l: integer = 5): boolean;
var
  p: integer;
  fv: extended;
begin
  Result := false;
  p := Pos(DecimalSeparator,f);
  if p > 0 then
  begin
    fv := StrToFloatDef(f,0.0);
    Result := (Length(f) >= l) and (fv > 0.1);
  end
end;

function ValidRpt(r, mode: string): boolean;
begin
  if (Copy(mode,1,2) = 'JT') or (mode = 'ROS') or (mode = 'ISCAT') then
    Result := Between(StrToIntDef(r,-99),-30,50)
  else if Length(r) = 2 then
    Result := Between(StrToIntDef(r,-1),11,59)
  else if Length(r) = 3 then
    Result := Between(StrToIntDef(r,-1),111,599)
  else
    Result := false;
end;

function ValidLocator(r: string): boolean;
begin
  Result := ((Length(r) = 4) or (Length(r) = 6)) and
    (r[1] in ['A'..'Z','a'..'z']) and
    (r[2] in ['A'..'Z','a'..'z']) and
    (r[3] in ['0'..'9']) and
    (r[4] in ['0'..'9']);
  if (Length(r) = 6) then
    Result := Result and
    (r[5] in ['A'..'X','a'..'x']) and
    (r[6] in ['A'..'X','a'..'x']);
end;

function ValidIOTA(r: string): boolean;
begin
  Result := (Length(r) = 6) and
    (r[1] in ['A'..'Z','a'..'z']) and
    (r[2] in ['A'..'Z','a'..'z']) and
    (r[3] = '-') and
    (r[4] in ['0'..'9']) and
    (r[5] in ['0'..'9']) and
    (r[6] in ['0'..'9']);
end;

function ADIFmode(mode: string): string;
begin
  Result := mode;
	case Pos(Trim(Copy(mode,1,3)),modes) of
	1,4,7:      Result := 'SSB';
	10:         Result := 'CW';
	12:         Result := 'RTTY';
	15:         Delete(Result,1,1); // BPSK => PSK
	16:         ; // PSK
	19:         ; // FM
	21:         ; // AM
	23:         Result := 'ASCI';
	26:         ; // ATV
	28:         ; // V4
	30:         ; // CLO
	33:         ; // FAX
	36:         Result := 'GTOR';
	39:         Result := 'HELL';
	42:         Result := 'HFSK';
	45:         Result := 'JT44';
	48:         Result := 'JT65';
	51:         ; // MFSK
	54:         Result := 'MT63';
	57:         Result := 'OLIVIA';
	60:         ; // PAC
	63:         ; // PKT
	66:         ; // QPSK
	68:         Result := 'SSTV';
	71:         Result := 'THRB';
	73:         Result := 'TOR';
	75:         ; // ROS
  78:         Result := 'SSB';  // DV => SSB until ADIF supports mode DV
  80:         Result := 'DSTAR';
  85:         ; // JT9
	else
    Result := '';
  end
end;

function ShowDate(dtstr: string): string;
var
  d: string;
begin
  d := Copy(dtstr,1,8);
  Insert(DateSeparator,d,7);
  Insert(DateSeparator,d,5);
  Result := d;
end;

function ShowTime(dtstr: string): string;
var
  t: string;
begin
  t := Copy(dtstr,9,4);
  Insert(TimeSeparator,t,3);
  Result := t;
end;

function ShowFreq(freqstr: string; kHz: boolean = false): string;
var
  l,n: integer;
  f: string;
begin
  f := freqstr;
  if kHz then
  begin
    // kHz format for DX Cluster
    l := Length(f) - 2;
    n := 1;
  end
  else
  begin
    // normal display format
    l := Length(f) - 5;
    n := 3;
  end;
  Insert(DecimalSeparator,f,l);
  Result := Copy(f,1,l+n);
end;

function StrToFreq(const freqstr: string): extended;
var
	i: Integer;
begin
	Result := 0.0;
	i := 1;
	while i <= Length(freqstr) do
	begin
		Result := (Result * 10) + (Ord(freqstr[i]) - Ord('0'));
		inc(i);
	end;
	Result := Result / 1000;
end;

function FreqToBand(freq: string): string;
var
  f: double;
begin
  Result := '';
  try
    f := StrToFloat(freq) / 1000000;
    if (f >= 0.136) and (f <=	0.137) then Result := '2190m'
    else if (f >= 1.8) and (f <= 2.0) then Result := '160m'
    else if (f >= 3.5) and (f <= 4.0) then Result := '80m'
    else if (f >= 5.25) and (f <= 5.4) then Result := '60m'
    else if (f >= 7.0) and (f <= 7.3) then Result := '40m'
    else if (f >= 10.0) and (f <= 10.15) then Result := '30m'
    else if (f >= 14.0) and (f <= 14.35) then Result := '20m'
    else if (f >= 18.0) and (f <= 18.168) then Result := '17m'
    else if (f >= 21.0) and (f <= 21.45) then Result := '15m'
    else if (f >= 24.0) and (f <= 24.99) then Result := '12m'
    else if (f >= 28.0) and (f <= 29.7) then Result := '10m'
    else if (f >= 50) and (f <= 54) then Result := '6m'
    else if (f >= 70) and (f <= 71) then Result := '4m'
    else if (f >= 144) and (f <= 148) then Result := '2m'
    else if (f >= 222) and (f <= 225) then Result := '1.25m'
    else if (f >= 420) and (f <= 450) then Result := '70cm'
    else if (f >= 1240) and (f <= 1300) then Result := '23cm';
  except
  end;
end;

procedure BandMode(freq: string; var b, md: integer);
var
  f: double;
begin
  b := 0;
  md := 2;
  try
    f := StrToFloat(freq) / 1000;
    b := Trunc(f);
    if b = 29 then Dec(b);
    if (b > 50) and (b <= 54) then b := 50;
    if (b > 144) and (b <= 148) then b := 144;
    if (b >= 430) then b := 432;
    case b of
    1:  if f < 1.84 then md := 3 else md := 1;
    3:  if f < 3.6 then md := 3 else md := 1;
    5:  md := 2;
    7:  if f < 7.035 then md := 3 else if f < 7.043 then md := 6 else md := 1;
    10: if f < 10.14 then md := 3 else md := 6;
    14: if f < 14.07 then md := 3 else if f < 14.1 then md := 6 else md := 2;
    18: if f < 18.095 then md := 3 else if f < 18.11 then md := 6 else md := 2;
    21: if f < 21.07 then md := 3 else if f < 21.11 then md := 6 else md := 2;
    24: if f < 24.915 then md := 3 else if f < 24.93 then md := 6 else md := 2;
    28: if f < 28.07 then md := 3 else if f < 28.1 then md := 6 else if f < 29.5 then md := 2 else md := 4;
    50: if f < 50.11 then md := 3 else md := 2;
    70: md := 3;
    144: if f < 144.2 then md := 3 else md := 2;
    432: if f < 432.2 then md := 3 else md := 2;
    end;
    if (md = 3) and cwrev then md := 7;
  except
  end;
end;

procedure LocatorToGeog(const loc: string; var lat, lon: extended);
var
	loctmp: string;
begin
	lat := 0.0; lon := 0.0;
  loctmp := UpperCase(loc);
  if Length(loctmp) = 4 then
    loctmp := loctmp + 'LL';
	if Length(loctmp) = 6 then
	begin
		lon := 180.0 - (((Ord(loctmp[1])-Ord('A')) * 20.0) + ((Ord(loctmp[3])-Ord('0')) * 2.0) + ((Ord(loctmp[5])-Ord('A')) * 0.0833333) + 0.00416667);
		lat := (((Ord(loctmp[2])-Ord('A')) * 10.0) + (Ord(loctmp[4])-Ord('0')) + ((Ord(loctmp[6])-Ord('A')) * 0.0416667) - 90.0) + 0.00208333;
	end;
end;

function degtorad(d: extended): extended;
begin
 	Result := Math.degtorad(d);
	if Result = 0.0 then Result := 0.00000001;
end;

procedure RangeCalc(tlat,tlon,rlat,rlon: extended; lpath: boolean; var range,bearing: extended);
var
  c1, r7: extended;
begin
	r7 := sin(tlat)*sin(rlat)+cos(tlat)*cos(rlat)*cos(rlon-tlon);
	range := arccos(r7); // distance in radians
  if range = 0.0 then
    bearing := 0
  else
  begin
   	c1 := (sin(rlat)-sin(tlat)*r7)/(cos(tlat)*sin(range));
   	if c1 >= 1.0 then
     	bearing := 0
    else if c1 <= -1.0 then
     	bearing := pi
    else
   		bearing := arccos(c1);
  end;
	if sin(tlon-rlon) < 0.0 then bearing := pi*2 - bearing;
	if lpath then
	begin
		range := pi*2 - range;
		bearing := bearing + pi;
		if bearing > pi*2 then bearing := bearing - pi*2;
	end;
end;

procedure PathCalc(tlat,tlon,rlat,rlon: extended; lpath: Boolean; var range,bearing: extended);
var
	t_lat,t_lon,r_lat,r_lon: extended;
	razim,rrange: extended;
begin
	// convert inputs from degrees to radians
	t_lat := degtorad(tlat); t_lon := degtorad(tlon); r_lat := degtorad(rlat); r_lon := degtorad(rlon);
	// calculate range and bearing
	RangeCalc(t_lat,t_lon,r_lat,r_lon,lpath,rrange,razim);							// rrange is range in radians
  // change back to degrees and kilometres
	bearing := radtodeg(razim);																					// calculate bearing in degrees
	range := 6367.0 * rrange;																						// and range in kilometres
end;

function ParseFromText(key1, key2, ignore1, ignore2, str: string; var txt: string; check: boolean): boolean;
var
  i, p: integer;
  s, st: string;
begin
  Result := false;
  if Length(str) > 10 then
  begin
    s := UpperCase(str)+' ';
    for i := 1 to Length(s) do
      if not (s[i] in ['0'..'9','A'..'Z','/',#$C0..#$FF]) then
        s[i] := ' ';
    p := Pos(' '+key1+' ',s);
    if p > 0 then
      Delete(s,1,p+Length(key1))
    else if Length(key2) > 0 then
    begin
      p := Pos(' '+key2+' ',s);
      if p > 0 then
        Delete(s,1,p+Length(key2));
    end;
    if p > 0 then
    begin
      if Length(ignore1) > 0 then
      begin
        p := Pos(' '+ignore1+' ',s);
        if p > 0 then
          Delete(s,1,p+Length(ignore1))
        else if Length(ignore2) > 0 then
        begin
          p := Pos(' '+ignore2+' ',s);
          if p > 0 then
            Delete(s,1,p+Length(ignore2));
        end;
      end;
      s := Trim(s);
      p := Pos(' ',s);
      if p > 3 then
      begin
        st := Copy(s,1,p-1);
        Delete(s,1,p-1);
        p := Pos(' '+st+' ',s);
        if (p > 0) or (not check) then
        begin
          Result := true;
          txt := st;
        end;
      end;
    end;
  end;
end;

procedure ParseLogLine(line: string; var logitems: TLogItems);
var
  i, j, s: Integer;
begin
  i := 1; j := 0;
  while j <= 25 do
  begin
    s := i;
    while (i < Length(line)) and (line[i] <> ';') do
      Inc(i);
//    if i = s+1 then
//      logitems[j] := ''
//    else
      logitems[j] := Copy(line,s,i-s);
    Inc(i);
    Inc(j);
  end;
end;

procedure OpenURL( url: string );
{$IFNDEF WINDOWS}
var
  browser: string;
{$ENDIF}
begin
  Delay(20);
  {$IFDEF WINDOWS}
	ShellExecute(0,PChar(0),PChar(url),PChar(0),PChar(0),SW_SHOW);
  {$ELSE}
	browser := GetValueFromConfigFile(sConfigRoot,'Web_Browser','');
  if browser = '' then
    Application.MessageBox('Web browser not specified in Settings -> Misc',PChar(Application.Title),MB_ICONEXCLAMATION)
  else
    try
      RunProgram(browser,url);
    except
    end;
  {$ENDIF}
end;

function GetPath( cmdline: string ): string;
var
  p: integer;
begin
  Result := cmdline;
  p := Pos('.EXE',UpperCase(Result));
  if p > 0 then
    Result := Copy(Result,1,p+3);
end;

function RunProgram( progpath, args: string ): boolean;
var
  progdir: string;
  process: TProcess;
begin
  Result := false;
  if not FileExists(progpath) then Exit;
  Delay(20);
	progdir := ExtractFilePath(progpath);
  Delete(progdir,Length(progdir),1);
  process := TProcess.Create(nil);
  try
    try
      process.CommandLine := Trim(progpath+' '+args);
      process.Options := [poNoConsole {$IFDEF WINDOWS}, poNewProcessGroup {$ENDIF}];
      process.Execute;
      Result := true;
    except
    end;
  finally
    process.Destroy;
  end;
end;

(* procedure AddText( memo: TMemo; s: string );
var
  i, l: integer;
  txt: string;
begin
  if Length(s) = 0 then Exit;
  memo.BeginUpdateBounds;
  txt := memo.Text;
  for i := 1 to Length(s) do
  begin
    case s[i] of
    #13:  begin
            txt := txt + #13#10;
          end;
    #10:  ;
    #8:   begin
            l := Length(txt);
            if l > 0 then
              Delete(txt,l,1);
            l := Length(txt);
            if (l > 0) and (txt[l] < #32) then
              Delete(txt,l,1);
          end;
    else
      txt := txt + s[i];
    end;
  end;
  memo.Text := txt;
  memo.SelStart := Length(txt);
  memo.EndUpdateBounds;
end; *)

function GetCharEncoding(encoding: string): integer;
const
  encodings: array[1..13] of string = (
  'cp866',
  'cp874',
  'cp1250',
  'cp1251',
  'cp1252',
  'cp1253',
  'cp1254',
  'cp1255',
  'cp1256',
  'cp1257',
  'cp1258',
  'iso88591',
  'koi8' );
var
  i, p: integer;
  se: string;
begin
  se := encoding;
  repeat
    p := Pos('-',se);
    if p > 0 then Delete(se,p,1)
  until p = 0;
  repeat
    p := Pos('_',se);
    if p > 0 then Delete(se,p,1)
  until p = 0;
  {$IFDEF WINDOWS}
  Result := 0;
  {$ELSE}
  Result := 12; // make ISO-8859-1 the default
  {$ENDIF}
  for i := 1 to 13 do
    if encoding = encodings[i] then
      Result := i;
end;

function StrToUTF8(s: string; encoding: integer): string;
var
  i: integer;
begin
try
    case encoding of
    1:  Result := CP866ToUTF8(s);
    2:  Result := CP874ToUTF8(s);
    3:  Result := CP1250ToUTF8(s);
    4:  Result := CP1251ToUTF8(s);
    5:  Result := CP1252ToUTF8(s);
    6:  Result := CP1253ToUTF8(s);
    7:  Result := CP1254ToUTF8(s);
    8:  Result := CP1255ToUTF8(s);
    9:  Result := CP1256ToUTF8(s);
    10:  Result := CP1257ToUTF8(s);
    11:  Result := CP1258ToUTF8(s);
    12:  Result := ISO_8859_1ToUTF8(s);
    13:  Result := KOI8ToUTF8(s);
    else
      i := 1;
      while i <= Length(s) do
      begin
        if s[i] <= #127 then
          Result := Result + s[i];
        inc(i);
      end;
    end;
  except
    Result := '?';
  end;
end;

function UTF8ToStr(s: string; encoding: integer): string;
begin
  try
    case encoding of
    1:  Result := UTF8ToCP866(s);
    2:  Result := UTF8ToCP874(s);
    3:  Result := UTF8ToCP1250(s);
    4:  Result := UTF8ToCP1251(s);
    5:  Result := UTF8ToCP1252(s);
    6:  Result := UTF8ToCP1253(s);
    7:  Result := UTF8ToCP1254(s);
    8:  Result := UTF8ToCP1255(s);
    9:  Result := UTF8ToCP1256(s);
    10:  Result := UTF8ToCP1257(s);
    11:  Result := UTF8ToCP1258(s);
    12:  Result := UTF8ToISO_8859_1(s);
    13:  Result := UTF8ToKOI8(s);
    else
      Result := UTF8ToCP1252(s);
    end;
  except
    Result := '?';
  end;
end;

// add text to TMemo
const
  word_wrap = 60;
var
  add_nl: boolean = false;

procedure AddText( memo: TMemo; s: string );
var
  i, l, lt: integer;
  txt: string;
  c: char;
begin
  if Length(s) = 0 then Exit;
  memo.BeginUpdateBounds;
  l := memo.Lines.Count;
  if l = 0 then
  begin
    memo.Lines.Add('');
    Inc(l);
    txt := '';
    add_nl := false;
  end
  else
    txt := memo.Lines[l-1];
  for i := 1 to Length(s) do
  begin
    c := s[i];
    case c of
    #13,
    #10:  if not add_nl then
          begin
            memo.Lines[l-1] := txt;
            memo.Lines.Add('');
            Inc(l);
            txt := '';
            add_nl := true;
          end;
    #8:   begin
            lt := Length(txt);
            if lt > 0 then
              Delete(txt,lt,1);
            add_nl := false;
          end;
    ' ':  begin
            lt := Length(txt);
            if lt > word_wrap then
            begin
              memo.Lines[l-1] := txt;
              memo.Lines.Add('');
              Inc(l);
              txt := '';
            end
            else
              txt := txt + c;
            add_nl := false;
          end;
    else
      if c > #127 then
        txt := txt + StrToUTF8(c,rxcharset)
      else if c >= #32 then
        txt := txt + c;
      add_nl := false;
    end;
  end;
  memo.Lines[l-1] := txt;
  memo.SelStart := Length(memo.Text) - 1;
//  memo.VertScrollBar.Position := memo.VertScrollBar.Range-1;
  memo.EndUpdateBounds;
end;

function APos(const needle, haystack: string): integer;
// non case-sensitive Pos function
begin
  Result := Pos(UpperCase(needle),UpperCase(haystack));
end;



initialization

// 	rd := pi/180; cnv :=  180/pi;	 // standard conversion factors

  rxcharset := GetCharEncoding(GetDefaultTextEncoding);
  txcharset := rxcharset;
  syscharset := rxcharset;

finalization

end.

