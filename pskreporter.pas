unit PSKReporter;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows;

var
  pskreporteravailable: boolean;
  pskreporterready: boolean;

function InitPSKReporter: boolean;
function StartPSKReporter(hostname, port: string): boolean;
procedure SetPSKReporterLocalInfo(call, grid, progname, progver: string);
procedure SendPSKReporterSpot(call, mode, freq: string; flag: DWORD);
procedure UnInitPSKReporter;

const
  REPORTER_SOURCE_MASK = $07;
  REPORTER_SOURCE_AUTOMATIC = $01;
  REPORTER_SOURCE_LOG = $02;
  REPORTER_SOURCE_MANUAL = $03;
  REPORTER_SOURCE_TENTATIVE = $40;
  REPORTER_SOURCE_TEST = $80;

type
  TREPORTER_STATISTICS  = record
    hostname: array[0..256-1] of WideChar;
    port: array[0..32-1] of WideChar;
    connected : Bool;
    callsigns_sent : DWord;
    callsigns_buffered : DWord;
    callsigns_discarded : DWord;
    last_send_time : DWord;
    next_send_time : DWord;
    last_callsign_queued: array[0..24-1] of WideChar;
    bytes_sent : DWord;
    bytes_sent_total : DWord;
    packets_sent : DWord;
    packets_sent_total : DWord;
  end;  //REPORTER_STATISTICS

  TReporterInitialize = function(const hostname: WideString; const port: WideString): DWORD; cdecl;
  TReporterSeenCallsign = function(const remoteInformation: WideString; const localInformation: WideString; flags: DWORD): DWORD; cdecl;
  TReporterTickle = function(): DWORD; cdecl;
  TReporterGetInformation = function(var buffer: WideString; maxlen: DWORD): DWORD; cdecl;
  TReporterGetStatistics = function(var buffer: TREPORTER_STATISTICS; maxlen: DWORD): DWORD; cdecl;
  TReporterUninitialize = function(): DWORD; cdecl;

var
  ReporterInitialize: TReporterInitialize = nil;
  ReporterSeenCallsign: TReporterSeenCallsign = nil;
  ReporterTickle: TReporterTickle = nil;
  ReporterGetInformation: TReporterGetInformation = nil;
  ReporterGetStatistics: TReporterGetStatistics = nil;
  ReporterUninitialize: TReporterUninitialize = nil;

//  Function prototypes for PSK Reporter DLL
//  ========================================
//
//  function ReporterInitialize (const hostname: WideString;
//    const port: WideString): DWORD; cdecl;
//  function ReporterSeenCallsign (const remoteInformation: WideString;
//    const localInformation: WideString;
//    flags: DWORD): DWORD cdecl;
//  function ReporterTickle : DWORD cdecl;
//  function ReporterGetInformation (var buffer: WideString;
//    maxlen: DWORD): DWORD cdecl;
//  function ReporterGetStatistics (var buffer: REPORTER_STATISTICS;
//    maxlen: DWORD): DWORD cdecl;
//  function ReporterUninitialize : DWORD; cdecl;

implementation

const
  PSKR_DLL = 'PSKREPORTER.DLL';

var
  FLibHandle: THandle = 0;

  local_string: string;

function InitPSKReporter: boolean;
begin
  Result := false;
{$IFDEF WINDOWS}
  if FLibHandle = 0 then
  begin
    FLibHandle := LoadLibrary(PSKR_DLL);
    if FLibHandle <> 0 then
    begin
      Pointer(ReporterInitialize) := GetProcAddress(FLibHandle, 'ReporterInitialize');
      Pointer(ReporterSeenCallsign) := GetProcAddress(FLibHandle, 'ReporterSeenCallsign');
      Pointer(ReporterTickle) := GetProcAddress(FLibHandle, 'ReporterTickle');
      Pointer(ReporterGetInformation) := GetProcAddress(FLibHandle, 'ReporterGetInformation');
      Pointer(ReporterGetStatistics) := GetProcAddress(FLibHandle, 'ReporterGetStatistics');
      Pointer(ReporterUninitialize) := GetProcAddress(FLibHandle, 'ReporterUninitialize');
      Result := Assigned(ReporterInitialize)
        and Assigned(ReporterSeenCallsign)
        and Assigned(ReporterTickle)
        and Assigned(ReporterGetInformation)
        and Assigned(ReporterGetStatistics)
        and Assigned(ReporterUninitialize);
    end;
  end
  else
    Result := true;
{$ENDIF}
  pskreporteravailable := Result;
end;

function StartPSKReporter(hostname, port: string): boolean;
begin
  Result := ReporterInitialize(hostname,port) = 0;
  pskreporterready := Result;
end;

procedure SetPSKReporterLocalInfo(call, grid, progname, progver: string);
begin
  if (call = '') or (grid = '') or (progname = '') or (progver = '') then
    pskreporterready := false
  else
    local_string := 'STATION_CALLSIGN' + #0 + call + #0
      + 'MY_GRIDSQUARE' + #0 + grid + #0
      + 'PROGRAMID' + #0 + progname + #0
      + 'PROGRAMVERSION' + #0 + progver + #0#0;
end;

procedure SendPSKReporterSpot(call, mode, freq: string; flag: DWORD);
var
  remote_string: string;
begin
  if (call = '') or (mode = '') or (freq = '') or (local_string = '') then Exit;
  remote_string := 'CALL' + #0 + call + #0 + 'MODE' + #0 + mode + #0 + 'FREQ' + #0 + freq + #0 + #0;
  ReporterSeenCallsign(remote_string, local_string, flag);
end;

procedure UnInitPSKReporter;
begin
  if FLibHandle <> 0 then
    FreeLibrary(FLibHandle);
  FLibHandle := 0;
  pskreporterready := false;
end;

initialization
  pskreporteravailable := false;
  pskreporterready := false;

finalization
  if pskreporterready then
    ReporterUninitialize;
  UnInitPSKReporter;

end.

