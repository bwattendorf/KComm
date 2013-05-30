unit dxclusterselect;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmClusterSelect }

  TfrmClusterSelect = class (TForm )
    btnOK: TButton;
    btnCancel: TButton;
    lbClusterData: TListBox;
    procedure FormShow (Sender: TObject );
    procedure lbClusterDataClick (Sender: TObject );
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmClusterSelect: TfrmClusterSelect;

implementation

uses
  Main;

{ TfrmClusterSelect }

procedure TfrmClusterSelect.FormShow (Sender: TObject );
begin
  lbClusterData.Items.LoadFromFile(progpath+'dxclusters.dat');
end;

procedure TfrmClusterSelect.lbClusterDataClick (Sender: TObject );
begin
  btnOK.Enabled := true;
end;

initialization
  {$I dxclusterselect.lrs}

end.

