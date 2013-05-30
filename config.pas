unit config;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  Forms, Graphics, Controls, Classes, SysUtils, XMLCfg;
  
procedure SetConfigFileName( const filename: string );
function GetFromConfigFile(const SectionName, ValueName, Attribute, Default: string): string;
function GetFromConfigFile(const SectionName, ValueName, Attribute: string; Default: Integer): Integer;
function GetFromConfigFile(const SectionName, ValueName, Attribute: string; Default: Boolean): Boolean;
function GetValueFromConfigFile(const SectionName, ValueName, Default: string): string;
function GetValueFromConfigFile(const SectionName, ValueName: string; Default: Integer): Integer;
function GetValueFromConfigFile(const SectionName, ValueName: string; Default: Boolean): Boolean;
procedure GetFormPositionFromConfigFile(const SectionName, ValueName: string; AForm: TForm);
function GetFontFromConfigFile(const SectionName, ValueName: string; var Font: TFont): boolean;
procedure SaveToConfigFile(const SectionName, ValueName, Attribute, Value: string);
procedure SaveToConfigFile(const SectionName, ValueName, Attribute: string; Value: Integer);
procedure SaveToConfigFile(const SectionName, ValueName, Attribute: string; Value: Boolean);
procedure SaveValueToConfigFile(const SectionName, ValueName, Value: string);
procedure SaveValueToConfigFile(const SectionName, ValueName: string; Value: Integer);
procedure SaveValueToConfigFile(const SectionName, ValueName: string; Value: Boolean);
procedure SaveFormPositionToConfigFile(const SectionName, ValueName: string; AForm: TForm);
procedure SaveFontToConfigFile(const SectionName, ValueName: string; Font: TFont);
procedure DeleteValueFromConfigFile(const SectionName, ValueName: string);

const
  sConfigRoot = 'Settings';
  sValue = 'Value';

implementation

var
  XMLConfig: TXMLConfig;

procedure SetConfigFileName( const filename: string );
begin
  XMLConfig := TXMLConfig.Create(nil);
  XMLConfig.Filename := filename;
end;
  
function GetFromConfigFile(const SectionName, ValueName, Attribute, Default: string): string;
begin
  Result := XMLConfig.GetValue(SectionName+'/'+ValueName+'/'+Attribute, Default);
end;

function GetFromConfigFile(const SectionName, ValueName, Attribute: string; Default: Integer): Integer;
begin
  Result := XMLConfig.GetValue(SectionName+'/'+ValueName+'/'+Attribute, Default);
end;

function GetFromConfigFile(const SectionName, ValueName, Attribute: string; Default: Boolean): Boolean;
begin
  Result := XMLConfig.GetValue(SectionName+'/'+ValueName+'/'+Attribute, Default);
end;

function GetValueFromConfigFile(const SectionName, ValueName, Default: string): string;
begin
  Result := GetFromConfigFile(SectionName, ValueName, sValue, Default);
end;

function GetValueFromConfigFile(const SectionName, ValueName: string; Default: Integer): Integer;
begin
  Result := GetFromConfigFile(SectionName, ValueName, sValue, Default);
end;

function GetValueFromConfigFile(const SectionName, ValueName: string; Default: Boolean): Boolean;
begin
  Result := GetFromConfigFile(SectionName, ValueName, sValue, Default);
end;

procedure SaveToConfigFile(const SectionName, ValueName, Attribute, Value: string);
begin
  if Value = '' then
    XMLConfig.DeleteValue(SectionName+'/'+ValueName+'/'+Attribute)
  else
    XMLConfig.SetValue(SectionName+'/'+ValueName+'/'+Attribute, Value);
end;

procedure SaveToConfigFile(const SectionName, ValueName, Attribute: string; Value: Integer);
begin
  XMLConfig.SetValue(SectionName+'/'+ValueName+'/'+Attribute, Value);
end;

procedure SaveToConfigFile(const SectionName, ValueName, Attribute: string; Value: Boolean);
begin
  XMLConfig.SetValue(SectionName+'/'+ValueName+'/'+Attribute, Value);
end;

procedure SaveValueToConfigFile(const SectionName, ValueName, Value: string);
begin
  SaveToConfigFile(SectionName, ValueName, sValue, Value);
end;

procedure SaveValueToConfigFile(const SectionName, ValueName: string; Value: Integer);
begin
  SaveToConfigFile(SectionName, ValueName, sValue, Value);
end;

procedure SaveValueToConfigFile(const SectionName, ValueName: string; Value: Boolean);
begin
  SaveToConfigFile(SectionName, ValueName, sValue, Value);
end;

procedure GetFormPositionFromConfigFile(const SectionName, ValueName: string; AForm: TForm);
var
  ws: TWindowState;
  t, l, w: Integer;
begin
  ws := TWindowState(XMLConfig.GetValue(SectionName+'/'+ValueName+'/WindowState',Ord(wsNormal)));
  t := XMLConfig.GetValue(SectionName+'/'+ValueName+'/Top',AForm.Top);
  l := XMLConfig.GetValue(SectionName+'/'+ValueName+'/Left',AForm.Left);
  if t < Screen.Height then AForm.Top := t;
  if l < Screen.Width then AForm.Left := l;
  if AForm.BorderStyle = bsSizeable then
  begin
    w := XMLConfig.GetValue(SectionName+'/'+ValueName+'/Width',AForm.Width);
    if w > 40 then AForm.Width := w;
    AForm.Height := XMLConfig.GetValue(SectionName+'/'+ValueName+'/Height',AForm.Height);;
  end;
  Application.ProcessMessages;
	if ws = wsMaximized then AForm.WindowState := ws;
end;
  
procedure SaveFormPositionToConfigFile(const SectionName, ValueName: string; AForm: TForm);
var
  ws: TWindowState;
begin
  ws := AForm.WindowState;
  if ws = wsNormal then
  begin
    XMLConfig.SetValue(SectionName+'/'+ValueName+'/Top',AForm.Top);
    XMLConfig.SetValue(SectionName+'/'+ValueName+'/Left',AForm.Left);
    if AForm.BorderStyle = bsSizeable then
    begin
      XMLConfig.SetValue(SectionName+'/'+ValueName+'/Width',AForm.Width);
      XMLConfig.SetValue(SectionName+'/'+ValueName+'/Height',AForm.Height);
    end;
  end;
  XMLConfig.SetValue(SectionName+'/'+ValueName+'/WindowState',Ord(ws));
end;

function GetFontFromConfigFile(const SectionName, ValueName: string; var Font: TFont): boolean;
var
  name: string;
begin
  name := XMLConfig.GetValue(SectionName+'/'+ValueName+'/Name','');
  Result := name <> '';
  if Result then
  begin
    Font.Name := name;
    Font.Size := XMLConfig.GetValue(SectionName+'/'+ValueName+'/Size',8);
  end;
end;

procedure SaveFontToConfigFile(const SectionName, ValueName: string; Font: TFont);
begin
  XMLConfig.SetValue(SectionName+'/'+ValueName+'/Name',Font.Name);
  XMLConfig.SetValue(SectionName+'/'+ValueName+'/Size',Font.Size);
end;

procedure DeleteValueFromConfigFile(const SectionName, ValueName: string);
begin
  XMLConfig.DeletePath(SectionName+'/'+ValueName);
end;

initialization
  XMLConfig := nil;

finalization
  if XMLConfig <> nil then
    XMLConfig.Destroy;

end.

