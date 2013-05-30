unit editband;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmBand }

  TfrmBand = class (TForm )
    btnCancel: TButton;
    btnDefault: TButton;
    btnOK: TButton;
    edCaption: TEdit;
    edDefault: TEdit;
    edCW: TEdit;
    edDigi: TEdit;
    edFM: TEdit;
    edAM: TEdit;
    edQRPSSB: TEdit;
    edQRPCW: TEdit;
    edExtra: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure btnDefaultClick (Sender: TObject );
    procedure edFreqExit (Sender: TObject );
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmBand: TfrmBand;

implementation

{ TfrmBand }

uses
  Utils, LCLType;

procedure TfrmBand.edFreqExit (Sender: TObject );
var
  f: string;
begin
  f := TEdit(Sender).Text;
  if (f <> '') and not ValidFreq(f,3) then
    Application.MessageBox('Frequency format invalid',PChar(Application.Title),MB_ICONERROR);
end;

procedure TfrmBand.btnDefaultClick (Sender: TObject );
begin
  edCaption.Clear;
  edDefault.Clear;
  edCW.Clear;
  edDigi.Clear;
  edFM.Clear;
  edAM.Clear;
  edQRPSSB.Clear;
  edQRPCW.Clear;
  edExtra.Clear;
end;

initialization
  {$I editband.lrs}

end.

