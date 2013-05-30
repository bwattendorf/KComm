unit commdebug;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TfrmTrace }

  TfrmTrace = class(TForm)
    cbDisablePolling: TCheckBox;
    edTestCmd: TEdit;
    Label1: TLabel;
    lbTrace: TListBox;
    cbSave: TSpeedButton;
    SaveDialog: TSaveDialog;
    procedure cbSaveClick (Sender: TObject );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure cbDisablePollingClick(Sender: TObject);
    procedure edTestCmdKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate (Sender: TObject );
    procedure FormDestroy (Sender: TObject );
  private
    { private declarations }
  public
    { public declarations }
    TraceLog: TStringList;
    starttime: LongInt;
    procedure AddLine(s: string);
  end;

var
  frmTrace: TfrmTrace;

implementation

uses
  {$IFDEF WINDOWS}
  Windows,
  {$ELSE}
  LCLIntf,
  {$ENDIF}
  Main, Utils, LConvEncoding;

procedure TfrmTrace.cbDisablePollingClick(Sender: TObject);
begin
  disablepolling := cbDisablePolling.Checked;
end;

procedure TfrmTrace.edTestCmdKeyPress(Sender: TObject; var Key: char);
var
  command: string;
begin
  if (Key = ';') or (Key = #$0D) then
  begin
    command := edTestCmd.Text+';';
    Key := #0;
    edTestCmd.Clear;
    frmMain.SendSerial(command);
  end;
end;

procedure TfrmTrace.FormCreate (Sender: TObject );
begin
  TraceLog := TStringList.Create;
end;

procedure TfrmTrace.FormDestroy (Sender: TObject );
begin
  TraceLog.Destroy;
end;

procedure TfrmTrace.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  cbDisablePolling.Checked := false;
  cbDisablePollingClick(Sender);
end;

procedure TfrmTrace.cbSaveClick (Sender: TObject );
begin
  if SaveDialog.Execute then
    TraceLog.SaveToFile(SaveDialog.FileName);
end;

procedure TfrmTrace.AddLine(s: string);
var
  i: integer;
begin
  if frmTrace.Showing then
  begin
    i := 0;
    while i < Length(s) do
    begin
      Inc(i);
      if s[i] = #$0D then
      begin
        Delete(s,i,1);
        Insert('[cr]',s,i);
      end
      else if s[i] = #$0A then
      begin
        Delete(s,i,1);
        Insert('[lf]',s,i);
      end
      else if (s[i] < #$20) or (s[i] > #$7E) then
      begin
        Delete(s,i,1);
        Insert('[0x'+IntToHex(Ord(s[i]),2)+']',s,i);
      end
    end;
    s := ISO_8859_1ToUTF8(s);
    i := lbTrace.Canvas.TextWidth(s);
    if i > lbTrace.ScrollWidth then
      lbTrace.ScrollWidth := i;
    lbTrace.Items.Add(s);
    TraceLog.Add(Format('%7.1f %s',[(GetTickCount - starttime) / 1000.0,s]));
    if lbTrace.Count > 1 then;
      lbTrace.TopIndex := lbTrace.Count - 1;
  end;
end;

initialization
  {$I commdebug.lrs}
  
end.

