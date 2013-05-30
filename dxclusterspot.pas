unit dxclusterspot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmClusterSpot }

  TfrmClusterSpot = class(TForm)
    btnSend: TButton;
    btnCancel: TButton;
    cbPropMode: TComboBox;
    edFreq: TEdit;
    edCall: TEdit;
    edComment: TEdit;
    Label1: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure cbPropModeChange(Sender: TObject);
    procedure edCallKeyPress(Sender: TObject; var Key: char);
    procedure edFreqChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    cname: string;
    mode: string;
    rsts: string;
    grid: string;
    function Comment: string;
  end; 

var
  frmClusterSpot: TfrmClusterSpot;

implementation

{ TfrmClusterSpot }

uses
  Main;

var
  propidx: integer = 0;

procedure TfrmClusterSpot.edCallKeyPress(Sender: TObject; var Key: char);
begin
	if Key in ['a'..'z'] then
  	Key := Chr(Ord(Key) - $20);
end;

procedure TfrmClusterSpot.cbPropModeChange(Sender: TObject);
begin
  edComment.Text := Comment;
end;

procedure TfrmClusterSpot.edFreqChange(Sender: TObject);
var
  en_prop: boolean;
  f: extended;
begin
  en_prop := false;
  if Length(grid) >= 4 then
    try
      f := StrToFloat(edFreq.Text);
      en_prop := f >= 28000.0;
    except
    end;
  Label1.Enabled := en_prop;
  cbPropMode.Enabled := en_prop;
end;

function TfrmClusterSpot.Comment: string;
var
  cmnt, prop: string;
begin
  cmnt := '';
  if cbPropMode.Enabled and (cbPropMode.ItemIndex > 0) then
  begin
    if Length(grid) >= 4 then
    begin
      case cbPropMode.ItemIndex of
      1:  prop := 'AR';
      2:  prop := 'EME';
      3:  prop := 'F2';
      4:  prop := 'SAT';
      5:  prop := 'ES';
      6:  prop := 'TR';
      else
        prop := '';
      end;
      cmnt := Format('%s<%s>%s',[myloc,prop,grid]);
    end;
  end;
  if Length(cname) > 0 then
    cmnt := cmnt + ' ' + cname;
  if (vmode = data_a) then
    cmnt := cmnt + ' ' + mode;
  if Length(rsts) > 0 then
    cmnt := cmnt + ' ' + rsts;
  Result := Trim(cmnt);
end;

procedure TfrmClusterSpot.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  propidx := cbPropMode.ItemIndex;
end;

procedure TfrmClusterSpot.FormCreate(Sender: TObject);
begin
  cbPropMode.ItemIndex := propidx;
end;

procedure TfrmClusterSpot.FormShow(Sender: TObject);
begin
  edFreqChange(Self);
  edComment.Text := Comment;
end;

initialization
  {$I dxclusterspot.lrs}

end.

