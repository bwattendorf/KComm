unit editshortcut;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmShortcut }

  TfrmShortcut = class (TForm )
    btnCancel: TButton;
    btnOK: TButton;
    edCommand: TEdit;
    edName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edCommandKeyUp (Sender: TObject; var Key: Word;
      Shift: TShiftState );
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmShortcut: TfrmShortcut;

implementation

{ TfrmShortcut }

procedure TfrmShortcut.edCommandKeyUp (Sender: TObject; var Key: Word;
  Shift: TShiftState );
var
  s: string;
begin
  s := edCommand.Text;
  btnOK.Enabled := (Length(edName.Text) > 0) and (Length(s) = 0) or (s[Length(s)] = ';');
end;

initialization
  {$I editshortcut.lrs}

end.

