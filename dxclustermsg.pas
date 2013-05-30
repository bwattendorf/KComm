unit dxclustermsg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmClusterMsg }

  TfrmClusterMsg = class(TForm)
    btnOK: TButton;
    Memo1: TMemo;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmClusterMsg: TfrmClusterMsg;

implementation

initialization
  {$I dxclustermsg.lrs}

end.

