unit details;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TfrmDetail }

  TfrmDetail = class(TForm)
    btnClose: TButton;
    lbDetails: TListBox;
    btnCopy: TSpeedButton;
    procedure btnCopyClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmDetail: TfrmDetail;

implementation

{ TfrmDetail }

uses
  Clipbrd;

procedure TfrmDetail.btnCopyClick(Sender: TObject);
begin
  Clipboard.AsText := lbDetails.Items.Text;
end;

initialization
  {$I details.lrs}

end.

