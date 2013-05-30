unit chooser;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmChooser }

  TfrmChooser = class(TForm)
    btnOK: TButton;
    Label1: TLabel;
    lbChoices: TListBox;
    procedure btnOKClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmChooser: TfrmChooser;

implementation

{ TfrmChooser }

procedure TfrmChooser.btnOKClick(Sender: TObject);
begin
  Close;
end;

initialization
  {$I chooser.lrs}

end.

