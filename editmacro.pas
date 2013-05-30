unit editmacro;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 Julian Moss, G4ILO  (www.g4ilo.com)                           //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmMacro }

  TfrmMacro = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    edCaption: TEdit;
    edHint: TEdit;
    Label1: TLabel;
    Label15: TLabel;
    ListBox1: TListBox;
    txFuncKey: TLabel;
    Label2: TLabel;
    mmMacro: TMemo;
    Text1: TLabel;
    procedure btnClearClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmMacro: TfrmMacro;

implementation

{ TfrmMacro }

uses
  Utils;

procedure TfrmMacro.btnClearClick(Sender: TObject);
begin
  edCaption.Clear;
  edHint.Clear;
  mmMacro.Clear;
end;

procedure TfrmMacro.ListBox1Click(Sender: TObject);
var
  s: string;
begin
  try
    s := ListBox1.Items[ListBox1.ItemIndex];
    if Length(s) > 2 then
    begin
      s := Trim(Copy(s,1,2));
      if s <> '' then
        AddText(mmMacro,s);
    end;
  except
  end;
end;

initialization
  {$I editmacro.lrs}

end.

