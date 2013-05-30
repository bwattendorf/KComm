unit propdlg;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls;

type

  { TfrmProp }

  TfrmProp = class(TForm)
    bmpK: TImage;
    btnOK: TButton;
    cbEnableUpdates: TCheckBox;
    bmpA: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbForecast: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbDate: TLabel;
    lbSSN: TLabel;
    lbSF: TLabel;
    lbA: TLabel;
    lbK: TLabel;
    lbLF: TLabel;
    lbMF: TLabel;
    lbHF: TLabel;
    procedure cbEnableUpdatesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure UpdateForm;
  end;

var
  frmProp: TfrmProp;

implementation

uses
  Main, Prop;

{ TfrmProp }

procedure TfrmProp.cbEnableUpdatesClick(Sender: TObject);
begin
  frmMain.Update_Timer.Enabled := cbEnableUpdates.Checked;
end;

procedure TfrmProp.FormShow(Sender: TObject);
begin
  Label1.Font.Style := [fsBold];
  lbDate.Font.Style := [fsBold];
  Label7.Font.Style := [fsBold];
  lbForecast.Font.Style := [fsBold];
  cbEnableUpdates.Enabled := (mycall <> '') and (sradio <> '') and (mycall <> 'MYCALL');
  if not cbEnableUpdates.Enabled then
    cbEnableUpdates.Checked := false;
  UpdateForm;
end;

procedure TfrmProp.UpdateForm;
var
  p: char;

const
  condx: array[0..5] of string =
  ( 'Excellent',
    'Good',
    'Normal',
    'Fair',
    'Poor',
    'Very poor' );
  condxcolor: array[0..5] of TColor =
  ( clLime, clLime, clGreen, clGreen, clBlack, clBlack );

  function Value(v: string): string;
  var
    l: integer;
  begin
    Result := '';
    l := Length(v);
    if l > 0 then
      Result := Copy(v,1,l-1);
  end;

  function Delta(v: string): integer;
  var
    l: integer;
  begin
    Result := 1;
    l := Length(v);
    if l > 0 then
      case v[l] of
      '^':  Result := 0;
      '-':  Result := 1;
      'v':  Result := 2;
      end;
  end;

begin
  if Length(PropItems[2]) > 0 then
  begin
    lbDate.Caption := PropItems[2];
    lbSSN.Caption := PropItems[3];
    lbSF.Caption := PropItems[4];
    lbA.Caption := Value(PropItems[5]);
    ImageList1.GetBitmap(Delta(PropItems[5]),bmpA.Picture.Bitmap);
    lbK.Caption := Value(PropItems[6]);
    ImageList1.GetBitmap(Delta(PropItems[6]),bmpK.Picture.Bitmap);
    lbLF.Caption := condx[StrToIntDef(PropItems[9],2)];
    lbLF.Font.Color := condxcolor[StrToIntDef(PropItems[9],4)];
    lbMF.Caption := condx[StrToIntDef(PropItems[8],2)];
    lbMF.Font.Color := condxcolor[StrToIntDef(PropItems[8],4)];
    lbHF.Caption := condx[StrToIntDef(PropItems[7],2)];
    lbHF.Font.Color := condxcolor[StrToIntDef(PropItems[7],4)];
    lbForecast.Caption := PropItems[11];
    p := PropItems[10,1];
    case p of
    'S':  lbForecast.Font.Color := clBlack;
    'D':  lbForecast.Font.Color := clMaroon;
    'B':  lbForecast.Font.Color := clRed;
    end;
  end;
end;

initialization
  {$I propdlg.lrs}

end.

