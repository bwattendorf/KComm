unit mrp40;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows;

procedure StartMRP40;
procedure StopMRP40;

function MRP40_Active: boolean;
function MRP40_GetText: string;
function MRP40_GetChars: string;
procedure MRP40_ClearText;

function MRP40_Buffer_Overflow: boolean;

var
  mrp40_path: string;
  mrp40_handle: Cardinal = 0;

implementation

uses
  Utils;

var
  lasttextlen: Cardinal = 0;

const
  BUF_MAX = 8192;

procedure StartMRP40;
begin
  if mrp40_path = '' then Exit;
  if not MRP40_Active then
  begin
    if not RunProgram(mrp40_path,'') then Exit;
		repeat
    	Delay(500);
    until MRP40_Active;
  end;
end;

procedure StopMRP40;
begin
  if mrp40_handle <> 0 then
  begin
    SendMessage(mrp40_handle,WM_CLOSE,0,0);
    mrp40_handle := 0;
  end;
end;

function MRP40_Active: boolean;
begin
  mrp40_handle := FindWindow(PChar(0),'MRP40 Morse Decoder');
  Result := mrp40_handle <> 0;
end;

function MRP40_GetText: string;
var
  wc, wn: Cardinal;
begin
  if mrp40_handle = 0 then
    Result := ''
  else
  begin
    wc := GetWindow(mrp40_handle,GW_CHILD);
    wn := GetWindow(wc,GW_HWNDNEXT);
    wn := GetWindow(wn,GW_HWNDNEXT);
    lasttextlen := SendMessage(wn,WM_GETTEXTLENGTH,0,0);
    SetLength(Result,lasttextlen+1);
		if lasttextlen > 0 then
		  SendMessage(wn,WM_GETTEXT,lasttextlen,LongInt(PChar(Result)));
  end;
end;

function MRP40_GetChars: string;
var
  wc, wn, i, l: Cardinal;
  textbuf: string;
begin
  Result := '';
  if mrp40_handle <> 0 then
  begin
    wc := GetWindow(mrp40_handle,GW_CHILD);
    wn := GetWindow(wc,GW_HWNDNEXT);
    wn := GetWindow(wn,GW_HWNDNEXT);
    l := SendMessage(wn,WM_GETTEXTLENGTH,0,0);
    if (l <> lasttextlen) and (l <> 0) then
    begin
      SetLength(textbuf,l+1);
		  SendMessage(wn,WM_GETTEXT,l,LongInt(PChar(textbuf)));
      if l < lasttextlen then
        Result := textbuf
      else
        Result := Copy(textbuf,lasttextlen,l-lasttextlen);
    end;
    lasttextlen := l;
    // get rid of slash zeros
    for i := 1 to Length(Result) do
      if Result[i] = #$D8 then Result[i] := '0';
  end;
end;

procedure MRP40_ClearText;
var
  wc, wn, l: Cardinal;
  msg: string;
begin
  if mrp40_handle <> 0 then
  begin
    wc := GetWindow(mrp40_handle,GW_CHILD);
    wn := GetWindow(wc,GW_HWNDNEXT);
    wn := GetWindow(wn,GW_HWNDNEXT);
    msg := ' '+#0;
    SendMessage(wn,WM_SETTEXT,0,LongInt(PChar(msg)));
    lasttextlen := 1;
  end;
end;

function MRP40_Buffer_Overflow: boolean;
begin
  Result := lasttextlen >= BUF_MAX;
end;

initialization

end.

