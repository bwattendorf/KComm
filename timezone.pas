unit timezone;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 

var
  TimeZoneBias: TDateTime;

implementation

{$IFDEF WINDOWS}

uses Windows;

function GetTimeZoneBias: TDateTime;
var
	TZInfo: TTimeZoneInformation;
  Bias: Integer;
const
	TIME_ZONE_ID_STANDARD = 1;
	TIME_ZONE_ID_DAYLIGHT = 2;
begin
  ZeroMemory(@TZInfo,SizeOf(TZInfo));
	case GetTimeZoneInformation(TZInfo) of
	TIME_ZONE_ID_STANDARD:	Bias := TZInfo.StandardBias + TZInfo.Bias;
	TIME_ZONE_ID_DAYLIGHT:  Bias := TZInfo.DaylightBias + TZInfo.Bias;
	else
		Bias := TZInfo.Bias;
	end;
	Result := Bias / 1440;
end;

{$ELSE}

uses Unix;

function UTC_Now : TDateTime;
var
  TimeVal: TTimeVal;
  TimeZone: Pointer;
  a: Double;
begin
  TimeZone := nil;
  fpGetTimeOfDay (@TimeVal, TimeZone);
  // Convert to milliseconds
  a := (TimeVal.tv_sec * 1000.0) + (TimeVal.tv_usec / 1000.0);
  Result := (a / MSecsPerDay) + UnixDateDelta;
end;

function GetTimeZoneBias: TDateTime;
begin
  Result := UTC_Now - Now;
end;

{$ENDIF}

initialization

  TimeZoneBias := GetTimeZoneBias;

end.

