program kcomm;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 - 2013 Julian Moss, G4ILO  (www.g4ilo.com)                    //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)  //

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this },
  {$IFDEF WINDOWS}
  Windows,
  {$ENDIF}
  main, settings, utils, editmacro, editrecord, eqsl, chooser, countries,
  export, stats, details, commdebug, editband, editshortcut, dxclusterselect,
  dxcluster, config, waterfall, propdlg, prop, dxclustermsg, dxclusterspot,
  fldigi, uScaleDPI;
  

{$R *.res}

begin
  Application.Title:='KComm';
  {$IFDEF WINDOWS}
  // prevent multiple instances
  if FindWindow('Window',PChar(Application.Title)) <> 0 then
  begin
    MessageBox(0,'KComm is already running.',PChar(Application.Title),MB_ICONEXCLAMATION);
    Exit;
  end;
  {$ENDIF}
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TfrmMacro, frmMacro);
  Application.CreateForm(TfrmEditRec, frmEditRec);
  Application.CreateForm(TfrmChooser, frmChooser);
  Application.CreateForm(TfrmExport, frmExport);
  Application.CreateForm(TfrmDetail, frmDetail);
  Application.CreateForm(TfrmStats, frmStats);
  Application.CreateForm(TfrmTrace, frmTrace);
  Application.CreateForm(TfrmBand, frmBand);
  Application.CreateForm(TfrmShortcut, frmShortcut);
  HighDPI(96);
  Application.Run;
end.

