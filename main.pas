unit main;

{$mode objfpc}{$H+}

//  Copyright (c) 2007 - 2013 Julian Moss, G4ILO  (www.g4ilo.com)                     //
//  Released under the GNU GPL v2.0 (www.gnu.org/licenses/old-licenses/gpl-2.0.txt)   //

// *****************************************************************************
interface

uses
  {$IFDEF WINDOWS}
  Windows, PSK31Core, WFPalette,
  {$ELSE}
  ipc, LCLIntf,
  {$ENDIF}
  Classes, SysUtils, LResources, LCLType, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, Buttons, Clipbrd, Menus, Synaser, Waterfall;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnProp: TSpeedButton;
    btnB14: TButton;
    btnB13: TButton;
    btnB15: TButton;
    btnB02: TButton;
    btnB03: TButton;
    btnB04: TButton;
    btnB05: TButton;
    btnB06: TButton;
    btnB07: TButton;
    btnB08: TButton;
    btnB09: TButton;
    btnB10: TButton;
    btnB11: TButton;
    btnB12: TButton;
    btnB16: TButton;
    btnB17: TButton;
    btnB18: TButton;
    btnB19: TButton;
    btnFldigi: TSpeedButton;
    btnDXCluster: TSpeedButton;
    btnCWSkimmer: TSpeedButton;
    bmpIPC: TSpeedButton;
    btnMRP40: TSpeedButton;
    btnLSB: TButton;
    btnB20: TButton;
    btnB21: TButton;
    btnB22: TButton;
    btnB23: TButton;
    btnB24: TButton;
    btnPSKBrowser: TSpeedButton;
    btnUSB: TButton;
    btnAM: TButton;
    btnFM: TButton;
    btnCW: TButton;
    btnCWR: TButton;
    btnClearTx: TButton;
    btnMacro09: TButton;
    btnMacro10: TButton;
    btnMacro11: TButton;
    btnMacro12: TButton;
    btnMacro13: TButton;
    btnMacro14: TButton;
    btnMacro15: TButton;
    btnMacro16: TButton;
    btnMacro02: TButton;
    btnMacro03: TButton;
    btnMacro04: TButton;
    btnMacro05: TButton;
    btnMacro06: TButton;
    btnMacro07: TButton;
    btnMacro08: TButton;
    btnConnect: TButton;
    btnClearRx: TButton;
    btnLogNew: TButton;
    btnLogEnd: TButton;
    btnLogSave: TButton;
    btnSettings: TButton;
    btnLogStart: TButton;
    btnRollUp: TButton;
    btnMacro01: TButton;
    btnTxRx: TButton;
    btnB01: TButton;
    btnSpot: TButton;
    btnCenter: TButton;
    btnData: TButton;
    cbPSK31AFC2: TCheckBox;
    cbRxUpperCase: TCheckBox;
    cbCWUpperCase: TCheckBox;
    cbPSK31AFC: TCheckBox;
    cbTXLock: TCheckBox;
    cbPSKTune: TCheckBox;
    cbTXLock2: TCheckBox;
    edCall: TEdit;
    cbMode: TComboBox;
    edDate: TEdit;
    edName: TEdit;
    edExchr: TEdit;
    edFreq: TEdit;
    edExchs: TEdit;
    edGrid: TEdit;
    edNotes: TEdit;
    edQTH: TEdit;
    edRSTr: TEdit;
    edTime: TEdit;
    edRSTs: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    imgSpot: TImage;
    imSQ: TImage;
    Label1: TLabel;
    lbIMD: TLabel;
    LWfreqDisplay: TImage;
    LWfallDisplay: TImage;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    mnuModeBPSK63F: TMenuItem;
    mnuModeBPSK500: TMenuItem;
    mnuSaveTextToFile: TMenuItem;
    mnuSpotToCluster: TMenuItem;
    LWfallPanel: TPanel;
    pnSQ: TPanel;
    SunImages: TImageList;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    mnuSortLog: TMenuItem;
    mnuImportADIF: TMenuItem;
    mnuModeMFSK32: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    mnuCharset: TMenuItem;
    mnuModeBPSK: TMenuItem;
    mnuModeBPSK125: TMenuItem;
    mnuModeBPSK250: TMenuItem;
    mnuModeBPSK31: TMenuItem;
    mnuModeBPSK63: TMenuItem;
    mnuModeMFSK: TMenuItem;
    mnuModeMFSK16: TMenuItem;
    mnuModeMFSK8: TMenuItem;
    mnuModeOlivia: TMenuItem;
    mnuModeQPSK: TMenuItem;
    mnuModeQPSK125: TMenuItem;
    mnuModeQPSK250: TMenuItem;
    mnuModeQPSK31: TMenuItem;
    mnuModeQPSK63: TMenuItem;
    mnuModeRTTY: TMenuItem;
    mnuModes: TPopupMenu;
    ImportADIFDialog: TOpenDialog;
    StatusBar: TLabel;
    lbFreq2: TLabel;
    mnuOpenURL: TMenuItem;
    mnuAddToQTH: TMenuItem;
    Fl_Timer: TTimer;
    mr_Timer: TTimer;
    Update_Timer: TTimer;
    WaterfallDisplay: TImage;
    imgBkg: TImage;
    imgMeterBkg: TImage;
    imgMeterFg: TImage;
    lbTxRx: TLabel;
    lbRIT: TLabel;
    lbTime: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    lbShortcuts: TListBox;
    lbFreq: TLabel;
    Label20: TLabel;
    lbMode: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    mnuLoadShortcuts: TMenuItem;
    mnuExportShortcuts: TMenuItem;
    mnuImportShortcuts: TMenuItem;
    mnuExecuteShortcut: TMenuItem;
    mnuInsertShortcut: TMenuItem;
    mnuDeleteShortcut: TMenuItem;
    mnuEditShortcut: TMenuItem;
    mnuAddShortcut: TMenuItem;
    mnuExport2: TMenuItem;
    mnuStats1: TMenuItem;
    mnuStats2: TMenuItem;
    mnuExport1: TMenuItem;
    mnuStats0: TMenuItem;
    mnuSrchNext: TMenuItem;
    mnuSrchCall: TMenuItem;
    mnuRxEnable: TMenuItem;
    mnuCopyToClipboard: TMenuItem;
    mnuSelectAll: TMenuItem;
    MenuSep1: TMenuItem;
    mnuCopyToCall: TMenuItem;
    mnuCopyToName: TMenuItem;
    mnuCopyToRST: TMenuItem;
    mnuCopyToExch: TMenuItem;
    mnuCopyToQTH: TMenuItem;
    mnuCopyToGrid: TMenuItem;
    mnuAddToNotes: TMenuItem;
    ImportShortcutsDialog: TOpenDialog;
    OpenShortcutsDialog: TOpenDialog;
    OpenMacrosDialog: TOpenDialog;
    LogPopupMenu: TPopupMenu;
    pnDisplay: TPanel;
    lbSplit: TLabel;
    ExportShortcutsDialog: TSaveDialog;
    ShortcutsPopupMenu: TPopupMenu;
    RXPopupMenu: TPopupMenu;
    btnSndProps: TSpeedButton;
    txLookup2: TLabel;
    WaterfallPanel: TPanel;
    SaveMacrosDialog: TSaveDialog;
    TypeAhead: TMemo;
    RxPanel: TMemo;
    SaveRxDialog: TSaveDialog;
    btnOpenMacros: TSpeedButton;
    btnSaveMacros: TSpeedButton;
    txLookup: TLabel;
    Label9: TLabel;
    pnStatusBar: TPanel;
    sgLog: TStringGrid;
    Timer: TTimer;
    procedure btnBandMouseUp (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure btnBandClick (Sender: TObject );
    procedure btnCenterClick(Sender: TObject);
    procedure btnClearRxClick(Sender: TObject);
    procedure btnClearTxClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnCWSkimmerClick (Sender: TObject );
    procedure btnDataClick(Sender: TObject);
    procedure btnDXClusterClick (Sender: TObject );
    procedure btnFldigiClick(Sender: TObject);
    procedure btnLogEndClick(Sender: TObject);
    procedure btnLogNewClick(Sender: TObject);
    procedure btnLogSaveClick(Sender: TObject);
    procedure btnLogStartClick(Sender: TObject);
    procedure btnMRP40Click(Sender: TObject);
    procedure btnPropClick(Sender: TObject);
    procedure btnPSKBrowserClick(Sender: TObject);
    procedure btnSndPropsClick(Sender: TObject);
    procedure btnSpotClick (Sender: TObject );
    procedure btnUSBClick ( Sender: TObject ) ;
    procedure cbPSK31AFCClick(Sender: TObject);
    procedure cbPSKTuneClick(Sender: TObject);
    procedure cbTXLockClick(Sender: TObject);
    procedure edDateExit(Sender: TObject);
    procedure edExchKeyPress(Sender: TObject; var Key: char);
    procedure edExchrExit(Sender: TObject);
    procedure edFreqExit(Sender: TObject);
    procedure edGridExit(Sender: TObject);
    procedure edTimeExit(Sender: TObject);
    procedure Fl_TimerTimer (Sender: TObject );
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgSpotClick(Sender: TObject);
    procedure lbFreq2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbFreqMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbShortcutsDblClick (Sender: TObject );
    procedure lbShortcutsKeyDown (Sender: TObject; var Key: Word;
      Shift: TShiftState );
    procedure lbShortcutsMouseUp (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure LogPopupMenuPopup(Sender: TObject);
    procedure LWfallDisplayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuAddShortcutClick (Sender: TObject );
    procedure mnuAddToNotesClick(Sender: TObject);
    procedure btnAMClick(Sender: TObject);
    procedure mnuFldigiModesClick(Sender: TObject);
    procedure mnuImportADIFClick(Sender: TObject);
    procedure mnuModeBPSK125Click(Sender: TObject);
    procedure mnuModePSK31Click(Sender: TObject);
    procedure mnuModePSK63Click(Sender: TObject);
    procedure mnuAddToQTHClick (Sender: TObject );
    procedure mnuCharsetClick(Sender: TObject);
    procedure mnuCopyToCallClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure MacroMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MacroClick(Sender: TObject);
    procedure btnOpenMacrosClick(Sender: TObject);
    procedure btnRollUpClick(Sender: TObject);
    procedure btnSaveMacrosClick(Sender: TObject);
    procedure mnuSaveTextClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnTxRxClick(Sender: TObject);
    procedure edCallExit(Sender: TObject);
    procedure edCallKeyPress(Sender: TObject; var Key: char);
    procedure edGridKeyPress(Sender: TObject; var Key: char);
    procedure edNameKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuCopyToClipboardClick(Sender: TObject);
    procedure mnuCopyToExchClick(Sender: TObject);
    procedure mnuCopyToGridClick(Sender: TObject);
    procedure mnuCopyToNameClick(Sender: TObject);
    procedure mnuCopyToQTHClick(Sender: TObject);
    procedure mnuCopyToRSTClick(Sender: TObject);
    procedure btnCWClick(Sender: TObject);
    procedure mnuDeleteShortcutClick (Sender: TObject );
    procedure mnuEditShortcutClick (Sender: TObject );
    procedure mnuExport1Click(Sender: TObject);
    procedure mnuExport2Click(Sender: TObject);
    procedure btnFMClick(Sender: TObject);
    procedure mnuExportShortcutsClick (Sender: TObject );
    procedure mnuImportShortcutsClick (Sender: TObject );
    procedure mnuLoadShortcutsClick (Sender: TObject );
    procedure mnuModeRTTYClick(Sender: TObject);
    procedure mnuOpenURLClick (Sender: TObject );
    procedure mnuRxEnableClick(Sender: TObject);
    procedure mnuSelectAllClick(Sender: TObject);
    procedure mnuSortLogClick(Sender: TObject);
    procedure mnuSpotToClusterClick(Sender: TObject);
    procedure mnuSrchCallClick(Sender: TObject);
    procedure mnuSrchNextClick(Sender: TObject);
    procedure mnuStats0Click(Sender: TObject);
    procedure mnuStats2Click(Sender: TObject);
    procedure mnuStats1Click(Sender: TObject);
    procedure btnLSBClick(Sender: TObject);
    procedure mr_TimerTimer(Sender: TObject);
    procedure RxPanelDblClick(Sender: TObject);
    procedure RxPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RxPanelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RXPopupMenuPopup(Sender: TObject);
    procedure sgLogClick(Sender: TObject);
    procedure sgLogMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShortcutsPopupMenuPopup (Sender: TObject );
    procedure txLookupClick(Sender: TObject);
    procedure sgLogDblClick(Sender: TObject);
    procedure TypeAheadKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TypeAheadKeyPress(Sender: TObject; var Key: char);
    procedure TypeAheadKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
//		procedure TypeAheadKeyPress(Sender: TObject; var Key: Char);
    procedure TimerTimer(Sender: TObject);
    procedure TypeAheadUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
    procedure Update_TimerTimer(Sender: TObject);
    procedure WaterfallDisplayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  {$IFDEF WINDOWS}
  protected
    procedure PSK31CoreFFTDataReady(var msg: TMessage); message MSG_DATARDY;
    procedure PSK31CoreCharReady(var msg: TMessage); message MSG_PSKCHARRDY;
    procedure PSK31CoreStatusChange(var msg: TMessage); message MSG_STATUSCHANGE;
    procedure PSK31CoreIMDReady(var msg: TMessage); message MSG_IMDRDY;
  {$ENDIF}
  private
    { private declarations }
    SerialPort: TBlockSerial;
    Shortcuts: TStringList;
    disconnecting: Boolean;
    formmode: integer;
    procedure FormState(frmmode: integer);
    procedure BandButtons;
    procedure TaskbarButtons;
    function SendEQSLNow(call, freq, mode: string): boolean;
    procedure EQSLSent;
    procedure UpdatePropInfo;
    function AllowedChar(ch: char): boolean;
		procedure ProcessMacro(const macrotext: string);
		procedure TypeAheadPaste(Sender: TObject);
    {$IFDEF WINDOWS}
    procedure WaterfallDisplayPaint(f: integer);
    procedure LWFreqDisplayPaint;
    {$ENDIF}
  public
    { public declarations }
    connected: Boolean;
    CWWfall: TWaterfall;
    PSKWfall: TWaterfall;
    parsedataenabled: boolean;
		procedure LoadMacros(const filename: string);
		procedure SaveMacros(const filename: string);
    procedure SetBandButtonCaption(var Button: TButton);
    function GetBandFreq(bandbtn: string): string;
    function GetBandDefaultFreq(b, md: integer): string;
    procedure SetFrequency(f: string; m: integer; extra: string );
    procedure SetQSOFreq;
    procedure ChangeFrequency(df: extended);
    procedure LoadLog;
    procedure LoadShortcuts(const filename: string);
    procedure UnloadShortcuts;
    procedure InsertText(txt: string);
    procedure ShowContactInfo(call,band,mode: string);
    procedure ContactInfo(call, band, mode: string; var infostr, newstr, wkdstr, cname, qth, grid: string);
    procedure AddCWText(s: string);
    procedure SetCWSpotFreq(f: integer);
    procedure ParseDataIn;
    procedure AbortTX;
    {$IFDEF WINDOWS}
    function StartPSK31Core: boolean;
    procedure StopPSK31Core;
    function TrueFrequency(pitch: integer): extended;
    {$ELSE}
    procedure SetupIPC;
    procedure GetIPCData;
    procedure ProcessIPCData;
    {$ENDIF}
    procedure SetFonts;
    procedure SendSerial(s: string);
  end;

type
  TRadio = (k2, k3, kx3);
	TMode = (unknown, phone, cw, data_a);
  TEQSLOptions = (no, yes, ask, smart);

var
  frmMain: TfrmMain;

  datapath: string;
  progpath: string;
  log: TStringList;
  logfilename: string;
  logchanged: boolean = false;

  shortcutsfilename: string;

  portlist: string;
  datain: string;
  cwrev: boolean;
  commtrace: boolean;
  disablepolling: boolean = false;
  pp: integer;

  curr_f: extended;                   // current frequency, in kHz
  radio: TRadio;
  sradio: string;                     // name of radio (from Settings drop-down)
  iskx3: boolean = false;             // distinguish KX3 from K3
	mode: integer;											// current mode value returned by K2/3
  mycall, myloc: string;              // my call and locator
  mylat, mylon: extended;
  vmode: TMode;												// current mode as TMode;
  contestmode: boolean;
  eqsluser, eqslpass: string;         // eQSL credentials
  autoeqsl: TEQSLOptions;
  dxchost, dxcport,
  dxcuser, dxcpass: string;           // DX Cluster settings
  usesoundcard: boolean;              // use sound card
  cwwaterfall: boolean = false;       // show waterfall in CW
  usek3dsp: boolean = false;          // use K3 internal PSK/RTTY modems
  pskwaterfall: boolean = false;      // show waterfall in PSK31/RTTY
  largewfall: boolean = false;        // use full width PSK waterfall
  lwpalette: string;                  // filename of large waterfall palette
  cwcenterfreq: integer;
  decodepsk: boolean = false;         // use sound card PSK decoder (PSK Core DLL - Windows only)
  pskcenterfreq: integer;
  usefldigi: boolean = false;         // ok to use Fldigi as data modes engine
  fldigiactive: boolean = false;      // use Fldigi as data modes engine
  fldigiversion: string;
  fldigikeepontop: boolean = false;   // keep KComm on top of Fldigi
  lookupurl1,
  lookupurl2: string;                 // urls to lookup calls
  dlgshowing: boolean = false;
  mr_count: integer;                  // countdown of number of seconds for macro repeat
  mr_text: string;                    // macro text to repeat
  pm_idx: integer;
  // *****************************************************************************

const
  sTimeBlank = '--:--:--';
  sFreqBlank = '--.---';
  sModeBlank = '---';

  sBand = 'Band';

  sStartup: array[k2..kx3] of string = (
    'K22;AI1;',
    'TT0;K22;K31;AI1;',
    'TT0;K22;K31;AI1;' );
  sShutdown: array[k2..kx3] of string = (
    'RX;AI0;',
    'RX;AI0;TT0;',
    'RX;AI0;TT0;' );

	ModeStr: array[k2..kx3,1..9] of string = (
  ( {1}	'SSB',    // K2
  	{2}	'SSB',
	  {3}	'CW',
  	{4}	'',
	  {5}	'',
  	{6}	'BPSK31',
	  {7}	'CW',
  	{8}	'',
	  {9}	'BPSK31'),
  ( {1}	'SSB',      // K3
  	{2}	'SSB',
	  {3}	'CW',
  	{4}	'FM',
	  {5}	'AM',
  	{6}	'BPSK31',
	  {7}	'CW',
  	{8}	'',
	  {9}	'BPSK31'),
  ( {1}	'SSB',      // KX3
  	{2}	'SSB',
	  {3}	'CW',
  	{4}	'FM',
	  {5}	'AM',
  	{6}	'BPSK31',
	  {7}	'CW',
  	{8}	'',
	  {9}	'BPSK31' ));

  AGCStr: array[0..2] of string = (
    'off', 'fast', 'slow' );

  sVerNo = '2.1';
  {$IFDEF WINDOWS}
  sDeg = '°';
  sSlash = '\';
  mbPopup = mbRight;
  {$ELSE}
  sDeg = '°';
  sSlash = '/';
  mbPopup = mbMiddle;
  {$ENDIF}
  sCopy = '©';
  sVer = 'KComm v'+sVerNo+' Copyright '+sCopy+' 2007-2013 Julian G4ILO (www.g4ilo.com)';

  surldef1 = 'http://hamcall.net/call?entry=';  //default urls for call lookups
  surldef2 = 'http://qrz.com/db/';
  surlhint1 = 'Lookup call at HamCall.net';
  surlhint2 = 'Lookup call at QRZ.com';
// *****************************************************************************

implementation

{ TfrmMain }

uses
  Config, Settings, EditMacro, EditBand, EditShortcut, Utils, XMLCfg, EditRecord,
  Export, Stats, eQSL, Chooser, DXCluster, Prop, PropDlg,
  {$IFDEF WINDOWS} MRP40, CW_Skimmer, PSKBrowser, Reporter, PSKReporter, soundcards, {$ENDIF}
  Fldigi, Details, countries, commdebug, FTPSend, TimeZone, LConvEncoding;

{$IFNDEF WINDOWS}
// **LINUX** IPC communication data types
// for logging from gMFSK and fl_digi
type
  TMsgType = record
    mtype: LongInt;
    mtext: array[0..1023] of char;
  end;

var
   msgid: integer = -1;
   ipcactive: boolean = false;
   processingipc: boolean = false;
   msgbuf: TMsgType;
{$ENDIF}
 
var
  currentmacros: string;
	macros: Array[1..16] of string;

  rev204: boolean;
  currfreq: string;                   // current frequency (11-digit IF/FA/FB format)
  vfoa: integer;                      // active vfo: 0 = A; 1 = B;
  rit: integer;                       // RIT state: 0 = off; 1 = on; -1 = unknown
  xit: integer;                       // XIT state: 0 = off; 1 = on; -1 = unknown
  split: integer;                     // SPLIT state: 0 = off; 1 = on; -1 = unknown
  lstrfreq: string;                   // previously displayed frequency
  delta_f: extended;                  // RIT offset (Hz)
	tx: boolean;                        // from radio status: true if TXing;
  txstat: integer;                    // desired TX state: 0 = rx; 1 = tx; 2 = waiting for end of transmission
  dmode: integer;                     // current data submode
  cmode: integer;                     // current mode as dmode * 100 + mode
  pwr, spd, ant, agc: integer;
  
  dsdisp: string;
  
	bgval: integer;
  cwbksp: boolean;
 
	cwbufstate: integer;
	txbuf: string;
 
  rxpdelay: integer;
  rxpdblclick: boolean;
  rxbuf: string;
  parsebuf: string;
  autoparse: boolean;
  autospot: boolean;

	timestarted: TDateTime;
  timefinished: TDateTime;
  qsostarted: boolean;
  logend: boolean;
  rstr: boolean;

  adding: boolean = false;
  realreports: boolean;
  strength: integer;
  chkqsobefore: string;               // last call checked for QSO B4
  Check, CQZ, ITUZ: TStringList;
  
  incexch: boolean;
  dupcheck: integer;
  alerts: array[0..3] of boolean;
  antenna: array[1..2] of string;
  conteststart: string;
  
	seltext, useltext, lseltext, nseltext: string;
 
  srchpos: integer;
  srchcall: string;

  {$IFDEF WINDOWS}
  rx_sound_dev: integer = -1;
  tx_sound_dev: integer = -1;
  // PSK31 Core support
  WaterfallBitmap: TBitmap;
	SignalOverload: boolean;
	FFTData: TFFTData;
  WFMin, WFMax, WFBandwidth, WFOffset: integer;
  SigQuality: integer = 0;
  afcrange: integer = 10;
  afcmin: integer = 1;
	soundcard_on: boolean = false;
  // CW Skimmer support
  usecwskimmer: boolean = false;
  // MRP40 support
  usemrp40: boolean = false;
  mrp40keepontop: boolean = false;
  {$ELSE}
  sound_dev: string;
  {$ENDIF}

  fontname: string;

const
  maxfreq: array[k2..kx3] of extended = (
    30000.0,
    54000.0,
    54000.0 );


procedure TfrmMain.FormCreate(Sender: TObject);
var
  cfgname: string;
begin
	DecimalSeparator := '.';
	TimeSeparator := ':';
  DoubleBuffered := true;
  WaterfallPanel.DoubleBuffered := true;
  {$IFDEF WINDOWS}
  LWfallPanel.DoubleBuffered := true;
  pnSQ.DoubleBuffered := true;
  RXPanel.PopupMenu := RXPopupMenu;
  {$ELSE}
  lbFreq.Top := 14;
  lbFreq2.Top := 16;
  {$ENDIF}
  imgBkg.Align := alClient;
  lbTime.Caption := sTimeBlank;
  lbFreq.Caption := sFreqBlank;
  lbFreq2.Caption := sModeBlank;
  lbMode.Caption := sModeBlank;
  lbRIT.Caption := '';
  lbSplit.Caption := '';
  lbTxRx.Caption := '';
  imgMeterFg.Width := 1;
  SunImages.GetBitmap(0,btnProp.Glyph);
  parsedataenabled := true;
  // create the serial port object
  SerialPort := TBlockSerial.Create;
  connected := false;
  // create the shortcuts list
  Shortcuts := TStringList.Create;
  // set the data folders and configuration file path
  progpath := StrToUTF8(ExtractFilePath(Application.ExeName),syscharset);
  if progpath[Length(progpath)] = sSlash then
    Delete(progpath,Length(progpath),1);
  cfgname := 'kcomm.conf';
  if ParamCount > 0 then
    cfgname := ParamStr(1)+'.conf';
  {$IFDEF WINDOWS}
  datapath := StrToUTF8(GetEnvironmentVariable('APPDATA')+sSlash+'kcomm',syscharset);
  if datapath = '' then
    datapath := progpath;
  {$ELSE}
  datapath := StrToUTF8(GetEnvironmentVariable('HOME')+sSlash+'kcomm',syscharset);
  {$ENDIF}
  if FileExists(progpath+sSlash+cfgname) then
    datapath := progpath
  else if not DirectoryExists(datapath) then
    try
      MkDir(UTF8ToStr(datapath,syscharset));
    except
      Application.MessageBox(PChar(Format ('Unable to create data folder in %s',[datapath])),
        PChar(Application.Title),MB_ICONERROR+MB_OK);
      Halt;
    end;
  OpenMacrosDialog.InitialDir := datapath;
  SaveMacrosDialog.InitialDir := datapath;
  datapath := datapath+sSlash;
  progpath := progpath+sSlash;
  try
    SetConfigFileName(datapath+cfgname);
  except
      Application.MessageBox(PChar(Format('Unable to open configuration file %s',[datapath+cfgname])),
        PChar(Application.Title),MB_ICONERROR+MB_OK);
      Halt;
  end;
  shortcutsfilename := datapath+ChangeFileExt(cfgname,'.shortcuts');
  // set form position and persistent values
	GetFormPositionFromConfigFile(sConfigRoot,'WindowPos',frmMain);
  // create the log
  log := TStringList.Create;
  Check := TStringList.Create;
  CQZ := TStringList.Create;
  ITUZ := TStringList.Create;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  i: integer;
  strtmp,st1,st2,st3,st4: string;
begin
  SetFonts;
  Application.ProcessMessages;
  FormState(GetValueFromConfigFile(sConfigRoot,'FormState',2));
  // list serial ports
  {$IFDEF WINDOWS}
  portlist := GetSerialPortNames;
  if portlist <> '' then
  begin
    for i := 1 to Length(portlist) do
      if portlist[i]=',' then portlist[i] := #13;
  end;
  {$ENDIF}
	btnSaveMacros.Enabled := false;
  txLookup.Hint := GetValueFromConfigFile(sConfigRoot,'LookupHint1',sURLHint1);
  txLookup2.Hint := GetValueFromConfigFile(sConfigRoot,'LookupHint2',sURLHint2);
  // context
  txLookup.Visible := false;
  txLookup2.Visible := false;
  imgSpot.Visible := false;
  // load country data
  CtyInit;
  // get other settings
  btnConnect.Visible := GetValueFromConfigFile(sConfigRoot,'Com_Port','') <> '';
  sradio := GetValueFromConfigFile(sConfigRoot,'Radio','');
  radio := TRadio(frmSettings.cbRadio.Items.IndexOf(sradio));
  cwrev := GetValueFromConfigFile(sConfigRoot,'CW_Rev',false);
  KeyPreview := GetValueFromConfigFile(sConfigRoot,'Enable_PowerMate',false);
  autoparse := GetValueFromConfigFile(sConfigRoot,'Auto_Parse',false);
  autospot := GetValueFromConfigFile(sConfigRoot,'Auto_Spot',false);
  // disable buttons
  rev204 := GetValueFromConfigFile(sConfigRoot,'Rev_2.04',false);
  mycall := GetValueFromConfigFile(sConfigRoot,'My_Call','MYCALL');
  myloc := GetValueFromConfigFile(sConfigRoot,'My_Locator','');
  pwr := StrToIntDef(GetValueFromConfigFile(sConfigRoot,'Power','10'),0);
  ant := 1;
  antenna[1] := GetValueFromConfigFile(sConfigRoot,'Ant_1','');
  antenna[2] := GetValueFromConfigFile(sConfigRoot,'Ant_2','');
  realreports := GetValueFromConfigFile(sConfigRoot,'Real_Reports',false);
  contestmode := GetValueFromConfigFile(sConfigRoot,'Contest_mode',false);
  edExchs.Enabled := contestmode;
  edExchr.Enabled := contestmode;
  if contestmode then
  begin
    dupcheck := GetValueFromConfigFile(sConfigRoot,'Duplicate_check',0);
    incexch := GetValueFromConfigFile(sConfigRoot,'Increment_exchange',true);
    conteststart := StripAll(DateSeparator,GetValueFromConfigFile(sConfigRoot,'Contest_start_date',FormatDateTime('yyyy/mm/dd',Now + TimeZoneBias)))
      +StripAll(TimeSeparator,GetValueFromConfigFile(sConfigRoot,'Contest_start_time',FormatDateTime('hh:nn',Now + TimeZoneBias)))+'00';
    alerts[0] := GetValueFromConfigFile(sConfigRoot,'Alert_0',false);
    alerts[1] := GetValueFromConfigFile(sConfigRoot,'Alert_1',false);
    alerts[2] := GetValueFromConfigFile(sConfigRoot,'Alert_2',false);
    alerts[3] := GetValueFromConfigFile(sConfigRoot,'Alert_3',false);
  end;
  cbRxUpperCase.Checked := GetValueFromConfigFile(sConfigRoot,'CW_Uppercase_1',false);
  cbCWUpperCase.Checked := GetValueFromConfigFile(sConfigRoot,'CW_Uppercase_2',false);
  eqsluser := GetValueFromConfigFile(sConfigRoot,'eQSL_Call','');
  eqslpass := GetValueFromConfigFile(sConfigRoot,'eQSL_Password','');
  autoeqsl := TEQSLOptions(GetValueFromConfigFile(sConfigRoot,'Auto_eQSL',0));
  dxchost := GetValueFromConfigFile(sConfigRoot,'DX_Cluster_Host','');
  dxcport := GetValueFromConfigFile(sConfigRoot,'DX_Cluster_Port','');
  dxcuser := GetValueFromConfigFile(sConfigRoot,'DX_Cluster_Login',LowerCase(mycall));
  dxcpass := GetValueFromConfigFile(sConfigRoot,'DX_Cluster_Password','');
  usesoundcard := GetValueFromConfigFile(sConfigRoot,'Use_Soundcard',false);
  usek3dsp := GetValueFromConfigFile(sConfigRoot,'Use_K3_DSP',false);
  cwwaterfall := usesoundcard and GetValueFromConfigFile(sConfigRoot,'CW_Waterfall',false);
  cwcenterfreq := GetValueFromConfigFile(sConfigRoot,'CW_Center_Freq',800);
  pskwaterfall := usesoundcard and GetValueFromConfigFile(sConfigRoot,'PSK_Waterfall',false);
  rxcharset := GetValueFromConfigFile(sConfigRoot,'RX_Charset',rxcharset);
  txcharset := GetValueFromConfigFile(sConfigRoot,'TX_Charset',txcharset);
  for i := 0 to mnuCharset.Count - 1 do
    if mnuCharset.Items[i].Tag = rxcharset then
      mnuCharset.Items[i].Checked := true;
  {$IFDEF WINDOWS}
  // show Windows Sound Properties button
  rx_sound_dev := GetSoundCardIDFromName(GetValueFromConfigFile(sConfigRoot,'Sound_Device',''),true);
  tx_sound_dev := GetSoundCardIDFromName(GetValueFromConfigFile(sConfigRoot,'Sound_Device_Tx',''),false);
  // check if PSK31 Core DLL available
  InitPSK31Core;
  // sound card setup
  decodepsk := usesoundcard and psk31coreavailable and GetValueFromConfigFile(sConfigRoot,'Use_PSK31CoreDLL',false);
  pskcenterfreq := GetValueFromConfigFile(sConfigRoot,'PSK31_Center_Freq',1200);
  largewfall := usesoundcard and GetValueFromConfigFile(sConfigRoot,'Large_Waterfall',false);
  if largewfall then
    lwpalette := GetValueFromConfigFile(sConfigRoot,'Waterfall_Palette','');
  usemrp40 := GetValueFromConfigFile(sConfigRoot,'Use_MRP40',false);
  mrp40_path := GetValueFromConfigFile(sConfigRoot,'MRP40','');
  mrp40keepontop := GetValueFromConfigFile(sConfigRoot,'MRP40_KeepOnTop',false) and usemrp40;
  usecwskimmer := GetValueFromConfigFile(sConfigRoot,'Use_CW_Skimmer',false);
  usefldigi := GetValueFromConfigFile(sConfigRoot,'Use_Fldigi',false);
  fldigikeepontop := GetValueFromConfigFile(sConfigRoot,'Fldigi_KeepOnTop',false) and usefldigi;
  {$ELSE}
  // **LINUX**
  sound_dev := GetValueFromConfigFile(sConfigRoot,'Sound_Device','/dev/dsp');
  // set up IPC communication
  SetupIPC;
  {$ENDIF}
  // CW Waterfall
  try
    CWWfall := TWaterfall.Create;
    with CWWfall do
    begin
      {$IFDEF WINDOWS}
      SoundCard := rx_sound_dev;
      {$ELSE}
      DSPDevice := sound_dev;
      {$ENDIF}
      WaterfallImage := WaterfallDisplay;
      SetCWSpotFreq(cwcenterfreq);
      Initialize;
    end;
  except
    Application.MessageBox('Error creating CW Waterfall',
      PChar(Application.Title),MB_ICONERROR+MB_OK);
  end;
  // PSK Waterfall
  try
    PSKWfall := TWaterfall.Create;
    with PSKWfall do
    begin
      {$IFDEF WINDOWS}
      SoundCard := rx_sound_dev;
      {$ELSE}
      DSPDevice := sound_dev;
      {$ENDIF}
      WaterfallImage := WaterfallDisplay;
      SetSampleRateAndCenterFreq(16000,1000);
      Initialize;
    end;
  except
    Application.MessageBox('Error creating PSK Waterfall',
      PChar(Application.Title),MB_ICONERROR+MB_OK);
  end;
  // hide mode dependent controls
  BandButtons;
  TaskbarButtons;
  WaterfallPanel.Visible := false;
  btnSpot.Visible := false;
  cbRxUpperCase.Visible := false;
  cbPSK31AFC.Visible := false;
  cbTXLock.Visible := false;
  cbCWUpperCase.Visible := false;
  // calculate home lat and long
  if ctydatavailable then
  begin
    if myloc = '' then
      FindCountry(mycall,strtmp, st1, st2, st3, st4, mylat, mylon)
    else
      LocatorToGeog(myloc,mylat,mylon);
  end
  else
    StatusBar.Caption := 'Warning: Country/prefix data not found';
  // load log
  logfilename := GetValueFromConfigFile(sConfigRoot,'Log_File',datapath+'kcomm.log');
  if FileExists(LogFileName) then
    LoadLog;
  // load macros
	strtmp := GetValueFromConfigFile(sConfigRoot,'Default_Macros',datapath+'default.macro');
	if FileExists(strtmp) then
	begin
		LoadMacros(strtmp);
    OpenMacrosDialog.FileName := strtmp;
		SaveMacrosDialog.FileName := strtmp;
	end;
  // check for FLDigi log messages if using external decoder
  if usefldigi then
    Fl_Timer.Enabled := true;
  Update_Timer.Enabled := GetValueFromConfigFile(sConfigRoot,'Update_Check',false);
  if Update_Timer.Enabled then
    btnProp.Hint := 'Waiting for update'
  else
    btnProp.Hint := 'Propagation updates not enabled';
end;

procedure TfrmMain.SetFonts;
var
  tmpfont: TFont;
  i, smallfontsize: integer;
  {$IFDEF WINDOWS}
	NonClientMetrics: TNonClientMetrics;
  {$ENDIF}
begin
  smallfontsize := 0;
  lbFreq.ParentFont := true;
  lbFreq2.ParentFont := true;
  lbRIT.ParentFont := true;
  lbSplit.ParentFont := true;
  lbTxRx.ParentFont := true;
  {$IFNDEF WINDOWS}
  cbMode.ParentFont := true;
  {$ENDIF}
  Application.ProcessMessages;
  tmpfont := Font;
  if GetFontFromConfigFile(sConfigRoot,'Font',tmpfont) then
  begin
    Font := tmpfont;
    fontname := Font.Name;
  end
  else
  begin
    {$IFDEF WINDOWS}
  	// set window font to system message text font ** WINDOWS ONLY **
	  NonClientMetrics.cbSize := SizeOf(NonClientMetrics);
  	if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
	  	Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
    fontname := Font.Name;
    {$ELSE}
    // set window font to default font
    fontname := '';
    {$ENDIF}
  end;
  if Font.Size = 0 then
    smallfontsize := 7
  else
    smallfontsize := Font.Size - 1;
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TLabel then
    begin
      if fontname <> '' then TLabel(Components[i]).Font.Name := fontname;
      if (smallfontsize <> 0) and (TLabel(Components[i]).Parent = GroupBox2) then
        TLabel(Components[i]).Font.Size := smallfontsize;
      if TLabel(Components[i]).Parent = pnDisplay then
        TLabel(Components[i]).Font.Size := Font.Size;
    end else if (Components[i] is TButton) then
    begin
      if fontname <> '' then
        TButton(Components[i]).Font.Name := fontname;
      if (smallfontsize <> 0) and (Components[i].Tag = 20) then
        TButton(Components[i]).Font.Size := smallfontsize;
    end;
  end;
  lbFreq.ParentFont := false;
  lbFreq.Font.Size := 12;
  lbFreq.Font.Style := [fsBold];
  lbFreq2.ParentFont := false;
  lbFreq2.Font.Size := 10;
  lbRIT.ParentFont := false;
  lbRIT.Font.Color := clRed;
  lbSplit.ParentFont := false;
  lbSplit.Font.Color := clRed;
  lbTxRx.ParentFont := false;
  lbTxRx.Font.Style := [fsBold];
  {$IFNDEF WINDOWS}
  cbMode.ParentFont := false;
  cbMode.Font.Size := smallfontsize;
  cbMode.Height := edFreq.Height;
  {$ENDIF}
  if fontname <> '' then
  begin
    btnConnect.Font.Name := Font.Name;
    btnConnect.Font.Size := Font.Size;
    btnConnect.Font.Style := [fsBold];
    sgLog.Font.Name := Font.Name;
    sgLog.Font.Size := Font.Size;
    btnMacro01.Font.Name := Font.Name;
    btnMacro01.Font.Size := Font.Size;
    btnMacro02.Font.Name := Font.Name;
    btnMacro02.Font.Size := Font.Size;
    btnMacro03.Font.Name := Font.Name;
    btnMacro03.Font.Size := Font.Size;
    btnMacro04.Font.Name := Font.Name;
    btnMacro04.Font.Size := Font.Size;
    btnMacro05.Font.Name := Font.Name;
    btnMacro05.Font.Size := Font.Size;
    btnMacro06.Font.Name := Font.Name;
    btnMacro06.Font.Size := Font.Size;
    btnMacro07.Font.Name := Font.Name;
    btnMacro07.Font.Size := Font.Size;
    btnMacro08.Font.Name := Font.Name;
    btnMacro08.Font.Size := Font.Size;
    btnMacro09.Font.Name := Font.Name;
    btnMacro09.Font.Size := Font.Size;
    btnMacro10.Font.Name := Font.Name;
    btnMacro10.Font.Size := Font.Size;
    btnMacro11.Font.Name := Font.Name;
    btnMacro11.Font.Size := Font.Size;
    btnMacro12.Font.Name := Font.Name;
    btnMacro12.Font.Size := Font.Size;
    btnMacro13.Font.Name := Font.Name;
    btnMacro13.Font.Size := Font.Size;
    btnMacro14.Font.Name := Font.Name;
    btnMacro14.Font.Size := Font.Size;
    btnMacro15.Font.Name := Font.Name;
    btnMacro15.Font.Size := Font.Size;
    btnMacro16.Font.Name := Font.Name;
    btnMacro16.Font.Size := Font.Size;
    frmSettings.Font := Font;
    frmMacro.Font := Font;
    frmEditRec.Font := Font;
    frmChooser.Font := Font;
    frmExport.Font := Font;
    frmStats.Font := Font;
    frmTrace.Font := Font;
    frmBand.Font := Font;
    frmDetail.Font := Font;
    frmShortcut.Font := Font;
  end;
  for i := 0 to frmEditRec.ComponentCount - 1 do
  begin
    if frmEditRec.Components[i] is TLabel then
    begin
      if fontname <> '' then TLabel(frmEditRec.Components[i]).Font.Name := Font.Name;
      if smallfontsize <> 0 then
        TLabel(frmEditRec.Components[i]).Font.Size := smallfontsize;
    end;
  end;
  if fontname <> '' then
  begin
    frmChooser.Font := Font;
    frmExport.Font := Font;
    frmDetail.Font := Font;
    frmStats.Font := Font;
    with frmStats do
    begin
      sgStats.Font.Name := Font.Name;
      sgStats.Font.Size := Font.Size;
    end;
    if Assigned(frmClusterClient) then
    begin
      frmClusterClient.Font := Font;
      with frmClusterClient do
      begin
        sgCluster.Font.Name := Font.Name;
        sgCluster.Font.Size := Font.Size;
      end;
    end;
  end;
end;

procedure TfrmMain.TaskbarButtons;
// display the task bar buttons
var
  l: integer;
begin
  l := btnRollUp.Left;
  {$IFDEF WINDOWS}
  btnSndProps.Visible := usesoundcard or fldigiactive;
  {$ELSE}
  btnSndProps.Visible := false;
  {$ENDIF}
  if btnSndProps.Visible then
  begin
    Dec(l,20);
    btnSndProps.Left := l;
  end;
  btnDXCluster.Visible := (dxchost <> '') and (StrToIntDef(dxcport,0) > 0);
  if btnDXCluster.Visible then
  begin
    Dec(l,20);
    btnDXCluster.Left := l;
  end;
  {$IFDEF WINDOWS}
  btnMRP40.Visible := usemrp40 and connected and (vmode = cw);
  if btnMRP40.Visible then
  begin
    Dec(l,20);
    btnMRP40.Left := l;
  end;
  btnCWSkimmer.Visible := usecwskimmer and connected and (vmode = cw);
  if btnCWSkimmer.Visible then
  begin
    Dec(l,20);
    btnCWSkimmer.Left := l;
  end;
  btnPSKBrowser.Visible := decodepsk and (vmode = data_a);
  if btnPSKBrowser.Visible then
  begin
    Dec(l,20);
    btnPSKBrowser.Left := l;
  end;
  {$ENDIF}
  btnFldigi.Visible := usefldigi;
  if btnFldigi.Visible then
  begin
    Dec(l,20);
    btnFldigi.Left := l;
  end;
  Dec(l,20);
  btnProp.Left := l;
  Dec(l,20);
  bmpIPC.Left := l;
  StatusBar.Width := l-10;
end;

procedure TfrmMain.SetQSOFreq;
var
  qso_f: extended;
begin
  if connected or fldigiactive then
  begin
    if fldigiactive then
    begin
      if connected then
        qso_f := curr_f + (Fldigi_GetCarrier / 1000.0)
      else
        qso_f := Fldigi_GetQSOFrequency;
    end
    {$IFDEF WINDOWS}
    else if (vmode = data_a) and decodepsk and soundcard_on then
      qso_f := TrueFrequency(fnGetRXFrequency(0))
    {$ENDIF}
    else
      qso_f := curr_f;
    edFreq.Text := Trim(Format('%11.3f',[qso_f/1000.0]));
    if cbMode.ItemIndex < 0 then
      try
        cbMode.ItemIndex := cbMode.Items.IndexOf(lbMode.Caption);
      except
      end;
    Delay(20);
  end;
end;

procedure TfrmMain.mnuCopyToClipboardClick(Sender: TObject);
begin
  Clipboard.AsText := seltext;
end;

procedure TfrmMain.mnuCopyToExchClick(Sender: TObject);
begin
  edExchr.Text := useltext;
end;

procedure TfrmMain.mnuCopyToGridClick(Sender: TObject);
begin
  edGrid.Text := Copy(useltext,1,2)+Copy(lseltext,3,4);
  edGridExit(Sender);
end;

procedure TfrmMain.mnuCopyToNameClick(Sender: TObject);
begin
  edName.Text := useltext[1]+Copy(lseltext,2,31);
end;

procedure TfrmMain.mnuCopyToQTHClick(Sender: TObject);
begin
  edQTH.Text := StringReplace(CapText(seltext), 'Nr ', 'nr ', [rfReplaceAll]);
end;

procedure TfrmMain.mnuCopyToRSTClick(Sender: TObject);
begin
  edRSTr.Text := nseltext;
end;

procedure TfrmMain.btnCWClick(Sender: TObject);
var
  vfo_ofs: integer;
  cwmode: boolean;
  des_f: extended;
begin
  if connected then
  begin
    cwmode := cwrev;
    if Sender = btnCWR then cwmode := not cwmode;
    case cwmode of
      false: if mode <> 3 then SendSerial('MD3;');
      true: if mode <> 7 then SendSerial('MD7;');
    end;
  end;
  if fldigiactive then
    Fldigi_SetMode('CW');
end;

procedure TfrmMain.mnuDeleteShortcutClick (Sender: TObject );
var
  i: integer;
begin
  i := lbShortcuts.ItemIndex;
  if i >= 0 then
  begin
    lbShortcuts.Items.Delete(i);
    Shortcuts.Delete(i);
    Shortcuts.SaveToFile(shortcutsfilename);
  end;
end;

procedure TfrmMain.mnuEditShortcutClick (Sender: TObject );
var
  n, c: string;
  i, p: integer;
begin
  i := lbShortcuts.ItemIndex;
  if i >= 0 then
  begin
    c := Shortcuts.Strings[i];
    p := Pos('|',c);
    if p > 0 then
    begin
      n := Copy(c,1,p-1);
      Delete(c,1,p);
    end
    else
    begin
      n := c;
      c := '';
    end;
    with frmShortcut do
    begin
      edName.Text := n;
      edCommand.Text := c;
      dlgshowing := true;
      if ShowModal = mrOK then
      begin
        n := Trim(edName.Text);
        c := Trim(edCommand.Text);
        if n <> '' then
        begin
          lbShortcuts.Items[i] := n;
          if c = '' then
            Shortcuts.Strings[i] := n
          else
            Shortcuts.Strings[i] := n+'|'+c;
        end;
        Shortcuts.SaveToFile(shortcutsfilename);
        dlgshowing := false;
      end;
    end;
  end;
end;

procedure TfrmMain.mnuExport1Click(Sender: TObject);
var
  selection: TGridRect;
begin
  selection := sgLog.Selection;
  with frmExport do
  begin
    firstrec := selection.Top - 1;
    lastrec := selection.Bottom - 1;
    dlgshowing := true;
    ShowModal;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.mnuExport2Click(Sender: TObject);
var
  i: integer;
  logitems: TLogItems;
begin
  if conteststart = '' then Exit;
  i := log.Count;
  if i = 0 then Exit;
  repeat
    Dec(i);
    ParseLogLine(Log.Strings[i],logitems);
  until (i < 0) or (logitems[2] < conteststart);
  with frmExport do
  begin
    firstrec := i + 1;
    lastrec := log.Count - 1;
    dlgshowing := true;
    ShowModal;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.btnFMClick(Sender: TObject);
begin
  if not connected then Exit;
  if radio = k2 then Exit;
  SendSerial('MD4;');
end;

procedure TfrmMain.mnuExportShortcutsClick (Sender: TObject );
var
  i: integer;
  sctmp: TStringList;
begin
  if lbShortcuts.Count = 0 then Exit;
  sctmp := TStringList.Create;
  try
    for i := 0 to lbShortcuts.Count - 1 do
      if lbShortcuts.Selected[i] then
        sctmp.Add(Shortcuts.Strings[i]);
    if sctmp.Count > 0 then
      with ExportShortcutsDialog do
        if Execute and (FileName <> '') then
          sctmp.SaveToFile(FileName);
  finally
    sctmp.Destroy;
  end;
end;

procedure TfrmMain.mnuImportShortcutsClick (Sender: TObject );
var
  i, p: integer;
  strtmp: string;
  sctmp: TStringList;
begin
  sctmp := TStringList.Create;
  try
    with ImportShortcutsDialog do
      if Execute and FileExists(FileName) then
      begin
        sctmp.LoadFromFile(FileName);
        i := 0;
        while i < sctmp.Count do
        begin
          strtmp := sctmp.Strings[i];
          p := Pos('|',strtmp);
          if p > 0 then
            lbShortcuts.Items.Add(Copy(strtmp,1,p-1))
          else
            lbShortcuts.Items.Add(strtmp);
          Shortcuts.Add(strtmp);
          Inc(i);
        end;
        Shortcuts.SaveToFile(shortcutsfilename);
      end;
  finally
    sctmp.Destroy;
  end;
end;

procedure TfrmMain.mnuLoadShortcutsClick (Sender: TObject );
begin
  with OpenShortcutsDialog do
  begin
    InitialDir := datapath;
    if Execute then
    begin
      LoadShortcuts(FileName);
      if Shortcuts.Count > 0 then
        Shortcuts.SaveToFile(shortcutsfilename);
    end;
  end;
end;

procedure TfrmMain.mnuModeRTTYClick(Sender: TObject);
begin
  if connected then
  begin
    lbMode.Caption := 'RTTY';
    cbMode.ItemIndex := cbMode.Items.IndexOf('RTTY');
    case radio of
    k2  : SendSerial('MD9;');
    k3,kx3:
          begin
            if usek3dsp then
              SendSerial('MD6;DT2;')
            else if usesoundcard then
              SendSerial('MD6;DT0;');
          end;
    end;
  end;
  if fldigiactive then
    Fldigi_SetMode('RTTY');
end;


procedure TfrmMain.mnuOpenURLClick (Sender: TObject );
var
  s: string;
begin
  s := lseltext;
  if Copy(s,1,4) = 'www.' then
    s := 'http://'+s;
  if Copy(s,1,4) = 'http' then
    OpenURL(s);
end;

procedure TfrmMain.mnuRxEnableClick(Sender: TObject);
begin
  if mnuRxEnable.Checked then
  begin
    // pause reception
    rxpdelay := MAXINT;
    mnuRxEnable.Checked := false;
  end
  else
  begin
    // re-enable reception
    mnuRxEnable.Checked := true;
    rxpdelay := 0;
  end;
end;

procedure TfrmMain.mnuSelectAllClick(Sender: TObject);
begin
  RXPanel.SelStart:= 0;
  RXPanel.SelLength:= Length(RXPanel.Text);
end;

procedure TfrmMain.mnuSortLogClick(Sender: TObject);
var
  i,p: integer;
  line: string;
  logitems: TLogItems;
begin
  log.SaveToFile(ChangeFileExt(LogFileName,'.bak'));
  i := 0;
  while i < Log.Count do
  begin
    line := log.Strings[i];
    ParseLogLine(line,logitems);
    log.Strings[i] := logitems[2]+#9+line;
    Inc(i);
  end;
  log.Sort;
  i := 0;
  while i < Log.Count do
  begin
    line := log.Strings[i];
    p := Pos(#9,line);
    if p > 0 then
      Delete(line,1,p);
    log.Strings[i] := line;
    Inc(i);
  end;
  log.SaveToFile(LogFileName);
  LoadLog;
end;

procedure TfrmMain.mnuSpotToClusterClick(Sender: TObject);
var
  selection: TGridRect;
  logitems: TLogItems;
begin
  if not Assigned(frmClusterClient) then Exit;
  selection := sgLog.Selection;
  if selection.Bottom > selection.Top then Exit;
  ParseLogLine(log.Strings[selection.Top - 1],logitems);
  frmClusterClient.SendSpot(ShowFreq(logitems[6],true),logitems[1],logitems[14],logitems[9],logitems[10],logitems[21]);
end;

procedure TfrmMain.mnuSrchCallClick(Sender: TObject);
var
  call: string;
  found: boolean;
  logitems: TLogItems;
begin
  call := InputBox('Search','Enter call to search for:',srchcall);
  if call <> '' then
  begin
    srchcall := UpperCase(call);
    srchpos := 0;
    repeat
      ParseLogLine(log.Strings[srchpos],logitems);
      found := Pos(srchcall,logitems[1]) = 1;
      Inc(srchpos);
      if found then
      begin
        sgLog.Row := srchpos;
        Application.ProcessMessages;
        Application.MessageBox('Found!',PChar(Application.Title),0);
      end;
    until found or (srchpos >= log.Count);
  end;
end;

procedure TfrmMain.mnuSrchNextClick(Sender: TObject);
var
  found: boolean;
  logitems: TLogItems;
begin
  if (srchpos >= log.Count) or (srchcall = '') then Exit;
  repeat
    ParseLogLine(log.Strings[srchpos],logitems);
    found := Pos(srchcall,logitems[1]) = 1;
    Inc(srchpos);
    if found then
    begin
      sgLog.Row := srchpos;
      Application.ProcessMessages;
      Application.MessageBox('Found!',PChar(Application.Title),0);
    end;
  until found or (srchpos >= log.Count);
end;

procedure TfrmMain.mnuStats0Click(Sender: TObject);
begin
  with frmStats do
  begin
    firstrec := 0;
    lastrec := log.Count - 1;
    dlgshowing := true;
    ShowModal;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.mnuStats1Click(Sender: TObject);
var
  selection: TGridRect;
begin
  selection := sgLog.Selection;
  with frmStats do
  begin
    firstrec := selection.Top - 1;
    lastrec := selection.Bottom - 1;
    dlgshowing := true;
    ShowModal;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.btnLSBClick(Sender: TObject);
var
  vfo_ofs: integer;
  des_f: extended;
begin
  if not connected then Exit;
  SendSerial('MD1;');
end;

procedure TfrmMain.mr_TimerTimer(Sender: TObject);
begin
  Dec(mr_count);
  {$IFDEF WINDOWS}
  if SigQuality > 50 then
  begin
    mr_text := '';
    mr_count := 0;
    StatusBar.Caption := 'Frequency in use. Repeating macro aborted';
    pp := 5;
  end;
  {$ENDIF}
  if mr_count > 0 then
  begin
    StatusBar.Caption := Format('Repeating macro in %d seconds. Esc to abort.',[mr_count]);
    pp := 5;
  end
  else
  begin
    mr_Timer.Enabled := false;
    if Length(mr_text) > 0 then
    begin
      StatusBar.Caption := '';
      ProcessMacro(mr_text);
    end;
  end;
end;

procedure TfrmMain.mnuStats2Click(Sender: TObject);
var
  i: integer;
  logitems: TLogItems;
begin
  if conteststart = '' then Exit;
  i := log.Count;
  if i = 0 then Exit;
  repeat
    Dec(i);
    ParseLogLine(log.Strings[i],logitems);
  until (i < 0) or (logitems[2] < conteststart);
  with frmStats do
  begin
    firstrec := i + 1;
    lastrec := log.Count - 1;
    dlgshowing := true;
    ShowModal;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.RxPanelDblClick(Sender: TObject);
begin
  rxpdblclick := true;
end;

procedure TfrmMain.RxPanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if rxpdelay < 10 then
    rxpdelay := 10;
end;

procedure TfrmMain.RxPanelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ss, se, sl: integer;
  ptClient: TPoint;
  rtxt: string;
begin
  if rxpdblclick then
  begin
//    ss := rxpselstart + 1; // RxPanel.SelStart + 1;
    ss := RxPanel.SelStart + 1;
    rtxt := UTF8ToStr(RxPanel.Text,rxcharset);
    sl := Length(rtxt);
    if sl > 0 then
    begin
      while (ss > 1) and (rtxt[ss-1] in ['0'..'9','A'..'Z','a'..'z','/']) do
        Dec(ss);
      se := ss;
      while (se < sl) and (rtxt[se + 1] in ['0'..'9','A'..'Z','a'..'z','/']) do
        Inc(se);
      sl := se - ss + 1;
      seltext := Trim(Copy(rtxt,ss,sl));
      if Length(seltext) <= 1 then Exit;
      InsertText(seltext);
    end;
    rxpdblclick := false;
    if rxpdelay < 20 then
      rxpdelay := 0;
  end
  else
  begin
//    rxpselstart := RxPanel.SelStart;
    if rxpdelay < 20 then
    begin
      if Trim(RXPanel.SelText) = '' then
        rxpdelay := 0
      else
        rxpdelay := 4;
    end;
  end;
  {$IFNDEF WINDOWS}
  if Button = mbPopup then
  begin
    ptClient.x:= X;
    ptClient.y:= Y;
    ptClient := RxPanel.ClientToScreen(ptClient);
    RXPopupMenu.PopUp(ptClient.x,ptClient.y);
  end;
  {$ENDIF}
end;

procedure TfrmMain.InsertText(txt: string);
var
  i: integer;
  hasnumbers, hasletters, isnumeric: Boolean;
begin
  useltext := UpperCase(txt);
  lseltext := LowerCase(txt);
	hasnumbers := false;
	hasletters := false;
  for i := 1 to Length(useltext) do
  begin
	    if useltext[i] in ['0'..'9'] then
    	hasnumbers := true;
	    if useltext[i] in ['A'..'Z'] then
    	hasletters := true;
  end;
  isnumeric := hasnumbers;
  if isnumeric then
  begin
    for i := 1 to Length(useltext) do
    	if not (useltext[i] in ['0'..'9','N','T']) then
        isnumeric := false;
    if isnumeric and (useltext[1]='5') then
    begin
    	nseltext := useltext;
     	for i := 1 to Length(nseltext) do
      begin
       	if nseltext[i] = 'N' then nseltext[i] := '9'
        else if nseltext[i] = 'T' then nseltext[i] := '0';
      end;
    end;
  end;
	if isnumeric then
  begin
  	if edRSTr.Text = '' then
			edRSTr.Text := nseltext
    else if edExchr.Enabled then
      edExchr.Text := nseltext;
  end
  else
  begin
    if hasnumbers and hasletters then
    begin
  	  if ((Length(txt) = 4) or (Length(txt) = 6)) and (txt[3] in ['0'..'9']) and (txt[4] in ['0'..'9']) then
      begin
      	edGrid.Text := Copy(useltext,1,2)+Copy(lseltext,3,4);
        edGridExit(Self);
      end
      else if not qsostarted then
      begin
        SetQSOFreq;
        edCall.Text := useltext;
        if (not contestmode) and realreports then
        begin
          edRSTs.Clear;
          edRSTr.Clear;
        end;
        edExchr.Clear;
        edName.Clear;
        edQTH.Clear;
        edGrid.Clear;
        edNotes.Clear;
        txLookup.Visible := true;
        txLookup2.Visible := true;
        {$IFDEF WINDOWS}
        imgSpot.Visible := true;
        {$ENDIF}
        Delay(50);
        if (edFreq.Text <> '') and (cbMode.Text <> '') then
          ShowContactInfo(edCall.Text,freqtoband(StripAll(DecimalSeparator,edFreq.Text)+'000'),cbMode.Text);
      end;
    end
    else
    begin
      if edName.Text = '' then
        edName.Text := useltext[1]+Copy(lseltext,2,31)
      else
        edQTH.Text := StringReplace(CapText(seltext), 'Nr ', 'nr ', [rfReplaceAll]);
    end;
  end;
  if formmode > 0 then
	  TypeAhead.SetFocus;
end;

procedure TfrmMain.RXPopupMenuPopup(Sender: TObject);
var
	i: Integer;
  hasnumbers, hasletters, isnumeric, copyenabled, isurl: Boolean;
  s: string;
begin
	seltext := Trim(RXPanel.SelText);
  if (Length(seltext) > 0) and not (seltext[1] in ['0'..'9','A'..'Z','a'..'z']) then
    Delete(seltext,1,1);
  if (Length(seltext) > 0) and not (seltext[Length(seltext)] in ['0'..'9','A'..'Z','a'..'z']) then
    Delete(seltext,Length(seltext),1);
  copyenabled := Length(seltext) > 0;
  if copyenabled then
  begin
    useltext := UpperCase(seltext);
    lseltext := LowerCase(seltext);
  	hasnumbers := false;
    for i := 1 to Length(useltext) do
    	if useltext[i] in ['0'..'9'] then
      	hasnumbers := true;
  	hasletters := false;
    for i := 1 to Length(useltext) do
    	if useltext[i] in ['A'..'Z'] then
      	hasletters := true;
    isnumeric := hasnumbers;
    if isnumeric then
    begin
      for i := 1 to Length(useltext) do
      	if not (useltext[i] in ['0'..'9','N','T']) then
          isnumeric := false;
    end;
    s := Copy(lseltext,1,4);
    isurl := (s = 'www.') or (s = 'http');
  end;
  mnuCopytoCall.Enabled := copyenabled and hasnumbers and hasletters;
  mnuCopytoName.Enabled := copyenabled and not hasnumbers;
  mnuCopyToRST.Enabled := copyenabled and isnumeric;
  mnuCopytoExch.Enabled := copyenabled;
  mnuCopytoQTH.Enabled := copyenabled and not hasnumbers;
  mnuAddToQTH.Enabled := copyenabled;
  mnuCopytoGrid.Enabled := copyenabled and ((Length(seltext) = 4) or (Length(seltext) = 6)) and (seltext[3] in ['0'..'9']) and (seltext[4] in ['0'..'9']);
  mnuAddToNotes.Enabled := copyenabled;
  mnuCopyToClipboard.Enabled := copyenabled;
  mnuOpenURL.Enabled := copyenabled and isurl;
end;

procedure TfrmMain.sgLogClick(Sender: TObject);
var
  prefix,country,continent,cqzone,ituzone: string;
  lat,lon,range,bearing: extended;
  logitems: TLogItems;
begin
  lat := 0.0; lon := 0.0;
  // this procedure is executed even if Row is set programmatically
  // so we must bail out when adding a new record
  if adding then Exit;
  // otherwise display info on selected record
  if ctydatavailable then
  begin
    ParseLogLine(log.Strings[sgLog.Row-1],logitems);
    if FindCountry(logitems[1],prefix,country,continent,cqzone,ituzone,lat,lon) then
    begin
      if logitems[21] = '' then
        PathCalc(mylat,mylon,lat,lon,false,range,bearing)
      else
      begin
        LocatorToGeog(logitems[21],lat,lon);
        if (lat <> 0.0) and (lon <> 0.0) then
          PathCalc(mylat,mylon,lat,lon,false,range,bearing);
      end;
      StatusBar.Caption := Format('%s: %s (%s) CQ: %s ITU: %s QRB: %4.0fkm  QTF: %3.0f%s',[prefix,country,continent,cqzone,ituzone,range,bearing,sDeg]);
      pp := 15;
    end;
  end;
end;

procedure TfrmMain.sgLogMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ptClient: TPoint;
begin
  if Button = mbPopup then
  begin
    ptClient.x:= X;
    ptClient.y:= Y;
    ptClient := sgLog.ClientToScreen(ptClient);
    LogPopupMenu.PopUp(ptClient.x,ptClient.y);
  end;
end;

procedure TfrmMain.ShortcutsPopupMenuPopup (Sender: TObject );
begin
  mnuEditShortcut.Enabled := lbShortcuts.ItemIndex >= 0;
  mnuDeleteShortcut.Enabled := lbShortcuts.ItemIndex >= 0;
end;

procedure TfrmMain.FormState(frmmode: integer);
var
  sticktoright, lw: boolean;

  procedure ButtonPositions;
  begin
    btnRollUp.Left := pnStatusBar.Width - 22;
    TaskbarButtons;
  end;
  
begin
  sticktoright := (Self.Left + Self.Width) >= (Screen.DesktopWidth - 10);
  GroupBox3.Visible := false;
  GroupBox4.Visible := false;
  GroupBox7.Visible := false;
  GroupBox8.Visible := false;
  Delay(20);
  case frmmode of
  0:  begin
        // all hidden
        GroupBox7.Top := GroupBox1.Top;
        GroupBox7.Left := GroupBox1.Left + GroupBox1.Width + 8;
        GroupBox7.Height := GroupBox2.Top + GroupBox2.Height - GroupBox7.Top;
        FrmMain.Height :=  GroupBox2.Top + GroupBox2.Height + 26;
        FrmMain.Width := GroupBox7.Left + GroupBox7.Width + 8;
        lbShortcuts.Height := GroupBox7.Height - 25;
        btnRollUp.Caption := 'v';
        btnRollUp.Hint := 'Show receive and transmit panels';
      end;
  1:  begin
        // transmit panel visible
        GroupBox4.Top := GroupBox3.Top;
        GroupBox7.Top := GroupBox3.Top;
        GroupBox7.Left := GroupBox3.Left + GroupBox3.Width + 8;
        GroupBox7.Height := GroupBox4.Height;
        lbShortcuts.Height := GroupBox4.Height - 25;
        FrmMain.Height :=  GroupBox4.Top + GroupBox4.Height + 26;
        FrmMain.Width := GroupBox1.Width + 16;
        GroupBox4.Visible := true;
        if btnRollUp.Caption = '^' then
          btnRollUp.Hint := 'Hide receive panel'
        else
          btnRollUp.Hint := 'Show receive panel';
      end;
  else
    // all visible
    GroupBox4.Top := GroupBox3.Top + GroupBox3.Height;
    GroupBox7.Height := GroupBox4.Top + GroupBox4.Height - GroupBox3.Top;
    GroupBox7.Left := GroupBox3.Left + GroupBox3.Width + 8;
    lbShortcuts.Height := GroupBox7.Height - 25;
    {$IFDEF WINDOWS}
    lw := largewfall and decodepsk and (vmode = data_a);
    if lw then
    begin
      FrmMain.Height := GroupBox8.Top + GroupBox8.Height + 26;
      GroupBox8.Visible := true;
      if Screen.Cursors[1] = 0 then
      begin
        Screen.Cursors[1] := LoadCursorFromLazarusResource('PSK31');
        Screen.Cursors[2] := LoadCursorFromLazarusResource('PSK63');
        Screen.Cursors[3] := LoadCursorFromLazarusResource('PSK125');
      end;
      if lwpalette = '' then
        ResetDefaultPalette
      else
        LoadPaletteFromFile(lwpalette);
      LWfreqDisplayPaint;
    end
    else
    {$ENDIF}
    FrmMain.Height := GroupBox4.Top + GroupBox4.Height + 26;
    FrmMain.Width := GroupBox1.Width + 16;
    GroupBox3.Visible := true;
    GroupBox4.Visible := true;
    btnRollUp.Caption := '^';
    btnRollUp.Hint := 'Hide receive and transmit panels';
  end;
  GroupBox7.Visible := true;
  ButtonPositions;
  if sticktoright or ((Self.Left + Self.Width) >= Screen.DesktopWidth) then
    Self.Left := Screen.DesktopWidth - Self.Width - 6;
  formmode := frmmode;
end;

procedure TfrmMain.BandButtons;
begin
  // set band buttons
  SetBandButtonCaption(btnB01);
  SetBandButtonCaption(btnB02);
  SetBandButtonCaption(btnB03);
  SetBandButtonCaption(btnB04);
  SetBandButtonCaption(btnB05);
  SetBandButtonCaption(btnB06);
  SetBandButtonCaption(btnB07);
  SetBandButtonCaption(btnB08);
  SetBandButtonCaption(btnB09);
  SetBandButtonCaption(btnB10);
  SetBandButtonCaption(btnB11);
  SetBandButtonCaption(btnB12);
  SetBandButtonCaption(btnB13);
  SetBandButtonCaption(btnB14);
  SetBandButtonCaption(btnB15);
  SetBandButtonCaption(btnB16);
  // enable mode buttons
  btnLSB.Enabled := connected;
  btnUSB.Enabled := connected;
  btnCW.Enabled := connected or fldigiactive;
  btnData.Enabled := connected or fldigiactive;
  case radio of
  k2:
      begin
        btnCWR.Enabled := connected and (radio = k2);
        btnAM.Enabled := false;
        btnFM.Enabled := false;
        mnuModeRTTY.Visible := fldigiactive;
        mnuModeBPSK.Visible := (connected and decodepsk) or fldigiactive;
        mnuModeBPSK31.Visible := (connected and decodepsk) or fldigiactive;
        mnuModeBPSK63.Visible := (connected and decodepsk) or fldigiactive;
        mnuModeBPSK125.Visible := {$IFDEF WINDOWS}(connected and decodepsk and (psk31coreversion >= 121)) or {$ENDIF} fldigiactive;
      end;
  k3,kx3:
      begin
        btnCWR.Enabled := connected;
        btnAM.Enabled:= connected;
        btnFM.Enabled:= connected;
        mnuModeRTTY.Visible := fldigiactive or usek3dsp;
        mnuModeBPSK.Visible := (connected and (decodepsk or usek3dsp)) or fldigiactive;
        mnuModeBPSK31.Visible := (connected and (decodepsk or usek3dsp)) or fldigiactive;
        mnuModeBPSK63.Visible := (connected and decodepsk) or fldigiactive;
        mnuModeBPSK125.Visible := {$IFDEF WINDOWS}((connected and decodepsk) and (psk31coreversion >= 121)) or {$ENDIF} fldigiactive;
      end;
  end;
  mnuModeBPSK63F.Visible := fldigiactive;
  mnuModeBPSK250.Visible := fldigiactive;
  mnuModeBPSK500.Visible := fldigiactive;
  mnuModeQPSK.Visible := fldigiactive;
  mnuModeMFSK.Visible := fldigiactive;
  mnuModeOlivia.Visible := fldigiactive;
end;

procedure TfrmMain.ShowContactInfo(call,band,mode: string);
var
  infostr, newstr, wkdstr, cname, qth, grid: string;
begin
  // quit if we have already looked up this call
  if call = chkqsobefore then Exit;
  chkqsobefore := call;
  ContactInfo(call, band, mode, infostr, newstr, wkdstr, cname, qth, grid);
  StatusBar.Caption := Trim(infostr+'  '+Trim(newstr)+'  '+wkdstr);
  pp := 15;
  if wkdstr <> '' then
  begin
    edName.Text := cname;
    edQTH.Text := qth;
    edGrid.Text := grid;
    Delay(100);
    Application.MessageBox('QSO before!',PChar(Application.Title),MB_ICONINFORMATION);
    if contestmode then
    begin
      edCall.Clear;
      edCall.SetFocus;
    end;
  end
  else
    if contestmode then edExchr.SetFocus;
end;

procedure TfrmMain.ContactInfo(call,band,mode: string; var infostr, newstr, wkdstr, cname, qth, grid: string);
var
  i: integer;
  wkd, chknew: boolean;
  new: array[0..14] of boolean;
  prefix,country,continent,cqzone,ituzone: string;
  chkline, cq, itu: string;
  b1, c1, c2: string;
  lat,lon,range,bearing: extended;
  logitems: TLogItems;
begin
  chknew := (band <> '') and (mode <> '') and ctydatavailable;
  lat := 0.0; lon := 0.0;
  infostr := Format('%s: <unknown>',[call]); newstr := ''; wkdstr := '';
  // get the country, continent and distance details
  if ctydatavailable then
  begin
    if FindCountry(call,prefix,country,continent,cqzone,ituzone,lat,lon) then
      PathCalc(mylat,mylon,lat,lon,false,range,bearing)
    else
      chknew := false;
  end;
  if chknew then
    for i := 0 to 14 do new[i] := true;
  // scan backwards thru the log checking for previous qso, new country etc.
  i := log.Count;
  wkd := false;
  repeat
    Dec(i);
    if i < 0 then break;
    ParseLogLine(log.Strings[i],logitems);
    if contestmode and (logitems[2] < conteststart) then break;
    if not wkd then
    begin
      // check if QSO before
      if contestmode then
        case dupcheck of
        0: wkd := call = logitems[1];
        1: wkd := (call = logitems[1]) and (band = FreqToBand(logitems[6]));
        2: wkd := (call = logitems[1]) and (band = FreqToBand(logitems[6])) and (mode = logitems[9]);
        end
      else
        wkd := call = logitems[1];
      if wkd then
      begin
        if contestmode then
          wkdstr := Format('Worked on %s %s (%s %s)',[FreqToBand(logitems[6]),logitems[9],ShowDate(logitems[2]),ShowTime(logitems[2])])
        else
          wkdstr := Format('Last QSO on %s at %s on %s %s.',[ShowDate(logitems[2]),ShowTime(logitems[2]),FreqToBand(logitems[6]),logitems[9]]);
        cname := logitems[14];
        qth := logitems[15];
        if logitems[21] <> '' then
        begin
          grid := logitems[21];
          // recalculate QRB using previously logged grid
          LocatorToGeog(logitems[21],lat,lon);
          if (lat <> 0.0) and (lon <> 0.0) then
            PathCalc(mylat,mylon,lat,lon,false,range,bearing);
        end;
      end;
    end;
    if chknew then
    begin
      chkline := Check.Strings[i]; cq := CQZ.Strings[i]; itu := ITUZ.Strings[i];
      b1 := FreqToBand(logitems[6]);
      c1 := continent+';'+country+';';
      c2 := c1+prefix+';';
      // check for all-time new entities
      if continent = Copy(chkline,1,2) then
      begin
        new[0] := false;                                                        // new[0]: all-time new continent
        if c1 = Copy(chkline,1,Length(c1)) then
        begin
          new[1] := false;                                                      // new[1]: all-time new country
          if c2 = chkline then new[2] := false;                                 // new[2]: all-time new prefix
        end
      end;
      if cqzone = cq then new[3] := false;                                      // new[3]: all-time new CQ zone
      if ituzone = itu then new[4] := false;                                    // new[4]: all-time new ITU zone
      // check for band new entities
      if band = b1 then
      begin
        if continent = Copy(chkline,1,2) then
        begin
          new[5] := false;                                                      // new[5]: new continent on band
          if c1 = Copy(chkline,1,Length(c1)) then
          begin
            new[6] := false;                                                    // new[6]: new country on band
            if c2 = chkline then new[7] := false;                               // new[7]: new prefix on band
          end
        end;
        if cqzone = cq then new[8] := false;                                    // new[8]: new CQ zone on band
        if ituzone = itu then new[9] := false;                                  // new[9]: new ITU zone on band
        // check for band / mode new entities
        if mode = logitems[9] then
        begin
          if continent = Copy(chkline,1,2) then
          begin
            new[10] := false;                                                   // new[10]: new continent on band/mode
            if c1 = Copy(chkline,1,Length(c1)) then
            begin
              new[11] := false;                                                 // new[11]: new country on band/mode
              if c2 = chkline then new[12] := false;                            // new[12]: new prefix on band/mode
            end
          end;
          if cqzone = cq then new[13] := false;                                 // new[13]: new CQ zone on band/mode
          if ituzone = itu then new[14] := false;                               // new[14]: new ITU zone on band/mode
        end
      end;
    end;
  until false;
  if lat <> 0.0 then
    infostr := Format('%s: %s (%s) CQ: %s ITU: %s QRB: %4.0fkm  QTF: %3.0f%s',[prefix,country,continent,cqzone,ituzone,range,bearing,sDeg]);
  if chknew then
  begin
    if contestmode then
    begin
      if alerts[0] and new[3] then newstr := 'New CQ zone. ';
      if alerts[1] and new[4] then newstr := newstr + 'New ITU zone. ';
      if alerts[2] and new[1] then newstr := newstr + 'New country. ';
      if alerts[3] and new[2] then newstr := newstr + 'New WPX. ';
      if alerts[0] and new[8] and (not new[3]) then newstr := newstr + Format('New CQ zone on %s. ',[band]);
      if alerts[1] and new[9] and (not new[4]) then newstr := newstr + Format('New ITU zone on %s. ',[band]);
      if alerts[2] and new[6] and (not new[1]) then newstr := newstr + Format('New country on %s. ',[band]);
      if alerts[3] and new[7] and (not new[2]) then newstr := newstr + Format('New WPX on %s. ',[band]);
      if alerts[0] and new[13] and (not new[3]) and (not new[8]) then newstr := newstr + Format('New CQ zone on %s %s. ',[band, mode]);
      if alerts[1] and new[14] and (not new[4]) and (not new[9]) then newstr := newstr + Format('New ITU zone on %s %s. ',[band, mode]);
      if alerts[2] and new[11] and (not new[1]) and (not new[6]) then newstr := newstr + Format('New country on %s %s. ',[band, mode]);
      if alerts[3] and new[12] and (not new[2]) and (not new[7]) then newstr := newstr + Format('New WPX on %s %s. ',[band, mode]);
    end
    else
    begin
      if new[0] then newstr := 'New continent. '
      else if new[1] then newstr := 'New country. '
      else if new[2] then newstr := 'New WPX. ';
      if new[5] and (not new[0]) then
        newstr := newstr + Format('New continent on %s. ',[band])
      else if new[6] and (not new[1]) then newstr := newstr + Format('New country on %s. ',[band])
      else if new[7] and (not new[2]) then newstr := newstr + Format('New WPX on %s. ',[band]);
      if new[10] and (not new[0]) and (not new[5]) then
        newstr := newstr + Format('New continent on %s %s. ',[band, mode])
      else if new[11] and (not new[1]) and (not new[6]) then newstr := newstr + Format('New country on %s %s. ',[band, mode])
      else if new[12] and (not new[2]) and (not new[7]) then newstr := newstr + Format('New WPX on %s %s. ',[band, mode]);
    end;
  end;
end;

procedure TfrmMain.txLookupClick(Sender: TObject);
var
  url, defaulturl, n: string;
begin
  if Sender = txLookup then
  begin
  	 n := 'LookupURL1';
     defaulturl := surldef1;
  end
  else
  begin
  	 n := 'LookupURL2';
     defaulturl := surldef2;
  end;
  url := GetValueFromConfigFile(sConfigRoot,n,defaulturl)+edCall.Text;
  StatusBar.Caption := Format('Opening %s in your browser',[url]);
  pp := 5;
  try
	  OpenURL(url);
  except
  end;
end;

procedure TfrmMain.sgLogDblClick(Sender: TObject);
var
  recno, i, n, p: integer;
  dd, st, et, ll: string;
  selection: TGridRect;
  logitems: TLogItems;
  chkline,prefix,country,continent,cqzone,ituzone: string;
  l1,l2: extended;
  
  function EndTime(t1, t2: string): string;
  var
    st, et: TDateTime;
  begin
    st := (StrToIntDef(Copy(t1,9,2),0)*3600+StrToIntDef(Copy(t1,11,2),0)*60+StrToIntDef(Copy(t1,11,2),0)) / 86400;
    et := st + StrToIntDef(t2,0) / 86400;
    Result := FormatDateTime('hh:nn',et);
  end;
  
  function TimeDiff(t1, t2: string): string;
  var
    p, st, et, diff: Integer;
  begin
    p := Pos(TimeSeparator,t1);
    st := StrToIntDef(Copy(t1,1,p-1),0)*3600+StrToIntDef(Copy(t1,p+1,2),0)*60;
    et := StrToIntDef(Copy(t2,1,p-1),0)*3600+StrToIntDef(Copy(t2,p+1,2),0)*60;
    diff := et - st;
    if diff < 0 then diff := diff + 86400;
    Result := IntToStr(diff);
  end;
  
begin
  selection := sgLog.Selection;
  if selection.Bottom > selection.Top then
  begin
    with frmExport do
    begin
      firstrec := selection.Top - 1;
      lastrec := selection.Bottom - 1;
      dlgshowing := true;
      ShowModal;
      dlgshowing := false;
    end;
  end
  else
  begin
    // selection.Top - 1 gives record number
    recno := selection.Top - 1;
    ParseLogLine(log.Strings[recno],logitems);
    with frmEditRec do
    begin
      dd := ShowDate(logitems[2]);
      edDate.Text := dd;
      st := ShowTime(logitems[2]);
      edTime.Text := st;
      et := EndTime(logitems[2],logitems[3]);
      edTimeEnded.Text := et;
      edFreq.Text := ShowFreq(logitems[6]);
      try
        n := frmEditRec.cbMode.Items.IndexOf(logitems[9]);
        cbMode.ItemIndex := n;
      except
      end;
      edCall.Text := logitems[1];
      edRSTS.Text := logitems[10];
      edExchS.Text := logitems[12];
      edRSTR.Text := logitems[11];
      edExchR.Text := logitems[13];
      edName.Text := logitems[14];
      edQTH.Text := logitems[15];
      edGrid.Text := logitems[21];
      edIOTA.Text := logitems[20];
      edDomain.Text := logitems[17];
      edCounty.Text := logitems[19];
      edNotes.Text := logitems[16];
      edCustom.Text := logitems[25];
      edQSLMgr.Text := logitems[18];
      cbQSLSent.Checked := logitems[4]<>'';
      cbQSLRcvd.Checked := logitems[5]<>'';
      cbeQSLSent.Checked := logitems[23]<>'';
      cbeQSLRcvd.Checked := logitems[24]<>'';
      if cbeQSLSent.Checked then
        btnSendEQSL.Enabled := false;
      if ctydatavailable then
      begin
        chkline := Check.Strings[recno];
        p := Pos(';',chkline);
        if p > 0 then
        begin
          continent := Copy(chkline,1,p-1);
          Delete(chkline,1,p);
        end;
        p := Pos(';',chkline);
        if p > 0 then
        begin
          country := Copy(chkline,1,p-1);
          Delete(chkline,1,p);
        end;
        p := Pos(';',chkline);
        if p > 0 then
        begin
          prefix := Copy(chkline,1,p-1);
          Delete(chkline,1,p);
        end;
        pnInfo.Caption := Format(' %s: %s (%s)  CQ zone: %s  ITU zone: %s',[prefix,country,continent,CQZ.Strings[recno],ITUZ.Strings[recno]]);
      end
      else
        pnInfo.Caption := ' Country data not available';
      dlgshowing := true;
      if ShowModal = mrOK then
      begin
        logitems[1] := CleanText(edCall.Text);
        logitems[2] := StripAll(DateSeparator,edDate.Text)+StripAll(TimeSeparator,edTime.Text)+'00';
        if edTimeEnded.Text <> et then
          logitems[3] := TimeDiff(edTime.Text,edTimeEnded.Text);
        if not cbQSLSent.Checked then logitems[4] := '';
        if cbQSLSent.Checked and (logitems[4]='') then
          logitems[4] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);
        if not cbQSLRcvd.Checked then logitems[5] := '';
        if cbQSLRcvd.Checked and (logitems[5]='') then
          logitems[5] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);
        logitems[6] := StripAll(DecimalSeparator,edFreq.Text)+'000';
        logitems[9] := cbMode.Text;
        logitems[10] := edRSTS.Text;
        logitems[11] := edRSTR.Text;
        logitems[12] := edExchS.Text;
        logitems[13] := edExchR.Text;
        logitems[14] := CleanText(edName.Text);
        logitems[15] := CleanText(edQTH.Text);
        logitems[16] := CleanText(edNotes.Text);
        logitems[17] := CleanText(edDomain.Text);
        logitems[18] := edQSLMgr.Text;
        logitems[19] := CleanText(edCounty.Text);
        logitems[20] := edIOTA.Text;
        logitems[21] := edGrid.Text;
        if not cbeQSLSent.Checked then logitems[23] := '';
        if cbeQSLSent.Checked and (logitems[23]='') then
          logitems[23] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);
        if not cbeQSLRcvd.Checked then logitems[24] := '';
        if cbeQSLRcvd.Checked and (logitems[24]='') then
          logitems[24] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);
        logitems[25] := CleanText(edCustom.Text);
        // build log line
        ll := '';
        for i := 0 to 25 do
          ll := Trim(ll+logitems[i]+';');
        if ll <> log.Strings[recno] then
        begin
          log.Strings[recno] := ll;
          log.SaveToFile(LogFileName);
          logchanged := true;
        end;
        // update string grid
        sgLog.Cells[0,recno+1] := edDate.Text;
        sgLog.Cells[1,recno+1] := edTime.Text;
        sgLog.Cells[2,recno+1] := edFreq.Text;
        sgLog.Cells[3,recno+1] := cbMode.Text;
        sgLog.Cells[4,recno+1] := CleanText(edCall.Text);
        sgLog.Cells[5,recno+1] := CleanText(edRSTS.Text+' '+edExchS.Text);
        sgLog.Cells[6,recno+1] := CleanText(edRSTR.Text+' '+edExchR.Text);
        sgLog.Cells[7,recno+1] := CleanText(edName.Text);
        sgLog.Cells[8,recno+1] := CleanText(edQTH.Text);
        sgLog.Cells[9,recno+1] := CleanText(edNotes.Text);
        // update check list
        if ctydatavailable then
        begin
          if FindCountry(edCall.Text,prefix,country,continent,cqzone,ituzone,l1,l2) then
          begin
            Check.Strings[recno] := continent+';'+country+';'+prefix+';';
            CQZ.Strings[recno] := cqzone;
            ITUZ.Strings[recno] := ituzone;
          end
          else
          begin
            Check.Strings[recno] := ';;;';
            CQZ.Strings[recno] := '--';
            ITUZ.Strings[recno] := '---';
          end
        end;
      end;
      dlgshowing := false;
    end;
  end;
end;

procedure TfrmMain.LoadLog;
var
  i: Integer;
  logitems: TLogItems;
  prefix,country,continent,cqzone,ituzone: string;
  l1,l2: extended;
begin
  // load MixW-compatible log file
  // this procedure is only executed if the log file exists...
  StatusBar.Caption := 'Loading log...';
  Application.ProcessMessages;
  log.LoadFromFile(LogFileName);
  if log.Count > 0 then
  begin
    Check.Clear;
    CQZ.Clear;
    ITUZ.Clear;
    sgLog.RowCount := log.Count + 1;
    i := 0;
    while (i < Log.Count) and (Trim(log.Strings[i]) <> '') do
    begin
      ParseLogLine(log.Strings[i],logitems);
      Inc(i);
      if (i mod 10) = 0 then
      begin
        StatusBar.Caption := 'Loading record '+IntToStr(i);
        Application.ProcessMessages;
      end;
      sgLog.Row := i;
      sgLog.Cells[0,i] := ShowDate(logitems[2]);
      sgLog.Cells[1,i] := ShowTime(logitems[2]);
      sgLog.Cells[2,i] := ShowFreq(logitems[6]);
      sgLog.Cells[3,i] := logitems[9];
      sgLog.Cells[4,i] := logitems[1];
      sgLog.Cells[5,i] := Trim(logitems[10]+' '+logitems[12]);
      sgLog.Cells[6,i] := Trim(logitems[11]+' '+logitems[13]);;
      sgLog.Cells[7,i] := logitems[14];
      sgLog.Cells[8,i] := logitems[15];
      sgLog.Cells[9,i] := logitems[16];
      if ctydatavailable then
      begin
        if FindCountry(logitems[1],prefix,country,continent,cqzone,ituzone,l1,l2) then
        begin
          Check.Add(continent+';'+country+';'+prefix+';');
          CQZ.Add(cqzone);
          ITUZ.Add(ituzone);
        end
        else
        begin
          Check.Add(';;;');
          CQZ.Add('--');
          ITUZ.Add('---');
        end;
      end;
    end;
    if log.Count > 3 then
    begin
      sgLog.TopRow := log.Count - 3;
      Delay(50);
    end;
  end
  else
    Application.MessageBox('Error opening log file',PChar(Application.Title),MB_ICONWARNING);
  StatusBar.Caption := sVer;
end;

procedure TfrmMain.TimerTimer(Sender: TObject);
var
  i,l,n: integer;
  data, pollstr, txt: string;
  f: extended;
  rxc, txc: char;
begin
  lbTime.Caption := FormatDateTime('hh:nn:ss',Now+TimeZoneBias);
  {$IFDEF WINDOWS}
  // Fldigi keep on top
  if fldigiactive and fldigikeepontop and (not dlgshowing) then
  begin
    if (GetForegroundWindow() = fl_handle) and (WindowState <> wsMinimized) then
    begin
      ForceForegroundWindow(Handle);
      Delay(50);
      SetWindowPos(fl_handle,Handle,0,0,0,0,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
    end;
  end;
  // MRP40 integration
  if usemrp40 and MRP40_Active then
  begin
    if mrp40keepontop and (not dlgshowing) then
    begin
      if (GetForegroundWindow() = mrp40_handle) and (WindowState <> wsMinimized) then
      begin
        ForceForegroundWindow(Handle);
        Delay(50);
        SetWindowPos(mrp40_handle,Handle,0,0,0,0,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
      end;
    end;
    if vmode = cw then
    begin
      txt := MRP40_GetChars;
      if Length(txt) > 0 then
      begin
        if cbRxUpperCase.Checked then txt := UpperCase(txt);
        rxbuf := rxbuf + txt;
        if MRP40_Buffer_Overflow then
          btnClearRXClick(Sender);
      end;
    end;
  end;
  {$ENDIF}
  if fldigiactive and ((vmode = data_a) or (vmode = cw)) then
    rxbuf := rxbuf + Fldigi_GetRxString;
  if rxpdelay > 0 then
    Dec(rxpdelay)
  else
  begin
    if rxbuf <> '' then
    begin
      AddText(RXPanel,rxbuf);
      if (autoparse or autospot) and (not tx) then
      begin
        for i := 1 to Length(rxbuf) do
        begin
          rxc := rxbuf[i];
          if rxc > #127 then
            parsebuf := parsebuf + StrToUTF8(rxc,rxcharset)
          else if rxc >= #32 then
            parsebuf := parsebuf + rxc;
        end;
        l := Length(parsebuf);
        if l > 32 then
          Delete(parsebuf,1,l-32);
        if qsostarted then
        begin
          if autoparse then
          begin
            if (not rstr) and ParseFromText('RST','RSQ','','',parsebuf,txt,true) and ValidRpt(txt,cbMode.Text) then
            begin
              edRSTr.Text := txt;
              rstr := true;
            end;
            if (edName.Text = '') and ParseFromText('NAME','','IS',':',parsebuf,txt,true) then
              edName.Text := CapText(txt);
            if (edQTH.Text = '') and ParseFromText('QTH','','IS','NR',parsebuf,txt,false) then
              edQTH.Text := CapText(txt);
            if (edGrid.Text = '') and ParseFromText('LOC','LOCATOR',':','',parsebuf,txt,true) and ValidLocator(txt) then
              edGrid.Text := Copy(txt,1,4)+LowerCase(Copy(txt,5,2));
            if (edGrid.Text = '') and ParseFromText('GRID','QRA',':','',parsebuf,txt,true) and ValidLocator(txt) then
              edGrid.Text := Copy(txt,1,4)+LowerCase(Copy(txt,5,2));
          end;
        end
        else
          if ParseFromText('CQ','DE','DE','DX',parsebuf,txt,true) and ValidCall(txt) and (edCall.Text = '') then
          begin
            if autoparse then
            begin
              InsertText(txt);                              // insert call
              if mr_Timer.Enabled or (mr_count > 0) then    // cancel macro timer if running
              begin
                mr_Timer.Enabled := false;
                mr_count := 0;
                mr_text := '';
                StatusBar.Caption := 'Countdown aborted';
              end;
            end;
            {$IFDEF WINDOWS}
            if autospot then
            begin
              if not Assigned(frmReporter) then
              begin
                frmReporter := TfrmReporter.Create(frmMain);
                if pskreporterready then
                  frmReporter.Show;
              end;
              if pskreporterready and (cbMode.Text <> '') then
              begin
                if (vmode = data_a) and decodepsk and soundcard_on then
                  f := TrueFrequency(fnGetRXFrequency(0))
                else
                  f := curr_f;
                frmReporter.SendSpot(txt,cbMode.Text,f,REPORTER_SOURCE_AUTOMATIC);
              end;
            end;
            {$ENDIF}
          end
      end;
      rxbuf := '';
    end;
  end;
  if SerialPort.InstanceActive then
  begin
    data := SerialPort.RecvPacket(0);
    if data <> '' then
    begin
      if commtrace then
        frmTrace.AddLine('<- '+data);
      datain := datain + data;
      if parsedataenabled then
      begin
        // stop entering parse routine before previous has finished
        parsedataenabled := false;
        ParseDataIn;
        parsedataenabled := true;
      end;
    end;
  end;
  if (connected and (not disconnecting)) or fldigiactive then
  begin
    if (txstat > 0) and (txbuf<>'') then
    begin
      // text still to send
      if txbuf[1]=Chr(254) then
      begin
        // #254 = we are just waiting for everything to be sent
        //        and then go to receive
        StatusBar.Caption := 'Waiting for transmission to finish';
        pp := MAXINT;
        {$IFDEF WINDOWS}
        if (vmode = data_a) and decodepsk and soundcard_on then
        begin
          // wait for everything to be sent before going to receive
          if fnGetTXCharsRemaining() = 0 then
          begin
            fnStopTX;
        		TypeAhead.Clear;
            txbuf := '';
            // finish transmitting on status change
          end
        end
        else
        {$ENDIF}
        if (vmode = cw) or ((vmode = data_a) and (radio in [k3,kx3]) and usek3dsp) then
        begin
          // K2, K3, KX3 KY data mode
          // wait for everything to be sent before going to receive
          // in cw we use break-in so no need to switch to RX
          if cwbufstate = 2 then
          begin
            // buffer is empty - everything is sent
        		txstat := 0;
        		TypeAhead.Clear;
            txbuf := '';
      	  	btnTxRX.Caption := 'Start sending';
            StatusBar.Caption := 'Transmission finished';
            pp := 15;
            if qsostarted and logend then
              btnLogEndClick(Sender);
            btnClearTxClick(Sender);
          end
          else
            // buffer still has text, so poll for status
            SendSerial('KY;');
        end
(*        else if (vmode = data_a) and fldigiactive then
        begin
          // wait for everything to be sent before going to receive
          // Fldigi will put TX to receive at end of transmission
          if not tx then
          begin
            // everything has been sent
        		txstat := 0;
        		TypeAhead.Clear;
            txbuf := '';
      	  	btnTxRX.Caption := 'Start sending';
            StatusBar.Caption := 'Transmission finished';
            pp := 15;
            if qsostarted and logend then
              btnLogEndClick(Sender);
            btnClearTxClick(Sender);
          end;
        end;  *)
      end
      else
      begin
        // text to send
        {$IFDEF WINDOWS}
        if (vmode = data_a) and decodepsk and soundcard_on then
        begin
          // using PSK Core DLL
          repeat
            txc := txbuf[1];
            if txc <> #254 then
            begin
              if txc = #9 then
              	fnSendTxCharacter(2,1)
              else
              	fnSendTxCharacter(Ord(txc),0);
              Delete(txbuf,1,1);
            end;
          until (Length(txbuf) = 0) or (txc = #254);
        end
        else
        {$ENDIF}
        if fldigiactive and (vmode = data_a) then
        begin
          // using Fldigi
          txt := '';
          repeat
            txc := txbuf[1];
            if txc <> #254 then
            begin
              txt := txt + txc;
              Delete(txbuf,1,1);
            end;
          until (Length(txbuf) = 0) or (txc = #254);
          if Length(txt) > 0 then
            Fldigi_SendTxString(txt);
        end
        else if (vmode = cw) or ((radio in [k3,kx3]) and (vmode = data_a) and usek3dsp) then
        begin
          // K2, K3 KY data mode
          case cwbufstate of
          0:  n := 6;
          1:  n := 0;
          2:  n := 24;
          else
            n := 0;
          end;
      		if n = 0 then
      			SendSerial('KY;')
      		else
      		begin
            i := 1;
            while (i < n) and (i < Length(txbuf)) and (txbuf[i]<>Chr(254)) do
              Inc(i);
            if txbuf[i]=Chr(254) then Dec(i);
            txt := Copy(txbuf,1,i);
      			SendSerial('KY '+txt+';');
      			cwbufstate := 1;
            if (vmode = cw) and (cbRxUpperCase.Checked) then txt := UpperCase(txt);
            rxbuf := rxbuf + txt;
     				Delete(txbuf,1,i);
      		end;
        end;
      end;
    end;
  end;
  if (connected and (not disconnecting))
    and (not disablepolling) then
  begin
    pollstr := '';
    if not fldigiactive then
    begin
//      if tx and (txstat = 0) then pollstr := 'RX;';
      case radio of
        k2:     if rev204 then pollstr := pollstr + 'TQ;' else pollstr := pollstr + 'IF;';
        k3,kx3: pollstr := pollstr + 'TQ;';
      end;
    end;
    if (not tx) then
    begin
      Dec(pp);
      pollstr := pollstr + 'BG;';
      if pp <= 0 then
      begin
        pollstr := pollstr + 'PC;GT;DS;';
        if vmode = cw then
          pollstr := pollstr + 'KS;';
      end;
      if (radio in [k3,kx3]) and ((vmode = cw) or ((vmode = data_a) and usek3dsp)) then
        pollstr := pollstr + 'TB;';
    end;
    if pollstr <> '' then
      SendSerial(pollstr);
  end;
  {$IFNDEF WINDOWS}
  if ipcactive and (not processingipc) then
    GetIPCData;
  {$ENDIF}
  btnLogSave.Enabled := (edDate.Text<>'') and (edTime.Text<>'') and (edFreq.Text<>'') and (cbMode.Text<>'')
    and (edCall.Text<>'') and (edRSTs.Text<>'') and (edRSTr.Text<>'') and (not contestmode or (edExchr.Text<>''));
end;

{$IFDEF WINDOWS}
// message-driven routines for PSK Core DLL  ** WINDOWS ONLY **
procedure TfrmMain.PSK31CoreFFTDataReady(var msg: TMessage);
begin
 	if fnGetFFTData( @FFTData, WFMin, WFMax ) and not SignalOverload then
  begin
  	StatusBar.Caption := '** Input Overload **';
    SignalOverload := true;
    pp := 15;
  end
  else
    SignalOverload := false;
  SigQuality := msg.LParam;
	WaterfallDisplayPaint(msg.WParam);
end;

procedure TfrmMain.PSK31CoreCharReady(var msg: TMessage);
var
  chan: Integer;
	char: Word;
  s: string;
begin
	char := msg.WParam;
  chan := msg.lParam;
  if chan <= 0 then
  begin
    if char in [8,13,32..255] then
      rxbuf := rxbuf + Chr(char);
  end
  else
    if Assigned(frmPSKBrowser) then frmPSKBrowser.AddChar(Chr(char),chan);
end;

procedure TfrmMain.PSK31CoreStatusChange(var msg: TMessage);
var
  errstr: string;
begin
  // deal with changes of state of the PSK31 Core DLL
	case msg.wParam of
  0:	begin
        // entered receive state
    		TypeAhead.Clear;
        txbuf := '';
        if qsostarted and logend then
          btnLogEndClick(Self);
        // turn off TX
        SendSerial('RX;');
   	  	btnTxRX.Caption := 'Start sending';
        StatusBar.Caption := 'Transmission finished';
        pp := 15;
    		txstat := 0;
        btnClearTxClick(Self);
        cbPSKTune.Enabled := true;
        if largewfall then
          lbIMD.Caption := 'n/a';
  		end;
  1:	begin
        // entered transmit state
        StatusBar.Caption := 'Transmitting';
        pp := MAXINT;
      end;
  3:  begin
        // received TxOff command
        StatusBar.Caption := 'Waiting for transmission to finish';
        pp := MAXINT;
      end;
  else
    SetLength(errstr,128);
    fnGetErrorString(PChar(errstr));
    SetLength(errstr,SizeOf(PChar(errstr)));
  	StatusBar.Caption := '** '+errstr+' **';
    pp := 15;
  end;
end;

procedure TfrmMain.PSK31CoreIMDReady(var msg: TMessage);
begin
 	if (msg.LParam = 0) and largewfall then
    lbIMD.Caption := Format('%d dB',[msg.WParam]);
end;
{$ENDIF}

procedure TfrmMain.WaterfallDisplayMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  f_ofs, wmode, rxf: integer;
  des_f: extended;
begin
  wmode := mode;
  if ((vmode = cw) and cwwaterfall) or ((vmode = data_a) and pskwaterfall) then
  begin
    if Button = mbLeft then
    begin
      // shift signal to center of passband
      case wmode of
      3:  f_ofs := -((X - (WaterfallDisplay.Width div 2)) * (CWWfall.CenterFreq div 120));
      7:  f_ofs := (X - (WaterfallDisplay.Width div 2)) * (CWWfall.CenterFreq div 120);
      6:  begin
            f_ofs := (X - (WaterfallDisplay.Width div 2)) * (1000 div 120);
            if dmode = 2 then f_ofs := -f_ofs;
          end;
      9:  begin
            f_ofs := (X - (WaterfallDisplay.Width div 2)) * (1000 div 120);
            if dmode = 3 then f_ofs := -f_ofs;
          end;
      end;
      if (radio = k2) and  (curr_f > 20000.0) then f_ofs := -f_ofs;   // K2 CW sideband switches above 20MHz
      des_f := curr_f + (f_ofs / 1000.0);
      SetFrequency(Trim(Format('%11.6f',[des_f/1000.0])),-1,'');
    end;
  end
  else if (vmode = data_a) and decodepsk then
  begin
    {$IFDEF WINDOWS}
    if Button = mbLeft then
    begin
			rxf := (X+1) * WFBandwidth div WaterfallDisplay.Width + WFOffset - 2;
      f_ofs := rxf - pskcenterfreq;
      if radio = k2 then f_ofs := -f_ofs;   // K2 DATA is LSB
      if Abs(f_ofs) < 50 then
  		  fnSetRXFrequency(rxf, 0, 0)
      else
      begin
        // shift signal to center of passband
        if wmode = 9 then f_ofs := -f_ofs;
        des_f := curr_f + (f_ofs / 1000.0);
        SetFrequency(Trim(Format('%11.6f',[des_f/1000.0])),-1,'');
        fnSetRXFrequency(pskcenterfreq, 0, 0)
      end;
      if not qsostarted then
        cbTXLock.Checked := false;
    end;
    if not cbPSK31AFC.Checked then
    begin
      // right-click waterfall to lock on to signal
    	fnSetAFCLimit(afcrange,0);
      Delay(1000);
      fnSetAFCLimit(afcmin, 0);
    end;
    if Button = mbRight then
      fnRewindInput(40);
    {$ENDIF}
  end;
end;

{$IFDEF WINDOWS}
procedure TfrmMain.WaterfallDisplayPaint(f: integer);
var
  TempBitmap: TBitmap;
  Rect: TRect;
  bmwidth, bmheight, i, v1, v2, g, sq: Integer;
// draw waterfall display  ** WINDOWS ONLY **
begin
  if largewfall then
  begin
    with LWfallDisplay do
    begin
  		bmwidth := Width;
    	bmheight := Height;
  	  TempBitmap := TBitmap.Create;
    	TempBitmap.Width := bmwidth;
  	  TempBitmap.Height := bmheight;
  	  Rect.Left := 0;
    	Rect.Top := 0;
  	  Rect.Right := bmwidth;
    	Rect.Bottom := bmheight;
      if soundcard_on then
   	  begin
        (* == this code draws a waterfall display == *)
  		  with TempBitmap.Canvas do
      	begin
        	// copy previous waterfall bitmap shifted down 1 pixel
        	BitBlt(Handle,0,1,bmwidth,bmheight-1,WaterfallBitmap.Canvas.Handle,0,0,SRCCOPY);
         // write new waterfall data
          for i := 0 to bmwidth-1 do
          begin
          	g := FFTData[WFMin+i];
            if g > 255 then g := 255;
            TempBitmap.Canvas.Pixels[i,0] := palette[g];
          end;
          // copy it back to waterfall bitmap
        	BitBlt(WaterfallBitmap.Canvas.Handle,0,0,bmwidth,bmheight,Handle,0,0,SRCCOPY);
  	  	  // draw Rx frequency position
  	    	Pen.Color := clRed;
  		    i := (f - WFOffset) * bmwidth div wfBandwidth;
          case psk31txmode of
          0:  begin v1 := -4; v2 := 4; end;
          8:  begin v1 := -8; v2 := 8; end;
          16: begin v1 := -15; v2 := 17; end;
          end;
    		  MoveTo(i+v1,0);
      		LineTo(i+v1,bmheight-1);
    		  MoveTo(i+v2,0);
      		LineTo(i+v2,bmheight-1);
  				// now draw waterfall display
        end;
      end
      else
  	    with TempBitmap.Canvas do
    	  begin
    		  Brush.Color := clBlack;
  	  		FillRect(Rect);
  	    end;
  		BitBlt(Canvas.Handle, 0, 0, Width, Height, TempBitmap.Canvas.Handle, 0, 0, SRCCOPY);
      LWfallDisplay.Invalidate;
  	  TempBitmap.Free;
    end;
    // display signal quality
    with imSQ do
    begin
  	  TempBitmap := TBitmap.Create;
    	TempBitmap.Width := Width;
  	  TempBitmap.Height := Height;
      sq := imSQ.Height - (SigQuality * 3) div 4;
      if sq < 0 then sq := 0;
      with TempBitmap.Canvas do
   	  begin
    	  Rect.Left := 0;
      	Rect.Top := 0;
  	    Rect.Right := imSQ.Width;
      	Rect.Bottom := sq;
        if sq > 0 then
        begin
     		  Brush.Color := clBtnFace;
      		FillRect(Rect);
        end;
        Rect.Top := sq;
        Rect.Bottom := imSQ.Height;
        if sq < imSQ.Height then
        begin
     		  Brush.Color := clGreen;
      		FillRect(Rect);
        end;
      end;
    	BitBlt(Canvas.Handle, 0, 0, Width, Height, TempBitmap.Canvas.Handle, 0, 0, SRCCOPY);
      imSQ.Invalidate;
      TempBitmap.Free;
    end;
    if SigQuality < 50 then
      lbIMD.Caption := 'n/a';
  end
  else
  begin
    with WaterfallDisplay do
    begin
  		bmwidth := Width;
    	bmheight := Height;
  	  TempBitmap := TBitmap.Create;
    	TempBitmap.Width := bmwidth;
  	  TempBitmap.Height := bmheight;
  	  Rect.Left := 0;
    	Rect.Top := 0;
  	  Rect.Right := bmwidth;
    	Rect.Bottom := bmheight;
      if soundcard_on then
   	  begin
        (* == this code draws a waterfall display == *)
  		  with TempBitmap.Canvas do
      	begin
        	// copy previous waterfall bitmap shifted down 1 pixel
        	BitBlt(Handle,0,1,bmwidth,bmheight-1,WaterfallBitmap.Canvas.Handle,0,0,SRCCOPY);
         // write new waterfall data
          for i := 0 to bmwidth-1 do
          begin
          	g := FFTData[WFMin+i] div 2;
            g := (g * g * g) div 2048 - 8;
            if g < 0 then g := 0;
            g := g + $1F;
            if g > 255 then g := 255;
            TempBitmap.Canvas.Pixels[i,0] := RGB(0,g,0);
          end;
          // copy it back to waterfall bitmap
        	BitBlt(WaterfallBitmap.Canvas.Handle,0,0,bmwidth,bmheight,Handle,0,0,SRCCOPY);
  	  	  // draw Rx frequency position
  	    	Pen.Color := clRed;
  		    i := (f - WFOffset) * bmwidth div WFBandwidth;
    		  MoveTo(i,0);
      		LineTo(i,bmheight-1);
  				// now draw waterfall display
        end;
      end
      else
  	    with TempBitmap.Canvas do
    	  begin
    		  Brush.Color := clBlack;
  	  		FillRect(Rect);
  	    end;
  		BitBlt(Canvas.Handle, 0, 0, Width, Height, TempBitmap.Canvas.Handle, 0, 0, SRCCOPY);
      WaterfallDisplay.Invalidate;
  	  TempBitmap.Free;
    end;
  end;
end;

procedure TfrmMain.LWfreqDisplayPaint;
var
  TempBitmap: TBitmap;
  Rect: TRect;
  bmwidth, bmheight, f, fstart, i, l: Integer;
  usb: boolean;
  fs: string;
begin
  case radio of
  k2: usb := mode = 9;
  k3,kx3: usb := mode = 6;
  end;
  with LWfreqDisplay do
  begin
		bmwidth := Width;
  	bmheight := Height;
	  TempBitmap := TBitmap.Create;
  	TempBitmap.Width := bmwidth;
	  TempBitmap.Height := bmheight;
	  Rect.Left := 0;
  	Rect.Top := 0;
	  Rect.Right := bmwidth;
  	Rect.Bottom := bmheight;
    with TempBitmap.Canvas do
 	  begin
 		  Brush.Color := clBlack;
  		FillRect(Rect);
      Font.Size := 8;
      Font.Color:= clWhite;
      Pen.Color := clYellow;
      MoveTo(0,bmheight-1);
      LineTo(bmwidth-1,bmheight-1);
      // display frequency ticks
      fstart := Trunc(curr_f * 1000.0);
      if usb then
      begin
        f := (fstart + WFOffset) div 100 * 100;
        repeat
          f := f + 100;
          i := (f - (fstart + WFOffset)) * 2048 div 8000;
          if (i > 1) and (i < bmwidth) then
          begin
            MoveTo(i,bmheight-1);
            if f mod 500 = 0 then
              LineTo(i,bmheight-10)
            else
              LineTo(i,bmheight-6);
            if f mod 1000 = 0 then
            begin
              fs := Format('%4.3f',[f / 1000000.0]);
              l := TextWidth(fs);
              TextOut(i-(l div 2),1,fs);
            end;
          end;
        until f > fstart + WFOffset + WFBandwidth;
      end
      else
      begin
        f := (fstart - WFOffset) div 100 * 100;
        repeat
          f := f - 100;
          i := ((fstart - WFOffset) - f) * 2048 div 8000;
          if (i > 1) and (i < bmwidth) then
          begin
            MoveTo(i,bmheight-1);
            if f mod 500 = 0 then
              LineTo(i,bmheight-10)
            else
              LineTo(i,bmheight-6);
            if f mod 1000 = 0 then
            begin
              fs := Format('%4.3f',[f / 1000000.0]);
              l := TextWidth(fs);
              TextOut(i-(l div 2),1,fs);
            end;
          end;
        until f < fstart - WFOffset - WFBandwidth;
      end;
    end;
  	BitBlt(Canvas.Handle, 0, 0, Width, Height, TempBitmap.Canvas.Handle, 0, 0, SRCCOPY);
    LWfreqDisplay.Invalidate;
    TempBitmap.Free;
  end;
  lbIMD.Caption := 'n/a';
end;
{$ENDIF}

procedure TfrmMain.btnSettingsClick(Sender: TObject);
var
  st,st1,st2,st3,st4: string;
begin
  // initialize settings dialog
  with frmSettings do
  begin
    edMyCall.Text := mycall;
    edLocator.Text := myloc;
    edPwr.Text := GetValueFromConfigFile(sConfigRoot,'Power','10');
    cbRpts.Checked := realreports;
    edAnt1.Text := antenna[1];
    edAnt2.Text := antenna[2];
    edLogFile.Text := LogFileName;
    cbBackupLog.Checked := GetValueFromConfigFile(sConfigRoot,'Backup_Log',false);
    edBackupFile.Text := GetValueFromConfigFile(sConfigRoot,'Backup_File','');
    frmSettings.cbBackupLogChange(Sender);
    cbAutoParse.Checked := GetValueFromConfigFile(sConfigRoot,'Auto_Parse',autoparse);
    cbAutoSpot.Checked := GetValueFromConfigFile(sConfigRoot,'Auto_Spot',autospot);
    cbContest.Checked := contestmode;
    if cbContest.Checked then
    begin
      edContestStartDate.Text := GetValueFromConfigFile(sConfigRoot,'Contest_start_date',FormatDateTime('yyyy/mm/dd',Now + TimeZoneBias));
      edContestStartTime.Text := GetValueFromConfigFile(sConfigRoot,'Contest_start_time',FormatDateTime('hh:nn',Now + TimeZoneBias));
      rgDuplicates.ItemIndex := dupcheck;
      cgAlerts.Checked[0] := alerts[0];
      cgAlerts.Checked[1] := alerts[1];
      cgAlerts.Checked[2] := alerts[2];
      cgAlerts.Checked[3] := alerts[3];
      cbIncExch.Checked := incexch;
    end;
    if iskx3 then radio := kx3;
    cbRadio.ItemIndex := Ord(radio);
    cbRev204.Checked := rev204;
    cbComPort.Items.Text := portlist;
    cbComPort.Text := GetValueFromConfigFile(sConfigRoot,'Com_Port','');
    cbPowerMate.Checked := frmMain.KeyPreview;
    cbCWRev.Checked:= GetValueFromConfigFile(sConfigRoot,'CW_Rev',false);
    cbCommTrace.Checked:= GetValueFromConfigFile(sConfigRoot,'Comm_Trace',false);
    frmSettings.cbRadioChange(Sender);
    if cbRadio.ItemIndex > 0 then
      cbSpeed.ItemIndex := cbSpeed.Items.IndexOf(GetValueFromConfigFile(sConfigRoot,'Speed','38400'));
    cbUseSoundcard.Checked := usesoundcard;
    cbUseK3DSP.Checked := usek3dsp;
    cbCWWaterfall.Checked := cwwaterfall;
    if cwwaterfall then
      try
        cbCWCenterFreq.ItemIndex := cbCWCenterFreq.Items.IndexOf(IntToStr(cwcenterfreq));
      except
      end;
    cbPSKWaterfall.Checked := pskwaterfall;
    {$IFDEF WINDOWS}
    cbRxSoundCard.ItemIndex := rx_sound_dev + 1;
    cbTxSoundCard.ItemIndex := tx_sound_dev + 1;
    cbDecodePSK.Checked := decodepsk;
    if decodepsk then
      try
        cbPSKCenterFreq.ItemIndex := cbPSKCenterFreq.Items.IndexOf(IntToStr(pskcenterfreq));
      except
      end;
    cbLargeWaterfall.Checked := largewfall;
    if lwpalette = '' then
      lbPSKPalette.Caption := 'default'
    else
      lbPSKPalette.Caption := lwpalette;
    // MRP40 options
    cbUseMRP40.Checked := GetValueFromConfigFile(sConfigRoot,'Use_MRP40',false);
    cbMRP40OnTop.Checked := GetValueFromConfigFile(sConfigRoot,'MRP40_KeepOnTop',false);
    edMRP40Path.Text := mrp40_path;
    // CW Skimmer options
    cbUseCWSkimmer.Checked := GetValueFromConfigFile(sConfigRoot,'Use_CW_Skimmer',false);
    edCWSkimmer.Text := GetValueFromConfigFile(sConfigRoot,'CW_Skimmer','');
    cbSpotCW.Checked := GetValueFromConfigFile(sConfigRoot,'Spot_CW',false);
    {$ELSE}
    try
      cbRxSoundCard.ItemIndex := cbRxSoundCard.Items.IndexOf(sound_dev);
    except
      cbRxSoundCard.ItemIndex := 0;
    end;
    {$ENDIF}
    // Fldigi options
    cbUseFldigi.Checked := GetValueFromConfigFile(sConfigRoot,'Use_Fldigi',false);
    {$IFDEF WINDOWS}
    cbFldigiOnTop.Checked := GetValueFromConfigFile(sConfigRoot,'Fldigi_KeepOnTop',false) and usefldigi;
    {$ENDIF}
    edFldigiPath.Text := GetValueFromConfigFile(sConfigRoot,'Fldigi','');
    // eQSL settings
    edEQSLUser.Text := eqsluser;
    edEQSLPassword.Text := eqslpass;
    cbAutoEQSL.ItemIndex := Ord(autoeqsl);
    // DX Cluster client settings
    edHost.Text := dxchost;
    edPort.Text := dxcport;
    edUserID.Text := dxcuser;
    edPassword.Text := dxcpass;
    cbShowInfo.Checked := GetValueFromConfigFile(sConfigRoot,'DX_Cluster_ShowInfo',false);
    // Call lookup settings
    edLookupURL1.Text := GetValueFromConfigFile(sConfigRoot,'LookupURL1',sURLdef1);
    edLookupURL2.Text := GetValueFromConfigFile(sConfigRoot,'LookupURL2',sURLdef2);
    edLookupHint1.Text := GetValueFromConfigFile(sConfigRoot,'LookupHint1',sURLHint1);
    edLookupHint2.Text := GetValueFromConfigFile(sConfigRoot,'LookupHint2',sURLHint2);
    // Misc settings
    fntchanged := false;
    try
      cbEncoding.ItemIndex := txcharset-1;
    except
    end;
    {$IFNDEF WINDOWS}
    edWebBrowser.Text := GetValueFromConfigFile(sConfigRoot,'Web_Browser','');
    {$ENDIF}
    dlgshowing := true;
    if ShowModal = mrOK then
    begin
      mycall := Uppercase(edMyCall.Text);
      SaveValueToConfigFile(sConfigRoot,'My_Call',mycall);
      myloc := edLocator.Text;
      SaveValueToConfigFile(sConfigRoot,'My_Locator',myloc);
      SaveValueToConfigFile(sConfigRoot,'Power',edPwr.Text);
      SaveValueToConfigFile(sConfigRoot,'Ant_1',edAnt1.Text);
      antenna[1] := edAnt1.Text;
      SaveValueToConfigFile(sConfigRoot,'Ant_2',edAnt2.Text);
      antenna[2] := edAnt2.Text;
      // recalculate home lat and long
      if (myloc = '') and ctydatavailable then
        FindCountry(mycall,st, st1, st2, st3, st4, mylat, mylon)
      else
        LocatorToGeog(myloc,mylat,mylon);
      if LogFileName <> edLogFile.Text then
      begin
        LogFileName := edLogFile.Text;
        if FileExists(LogFileName) then
        begin
          sgLog.RowCount := 1;
          LoadLog;
        end;
        SaveValueToConfigFile(sConfigRoot,'Log_File',LogFileName);
      end;
      SaveValueToConfigFile(sConfigRoot,'Backup_Log',cbBackupLog.Checked);
      SaveValueToConfigFile(sConfigRoot,'Backup_File',edBackupFile.Text);
      realreports := cbRpts.Checked;
      SaveValueToConfigFile(sConfigRoot,'Real_Reports',cbRpts.Checked);
      autoparse := cbAutoParse.Checked;
      SaveValueToConfigFile(sConfigRoot,'Auto_Parse',autoparse);
      autospot := cbAutoSpot.Checked;
      SaveValueToConfigFile(sConfigRoot,'Auto_Spot',autospot);
      contestmode := cbContest.Checked;
      SaveValueToConfigFile(sConfigRoot,'Contest_mode',contestmode);
      edExchs.Enabled := contestmode;
      edExchr.Enabled := contestmode;
      if contestmode then
      begin
        SaveValueToConfigFile(sConfigRoot,'Contest_start_date',edContestStartDate.Text);
        SaveValueToConfigFile(sConfigRoot,'Contest_start_time',edContestStartTime.Text);
        SaveValueToConfigFile(sConfigRoot,'Duplicate_check',rgDuplicates.ItemIndex);
        SaveValueToConfigFile(sConfigRoot,'Alert_0',cgAlerts.Checked[0]);
        SaveValueToConfigFile(sConfigRoot,'Alert_1',cgAlerts.Checked[1]);
        SaveValueToConfigFile(sConfigRoot,'Alert_2',cgAlerts.Checked[2]);
        SaveValueToConfigFile(sConfigRoot,'Alert_3',cgAlerts.Checked[3]);
        SaveValueToConfigFile(sConfigRoot,'Increment_exchange',cbIncExch.Checked);
        conteststart := StripAll(DateSeparator,edContestStartDate.Text)+StripAll(TimeSeparator,edContestStartTime.Text)+'00';
        dupcheck := rgDuplicates.ItemIndex;
        alerts[0] := cgAlerts.Checked[0];
        alerts[1] := cgAlerts.Checked[1];
        alerts[2] := cgAlerts.Checked[2];
        alerts[3] := cgAlerts.Checked[3];
        incexch := cbIncExch.Checked;
      end
      else
      begin
        DeleteValueFromConfigFile(sConfigRoot,'Contest_start_date');
        DeleteValueFromConfigFile(sConfigRoot,'Contest_start_time');
      end;
      sradio := cbRadio.Text;
      radio := TRadio(cbRadio.ItemIndex);
      iskx3 := radio = kx3;
      SaveValueToConfigFile(sConfigRoot,'Radio',sradio);
      if radio = k2 then
        SaveValueToConfigFile(sConfigRoot,'Rev_2.04',cbRev204.Checked);
      SaveValueToConfigFile(sConfigRoot,'Com_Port',cbComPort.Text);
      SaveValueToConfigFile(sConfigRoot,'Speed',cbSpeed.Text);
      frmMain.KeyPreview := cbPowerMate.Checked;
      SaveValueToConfigFile(sConfigRoot,'Enable_PowerMate',cbPowerMate.Checked);
      SaveValueToConfigFile(sConfigRoot,'CW_Rev',cbCWRev.Checked);
      cwrev := cbCWRev.Checked;
      SaveValueToConfigFile(sConfigRoot,'Comm_Trace',cbCommTrace.Checked);
      btnConnect.Visible := cbComPort.Text <> '';
      usesoundcard := cbUseSoundcard.Checked;
      SaveValueToConfigFile(sConfigRoot,'Use_Soundcard',usesoundcard);
      usek3dsp := cbUseK3DSP.Checked;
      SaveValueToConfigFile(sConfigRoot,'Use_K3_DSP',cbUseK3DSP.Checked);
      cwwaterfall := cbCWWaterfall.Checked and usesoundcard;
      cwcenterfreq := StrToIntDef(cbCWCenterFreq.Text,800);
      SaveValueToConfigFile(sConfigRoot,'CW_Waterfall',cwwaterfall);
      SaveValueToConfigFile(sConfigRoot,'CW_Center_Freq',cwcenterfreq);
      SetCWSpotFreq(cwcenterfreq);
      pskwaterfall := cbPSKWaterfall.Checked and usesoundcard;
      SaveValueToConfigFile(sConfigRoot,'PSK_Waterfall',pskwaterfall);
      {$IFDEF WINDOWS}
      rx_sound_dev := cbRxSoundCard.ItemIndex - 1;
      SaveValueToConfigFile(sConfigRoot,'Sound_Device',cbRxSoundCard.Items[cbRxSoundCard.ItemIndex]);
      tx_sound_dev := cbTxSoundCard.ItemIndex - 1;
      SaveValueToConfigFile(sConfigRoot,'Sound_Device_Tx',cbTxSoundCard.Items[cbTxSoundCard.ItemIndex]);
      CWWfall.SoundCard := rx_sound_dev;
      PSKWfall.SoundCard := rx_sound_dev;
      if psk31coreavailable then
      begin
        decodepsk := cbDecodePSK.Checked and usesoundcard;
        pskcenterfreq := StrToIntDef(cbPSKCenterFreq.Text,1200);
        largewfall := cbLargeWaterfall.Checked;
        SaveValueToConfigFile(sConfigRoot,'Use_PSK31CoreDLL',decodepsk);
        SaveValueToConfigFile(sConfigRoot,'PSK31_Center_Freq',pskcenterfreq);
        SaveValueToConfigFile(sConfigRoot,'Large_Waterfall',largewfall);
        if lwpalette = '' then
          DeleteValueFromConfigFile(sConfigRoot,'Waterfall_Palette')
        else
          SaveValueToConfigFile(sConfigRoot,'Waterfall_Palette',lwpalette);
      end;
      // MRP40 options
      if (edMRP40Path.Text <> '') and FileExists(edMRP40Path.Text) then
      begin
        SaveValueToConfigFile(sConfigRoot,'MRP40',edMRP40Path.Text);
        SaveValueToConfigFile(sConfigRoot,'Use_MRP40',cbUseMRP40.Checked);
        mrp40_path := edMRP40Path.Text;
        usemrp40 := cbUseMRP40.Checked;
        mrp40keepontop := cbMRP40OnTop.Checked and usemrp40;
        SaveValueToConfigFile(sConfigRoot,'MRP40_KeepOnTop',mrp40keepontop);
      end
      else
      begin
        SaveValueToConfigFile(sConfigRoot,'Use_MRP40',false);
        usemrp40 := false;
        mrp40keepontop := false;
      end;
      // CW Skimmer options
      if (edCWSkimmer.Text <> '') and FileExists(edCWSkimmer.Text) then
      begin
        SaveValueToConfigFile(sConfigRoot,'CW_Skimmer',edCWSkimmer.Text);
        SaveValueToConfigFile(sConfigRoot,'Use_CW_Skimmer',cbUseCWSkimmer.Checked);
        usecwskimmer := cbUseCWSkimmer.Checked;
        SaveValueToConfigFile(sConfigRoot,'Spot_CW',cbSpotCW.Checked);
      end
      else
      begin
        SaveValueToConfigFile(sConfigRoot,'Use_CW_Skimmer',false);
        usecwskimmer := false;
        SaveValueToConfigFile(sConfigRoot,'Spot_CW',false);
      end;
      {$ELSE}
      sound_dev := cbRxSoundCard.Text;
      SaveValueToConfigFile(sConfigRoot,'Sound_Device',sound_dev);
      CWWfall.DSPDevice := sound_dev;
      PSKWfall.DSPDevice := sound_dev;
      {$ENDIF}
      // Fldigi options
      if (edFldigiPath.Text <> '') and FileExists(GetPath(edFldigiPath.Text)) then
      begin
        SaveValueToConfigFile(sConfigRoot,'Fldigi',edFldigiPath.Text);
        SaveValueToConfigFile(sConfigRoot,'Use_Fldigi',cbUseFldigi.Checked);
        usefldigi := cbUseFldigi.Checked;
        {$IFDEF WINDOWS}
        fldigikeepontop := cbFldigiOnTop.Checked and usefldigi;
        SaveValueToConfigFile(sConfigRoot,'Fldigi_KeepOnTop',fldigikeepontop);
        {$ENDIF}
      end
      else
      begin
        SaveValueToConfigFile(sConfigRoot,'Use_Fldigi',false);
        usefldigi := false;
      end;
      // eQSL settings
      eqsluser := edEQSLUser.Text;
      eqslpass := edEQSLPassword.Text;
      if eqsluser <> '' then
        autoeqsl := TEQSLOptions(cbAutoEQSL.ItemIndex)
      else
        autoeqsl := no;
      SaveValueToConfigFile(sConfigRoot,'eQSL_Call',eqsluser);
      SaveValueToConfigFile(sConfigRoot,'eQSL_Password',eqslpass);
      SaveValueToConfigFile(sConfigRoot,'Auto_eQSL',Ord(autoeqsl));
      // DX Cluster Client settings
      dxchost := edHost.Text;
      dxcport := edPort.Text;
      dxcuser := edUserID.Text;
      dxcpass := edPassword.Text;
      SaveValueToConfigFile(sConfigRoot,'DX_Cluster_Host',dxchost);
      SaveValueToConfigFile(sConfigRoot,'DX_Cluster_Port',dxcport);
      SaveValueToConfigFile(sConfigRoot,'DX_Cluster_Login',dxcuser);
      SaveValueToConfigFile(sConfigRoot,'DX_Cluster_Password',dxcpass);
      SaveValueToConfigFile(sConfigRoot,'DX_Cluster_ShowInfo',cbShowInfo.Checked);
      // Call lookup settings
      SaveValueToConfigFile(sConfigRoot,'LookupURL1',edLookupURL1.Text);
      SaveValueToConfigFile(sConfigRoot,'LookupURL2',edLookupURL2.Text);
      SaveValueToConfigFile(sConfigRoot,'LookupHint1',edLookupHint1.Text);
      SaveValueToConfigFile(sConfigRoot,'LookupHint2',edLookupHint2.Text);
      frmMain.txLookup.Hint := edLookupHint1.Text;
      frmMain.txLookup2.Hint := edLookupHint2.Text;
      // Misc settings
      if fntchanged then
      begin
        frmMain.Font := frmSettings.Font;
        SetFonts;
      end;
      txcharset := cbEncoding.ItemIndex+1;
      SaveValueToConfigFile(sConfigRoot,'TX_Charset',txcharset);
      {$IFNDEF WINDOWS}
      SaveValueToConfigFile(sConfigRoot,'Web_Browser',edWebBrowser.Text);
      {$ENDIF}
      BandButtons;
      TaskbarButtons;
      if usefldigi then
        Fl_Timer.Enabled := true;
    end;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.btnTxRxClick(Sender: TObject);
begin
  if (not connected) and (not fldigiactive) then
  begin
    Application.MessageBox('Not connected to radio',PChar(Application.Title),MB_ICONEXCLAMATION);
    Exit;
  end;
  case txstat of
  0:  begin                                   // start sending
    		btnTxRx.Caption := 'Stop sending';
        StatusBar.Caption := 'Transmitting';
        pp := MAXINT;
        {$IFDEF WINDOWS}
        if (vmode = data_a) and decodepsk and soundcard_on then
        begin
          cbPSKTune.Enabled := false;
          if not cbTXLock.Checked then
            fnSetTXFrequency(fnGetRXFrequency(0));
          fnStartTX(psk31txmode);
        end;
        {$ENDIF}
        if (vmode = data_a) and fldigiactive then
          Fldigi_StartTx;
        if ((vmode = data_a) and (not usek3dsp)) then SendSerial('TX;');
        txstat := 1;
      end;
  1:  begin                     // go to receive when finished sending
        if (vmode = data_a) and fldigiactive then
          txbuf := txbuf + '^r' + Chr(254)    // send ^r for Fldigi end of transmission
        else if (vmode = data_a) and usek3dsp then
          txbuf := txbuf + Chr(4) + Chr(254)  // send EOT for KY datamode sending
            + 'RX;'                           // + RX command to ensure sidetone shuts off
        else
          txbuf := txbuf + Chr(254);
    		btnTxRx.Caption := 'Stopping...';
        txstat := 2;
      end;
  2:  AbortTX;                  // abort transmission immediately
  end;
	TypeAhead.SetFocus;
end;

procedure TfrmMain.edCallExit(Sender: TObject);
begin
  if edCall.Text = '' then Exit;
  if ValidCall(edCall.Text) then
  begin
    SetQSOFreq;
    Delay(10);
    txLookup.Visible := true;
    txLookup2.Visible := true;
    if (edFreq.Text <> '') and (cbMode.Text <> '') then
    begin
      ShowContactInfo(edCall.Text,freqtoband(StripAll(DecimalSeparator,edFreq.Text)+'000'),cbMode.Text);
      {$IFDEF WINDOWS}
      imgSpot.Visible := true;
      {$ENDIF}
    end;
  end
  else
    Application.MessageBox('Invalid call',PChar(Application.Title),MB_ICONEXCLAMATION);
end;

procedure TfrmMain.edCallKeyPress(Sender: TObject; var Key: char);
begin
	if Key in ['a'..'z'] then
  	Key := Chr(Ord(Key) - $20);
  if Length(edCall.Text)>=3 then
  begin
    txLookup.Visible := true;
    txLookup2.Visible := true;
  end;
end;

procedure TfrmMain.edGridKeyPress(Sender: TObject; var Key: char);
begin
	if (Key in ['a'..'z']) and (Length(TEdit(Sender).Text) < 2) then
  	Key := Chr(Ord(Key) - $20);
end;

procedure TfrmMain.edNameKeyPress(Sender: TObject; var Key: char);
begin
	if (Key in ['a'..'z']) and (Length(TEdit(Sender).Text) = 0) then
  	Key := Chr(Ord(Key) - $20);
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  if connected then
  begin
    // connected - do disconnect
    if Assigned(frmClusterClient) and frmClusterClient.Showing then
      frmClusterClient.Close;
    {$IFDEF WINDOWS}
    // close CW Skimmer connection if existing
    if Assigned(frmSkimmer) then
      frmSkimmer.Close;
    btnCWSkimmer.Enabled := false;
    {$ENDIF}
    StatusBar.Caption := 'Disconnecting...';
    disconnecting := true;
    disablepolling := true;
    pp := MAXINT;
    Application.ProcessMessages;
    SendSerial(sShutdown[radio]);
    if CWWfall.Active then
    begin
      CWWfall.Close;
      Delay(1000);
    end;
    if PSKWfall.Active then
    begin
      PSKWfall.Close;
      Delay(1000);
    end;
    {$IFDEF WINDOWS}
    if soundcard_on then
    begin
      StopPSK31Core;
      Delay(1000);
    end;
    cbPSK31AFC.Visible := false;
    {$ENDIF}
    SerialPort.CloseSocket;
    UnloadShortcuts;
    if fldigiactive then
      Caption := 'KComm - using Fldigi'
    else
      Caption := 'KComm - not connected';
    btnConnect.Caption := 'Connect';
    btnSettings.Enabled := true;
    connected := false;
    Delay(1000);
    if (radio in [k3,kx3]) and usek3dsp and (dmode > 0) then
      SaveValueToConfigFile(sConfigRoot,'Last_DMode',dmode);
    if contestmode then
      SaveValueToConfigFile(sConfigRoot,'Contest_exchange',edExchs.Text);
    lbFreq.Caption := sFreqBlank;
    lbFreq2.Caption := sModeBlank;
    lbMode.Caption := sModeBlank;
    lbRIT.Caption := '';
    lbSplit.Caption := '';
    lbTxRx.Caption := '';
    imgMeterFg.Width := 1;
    currfreq := '';
    vmode := unknown;
    WaterfallPanel.Visible := false;
    btnSpot.Visible := false;
    cbRxUpperCase.Visible := false;
    cbCWUpperCase.Visible := false;
    cbTXLock.Visible := false;
    StatusBar.Caption := 'Disconnected';
    // set band buttons
    BandButtons;
    TaskbarButtons;
    FormState(formmode);
  end
  else
  begin
    // not connected - do connect
    disconnecting := false;
    StatusBar.Caption := 'Connecting...';
    Application.ProcessMessages;
    commtrace := GetValueFromConfigFile(sConfigRoot,'Comm_Trace',false);
    disablepolling := false;
    SerialPort.Connect(GetValueFromConfigFile(sConfigRoot,'Com_Port','COM 2'));
    if SerialPort.InstanceActive then
    begin
      SerialPort.Config(GetValueFromConfigFile(sConfigRoot,'Speed',38400),8,'N',0,false,false);
      SerialPort.RTS := false;
      SerialPort.DTR := false;
      if commtrace then
      begin
        with frmTrace do
        begin
          lbTrace.Items.Clear;
          TraceLog.Clear;
          starttime := GetTickCount;
          Show;
          Delay(10);
        end;
      end;
      SendSerial('PS;'); // check transceiver status
      tx := true; // force display of tx/rx status
      // do some initializing
    	txbuf := '';
      cwbufstate := -1;
      rxbuf := '';
      parsebuf := '';
      rxpdelay := 0;
      mnuRxEnable.Checked := true;
      vmode := unknown;
      pwr := StrToIntDef(GetValueFromConfigFile(sConfigRoot,'Power','10'),0);
      spd := 0;
      ant := 1;
      agc := 1;
      vfoa := -1;
      rit := -1;
      xit := -1;
      split := -1;
      pp := MAXINT;
      currfreq := '';
      lstrfreq := '';
      curr_f := 0.0;
      pm_idx := 2;
      mode := -1;
      cmode := -1;
  	  txstat := 0;
      cwbksp := false;
      parsedataenabled := true;
      {$IFDEF WINDOWS}
      if decodepsk and psk31coreready then
        fnSetCWIDString(PChar(mycall));
      {$ENDIF}
      if contestmode then
        edExchs.Text := GetValueFromConfigFile(sConfigRoot,'Contest_exchange','');
    end
    else
      Application.MessageBox('Cannot open serial port','Error',0);
  end;
end;

procedure TfrmMain.btnCWSkimmerClick (Sender: TObject );
begin
  {$IFDEF WINDOWS}
  if not Assigned(frmSkimmer) then
    frmSkimmer := TfrmSkimmer.Create(Self);
  with frmSkimmer do
  begin
    Show;
    if not Login then
    begin
      MessageDlg('Login to CW Skimmer failed',mtError,[mbOK],0);
      frmSkimmer.Close;
    end;
  end;
  {$ENDIF}
end;

procedure TfrmMain.btnDataClick(Sender: TObject);
var
  popup: boolean;
begin
  case radio of
  k2     : popup := decodepsk or fldigiactive;
  k3,kx3 : popup := decodepsk or fldigiactive or usek3dsp;
  end;
  if popup then
    mnuModes.PopUp(frmMain.Left+GroupBox6.Left+btnData.Left+6,
    frmMain.Top+GroupBox6.Top+btnData.Top+btnData.Height+36)
  else if connected then
  begin
    case radio of
      k2:     SendSerial('MD9;');
      k3,kx3: SendSerial('MD6;DT0;');
    end;
  end;
end;

procedure TfrmMain.btnDXClusterClick (Sender: TObject );
begin
  if Assigned(frmClusterClient) then
  begin
    frmClusterClient.BringToFront;
    Exit;
  end;
  frmClusterClient := TfrmClusterClient.Create(Self);
  with frmClusterClient do
  begin
    Show;
    if not Login(dxchost,dxcport,dxcuser,dxcpass) then
    begin
      MessageDlg('Login to DX Cluster failed',mtError,[mbOK],0);
      frmClusterClient.Close;
    end;
  end;
end;

procedure TfrmMain.btnFldigiClick(Sender: TObject);
var
  p: integer;
  fl_path, fl_args: string;
begin
  fl_path := GetValueFromConfigFile(sConfigRoot,'Fldigi','');
  p := Pos('.EXE',UpperCase(fl_path));
  if p > 0 then
  begin
    fl_args := fl_path;
    fl_path := Copy(fl_args,1,p+3);
    Delete(fl_args,1,p+4);
  end;
  if (fl_path <> '') and FileExists(fl_path) and not Fldigi_IsRunning then
  begin
    tx := not connected;
    if RunProgram(fl_path,fl_args) then
      Fl_Timer.Interval := 1200;
  end;
end;

procedure TfrmMain.btnClearRxClick(Sender: TObject);
begin
  RxPanel.Clear;
  if not mnuRxEnable.Checked then
  begin
    mnuRxEnable.Checked := true;
    rxbuf := '';
    parsebuf := '';
    rxpdelay := 0;
  end;
  if usefldigi and fldigiactive then
    Fldigi_ClearRx;
  {$IFDEF WINDOWS}
  if usemrp40 and (vmode = cw) and MRP40_Active then
    MRP40_ClearText;
  {$ENDIF}
end;

function TfrmMain.GetBandFreq(bandbtn: string): string;
var
  mdstr, freq: string;
  b, md: integer;
begin
  freq := '';
  b := StrToIntDef(Copy(bandbtn,5,2),0);
  md := mode;
  if (not connected) and fldigiactive then
    md := 6;
  if pwr <= 10 then md := md + 10;
  case md of
  1, 2:
    mdstr := 'Phone';
  3, 7:
    mdstr := 'CW';
  4, 14:
    mdstr := 'FM';
  5, 15:
    mdstr := 'AM';
  6, 9, 16, 19:
    mdstr := 'Digital';
  11, 12:
    mdstr := 'QRP-SSB';
  13, 17:
    mdstr := 'QRP-CW';
  else
    mdstr := 'Default';
  end;
  freq := GetFromConfigFile(sBand,bandbtn,'Default','');
  freq := GetFromConfigFile(sBand,bandbtn,mdstr,freq);
  if freq = '' then
    freq := GetBandDefaultFreq(b, md);
  Result := freq;
end;

function TfrmMain.GetBandDefaultFreq(b, md: integer): string;
var
  p: integer;
begin
  Result := '';
  // default band settings
  case b of
  1:  begin   // 160m
        case md of
        0:  Result := '160m';
        3, 7:
            Result := '1.830';  // cw
        6, 9, 16, 19:
            Result := '1.838';  // digimodes
        11, 12:
            Result := '1.910';  // qrp ssb
        13, 17:
            Result := '1.812';  // qrp cw
        else
          Result := '1.850';    // general activity
        end;
      end;
  2:  begin   // 80m
        case md of
        0:  Result := '80m';
        3, 7:
            Result := '3.510';  // cw
        6, 9, 16, 19:
            Result := '3.580';  // digimodes
        11, 12:
            Result := '3.690';  // qrp ssb
        13, 17:
            Result := '3.560';  // qrp cw
        else
          Result := '3.750';    // general activity
        end;
      end;
  3:  begin   // 60m
        case md of
        0:  Result := '60m';
        else
          Result := '5.4035';
        end;
      end;
  4:  begin   // 40m
        case md of
        0:  Result := '40m';
        3, 7:
            Result := '7.010';  // cw
        6, 9, 16, 19:
            Result := '7.035';  // digimodes
        11, 12:
            Result := '7.090';  // qrp ssb
        13, 17:
            Result := '7.030';  // qrp cw
        else
          Result := '7.100';    // general activity
        end;
      end;
  5:  begin   // 30m
        case md of
        0:  Result := '30m';
        6, 9, 16, 19:
            Result := '10.140';  // digimodes
        13, 17:
            Result := '10.116';  // qrp cw
        else
          Result := '10.110';    // general activity
        end;
      end;
  6:  begin   // 20m
        case md of
        0:  Result := '20m';
        3, 7:
            Result := '14.010';  // cw
        6, 9, 16, 19:
            Result := '14.070';  // digimodes
        11, 12:
            Result := '14.285';  // qrp ssb
        13, 17:
            Result := '14.060';  // qrp cw
        else
          Result := '14.200';    // general activity
        end;
      end;
  7:  begin   // 17m
        case md of
        0:  Result := '17m';
        3, 7:
            Result := '18.070';  // cw
        6, 9, 16, 19:
            Result := '18.100';  // digimodes
        11, 12:
            Result := '18.130';  // qrp ssb
        13, 17:
            Result := '18.096';  // qrp cw
        else
          Result := '18.120';    // general activity
        end;
      end;
  8:  begin   // 15m
        case md of
        0:  Result := '15m';
        3, 7:
            Result := '21.010';  // cw
        6, 9, 16, 19:
            Result := '21.070';  // digimodes
        11, 12:
            Result := '21.285';  // qrp ssb
        13, 17:
            Result := '21.060';  // qrp cw
        else
          Result := '21.300';    // general activity
        end;
      end;
  9:  begin   // 12m
        case md of
        0:  Result := '12m';
        3, 7:
            Result := '24.900';  // cw
        6, 9, 16, 19:
            Result := '24.920';  // digimodes
        11, 12:
            Result := '24.950';  // qrp ssb
        13, 17:
            Result := '24.906';  // qrp cw
        else
          Result := '24.940';    // general activity
        end;
      end;
  10: begin   // 10m
        case md of
        0:  Result := '10m';
        3, 7:
            Result := '28.010';  // cw
        4, 14:
            Result := '29.600';  // fm
        6, 9, 16, 19:
            Result := '28.120';  // digimodes
        11, 12:
            Result := '28.360';  // qrp ssb
        13, 17:
            Result := '28.060';  // qrp cw
        else
          Result := '28.500';    // general activity
        end;
      end;
  11: begin   // 6m
        case md of
        0:  Result := '6m';
        3, 7, 13, 17:
            Result := '50.090';  // cw
        4, 14:
            Result := '51.510';  // fm
        6, 9, 16, 19:
            Result := '50.600';  // digimodes
        else
          Result := '50.110';    // general activity
        end;
      end;
  end;
  if Length(Result) > 0 then
  begin
    p := Pos('.',Result);
    if p > 0 then
      Result[p] := DecimalSeparator;
  end;
end;

procedure TfrmMain.btnBandClick(Sender: TObject );
var
  band, freq, extra: string;
  md: integer;
begin
  band := TButton(Sender).Name;
  freq := GetBandFreq(band);
  if (Length(freq) > 2) and (Copy(freq,1,2) = Format('5%s',[DecimalSeparator])) then
    md := 2
  else if mode <= 2 then
    md := 1
  else
    md := mode;
  extra := GetFromConfigFile(sBand,band,'Extra','');
  if connected then
    SetFrequency(freq,md,extra)
  else if fldigiactive then
    Fldigi_SetFrequency(StrToFloat(freq)*1000000.0);
  pp := 2;  // force poll for status update
end;

procedure TfrmMain.btnCenterClick(Sender: TObject);
var
  f_ofs, wmode: integer;
  des_f: extended;
begin
  {$IFDEF WINDOWS}
  wmode := mode;
  f_ofs := fnGetRXFrequency(0) - pskcenterfreq;
  if radio = k2 then f_ofs := -f_ofs;   // K2 DATA is LSB
  // shift signal to center of passband
  if wmode = 9 then f_ofs := -f_ofs;
  des_f := curr_f + (f_ofs / 1000.0);
  SetFrequency(Trim(Format('%11.6f',[des_f/1000.0])),-1,'');
  fnSetRXFrequency(pskcenterfreq, 0, 0);
  if not qsostarted then
    cbTXLock.Checked := false;
  if not cbPSK31AFC2.Checked then
  begin
  	fnSetAFCLimit(afcrange,0);
    Delay(1000);
    fnSetAFCLimit(afcmin, 0);
  end;
  {$ENDIF}
end;

procedure TfrmMain.btnBandMouseUp (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer );
var
  btn, def, tmp: string;
  b: Integer;
begin
  if Button = mbPopup then
  begin
    btn := TButton(Sender).Name;
    b := StrToIntDef(Copy(btn,5,2),0);
    with frmBand do
    begin
      btnDefaultClick(nil);
      edCaption.Text := GetFromConfigFile(sBand,btn,'Caption',GetBandDefaultFreq(b,0));
      def := GetFromConfigFile(sBand,btn,'Default',GetBandDefaultFreq(b,1));
      edDefault.Text := def;
      def := GetBandDefaultFreq(b,1);
      tmp := GetFromConfigFile(sBand,btn,'CW',GetBandDefaultFreq(b,3));
      if tmp <> def then edCW.Text := tmp;
      tmp := GetFromConfigFile(sBand,btn,'Digital',GetBandDefaultFreq(b,6));
      if tmp <> def then edDigi.Text := tmp;
      tmp := GetFromConfigFile(sBand,btn,'FM',GetBandDefaultFreq(b,4));
      if tmp <> def then edFM.Text := tmp;
      tmp := GetFromConfigFile(sBand,btn,'AM',GetBandDefaultFreq(b,5));
      if tmp <> def then edAM.Text := tmp;
      tmp := GetFromConfigFile(sBand,btn,'QRP-SSB',GetBandDefaultFreq(b,11));
      if tmp <> def then edQRPSSB.Text := tmp;
      tmp := GetFromConfigFile(sBand,btn,'QRP-CW',GetBandDefaultFreq(b,13));
      if tmp <> def then edQRPCW.Text := tmp;
      edExtra.Text := GetFromConfigFile(sBand,btn,'Extra','');
      dlgshowing := true;
      if ShowModal = mrOK then
      begin
        if edCaption.Text = '' then
          DeleteValueFromConfigFile(sBand,btn)
        else
        begin
          SaveToConfigFile(sBand,btn,'Caption',edCaption.Text);
          SaveToConfigFile(sBand,btn,'Default',edDefault.Text);
          SaveToConfigFile(sBand,btn,'CW',edCW.Text);
          SaveToConfigFile(sBand,btn,'Digital',edDigi.Text);
          SaveToConfigFile(sBand,btn,'FM',edFM.Text);
          SaveToConfigFile(sBand,btn,'AM',edAM.Text);
          SaveToConfigFile(sBand,btn,'QRP-SSB',edQRPSSB.Text);
          SaveToConfigFile(sBand,btn,'QRP-CW',edQRPCW.Text);
          SaveToConfigFile(sBand,btn,'Extra',edExtra.Text);
        end;
        BandButtons;
      end;
      dlgshowing := false;
    end;
  end;
end;

procedure TfrmMain.btnClearTxClick(Sender: TObject);
begin
	TypeAhead.Clear;
  txbuf := '';
	if txstat > 0 then
    AbortTX;
end;

procedure TfrmMain.btnLogNewClick(Sender: TObject);
begin
	if (not qsostarted) or (edCall.Text='') or (MessageDlg('Abandon contact with '+edCall.Text+'?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then
  begin
    edDate.Clear;
    edTime.Clear;
//    edFreq.Clear;
    edCall.Clear;
    if (not contestmode) and realreports then
    begin
      edRSTs.Clear;
      edRSTr.Clear;
    end;
    edExchr.Clear;
    edName.Clear;
    edQTH.Clear;
    edGrid.Clear;
    edNotes.Clear;
    txLookup.Visible := false;
    txLookup2.Visible := false;
    {$IFDEF WINDOWS}
    imgSpot.Visible := false;
    {$ENDIF}
    timestarted := 0.0;
    timefinished := 0.0;
    qsostarted := false;
    logend := false;
    cbTXLock.Checked := false;
    StatusBar.Caption := '';
    chkqsobefore := '';
    if contestmode then
      edCall.SetFocus;
  end;
end;

procedure TfrmMain.btnLogSaveClick(Sender: TObject);
var
  r, x: integer;
  logrec,qrb: string;
  prefix,country,continent,cqzone,ituzone: string;
  l1,l2: extended;
  lat,lon,range,bearing: extended;
begin
  // validate all the data items that must be present
  if not ValidDate(edDate.Text) then
  begin
    Application.MessageBox(PChar(Format('Date format invalid. Use format YYYY%sMM%sDD',[DateSeparator,DateSeparator])),PChar(Application.Title),MB_ICONERROR);
    Exit;
  end;
  if not ValidTime(edTime.Text) then
  begin
    Application.MessageBox(PChar(Format('Time format invalid. Use format HH%sMM',[TimeSeparator])),PChar(Application.Title),MB_ICONERROR);
    Exit;
  end;
  if not ValidCall(edCall.Text) then
  begin
    Application.MessageBox('Callsign invalid',PChar(Application.Title),MB_ICONERROR);
    Exit;
  end;
  if not ValidFreq(edFreq.Text) then
  begin
    Application.MessageBox(PChar(Format('Frequency format invalid. Use format 9%s999 (MHz)',[DecimalSeparator])),PChar(Application.Title),MB_ICONERROR);
    Exit;
  end;
  if not ValidRpt(edRSTs.Text,cbMode.Text) then
  begin
    Application.MessageBox('RSTS invalid',PChar(Application.Title),MB_ICONERROR);
    Exit;
  end;
  if not ValidRpt(edRSTr.Text,cbMode.Text) then
  begin
    Application.MessageBox('RSTR invalid',PChar(Application.Title),MB_ICONERROR);
    Exit;
  end;
  // add record to table
  adding := true;
  {$IFDEF WINDOWS}
  sgLog.RowCount := log.Count + 2;
  {$ELSE}
  sgLog.RowCount := log.Count + 2; // 3;
  {$ENDIF}
  r := log.Count + 1;
  StatusBar.Caption := Format('Adding record %d.',[r]);
  Delay(50);
  sgLog.Cells[0,r] := edDate.Text;
  sgLog.Cells[1,r] := edTime.Text;
  sgLog.Cells[2,r] := edFreq.Text;
  sgLog.Cells[3,r] := cbMode.Text;
  sgLog.Cells[4,r] := CleanText(edCall.Text);
  sgLog.Cells[5,r] := CleanText(edRSTs.Text+' '+edExchs.Text);
  sgLog.Cells[6,r] := CleanText(edRSTr.Text+' '+edExchr.Text);
  sgLog.Cells[7,r] := CleanText(edName.Text);
  sgLog.Cells[8,r] := CleanText(edQTH.Text);
  sgLog.Cells[9,r] := CleanText(edNotes.Text);
  Delay(50);
  // calculate distance if locator specified
  qrb := '';
  try
    if (Length(edGrid.Text) = 6) and (ValidLocator(edGrid.Text)) then
    begin
      LocatorToGeog(edGrid.Text,lat,lon);
      if (lat <> 0.0) and (lon <> 0.0) then
      begin
        PathCalc(mylat,mylon,lat,lon,false,range,bearing);
        qrb := Format('QRB: %4.0fkm',[range]);
      end;
    end;
  except
  end;
  // add record to log
  logrec := mycall+';'+CleanText(edCall.Text)+';'+StripAll(DateSeparator,edDate.Text)+StripAll(TimeSeparator,edTime.Text)+'00;'
    +IntToStr(Trunc((timefinished-timestarted)*86400.0))+';;;'+StripAll(DecimalSeparator,edFreq.Text)+'000'+';0;;'+cbMode.Text+';'
    +edRSTs.Text+';'+edRSTr.Text+';'+CleanText(edExchs.Text)+';'+CleanText(edExchr.Text)+';'
    +CleanText(edName.Text)+';'+CleanText(edQTH.Text)+';'+CleanText(edNotes.Text)+';;;;;'
    +CleanText(edGrid.Text)+';;;;'+qrb+';';
  log.Add(logrec);
  log.SaveToFile(LogFileName);
  logchanged := true;
  // update check list
  if ctydatavailable then
  begin
    if FindCountry(edCall.Text,prefix,country,continent,cqzone,ituzone,l1,l2) then
    begin
      Check.Add(continent+';'+country+';'+prefix+';');
      CQZ.Add(cqzone);
      ITUZ.Add(ituzone);
    end
    else
    begin
      Check.Add(';;;');
      CQZ.Add('--');
      ITUZ.Add('---');
    end;
  end;
  StatusBar.Caption := 'QSO saved to log.';
  pp := 15;
  // make new row visible
  if sgLog.RowCount > 4 then
  {$IFDEF WINDOWS}
    sgLog.TopRow := sgLog.RowCount - 4;
  {$ELSE}
    sgLog.TopRow := sgLog.RowCount - 4;
  {$ENDIF}
  qsostarted := false;
  Delay(50);
  adding := false;
  // do real-time eQSL if requested
  if SendEQSLNow(CleanText(edCall.Text),Trim(edFreq.Text),cbMode.Text) then
  begin
    SendEQSLThread := TSendEQSLThread.Create;
    if Assigned(SendEQSLThread.FatalException) then
      raise SendEQSLThread.FatalException;
    with SendEQSLThread do
    begin
      userid := eqsluser;
      userpwd := eqslpass;
      call := edCall.Text;
      starttime := timestarted;
      freq := StripAll(DecimalSeparator,edFreq.Text)+'000';
      mode := cbMode.Text;
      rst := edRSTS.Text;
      OnEQSLSent := @EQSLSent;
      Resume;
    end;
    Delay(50);
  end;
  // clear for new qso
  btnLogNewClick(Sender);
  // increment contest exchange
  if contestmode and incexch then
    try
      x := StrToInt(edExchs.Text);
      if x < 1000 then
        edExchs.Text := Format('%.3d',[x+1])
      else
        edExchs.Text := Format('%.4d',[x+1]);
    except
    end;
end;

function TfrmMain.SendEQSLNow(call, freq, mode: string): boolean;
var
  i: integer;
  dup: boolean;
  band: string;
  logitems: TLogItems;
begin
  // determine whether to send EQSL now
  case autoeqsl of
  no:   Result := false;
  yes:  Result := true;
  ask:  Result := Application.MessageBox(PChar(Format('Send eQSL for contact with %s ?',[call])),
            PChar(Application.Title),MB_YESNO) = IDYES;
  smart:if contestmode then
          Result := true
        else
        begin
          // check if eQSL'd on same band / mode before
          i := log.Count;
          dup := false;
          band := FreqToBand(freq);
          repeat
            Dec(i);
            if i < 0 then break;
            ParseLogLine(log.Strings[i],logitems);
            dup := (call = logitems[1]) and (band = FreqToBand(logitems[6])) and (mode = logitems[9]) and (logitems[23]<>'');
          until dup;
          if dup then
            Result := Application.MessageBox(PChar(Format('Send eQSL for contact with %s ?',[call])),
              PChar(Application.Title),MB_YESNO) = IDYES
          else
            Result := true;
        end;
  end;
end;

procedure TfrmMain.EQSLSent;
var
  i: integer;
  logline: string;
  logitems: TLogItems;
begin
  // explode last log line
  ParseLogLine(log.Strings[log.Count-1],logitems);
  // update eQSL Sent time stamp
  logitems[23] := FormatDateTime('yyyymmdd',Now+TimeZoneBias);
  // rebuild log line
  logline := '';
  for i := 0 to 25 do
    logline := Trim(logline+logitems[i]+';');
  log.Strings[log.Count-1] := logline;
  log.SaveToFile(LogFileName);
  logchanged := true;
  StatusBar.Caption := 'eQSL sent.';
  pp := 15;
end;

procedure TfrmMain.btnLogStartClick(Sender: TObject);
begin
	timestarted := Now + TimeZoneBias;
  timefinished := timestarted;
  edDate.Text := FormatDateTime('yyyy/mm/dd',timestarted);
  edTime.Text := FormatDateTime('hh:nn',timestarted);
  SetQSOFreq;
  if edRSTs.Text = '' then
  begin
    if (not contestmode) and realreports then
    begin
      if vmode = phone then
        edRSTs.Text := '5'+IntToStr(strength)
      else
        edRSTs.Text := '5'+IntToStr(strength)+'9';
    end
    else
    begin
      if vmode = phone then
      begin
        edRSTs.Text := '59';
        edRSTr.Text := '59';
      end
      else
      begin
        edRSTs.Text := '599';
        edRSTr.Text := '599';
      end;
    end;
  end;
  qsostarted := true;
  rstr := false;
  {$IFDEF WINDOWS}
  if (vmode = data_a) and decodepsk then
    cbTXLock.Checked := true;
  {$ENDIF}
  logend := false;
//  StatusBar.Caption:= 'QSO started at '+edTime.Text;
//  pp := 15;
end;

procedure TfrmMain.btnMRP40Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  StartMRP40;
  {$ENDIF}
end;

procedure TfrmMain.btnPropClick(Sender: TObject);
begin
  frmProp := TfrmProp.Create(Self);
  frmProp.Font := Font;
  frmProp.cbEnableUpdates.Checked := Update_Timer.Enabled;
  frmProp.ShowModal;
  SaveValueToConfigFile(sConfigRoot,'Update_Check',Update_Timer.Enabled);
  frmProp.Destroy;
  frmProp := nil;
end;

procedure TfrmMain.btnPSKBrowserClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if Assigned(frmPSKBrowser) then Exit;
  if not soundcard_on then Exit;
  frmPSKBrowser := TfrmPSKBrowser.Create(Self);
  frmPSKBrowser.Show;
  {$ENDIF}
end;

procedure TfrmMain.btnSndPropsClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  WinExec('sndvol32.exe', SW_SHOW);
  {$ENDIF}
end;

procedure TfrmMain.btnSpotClick (Sender: TObject );
begin
  if connected and (radio in [k3,kx3]) then SendSerial('SWT42;');
end;

procedure TfrmMain.btnUSBClick ( Sender: TObject ) ;
var
  vfo_ofs: integer;
  des_f: extended;
begin
  if not connected then Exit;
  SendSerial('MD2;');
end;

procedure TfrmMain.cbPSK31AFCClick(Sender: TObject);
// process click on PSK31 AFC control ** WINDOWS ONLY **
begin
  {$IFDEF WINDOWS}
  if Sender = cbPSK31AFC then
  begin
    cbPSK31AFC2.Checked := cbPSK31AFC.Checked;
  	if cbPSK31AFC.Checked then
    	fnSetAFCLimit(afcrange,0)
    else
    	fnSetAFCLimit(afcmin,0);
  end;
  if (Sender = cbPSK31AFC2) and (cbPSK31AFC.Checked <> cbPSK31AFC2.Checked) then
    cbPSK31AFC.Checked := cbPSK31AFC2.Checked;
  {$ENDIF}
end;

procedure TfrmMain.cbPSKTuneClick(Sender: TObject);
begin
  if cbPSKTune.Checked then
  begin
    StatusBar.Caption := 'Tuning';
    pp := MAXINT;
    {$IFDEF WINDOWS}
    if (vmode = data_a) and decodepsk and soundcard_on then
    begin
      btnTXRX.Enabled := false;
      if not cbTXLock.Checked then
        fnSetTXFrequency(fnGetRXFrequency(0));
      SendSerial('TX;');
      fnStartTX(3);
      txstat := 1;
    end;
    {$ENDIF}
  end
  else
  begin
    StatusBar.Caption := 'Tuning finished';
    pp := 15;
    {$IFDEF WINDOWS}
    if (vmode = data_a) and decodepsk and soundcard_on then
    begin
      btnTXRX.Enabled := true;
      fnStopTX;
      SendSerial('RX;');
      txstat := 0;
    end;
    {$ENDIF}
  end;
end;

procedure TfrmMain.cbTXLockClick(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if (Sender = cbTXLock) and (cbTXLock2.Checked <> cbTXLock.Checked) then
    cbTXLock2.Checked := cbTXLock.Checked;
  if (Sender = cbTXLock2) and (cbTXLock.Checked <> cbTXLock2.Checked) then
    cbTXLock.Checked := cbTXLock2.Checked;
  {$ENDIF}
end;

procedure TfrmMain.edDateExit(Sender: TObject);
begin
  if edDate.Text = '' then Exit;
  if not ValidDate(edDate.Text) then
  begin
    Application.MessageBox(PChar(Format('Date format invalid. Use format YYYY%sMM%sDD',[DateSeparator,DateSeparator])),PChar(Application.Title),MB_ICONERROR);
    edDate.SetFocus;
  end;
end;

procedure TfrmMain.edExchKeyPress(Sender: TObject; var Key: char);
begin
	if Key in ['a'..'z'] then
  	Key := Chr(Ord(Key) - $20);
end;

procedure TfrmMain.edExchrExit(Sender: TObject);
begin
//  if (not qsostarted) and (edCall.Text <> '') then
//    btnLogStartClick(Sender);
end;

procedure TfrmMain.edFreqExit(Sender: TObject);
begin
  if edFreq.Text = '' then Exit;
  try
    edFreq.Text := Format('%5.3f',[StrToFloat(edFreq.Text)]);
  except
    Application.MessageBox(PChar(Format('Frequency format invalid. Use format 9%s999 (MHz)',[DecimalSeparator])),PChar(Application.Title),MB_ICONERROR);
    edFreq.SetFocus;
  end;
end;

procedure TfrmMain.edGridExit(Sender: TObject);
var
  lat,lon,range,bearing: extended;
begin
  if (Length(edGrid.Text) = 6) and (ValidLocator(edGrid.Text)) then
  begin
    LocatorToGeog(edGrid.Text,lat,lon);
    PathCalc(mylat,mylon,lat,lon,false,range,bearing);
    StatusBar.Caption := Format('QRB: %4.0fkm  QTF: %3.0f%s',[range,bearing,sDeg]);
    pp := 15;
  end;
end;

procedure TfrmMain.edTimeExit(Sender: TObject);
begin
  if edTime.Text = '' then Exit;
  if ValidTime(edTime.Text) then
  begin
    if ValidDate(edDate.Text) then
    begin
      timestarted := EncodeDate(StrToInt(Copy(edDate.Text,1,4)),StrToInt(Copy(edDate.Text,6,2)),StrToInt(Copy(edDate.Text,9,2)))
        + EncodeTime(StrToInt(Copy(edTime.Text,1,2)),StrToInt(Copy(edTime.Text,4,2)),0,0);
      timefinished := timestarted;
    end;
  end
  else
  begin
    Application.MessageBox(PChar(Format('Time format invalid. Use format HH%sMM',[TimeSeparator])),PChar(Application.Title),MB_ICONERROR);
    edTime.SetFocus;
  end;
end;

procedure TfrmMain.Fl_TimerTimer (Sender: TObject );
var
  n: integer;
  txs: boolean;
  stmp: string;

begin
  if Fldigi_IsRunning then
  begin
    if Fl_Timer.Interval > 1000 then
    begin
      // do this once when it is first started
      Fl_Timer.Interval := 1000;
      fldigiactive := usefldigi;
      if fldigiactive then
      begin
        BandButtons;
        TaskbarButtons;
        lbTxRx.Caption := 'RX';
        lbTxRx.Font.Color := clGreen;
        btnFldigi.Hint := 'Fldigi is running';
        fldigiversion := Fldigi_GetVersion;
        if not connected then
        begin
          Caption := 'KComm - using Fldigi';
          vmode := data_a;
        end;
        // initialize
        pwr := StrToIntDef(GetValueFromConfigFile(sConfigRoot,'Power','10'),0);
        ant := 1;
        antenna[1] := GetValueFromConfigFile(sConfigRoot,'Ant_1','');
        antenna[2] := GetValueFromConfigFile(sConfigRoot,'Ant_2','');
      end;
    end
  end
  else if Fl_Timer.Interval = 1000 then
  begin
    Fl_Timer.Interval := 10000;
    bmpIPC.Visible := false;
    fldigiactive := false;
    BandButtons;
    TaskbarButtons;
    btnFldigi.Hint := 'Start Fldigi';
    if not connected then
    begin
      vmode := unknown;
      Caption := 'KComm - not connected';
    end;
    Exit;
  end;
  if fldigiactive then
  // use Fldigi XML-RPC communication
  begin
    // get TX state from Fldigi
    txs := Fldigi_IsTx;
		if txs <> tx then
		begin
      // TX status changed
      if txs then
      begin
        lbTxRx.Caption := 'TX';
        lbTxRx.Font.Color := clRed;
        StatusBar.Caption := 'Transmitting';
        txstat := 1;
        pp := 15;
      end
      else
      begin
        if connected then
          SendSerial('RX;');
        lbTxRx.Caption := 'RX';
        lbTxRx.Font.Color := clGreen;
        StatusBar.Caption := 'Transmission finished';
  		  txstat := 0;
        txbuf := '';
        pp := 15;
 	    	btnTxRX.Caption := 'Start sending';
        if qsostarted and logend then
          btnLogEndClick(Sender);
        btnClearTxClick(Sender);
        if (mr_count > 0) and (Length(mr_text) > 0) then  // repeat macro
          mr_Timer.Enabled := true;
      end;
			tx := txs;
    end;
    if not connected then
    begin
      // get frequency
      stmp := Format('%.11d',[Trunc(Fldigi_GetFrequency)]);
      if stmp <> currfreq then
      begin
        currfreq := stmp;
  			curr_f := StrToFreq(stmp);
        stmp := Trim(Format('%11.6f',[curr_f/1000.0]));
        n := Length(stmp);
  			lbFreq.Caption := Copy(stmp,1,n-3);
        lbFreq2.Caption := Copy(stmp,n-2,3);
        lstrfreq := stmp;
//        edFreq.Text := Copy(stmp,1,n-3);
  		end;
    end;
    // get mode
    if vmode in [cw,data_a] then
    begin
      lbMode.Caption := Fldigi_GetMode;
      if lbMode.Caption <> cbMode.Text then
        try
          cbMode.ItemIndex := cbMode.Items.IndexOf(lbMode.Caption);
        except
        end;
    end;
  end;
end;

// We use KeyPreview and OnKeyDown to detect keystrokes sent from PowerMate tuning knob
// NB: Lazarus does not allow processing of WM_HOTKEY messages so use of global hotkeys
// will not be possible.

const
  pm_max_steps = 4;
  pm_steps: array[1..pm_max_steps] of string = (
    '10', '20', '50', '1k' );

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState );
var
  dc: string;
begin
  if tx or (not connected) then Exit;
  if (ssCtrl in Shift) and (ssAlt in Shift) then
  begin
    dc := '';
    case Key of
    37: begin
          dc := 'DN%d;';
          Key := 0;
        end;
    38: begin
          Inc(pm_idx);
          if pm_idx > pm_max_steps then
            pm_idx := 1;
          Key := 0;
          StatusBar.Caption := Format('PowerMate step size: %sHz',[pm_steps[pm_idx]]);
          pp := 5;
        end;
    39: begin
          dc := 'UP%d;';
          Key := 0;
        end;
    40: begin
          pm_idx := 1;
          Key := 0;
          StatusBar.Caption := Format('PowerMate step size: %sHz',[pm_steps[pm_idx]]);
          pp := 5;
        end;
    end;
    if Length(dc) > 0 then
      SendSerial(Format(dc,[pm_idx]));
  end;
end;

procedure TfrmMain.imgSpotClick(Sender: TObject);
var
  f: extended;
begin
  {$IFDEF WINDOWS}
  if not Assigned(frmReporter) then
  begin
    frmReporter := TfrmReporter.Create(frmMain);
    if pskreporterready then
      frmReporter.Show;
  end;
  if pskreporterready and (edCall.Text <> '') and (cbMode.Text <> '') then
  begin
    if (vmode = data_a) and decodepsk and soundcard_on then
      f := TrueFrequency(fnGetRXFrequency(0))
    else
      f := curr_f;
    frmReporter.SendSpot(edCall.Text,cbMode.Text,f,REPORTER_SOURCE_MANUAL);
  end;
  {$ENDIF}
end;

procedure TfrmMain.ChangeFrequency(df: extended);
var
  p: integer;
  fs: string;
begin
  curr_f := curr_f + df;
  if connected then
  begin
    fs := Format('00000%8.6f000000',[(curr_f)/1000.0]);
    p := Pos(DecimalSeparator,fs);
    Delete(fs,p,1);
    if p > 6 then
      Delete(fs,1,p-6);
    fs := 'FA'+Copy(fs,1,11)+';';
    SendSerial(fs);
  end;
end;

procedure TfrmMain.lbFreqMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  mx, dx: integer;
  sign, df: extended;
begin
  df := 0.0;
  if Y < (lbFreq.Height div 2) then
    sign := 1.0
  else
    sign := -1.0;
  dx := lbFreq.Width div 8;
  mx := lbFreq.Width - X;
  if mx < (dx * 3) then
    case mx div dx of
    0 : df := 1.0;
    1 : df := 10.0;
    2 : df := 100.0;
    end
  else
  begin
    mx := mx - (dx div 2);
    case mx div dx of
    3 : df := 1000.0;
    4 : df := 10000.0;
    5 : df := 100000.0;
    6 : df := 1000000.0;
    end
  end;
  if df > 0.0 then
    ChangeFrequency(sign * df);

end;

procedure TfrmMain.lbFreq2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  sign, df: extended;
begin
  df := 0.0;
  if Y < (lbFreq2.Height div 2) then
    sign := 1.0
  else
    sign := -1.0;
  case X div (lbFreq2.Width div 3) of
  0 : df := 0.1;
  1 : df := 0.01;
  2 : df := 0.001;
  end;
  if df > 0.0 then
    ChangeFrequency(sign * df);
end;

procedure TfrmMain.lbShortcutsDblClick (Sender: TObject );
var
  s: string;
  i, p: integer;
begin
  if not connected then Exit;
  i := lbShortcuts.ItemIndex;
  if i >= 0 then
  begin
    s := Shortcuts.Strings[i];
    p := Pos('|',s);
    if p > 0 then
    begin
      Delete(s,1,p);
      SendSerial(s);
    end;
  end;
end;

procedure TfrmMain.lbShortcutsKeyDown (Sender: TObject; var Key: Word;
  Shift: TShiftState );
var
  n, s: string;
  l: integer;
begin
  if Shift = [ssShift] then
  begin
    l := lbShortcuts.ItemIndex;
    if Key = vk_Up then
    begin
      if l = 0 then
        Beep
      else
      begin
        n := lbShortcuts.Items[l];
        s := Shortcuts.Strings[l];
        lbShortcuts.Items.Delete(l);
        Shortcuts.Delete(l);
        lbShortcuts.Items.Insert(l-1,n);
        Shortcuts.Insert(l-1,s);
        lbShortcuts.ItemIndex := l;
        Shortcuts.SaveToFile(shortcutsfilename);
      end
    end
    else if Key = vk_Down then
    begin
      if l = (Shortcuts.Count-1) then
        Beep
      else
      begin
        n := lbShortcuts.Items[l];
        s := Shortcuts.Strings[l];
        lbShortcuts.Items.Delete(l);
        Shortcuts.Delete(l);
        if l = (Shortcuts.Count-1) then
        begin
          lbShortcuts.Items.Add(n);
          Shortcuts.Add(s);
          lbShortcuts.ItemIndex := l+1;
        end
        else
        begin
          lbShortcuts.Items.Insert(l+1,n);
          Shortcuts.Insert(l+1,s);
          lbShortcuts.ItemIndex := l;
        end;
        Shortcuts.SaveToFile(shortcutsfilename);
      end;
    end;
  end;
end;

procedure TfrmMain.lbShortcutsMouseUp (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer );
var
  ptClient: TPoint;
begin
  if Button = mbPopup then
  begin
    ptClient.x:= X;
    ptClient.y:= Y;
    ptClient := lbShortcuts.ClientToScreen(ptClient);
    ShortcutsPopupMenu.PopUp(ptClient.x,ptClient.y);
  end;
end;

procedure TfrmMain.LogPopupMenuPopup(Sender: TObject);
var
  selection: TGridRect;
begin
  selection := sgLog.Selection;
  mnuSpotToCluster.Enabled := Assigned(frmClusterClient) and frmClusterClient.Showing and (selection.Top = log.Count);
  mnuSrchCall.Enabled := log.Count > 0;
  mnuSrchNext.Enabled := (srchpos < log.Count) and (srchcall <> '');
  mnuStats0.Enabled := log.Count > 0;
  mnuStats1.Enabled :=  ctydatavailable and (selection.Bottom > selection.Top);
  mnuStats2.Enabled := contestmode;
  mnuExport1.Enabled := selection.Bottom > selection.Top;
  mnuExport2.Enabled := contestmode;
end;

procedure TfrmMain.LWfallDisplayMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  v: integer;
begin
  {$IFDEF WINDOWS}
  if Button = mbLeft then
  begin
    case psk31txmode of
    0:  v := 4;
    8:  v := 8;
    16: v := 16;
    end;
    fnSetRXFrequency(((X + WFMin + v) * 8000) div 2048, 0, 0);
    cbTXLock.Checked := false;
  end;
  if not cbPSK31AFC.Checked then
  begin
    // right-click waterfall to lock on to signal
  	fnSetAFCLimit(afcrange,0);
    Delay(1000);
    fnSetAFCLimit(afcmin, 0);
  end;
  lbIMD.Caption := 'n/a';
  Application.ProcessMessages;
  fnRewindInput(50);
  {$ENDIF}
end;

procedure TfrmMain.mnuAddShortcutClick (Sender: TObject );
var
  n, cmd: string;
  pos: integer;
begin
  pos := lbShortcuts.ItemIndex;
  with frmShortcut do
  begin
    if connected then
    begin
      edName.Text := Trim(Format('%s (%5.3f MHz)',[edCall.Text, curr_f/1000.0]));
      edCommand.Text := Format('FA%s;MD%d;',[currfreq,mode]);
    end
    else
    begin
      edName.Clear;
      edCommand.Clear;
    end;
    dlgshowing := true;
    if ShowModal = mrOK then
    begin
      n := Trim(edName.Text);
      cmd := Trim(edCommand.Text);
      if n <> '' then
      begin
        if (Shortcuts.Count = 0) or (Sender = mnuAddShortcut) then
        begin
          lbShortcuts.Items.Add(n);
          Shortcuts.Add(n+'|'+cmd);
          lbShortcuts.ItemIndex := pos + 1;
        end
        else
        begin
          lbShortcuts.Items.Insert(pos,n);
          Shortcuts.Insert(pos,n+'|'+cmd);
          lbShortcuts.ItemIndex := pos;
        end;
        Shortcuts.SaveToFile(shortcutsfilename);
      end;
    end;
    dlgshowing := false;
  end;
end;

procedure TfrmMain.mnuAddToNotesClick(Sender: TObject);
begin
  edNotes.Text := Trim(edNotes.Text+' '+seltext);
end;

procedure TfrmMain.btnAMClick(Sender: TObject);
begin
  if not connected then Exit;
  if radio = k2 then Exit;
  SendSerial('MD5;');
end;

procedure TfrmMain.mnuFldigiModesClick(Sender: TObject);
begin
  if fldigiactive then
  begin
    case radio of
      k2:     SendSerial('MD9;');
      k3,kx3: SendSerial('MD6;DT0;');
    end;
    Fldigi_SetMode(TMenuItem(Sender).Caption);
  end;
end;

procedure TfrmMain.mnuImportADIFClick(Sender: TObject);
var
  i, p, count, linecount: integer;
  logchanged, errors : boolean;
  adifpath, qso_date, time_on, time_off, freq, stmp, stmp2, logline: string;
  adiflog: TStringList;
  logitems: TLogItems;

  function GetAdifValue(field: string): string;
  var
    p: integer;
    s: string;

  begin
    Result := '';
    p := APos('<'+field,logline);
    if p > 0 then
    begin
      s := Copy(logline,p,255);
      p := Pos('>',s);
      if p > 0 then
      begin
        Delete(s,1,p);
        p := Pos('<',s);
        if p > 1 then
          Result := Trim(Copy(s,1,p-1));
      end;
    end;
  end;

  function TimeDiff(t1, t2: string): string;
  var
    st, et, diff: Integer;
  begin
    st := StrToIntDef(Copy(t1,1,2),0)*3600+StrToIntDef(Copy(t1,3,2),0)*60;
    et := StrToIntDef(Copy(t2,1,2),0)*3600+StrToIntDef(Copy(t2,3,2),0)*60;
    diff := et - st;
    if diff < 0 then diff := diff + 86400;
    Result := IntToStr(diff);
  end;

begin
  if ImportADIFDialog.Execute then
  begin
    adifpath := ImportADIFDialog.FileName;
    if FileExists(adifpath) then
    begin
      logchanged := false;
      errors := false;
      count := 0;
      linecount := 0;
      adiflog := TStringList.Create;
      try
        try
          adiflog.LoadFromFile(adifpath);
          if adiflog.Count > 0 then
          begin
            repeat
              StatusBar.Caption := 'Importing contact '+IntToStr(count+1);
              Delay(10);
              Inc(linecount);
              for i := 0 to 25 do logitems[i] := '';
              logline := adiflog.Strings[0];
              // import items
              logitems[1] := UpperCase(GetAdifValue('CALL'));
              if Length(logitems[1]) > 2 then
              begin
                logitems[0] := GetAdifValue('OPERATOR');
                if Length(logitems[0]) = 0 then
                  logitems[0] := GetAdifValue('STATION_CALLSIGN');
                if Length(logitems[0]) = 0 then
                  logitems[0] := mycall;
                // get qso start date and time
                qso_date := GetAdifValue('QSO_DATE');
                time_on := GetAdifValue('TIME_ON');
                // get qso end time
                time_off := GetAdifValue('TIME_OFF');
                if (Length(qso_date) = 8) and (Length(time_on) = 4) then
                begin
                  logitems[2] := Copy(qso_date + time_on,1,12);
                  if Length(time_off) = 4 then
                    logitems[3] := TimeDiff(time_on,time_off)
                  else
                    logitems[3] := '0';
                end;
                // get qsl sent/rcvd dates
                logitems[4] := GetAdifValue('QSLSDATE');
                logitems[5] := GetAdifValue('QSLRDATE');
                // get frequency (should be in MHz, so just delete the point)
                freq := GetAdifValue('FREQ');
                p := Pos('.',freq);
                if p > 0 then
                begin
                  Delete(freq,p,1);
                  Insert(DecimalSeparator,freq,p);
                end;
                logitems[6] := IntToStr(Round(StrToFloat(freq) * 1000000.0));
                // get Rx frequency
                freq := GetAdifValue('FREQ_RX');
                if Length(freq) > 0 then
                begin
                  p := Pos('.',freq);
                  if p > 0 then Delete(freq,p,1);
                  p := Pos(DecimalSeparator,freq);
                  if p > 0 then Delete(freq,p,1);
                  logitems[7] := freq;
                end
                else
                  logitems[7] := '0';
                // don't know what logitems[8] is ...
                // get mode
                logitems[9] := Uppercase(GetAdifValue('MODE'));
                // get reports
                logitems[10] := GetAdifValue('RST_SENT');
                logitems[11] := GetAdifValue('RST_RCVD');
                // get contest exchanges
                logitems[12] := GetAdifValue('STX');
                if Length(logitems[12]) = 0 then
                  logitems[12] := GetAdifValue('STX_STRING');
                logitems[13] := GetAdifValue('SRX');
                if Length(logitems[13]) = 0 then
                  logitems[13] := GetAdifValue('SRX_STRING');
                // get name, qth, gridsquare, notes
                logitems[14] := GetAdifValue('NAME');
                logitems[15] := GetAdifValue('QTH');
                logitems[16] := GetAdifValue('NOTES');
                // don't know what logitems[17] is ...
                logitems[18] := GetAdifValue('QSL_VIA');
                stmp := GetAdifValue('CNTY');
                stmp2 := GetAdifValue('STATE');
                if (Length(stmp) > 0) and (Length(stmp2) > 0) then
                  logitems[19] := stmp + ', ' + stmp2
                else
                  logitems[19] := stmp + stmp2;
                logitems[20] := GetAdifValue('IOTA');
                logitems[21] := GetAdifValue('GRIDSQUARE');
                // don't know what logitems[22] is ...
                // get e-qsl sent/rcvd dates
                logitems[23] := GetAdifValue('EQSL_QSLSDATE');
                logitems[24] := GetAdifValue('EQSL_QSLRDATE');
                logitems[25] := GetAdifValue('COMMENT');
                // check for a minimum valid qso
                if (logitems[2] <> '') and (logitems[6] <> '')
                  and (logitems[9] <> '') then
                begin
                  if count = 0 then
                    log.SaveToFile(ChangeFileExt(logfilename,'.bak'));
                  // build log line
                  logline := '';
                  for i := 0 to 25 do
                    logline := Trim(logline+logitems[i]+';');
                  log.Add(logline);
                  logchanged := true;
                  Inc(count);
                end
                else
                begin
                  errors := true;
                  StatusBar.Caption := '** Import errors **';
                end;
              end;
              adiflog.Delete(0);
            until errors or (adiflog.Count = 0);
          end;
        except
        end;
      finally
        adiflog.Destroy;
      end;
    end;
    if errors then
      Application.MessageBox(PChar(Format('Invalid ADIF input at line %d',[linecount])),
        PChar(Application.Title),MB_ICONERROR+MB_OK)
    else if logchanged then
    begin
      log.SaveToFile(logfilename);
      LoadLog;
      if MessageDlg('Delete import file?', mtConfirmation, mbYesNo, 0) = idYes then
        DeleteFile(adifpath);
    end;
  end;
end;

procedure TfrmMain.mnuModeBPSK125Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if connected and decodepsk then
  begin
    lbMode.Caption := 'PSK125';
    cbMode.ItemIndex := cbMode.Items.IndexOf('PSK125');
    psk31txmode := 16;
    fnSetRXPSKMode(psk31txmode,0);
    case radio of
      k2  : SendSerial('MD9;');
      k3,kx3  : SendSerial('MD6;DT0;');
    end;
    if largewfall then
    begin
      LWfreqDisplay.Cursor := 3;
      LWfallDisplay.Cursor := 3;
    end;
  end;
  {$ENDIF}
  if fldigiactive then
    Fldigi_SetMode('BPSK125');
end;

procedure TfrmMain.mnuModePSK31Click(Sender: TObject);
begin
  if connected then
  begin
    lbMode.Caption := 'BPSK31';
    cbMode.ItemIndex := cbMode.Items.IndexOf('BPSK31');
    {$IFDEF WINDOWS}
    if decodepsk then
    begin
      psk31txmode := 0;
      fnSetRXPSKMode(psk31txmode,0);
    end;
    if largewfall then
    begin
      LWfreqDisplay.Cursor := 1;
      LWfallDisplay.Cursor := 1;
    end;
    {$ENDIF}
    case radio of
      k2  : SendSerial('MD9;');
      k3,kx3:
            begin
              if usek3dsp then
                SendSerial('MD6;DT3;')
              else if usesoundcard then
                SendSerial('MD6;DT0;');
            end;
    end;
  end;
  if fldigiactive then
    Fldigi_SetMode('BPSK31');
end;

procedure TfrmMain.mnuModePSK63Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if connected and decodepsk then
  begin
    lbMode.Caption := 'BPSK63';
    cbMode.ItemIndex := cbMode.Items.IndexOf('BPSK63');
    psk31txmode := 8;
    fnSetRXPSKMode(psk31txmode,0);
    case radio of
      k2  : SendSerial('MD9;');
      k3,kx3  : SendSerial('MD6;DT0;');
    end;
    if largewfall then
    begin
      LWfreqDisplay.Cursor := 2;
      LWfallDisplay.Cursor := 2;
    end;
  end;
  {$ENDIF}
  if fldigiactive then
    Fldigi_SetMode('BPSK63');
end;

procedure TfrmMain.mnuAddToQTHClick (Sender: TObject );
begin
  edQTH.Text := edQTH.Text + ' ' + StringReplace(CapText(seltext), 'Nr ', 'nr ', [rfReplaceAll]);
end;

procedure TfrmMain.mnuCharsetClick(Sender: TObject);
var
  strtmp: string;
begin
  strtmp := UTF8ToStr(RXPanel.Text,rxcharset);
  rxcharset := TMenuItem(Sender).Tag;
  TMenuItem(Sender).Checked := true;
  SaveValueToConfigFile(sConfigRoot,'RX_Charset',rxcharset);
  RXPanel.Text := StrToUTF8(strtmp,rxcharset);
end;

procedure TfrmMain.mnuCopyToCallClick(Sender: TObject);
begin
  SetQSOFreq;
  edCall.Text := useltext;
  if (not contestmode) and realreports then
  begin
    edRSTr.Clear;
    edExchr.Clear;
  end;
  edName.Clear;
  edQTH.Clear;
  edGrid.Clear;
  edNotes.Clear;
  txLookup.Visible := true;
  txLookup2.Visible := true;
  {$IFDEF WINDOWS}
  imgSpot.Visible := true;
  {$ENDIF}
  if (edFreq.Text <> '') and (cbMode.Text <> '') then
    ShowContactInfo(edCall.Text,freqtoband(StripAll(DecimalSeparator,edFreq.Text)+'000'),cbMode.Text);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := true;
	if qsostarted and (edCall.Text<>'') and (MessageDlg('Abandon contact with '+edCall.Text+'?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
    CanClose := false;
	if btnSaveMacros.Enabled and (MessageDlg('Discard unsaved macro changes?',mtConfirmation,[mbYes,mbNo],0) = mrNo) then
    CanClose := false;
end;

procedure TfrmMain.MacroMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  macro: integer;
begin
	if Button = mbRight then
	begin
    macro := TButton(Sender).Tag;
    with frmMacro do
    begin
  		edCaption.Text := TButton(Sender).Caption;
      if macro <= 12 then txFuncKey.Caption := 'F'+IntToStr(macro) else txFuncKey.Caption := '';
  		edHint.Text := TButton(Sender).Hint;
  		mmMacro.Text := macros[macro];
      dlgshowing := true;
  		if ShowModal = mrOK then
  		begin
  			TButton(Sender).Caption := edCaption.Text;
  			TButton(Sender).Hint := edHint.Text;
  			macros[macro] := mmMacro.Text;
  			if (Pos('^t',macros[macro]) > 0) or (Pos('^T',macros[macro]) > 0) then
  				TButton(Sender).Font.Style := TButton(Sender).Font.Style + [fsBold]
  			else
  				TButton(Sender).Font.Style := TButton(Sender).Font.Style - [fsBold];
  			btnSaveMacros.Enabled := true;
      end;
      dlgshowing := false;
		end;
	end;
end;

procedure TfrmMain.MacroClick(Sender: TObject);
begin
  if connected or fldigiactive then
	  ProcessMacro(macros[TButton(Sender).Tag]);
end;

procedure TfrmMain.btnOpenMacrosClick(Sender: TObject);
begin
  with OpenMacrosDialog do
  begin
    if Execute and FileExists(FileName) then
    begin
      LoadMacros(FileName);
      SaveMacrosDialog.FileName := FileName;
      btnSaveMacros.Enabled := false;
    end;
  end;
end;

procedure TfrmMain.btnRollUpClick(Sender: TObject);
var
  m: integer;
begin
  if btnRollUp.Caption = '^' then
    m := formmode - 1
  else
    m := formmode + 1;
  FormState(m);
end;

procedure TfrmMain.btnSaveMacrosClick(Sender: TObject);
begin
  with SaveMacrosDialog do
  begin
    if Execute then
    begin
      SaveMacros(FileName);
      OpenMacrosDialog.FileName := FileName;
      btnSaveMacros.Enabled := false;
    end;
  end;

end;

procedure TfrmMain.mnuSaveTextClick(Sender: TObject);
begin
  with SaveRxDialog do
  begin
    FileName := StripAll(DateSeparator,edDate.Text)+StripAll(TimeSeparator,edTime.Text)+'_'+edCall.Text+'.txt';
    if Execute then
      RxPanel.Lines.SaveToFile(FileName);
  end;
end;

procedure TfrmMain.btnLogEndClick(Sender: TObject);
begin
  timefinished := Now + TimeZoneBias;
  if timestarted = 0.0 then
  begin
  	timestarted := timefinished;
    edDate.Text := FormatDateTime('yyyy/mm/dd',timestarted);
    edTime.Text := FormatDateTime('hh:nn',timestarted);
  end;
  SetQSOFreq;
  qsostarted := true;
  StatusBar.Caption := 'QSO ended at '+FormatDateTime('hh:nn',timefinished);
  pp := 15;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  p: integer;
  logbackuppath, ftpu, ftpp, ftps: string;
  validpath: boolean;
begin
  if connected then
  begin
    btnConnectClick(Sender);
    Delay(1000);
  end;
  // save settings
  SaveValueToConfigFile(sConfigRoot,'CW_Uppercase_1',cbRxUpperCase.Checked);
  SaveValueToConfigFile(sConfigRoot,'CW_Uppercase_2',cbCWUpperCase.Checked);
  if currentmacros <> '' then
	  SaveValueToConfigFile(sConfigRoot,'Default_Macros',currentmacros);
  // save form position
  SaveValueToConfigFile(sConfigRoot,'FormState',formmode);
  SaveFormPositionToConfigFile(sConfigRoot,'WindowPos',frmMain);
  // backup log
  if GetValueFromConfigFile(sConfigRoot,'Backup_Log',false) and logchanged then
  begin
    StatusBar.Caption := 'Backing up log data...';
    Application.ProcessMessages;
    logbackuppath := GetValueFromConfigFile(sConfigRoot,'Backup_File',ChangeFileExt(LogFileName,'.bak'));
    if LowerCase(Copy(logbackuppath,1,6)) = 'ftp://' then
    begin
      validpath := false;
      // ftp backup filename in the format: ftp://username:password@ftp.server/folder/filename
      Delete(logbackuppath,1,6);
      p := Pos(':',logbackuppath);
      if p > 0 then
      begin
        ftpu := Copy(logbackuppath,1,p-1);
        Delete(logbackuppath,1,p);
        p := Pos('@',logbackuppath);
        if p > 0 then
        begin
          ftpp := Copy(logbackuppath,1,p-1);
          Delete(logbackuppath,1,p);
          p := Pos('/',logbackuppath);
          if p > 0 then
          begin
            ftps := Copy(logbackuppath,1,p-1);
            Delete(logbackuppath,1,p);
            validpath := true;
          end;
        end;
      end;
      if validpath then
      begin
        if not FtpPutFile(ftps, '21', logbackuppath, logfilename, ftpu, ftpp) then
          Application.MessageBox(PChar('Backup failed'),PChar(Application.Title),MB_ICONEXCLAMATION);
      end
      else
        Application.MessageBox(PChar('Invalid path'),PChar(Application.Title),MB_ICONEXCLAMATION);
    end
    else
      log.SaveToFile(logbackuppath);
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  if psk31coreavailable and Assigned(WaterfallBitmap) then
    WaterfallBitmap.Destroy;
  {$ENDIF}
  CWWfall.Destroy;
  PSKWfall.Destroy;
  // destroy the serial port object
  if Assigned(SerialPort) then
  begin
    if SerialPort.InstanceActive then
    begin
      SerialPort.Purge;
      Delay(1000);
    end;
    SerialPort.Destroy;
  end;
  // destroy the lists
  Shortcuts.Destroy;
  Check.Destroy;
  CQZ.Destroy;
  ITUZ.Destroy;
  log.Destroy;
end;

procedure TfrmMain.AddCWText(s: string);
var
  rxtxt: string;
begin
  if tx then Exit;
  rxtxt := s;
  if rxtxt <> '' then
  begin
    if (vmode = cw) and (not cbRxUpperCase.Checked) then rxtxt := LowerCase(rxtxt);
    rxbuf := rxbuf + rxtxt;
  end;
end;

procedure TfrmMain.SetCWSpotFreq(f: integer);
begin
  with CWWfall do
  begin
    case f of
    400:  SetSampleRateAndCenterFreq(8000,400);
    500:  SetSampleRateAndCenterFreq(8000,500);
    550:  SetSampleRateAndCenterFreq(11025,551);
    600:  SetSampleRateAndCenterFreq(24000,600);
    650:  SetSampleRateAndCenterFreq(16000,666);
    700:  SetSampleRateAndCenterFreq(22050,689);
    750:  SetSampleRateAndCenterFreq(24000,750);
    800:  SetSampleRateAndCenterFreq(16000,800);
    1000: SetSampleRateAndCenterFreq(16000,1000);
    else
      MessageDlg(Format('CW center frequency %dHz not supported',[f]),mtError,[mbOK],0);
    end;
  end;
end;

{$IFDEF WINDOWS}
function TfrmMain.StartPSK31Core: boolean;
var
  FFTMax, err: integer;
  errstr: string;
  Rect: TRect;
begin
  if soundcard_on then Exit;
  if largewfall then
  begin
    // create waterfall bitmap
    with LWfallDisplay do
    begin
      WaterfallBitmap := TBitmap.Create;
     	WaterfallBitmap.Width := Width;
      WaterfallBitmap.Height := Height;
  		WFMin := 100;
      WFMax := WFMin + Width;
      WFBandwidth := (WFMax - WFMin) * 8000 div 2048;
    	WFOffset := WFMin * 8000 div 2048;
      Cursor := 1;
      LWfreqDisplay.Cursor := 1;
      cbPSK31AFC2.Checked := GetValueFromConfigFile(sConfigRoot,'PSK31_AFC',false);
    end;
  end
  else
  begin
    // create waterfall bitmap
    with WaterfallDisplay do
    begin
      WaterfallBitmap := TBitmap.Create;
     	WaterfallBitmap.Width := Width;
      WaterfallBitmap.Height := Height;
    end;
    cbPSK31AFC.Checked := GetValueFromConfigFile(sConfigRoot,'PSK31_AFC',false);
  	// set FFT parameters
    FFTMax := pskcenterfreq * 2048 div 4000 - 1;
    if FFTMax > 1023 then FFTMax := 1023;
  	// set waterfall display parameters
    with WaterfallDisplay do
    begin
  		WFMin := (FFTMax div 2) - Width div 2;
      WFMax := (FFTMax div 2) + Width div 2 - 1;
      WFBandwidth := (WFMax - WFMin) * 8000 div 2048;
    	WFOffset := WFMin * 8000 div 2048;
    end;
  end;
//  psk31txmode := 0;
  fnSetRXPSKMode(psk31txmode,0);  // set default mode BPSK31
  fnSetSquelchThreshold(10,1,0);
	fnSetFFTMode(1, 255, 10);
  if cbPSK31AFC.Checked then
    fnSetAFCLimit(afcrange,0)
  else
    fnSetAFCLimit(afcmin,0);
	fnSetSquelchThreshold(15,1,0);
  fnSetRXFrequency(pskcenterfreq, 0, 0);
  fnSetTXFrequency(pskcenterfreq);
  Rect.Left := 0;
  Rect.Top := 0;
  Rect.Right := Width;
	Rect.Bottom := Height;
  with WaterfallBitmap.Canvas do
  begin
	  Brush.Color := clBlack;
  	FillRect(Rect);
  end;
  fnEnableRXChannel(0,true);
  err := fnStartRXTXSoundCard(Handle,rx_sound_dev,tx_sound_dev,25);
  if err = 0 then
  begin
    StatusBar.Caption:= 'PSK31 Core DLL started';
    soundcard_on := true;
    pp := 15;
  end
  else
  begin
  	case err of
    10: errstr := 'Memory allocation error';
    11: errstr := 'Cannot open sound card';
    12: errstr := 'Sound card failure';
    13: errstr := 'Sound card already in use';
    else
    	errstr := 'Undefined error: code '+IntToStr(err);
    end;
    Application.MessageBox(PChar(errstr),PChar(Application.Title),MB_ICONEXCLAMATION);
  end;
  Result := err = 0;
end;

procedure TfrmMain.StopPSK31Core;
begin
  if soundcard_on then
  begin
    fnStopSoundCard;
    soundcard_on := false;
    Delay(500);
  end;
  if Assigned(frmPSKBrowser) then
    frmPSKBrowser.Close;
  if Assigned(frmReporter) then
    frmReporter.Close;
  if largewfall then
    SaveValueToConfigFile(sConfigRoot,'PSK31_AFC',cbPSK31AFC2.Checked)
  else
    SaveValueToConfigFile(sConfigRoot,'PSK31_AFC',cbPSK31AFC.Checked);
  WaterfallBitmap.Destroy;
  WaterfallBitmap := nil;
end;

function TfrmMain.TrueFrequency(pitch: integer): extended;
var
  usb: boolean;
begin
  case radio of
    k2: usb := mode = 9;
    k3,kx3: usb := mode = 6;
  end;
  if usb then
    Result := curr_f + (pitch / 1000.0)
  else
    Result := curr_f - (pitch / 1000.0);
end;

{$ENDIF}

function modetype(mode: Integer): TMode;
begin
  case mode of
  1,2,4,5:  Result := phone;
  3,7:  	  Result := cw;
  6,9:	    Result := data_a;
  else
		Result := unknown;
  end;
end;

procedure TfrmMain.ParseDataIn;
var
	n,n2,p: Integer;
  dsfreq: boolean;
  vmodet: TMode;
	datatype, data, dsstat, init: string;
	strtmp: string;
  c: char;
begin
	if Length(datain) > 2 then
	begin
		repeat
      if (radio in [k3,kx3]) and ((vmode = cw) or ((vmode = data_a) and usek3dsp))
        and (Copy(datain,1,2) = 'TB') then
      begin
        p := 0;
        if Length(datain) > 5 then
          p := StrToIntDef(Copy(datain,4,2),0) + 6;
      end
      else
			  p := Pos(';',datain);
			if p > 0 then
			begin
				data := Copy(datain,1,p-1);
				if Length(data) >= 2 then
				begin
					datatype := UpperCase(Copy(data,1,2));
					case Pos(datatype,'PSIFBGKYTQPCDBDSGTDTKSTB') of
					1:    begin                                                           // PS
                  // sent on connect, so a reply to this means we are just connected
                  Caption := PChar(Format('KComm - connected to %s´s %s',[mycall,sradio]));
                  btnConnect.Caption := 'Disconnect';
                  StatusBar.Caption := 'Connected';
                  btnSettings.Enabled := false;
                  {$IFDEF WINDOWS}
                  btnMRP40.Enabled := usemrp40;
                  btnCWSkimmer.Enabled := usecwskimmer;
                  {$ENDIF}
                  connected := true;
                  Delay(100);
                  init := sStartup[radio];
                  // set default mode is PSK31
                  if radio in [k3,kx3] then
                  begin
                    if usek3dsp then
                      dmode := GetValueFromConfigFile(sConfigRoot,'Last_DMode',2)
                    else if usesoundcard then
                      dmode := 0;
                    init := init + Format('DT%d;',[dmode]);
                  end;
                  SendSerial(init); // send initialization string
                  pp := 5;
                  BandButtons;
                  TaskbarButtons;
                  // load shortcuts
                  LoadShortcuts(shortcutsfilename);
                end;
					3:		begin																														// IF
									n := StrToIntDef(data[29],0);
									if n <> Ord(tx) then
									begin
                    // TX status changed
										tx := n = 1;
                    if tx then
                    begin
                      lbTxRx.Caption := 'TX';
                      lbTxRx.Font.Color := clRed;
                    end
                    else
                    begin
                      lbTxRx.Caption := 'RX';
                      lbTxRx.Font.Color := clGreen;
                      if (radio = k2) and (mr_count > 0) and (Length(mr_text) > 0) then  // repeat macro
                        mr_Timer.Enabled := true;
                    end;
									end;
									// vfo active
									n := StrToIntDef(data[31],-1);
									if n <> vfoa then
										vfoa := n;
									// rit/xit
									n := StrToIntDef(data[24],0);
									if n <> rit then
									begin
										rit := n;
                    if rit = 1 then
                      lbRIT.Caption := 'RIT'
                    else
                      lbRIT.Caption := '';
									end;
									n := StrToIntDef(data[25],0);
									if n <> xit then
									begin
										xit := n;
                    if xit = 1 then
                      lbRIT.Caption := 'XIT'
                    else if rit = 1 then
                      lbRIT.Caption := 'RIT'
                    else
                      lbRIT.Caption := '';
									end;
									// split
									n := StrToIntDef(data[33],0);
									if n <> split then
									begin
										split := n;
                    if split = 1 then
                      lbSplit.Caption := 'SPLIT'
                    else
                      lbSplit.Caption := '';
									end;
									// freq
									currfreq := Copy(data,3,11);
                  curr_f := StrToFreq(currfreq);
                  if rit = 1 then
                  begin
                    if data[19] = '-' then delta_f := -1.0 else delta_f := 1.0;
                    delta_f := (StrToIntDef(Copy(data,20,4),0) / 1000.0) * delta_f;
                  end
                  else
                    delta_f := 0.0;
                  strtmp := Trim(Format('%11.6f',[(curr_f+delta_f)/1000.0]));
                  if strtmp <> lstrfreq then
                  begin
                    n := Length(strtmp);
  								  lbFreq.Caption := Copy(strtmp,1,n-3);
                    lbFreq2.Caption := Copy(strtmp,n-2,3);
                    {$IFDEF WINDOWS}
                    if largewfall and decodepsk then
                      LWfreqDisplayPaint;
                    if Assigned(frmPSKBrowser) then
                      frmPSKBrowser.InitAllChannels;
                    {$ENDIF}
                    lstrfreq := strtmp;
                  end;
									// mode
  							  n := StrToIntDef(data[30],0);
                  if radio in [k3,kx3] then
                    n := n + StrToIntDef(data[35],0)*100;
									if n <> cmode then
									begin
										cmode := n;
                    mode := n mod 100;
                    vmodet := modetype(mode);
                  	if vmodet <> vmode then
                    begin
                      // mode has changed
                    	if vmodet = cw then
                      begin
                        // mode changing to cw
                        if cwwaterfall then
                        begin
                          WaterfallPanel.Visible := true;
                          cbRxUpperCase.Visible := true;
                          cbCWUpperCase.Visible := true;
                          CWWfall.Start;
                        end;
                        if (radio in [k3,kx3]) then
                        begin
                          btnSpot.Visible := not cwwaterfall;
                          cbRxUpperCase.Visible := true;
                          cbCWUpperCase.Visible := true;
                        end;
                        strtmp := GetValueFromConfigFile(sConfigRoot,'CW_Macros',currentmacros);
                      end
                      else if vmode = cw then
                      begin
                        // mode changing from cw
                        if cwwaterfall then
                        begin
                          CWWfall.Close;
                          WaterfallPanel.Visible := (vmodet = data_a) and (decodepsk or pskwaterfall)
                            {$IFDEF WINDOWS}and (not largewfall){$ENDIF};
                          cbRxUpperCase.Visible := false;
                          cbCWUpperCase.Visible := false;
                          RXPanel.Clear;
                        end;
                        if (radio in [k3,kx3]) then
                        begin
                          btnSpot.Visible := false;
                          cbRxUpperCase.Visible := false;
                          cbCWUpperCase.Visible := false;
                        end;
                      end;
                      Application.ProcessMessages;
                      if (vmodet = data_a) then
                      begin
                        // mode changing to data
                        {$IFDEF WINDOWS}
                        if decodepsk then
                        begin
                          if not largewfall then
                          begin
                            WaterfallPanel.Visible := true;
                            cbPSK31AFC.Visible := true;
                            cbTXLock.Visible := true;
                          end;
                          cbPSKTune.Visible := true;
                          StartPSK31Core;
                        end;
                        {$ENDIF}
                        if (radio in [k3,kx3]) then
                        begin
                          if (not decodepsk) and (not usefldigi) then
                          begin
                            if pskwaterfall then
                            begin
                              WaterfallPanel.Visible := true;
                              PSKWfall.Start;
                            end
                            else
                              btnSpot.Visible := true;
                          end;
                        end;
                        strtmp := GetValueFromConfigFile(sConfigRoot,'Data_Macros',currentmacros);
                      end
                      else if (vmode = data_a) then
                      begin
                        // mode changing from data
                        {$IFDEF WINDOWS}
                        if decodepsk then
                        begin
                          StopPSK31Core;
                          WaterfallPanel.Visible := (vmodet = cw) and cwwaterfall;
                          cbPSK31AFC.Visible := false;
                          cbTXLock.Visible := false;
                          cbPSKTune.Visible := false;
                          RXPanel.Clear;
                        end;
                        {$ENDIF}
                        if (radio in [k3,kx3]) and (not decodepsk) then
                        begin
                          if pskwaterfall then
                          begin
                            PSKWfall.Stop;
                            WaterfallPanel.Visible := (vmodet = cw) and cwwaterfall;
                          end
                          else
                            btnSpot.Visible := false;
                        end;
                      end;
                      // set RST to correct format for mode
                      if edRSTS.Text <> '' then
                      begin
                        if vmodet = phone then
                          edRSTS.Text := Copy(edRSTS.Text,1,2)
                        else
                          edRSTS.Text := Copy(edRSTS.Text,1,2)+'9';
                      end;
                      if edRSTR.Text <> '' then
                      begin
                        if vmodet = phone then
                          edRSTR.Text := Copy(edRSTR.Text,1,2)
                        else
                          edRSTR.Text := Copy(edRSTR.Text,1,2)+'9';
                      end;
                      vmode := vmodet;
                      if largewfall and decodepsk then
                        FormState(formmode);
                    	if currentmacros <> strtmp then
                        LoadMacros(strtmp);
                      TaskbarButtons;
                    end; // mode has changed
                    {$IFDEF WINDOWS}
                    if ((mode = 6) or (mode = 9)) and decodepsk then
                    begin
                      case psk31txmode of
                      0:  lbMode.Caption := 'BPSK31';
                      8:  lbMode.Caption := 'BPSK63';
                      16:  lbMode.Caption := 'PSK125';
                      end;
                    end
                    else
                    {$ENDIF}
                      if ((mode = 6) or (mode = 9)) then
                      begin
                        dmode := StrToIntDef(data[35],0); // extended data mode
                        case dmode of
                        1,2:  lbMode.Caption := 'RTTY';
                        3:    lbMode.Caption := 'BPSK31';
                        else
                          lbMode.Caption := 'DATA';
                        end;
                      end
                      else
  										  lbMode.Caption := ModeStr[radio,mode];
                    try
                      cbMode.ItemIndex := cbMode.Items.IndexOf(lbMode.Caption);
                    except
                    end;
									end;
								end;
					5:		begin																														// BG
									strength := StrToIntDef(Copy(data,3,2),0);
									if radio = k2 then
                  begin
                    if strength >= 12 then Dec(strength,12);
                    strength := strength * 2;
                  end;
                  if (not contestmode) and realreports then
                  begin
                    strtmp := edRSTs.Text;
                    if Length(strtmp) >= 2 then
                    begin
                      c := Chr(strength+48);
                      if c > '9' then c := '9';
                      if c > strtmp[2] then
                      begin
                        strtmp[2] := c;
                        edRSTs.Text := strtmp;
                      end;
                    end;
                  end;
                  n := strength * 6 + 1;
                  if n > 96 then n := 96;
									if bgval <> n then
									begin
										imgMeterFg.Width := n;
										bgval := n;
									end;
								end;
					7:		begin																														// KY
                  try
                    n := StrToInt(data[3]);
                    if n <> cwbufstate then
                    begin
    									cwbufstate := n;
                      case n of
                      0:  StatusBar.Caption := 'Transmit buffer not full';
                      1:  StatusBar.Caption := 'Transmit buffer full';
                      2:  StatusBar.Caption := 'Transmit buffer empty';
                      end;
                    end;
						  		except
							  	end;
                end;
					9:		begin     																											// TQ
                  try
  									n := StrToInt(data[3]);
  									if n <> Ord(tx) then
  									begin
                      // TX status changed
  										tx := n = 1;
                      if tx then
                      begin
                        lbTxRx.Caption := 'TX';
                        lbTxRx.Font.Color := clRed;
                      end
                      else
                      begin
                        lbTxRx.Caption := 'RX';
                        lbTxRx.Font.Color := clGreen;
                        if (mr_count > 0) and (Length(mr_text) > 0) then  // repeat macro
                          mr_Timer.Enabled := true;
                      end;
                      parsebuf := '';
  									end;
  								except
  								end;
                end;
					11:		begin																														// PC
                  try
  									n := StrToIntDef(Copy(data,3,3),0);
	  								n2 := StrToIntDef(data[6],0);
		  							if n2 = 0 then n := n div 10;
                    if n <> pwr then
  			  						pwr := n;
                  except
                  end;
								end;
          13:   begin                                                           // DB
                  Delete(data,1,2);
                  StatusBar.Caption := data;
                end;
          15:   begin                                                           // DS
                  Delete(data,1,2);
                  if Length(data) = 10 then
                  begin
                    dsdisp := '';
                    dsstat := '';
                    dsfreq := false;
                    for n := 1 to 8 do
                    begin
                      if Ord(data[n]) > 127 then
                      begin
                        dsdisp := dsdisp + DecimalSeparator;
                        data[n] := Chr(Ord(data[n]) and $7F);
                        case radio of
                        k2: if (n = 6) then dsfreq := true;
                        k3,kx3: if (n = 3) or (n = 4) then dsfreq := true;
                        end;
                      end;
                      case data[n] of
                      '<':  dsdisp := dsdisp + 'L';
                      '>':  dsdisp := dsdisp + ':';
                      '@':  dsdisp := dsdisp + ' ';
                      'I':  dsdisp := dsdisp + '1';
                      'K':  dsdisp := dsdisp + 'H';
                      'M':  dsdisp := dsdisp + 'N';
                      'Q':  dsdisp := dsdisp + 'O';
                      'V':  dsdisp := dsdisp + 'U';
                      'W':  dsdisp := dsdisp + 'I';
                      'X':  dsdisp := dsdisp + 'c';
                      'Z':  dsdisp := dsdisp + 'C';
                      '[':  dsdisp := dsdisp + 'r';
                      else
                        dsdisp := dsdisp + data[n];
                      end;
                      case radio of
                      k2: if (n < 8) and not (data[n] in ['@','0'..'9',' ']) then dsfreq := false;
                      k3,kx3: if (n < 8) and not (data[n] in ['@','0'..'9']) then dsfreq := false;
                      end;
                    end;
                    if dsfreq then
                    begin
                      // display is frequency so show status instead
                      if radio = k2 then
                      begin
                        if (Ord(data[9]) and $04) = 0 then
                          dsstat := dsstat + 'VFO A    '
                        else
                          dsstat := dsstat + 'VFO B    ';
                      end;
                      if (Ord(data[9]) and $20) = 0 then
                        ant := 1
                      else
                        ant := 2;
                      if (curr_f > 1800.0) and (curr_f < maxfreq[radio]) then
                        dsstat := dsstat + Format('ANT %d (%s)    ',[ant,antenna[ant]]);
                      if radio in [k3,kx3] then
                      begin
                        if (Ord(data[10]) and $10) = 0 then
                          dsstat := dsstat + 'ATU byp    '
                        else
                          dsstat := dsstat + 'ATU on    ';
                        if (Ord(data[10]) and $40) <> 0 then
                          dsstat := dsstat + 'SUB on    ';
                        if (Ord(data[10]) and $20) <> 0 then
                          dsstat := dsstat + 'RXANT on    ';
                      end;
                      if (Ord(data[9]) and $10) <> 0 then
                        dsstat := dsstat + 'PRE on    ';
                      if (Ord(data[9]) and $08) <> 0 then
                        dsstat := dsstat + 'ATT on    ';
                      if (Ord(data[9]) and $40) <> 0 then
                        dsstat := dsstat + 'NB on    ';
                      dsstat := dsstat + 'AGC ' + AGCStr[agc] + '    ';
                      if radio in [k3,kx3] then
                      begin
                        if (Ord(data[10]) and $04) <> 0 then
                          dsstat := dsstat + 'NR on    ';
                        if (Ord(data[10]) and $03) <> 0 then
                          dsstat := dsstat + 'NTCH on    ';
                      end;
                      if (curr_f > 1800.0) and (curr_f < maxfreq[radio]) then
                        dsstat := dsstat + Format('PWR %dw    ',[pwr]);
                      if (vmode = cw) and (spd > 0) then
                        dsstat := dsstat + Format('SPD %dwpm    ',[spd]);
                      if pp <= 0 then
                        StatusBar.Caption := Trim(dsstat);
                      pp := 15;
                    end
                    else
                    begin
                      StatusBar.Caption := Trim(dsdisp);
                      pp := 4;
                      Delay(100);
                      SendSerial('DS;');
                    end;
                  end;
                end;
					17:		if Length(data) = 6 then  																			// GT
                begin
                  if data[6] = '0' then
                    agc := 0
                  else if data[5] = '2' then
                    agc := 1
                  else
                    agc := 2
								end;
					19:		begin                     																			// DT
                  dmode := StrToIntDef(data[3],0); // extended data mode
                  if (vmode = data_a) and (dmode > 1) then
                  begin
                    case dmode of
                    2:  lbMode.Caption := 'RTTY';
                    3:  lbMode.Caption := 'BPSK31';
                    end;
                    try
                      cbMode.ItemIndex := cbMode.Items.IndexOf(lbMode.Caption);
                    except
                    end;
                  end;
								end;
					21:		spd := StrToIntDef(Copy(data,3,3),0);                           // KS
          23:   begin                                                           // TB
                  Delete(data,1,5);
                  if Length(data) > 0 then
                  begin
                    if vmode = cw then
                      AddCWText(data)
                    else
                      rxbuf := rxbuf + data;
                  end;
                end;
					end;
				end;
        Delete(datain,1,p);
			end
			else
				data := '';
		until data = '';
	end;
end;

procedure TfrmMain.LoadMacros(const filename: string);
var
	i, p: Integer;
	btn, macro, tmp: string;
	c: TComponent;
  macrofile: TXMLConfig;
begin
  macrofile := TXMLConfig.Create(nil);
  if FileExists(filename) then
    macrofile.Filename := filename;
  currentmacros := filename;
  if vmode = data_a then
    SaveValueToConfigFile(sConfigRoot,'Data_Macros',currentmacros)
  else if vmode = cw then
    SaveValueToConfigFile(sConfigRoot,'CW_Macros',currentmacros);
	for i := 1 to 16 do
	begin
		btn := Format('btnMacro%.2d',[i]);
		macro := Format('Macro%.2d',[i]);
		c := FindComponent(btn);
		if c <> nil then
		begin
      TButton(c).Caption := macrofile.GetValue(macro+'/Caption','');
			TButton(c).Hint := macrofile.GetValue(macro+'/Hint','');
			tmp := macrofile.GetValue(macro+'/Macro','');
			repeat
				p := Pos('||',tmp);
				if p > 0 then
				begin
					tmp[p] := #13;
					tmp[p+1] := #10;
				end;
			until p = 0;
			macros[i] := tmp;
      if fontname <> '' then
        begin
  			if (Pos('^t',tmp) > 0) or (Pos('^T',tmp) > 0) then
  				TButton(c).Font.Style := TButton(c).Font.Style + [fsBold]
  			else
  				TButton(c).Font.Style := TButton(c).Font.Style - [fsBold];
      end;
		end;
	end;
  macrofile.Destroy;
end;

procedure TfrmMain.SaveMacros(const filename: string);
var
	i, p: Integer;
	btn, macro, tmp: string;
	c: TComponent;
  macrofile: TXMLConfig;
begin
  macrofile := TXMLConfig.Create(nil);
  macrofile.Filename := filename;
  currentmacros := filename;
  if vmode = data_a then
    SaveValueToConfigFile(sConfigRoot,'Data_Macros',currentmacros)
  else if vmode = cw then
    SaveValueToConfigFile(sConfigRoot,'CW_Macros',currentmacros);
	for i := 1 to 16 do
	begin
		btn := Format('btnMacro%.2d',[i]);
		macro := Format('Macro%.2d',[i]);
		c := FindComponent(btn);
		if c <> nil then
		begin
			macrofile.SetValue(macro+'/Caption',TButton(c).Caption);
			macrofile.SetValue(macro+'/Hint',TButton(c).Hint);
			tmp := macros[i];
			repeat
				p := Pos(#13#10,tmp);
				if p > 0 then
				begin
					tmp[p] := '|';
					tmp[p+1] := '|';
				end;
			until p = 0;
			macrofile.SetValue(macro+'/Macro',tmp);
		end;
	end;
  macrofile.Destroy;
end;

procedure TfrmMain.LoadShortcuts(const filename: string);
var
  i, p: integer;
  strtmp: string;
begin
  if FileExists(filename) then
    Shortcuts.LoadFromFile(filename);
  lbShortcuts.Clear;
  i := 0;
  while i < Shortcuts.Count do
  begin
    strtmp := Shortcuts.Strings[i];
    p := Pos('|',strtmp);
    if p > 0 then
      lbShortcuts.Items.Add(Copy(strtmp,1,p-1))
    else
      lbShortcuts.Items.Add(strtmp);
    Inc(i);
  end;
  lbShortcuts.Enabled := true;
end;

procedure TfrmMain.UnloadShortcuts;
begin
  Shortcuts.Clear;
  lbShortcuts.Clear;
  lbShortcuts.Enabled := true;
end;

procedure TfrmMain.SetBandButtonCaption( var Button: TButton );
var
  btn: string;
  b: Integer;
begin
  btn := Button.Name;
  if Length(btn) = 6 then
  begin
    b := StrToIntDef(Copy(btn,5,2),0);
    Button.Caption := GetFromConfigFile(sBand,btn,'Caption',GetBandDefaultFreq(b,0));
    Button.Enabled := connected or fldigiactive;
  end;
end;

procedure TfrmMain.AbortTX;
begin
  if mr_Timer.Enabled or (mr_count > 0) then
  begin
    mr_Timer.Enabled := false;
    mr_count := 0;
    mr_text := '';
    StatusBar.Caption := 'Countdown aborted';
  end;
	txbuf := '';
  // abort transmission
  if txstat > 0 then
  begin
    if (vmode = cw) or ((radio in [k3,kx3]) and (vmode = data_a) and usek3dsp) then
    begin
      if vmode = cw then
        SendSerial('KY @;RX;')
      else
        SendSerial('KY '#3';RX;');
  		btnTxRX.Caption := 'Start sending';
      StatusBar.Caption := 'Aborted sending';
      pp := 15;
    end
    else
    begin
      if connected then
        SendSerial('RX;');
      if fldigiactive then
      begin
        Fldigi_AbortTx;
        Fldigi_ClearTx;
        Fldigi_StopTx;
      end;
    end;
    {$IFDEF WINDOWS}
    if (vmode = data_a) and decodepsk and soundcard_on then
    begin
    	if fnGetTXCharsRemaining() = 0 then
      	fnStopTX
      else
      begin
    		fnAbortTX;
  	    fnClearTXBuffer;
      end;
    end;
    {$ENDIF}
  end;
	TypeAhead.Clear;
	TypeAhead.SetFocus;
  txstat := 0;
end;

function TfrmMain.AllowedChar(ch: char): boolean;
begin
  case vmode of
    cw:               Result := ch in [' ','(','*','+',',','-','.','/','0'..'9','=','?','A'..'Z','_','a'..'z'];
    data_a, unknown:  if decodepsk then
                        Result := (ch >= #32) and (ch < #254)
                      else
                      begin
                        if dmode = 2 then // rtty character set
                          Result := ch in [' '..'$','&'..')','+'..'/','0'..'9',':',';','=','?','A'..'Z','a'..'z']
                        else
                          Result := (ch >= #32) and (ch < #254) and not (ch in [';','<','>']);
                      end;
  else
    Result := false;
  end;
end;

procedure TfrmMain.ProcessMacro(const macrotext: string);
var
	i, j, l, p, q, cs1: integer;
	tmp, ins, mactxt, qtxt, quest: string;
  choices: Array[1..8] of string;
	tx, log, abortit: Boolean;
	ch, ch2: char;
	hh,nn,ss,ms: Word;

  function ContestStyle(const exch: string): string;
  var
  	i: Integer;
  begin
  	Result := exch;
    if Length(Result) > 0 then
    begin
    	for i := 1 to Length(Result) do
      	if Result[i] = '9' then Result[i] := 'N'
        else if Result[i] = '0' then Result[i] := 'T';
    end;
  end;

  procedure ReplaceCWProsigns;
  var
    p: integer;
    umactxt: string;
  begin
    umactxt := UpperCase(mactxt);
    // AR => '+'
    repeat
      p := Pos(' AR ',umactxt);
      if p > 0 then
      begin
        Inc(p);
        Delete(umactxt,p,2);
        Delete(mactxt,p,2);
        Insert('+',umactxt,p);
        Insert('+',mactxt,p);
      end;
    until p = 0;
    // AS => '%'
    repeat
      p := Pos(' AS ',umactxt);
      if p > 0 then
      begin
        Inc(p);
        Delete(umactxt,p,2);
        Delete(mactxt,p,2);
        Insert('%',umactxt,p);
        Insert('%',mactxt,p);
      end;
    until p = 0;
    // BT => '='
    repeat
      p := Pos(' BT ',umactxt);
      if p > 0 then
      begin
        Inc(p);
        Delete(umactxt,p,2);
        Delete(mactxt,p,2);
        Insert('=',umactxt,p);
        Insert('=',mactxt,p);
      end;
    until p = 0;
    // KN => '('
    repeat
      p := Pos(' KN ',umactxt);
      if p > 0 then
      begin
        Inc(p);
        Delete(umactxt,p,2);
        Delete(mactxt,p,2);
        Insert('(',umactxt,p);
        Insert('(',mactxt,p);
      end;
    until p = 0;
    // SK => '*'
    repeat
      p := Pos(' SK ',umactxt);
      if p > 0 then
      begin
        Inc(p);
        Delete(umactxt,p,2);
        Delete(mactxt,p,2);
        Insert('*',umactxt,p);
        Insert('*',mactxt,p);
      end;
    until p = 0;
    // VE => '!'
    repeat
      p := Pos(' VE ',umactxt);
      if p > 0 then
      begin
        Inc(p);
        Delete(umactxt,p,2);
        Delete(mactxt,p,2);
        Insert('!',umactxt,p);
        Insert('!',mactxt,p);
      end;
    until p = 0;
    // remove spaces after AR
    repeat
      p := Pos('+ ',mactxt);
      if p > 0 then
        Delete(mactxt,p+1,1);
    until p = 0;
  end;

begin
  abortit := false;
  mactxt := UTF8ToStr(macrotext,txcharset);
  cs1 := 0;
	if Length(mactxt) > 0 then
	begin
    if vmode = cw then
      ReplaceCWProsigns;
		tx := false;
		log := false;
		tmp := TypeAhead.Text;
  	i := 1;
    l := Length(mactxt);
		while i <= l do
		begin
			ch := mactxt[i];
      if i < l then ch2 := mactxt[i+1] else ch2 := ' ';
      if ((vmode = cw) and cbCWUpperCase.Checked) or (dmode = 2) then
        ch := Upper(ch);
      if AllowedChar(ch) and not((ch in ['^','%']) and (ch2 <> ' ')) then
      begin
				txbuf := txbuf + ch;
				tmp := tmp + StrToUTF8(ch,txcharset);
      end
      else
      begin
  			case ch of
    			'%':	begin
									inc(i);
									ch := mactxt[i];
                  ins := '';
									case ch of
                    'a','A': if ant = 1 then
                              ins := GetValueFromConfigFile(sConfigRoot,'Ant_1','')
                             else
                              ins := GetValueFromConfigFile(sConfigRoot,'Ant_2','');
										'm','M',
                    'y','Y': ins := mycall;
										'c','C': begin
															if edCall.Text = '' then
																edCall.Text := InputBox('Enter call','Type station call below:','');
															ins := edCall.Text;
                              if ins = '' then abortit := true;
														 end;
										'n','N': begin
															if edName.Text = '' then
                                ins := 'OM'
                              else
															  ins := edName.Text;
														 end;
                    'p','P': begin
                              ins := IntToStr(pwr);
                             end;
                    'q','Q': ins := sradio;
										'r','R': begin
															if edRSTs.Text = '' then
                              begin
                                if (vmode = phone) then
                                  edRSTs.Text := '59'
                                else
                                  edRSTs.Text := '599';
                              end;
                              if (vmode = cw) and ((cs1 > 0) or contestmode) then
                                ins := ContestStyle(edRSTs.Text)
                              else
                                ins := edRSTs.Text;
                              Inc(cs1);
														 end;
                    's','S': begin
                              if fldigiactive then
                                ins := Format('KComm v%s by G4ILO, Fldigi v%s',[sVerNo,fldigiversion])
                              else
                                ins := Format('KComm v%s by G4ILO',[sVerNo]);
                             end;
										'x','X': begin
										          if edExchs.Text <> '' then
                              begin
                                if (vmode = cw) then
																  ins := ContestStyle(edExchs.Text)
                                else
                                  ins := edExchs.text;
                              end;
														 end;
										'g','G': begin
															DecodeTime(Now,hh,nn,ss,ms);
															if hh < 12 then
																ins := 'GM'
															else if hh < 18 then
                                ins := 'GA'
															else
																ins := 'GE';
														 end;
                    '?':     begin
                              j := i;
                              while (j < Length(mactxt)) and not (mactxt[j+1]='?') do
                                inc(j);
                              qtxt := Copy(mactxt,i+1,j-i);
                              if qtxt <> '' then
                              begin
                                for q := 1 to 8 do choices[q] := '';
                                q := 0;
                                p := Pos('|',qtxt);
                                if p = 0 then
                                  quest := qtxt
                                else
                                begin
                                  quest := Copy(qtxt,1,p-1);
                                  Delete(qtxt,1,p);
                                  repeat
                                    inc(q);
                                    p := Pos('|',qtxt);
                                    if p > 0 then
                                    begin
                                      choices[q] := Copy(qtxt,1,p-1);
                                      Delete(qtxt,1,p);
                                    end
                                    else
                                    begin
                                      if qtxt <> '' then
                                        choices[q] := qtxt;
                                      qtxt := '';
                                    end;
                                  until qtxt = '';
                                end;
                                if q < 2 then
                                  ins := InputBox('Enter answer','Type '+quest+' below:',choices[1])
                                else
                                begin
                                  with frmChooser do
                                  begin
                                    lbChoices.Clear;
                                    p := 1;
                                    repeat
                                      lbChoices.Items.Add(StrToUTF8(choices[p],txcharset));
                                      inc(p)
                                    until p > q;
                                    frmChooser.Caption := 'Choose '+StrToUTF8(quest,txcharset);
                                    dlgshowing := true;
                                    frmChooser.ShowModal;
                                    dlgshowing := false;
                                    if lbChoices.ItemIndex >= 0 then
                                      ins := lbChoices.Items[lbChoices.ItemIndex];
                                  end;
                                end;
                              end;
                              i := j+1;
                             end;
                  else
                    if (vmode = data_a) then
                      ins := '%'+ch;
									end;
                  if (vmode = cw) and cbCWUpperCase.Checked then
                    ins := UpperCase(ins);
									txbuf := txbuf + UTF8ToStr(ins,txcharset);
									tmp := tmp + ins;
								end;
    			'^':	begin
									inc(i);
									ch := mactxt[i];
									case ch of
									'c','C':	begin                                     // clear tx buffer
															tmp := '';
															txbuf := '';
														end;
                  'i','I':  if (vmode = data_a) and decodepsk then    // send cw ident
                              txbuf := txbuf + Chr(9);
									'l','L':	log := true;                              // save contact to log
									'r','R':  begin                                     // go to receive
                              if (vmode = data_a) and fldigiactive then
                                txbuf := txbuf + '^r' + Chr(254)      // send ^r for Fldigi end of transmission
                              else if (vmode = data_a) and usek3dsp then
                                txbuf := txbuf + Chr(4) + Chr(254)    // send EOT for KY datamode sending
                              else
                                txbuf := txbuf + Chr(254);
                            end;
									's','S':  btnLogStartClick(nil);                    // log start of contact
									't','T':	tx := true;                               // start sending
									'x','X':  logend := true;                           // log end of contact
                  'z','Z':  begin                                     // repeat macro in nn seconds
                              mr_text := macrotext;
                              mr_count := 0;
                              while (i < Length(mactxt)) and (mactxt[i+1] in ['0'..'9']) do
                              begin
                                inc(i);
                                mr_count := mr_count * 10 + (Ord(mactxt[i]) - Ord('0'));
                              end;
                            end;
									end;
                  Delay(50);
								end;
    			#13,
          #10:  begin
                  if vmode = cw then
									  txbuf := txbuf + ' '
                  else
                    txbuf := txbuf + ch;
									tmp := tmp + ch;
								end;
          ';':  begin
                  txbuf := txbuf + ':';
                  tmp := tmp + ch;
                end;
  			end;
      end;
			inc(i);
		end;
    if abortit then Exit;
		TypeAhead.Text := tmp;
		if tx and (txstat = 0) then
      btnTxRxClick(Self);
		if log and (edCall.Text <>'') then
			btnLogSaveClick(nil);
    TypeAhead.SelStart := Length(tmp);
		TypeAhead.SetFocus;
	end;
end;

var
  ctrlpressed: boolean;

procedure TfrmMain.TypeAheadKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ctrlpressed := Shift = [ssCtrl];
  if ctrlpressed and (Key = VK_M) then
    Key := 0;
end;

procedure TfrmMain.TypeAheadKeyPress(Sender: TObject; var Key: char);
begin
  if ((vmode = cw) and cbCWUpperCase.Checked) or (dmode = 2) then
    Key := Upper(Key);
end;

procedure TfrmMain.TypeAheadUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
var
  Key: string;
  k: Char;
begin
  k := #0;
  Key := UTF8ToStr(UTF8Key,txcharset);
  if Length(Key) = 0 then
  begin
    UTF8Key := '';
    Exit;
  end;
  k := Key[1];
(*  if ((vmode = cw) and cbCWUpperCase.Checked) or (dmode = 2) then
  begin
    k := Upper(k);
    UTF8Key := StrToUTF8(k,txcharset);
  end;    *)
  if AllowedChar(k) then
		txbuf := txbuf + k
  else
  begin
  	case k of
	    #8:		begin              if (Length(txbuf) > 0) then
              begin
                if txbuf[Length(txbuf)] = #10 then
                begin
                  Delete(txbuf,Length(txbuf),1);
                  if (Length(txbuf) > 0) and (txbuf[Length(txbuf)] = #13) then
                  Delete(txbuf,Length(txbuf),1);
                end
                else
                  Delete(txbuf,Length(txbuf),1);
              end
              else
              begin
                if (vmode = cw) and (not cwbksp) then
                  txbuf := txbuf + ' EEEEEEEE  '
                else
                  txbuf := txbuf + k;
              end;
            end;
			#13,
      #10:  begin
              if vmode = cw then
                txbuf := txbuf + ' '
              else
                txbuf := txbuf + k;
            end;
      ';':  begin
              k := ':';
              txbuf := txbuf + k;
            end;
    	#22:	TypeAheadPaste(Sender);
    	#27:  AbortTX;
    else
      UTF8Key := '';
    end;
  end;
  cwbksp := k = #8;
end;

procedure TfrmMain.Update_TimerTimer(Sender: TObject);
begin
  if (tx and (vmode = data_a)) then Exit;
  if (mycall = '') or (sradio = '') or (mycall = 'MYCALL') then Exit;
  Update_Timer.Interval := 600000;
  PropThread := TPropThread.Create;
  if Assigned(PropThread.FatalException) then
    raise PropThread.FatalException;
  with PropThread do
  begin
    call := mycall;
    rig := sradio;
    OnPropDataReady := @UpdatePropInfo;
    Resume;
  end;
end;

procedure TfrmMain.UpdatePropInfo;
var
  p: char;

begin
  if Length(PropItems[10]) > 1 then
  begin
    p := PropItems[10,1];
    case p of
    'S':  SunImages.GetBitmap(0,btnProp.Glyph);
    'D':  SunImages.GetBitmap(1,btnProp.Glyph);
    'B':  SunImages.GetBitmap(2,btnProp.Glyph);
    end;
    btnProp.Hint := Format('SSN: %s SF: %s A: %s K: %s Condx: %s',[PropItems[3],PropItems[4],PropItems[5],PropItems[6],PropItems[10]]);
    if Assigned(frmProp) then
      frmProp.UpdateForm;
    if sVerNo < PropItems[0] then
    begin
      StatusBar.Caption := Format('>> KComm version %s now available for download <<',[PropItems[0]]);
      pp := 15;
    end;
  end;
end;

procedure TfrmMain.TypeAheadKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_F1 .. VK_F12:  ProcessMacro(macros[Key - VK_F1 + 1]);
  VK_A:             if (Shift = [ssCtrl]) and (vmode = cw) then ProcessMacro(' AR ');
  VK_B:             if (Shift = [ssCtrl]) and (vmode = cw) then ProcessMacro(' BT ');
  VK_C:             if Shift = [ssCtrl] then ProcessMacro('%c ');
  VK_G:             if Shift = [ssCtrl] then ProcessMacro('%g ');
  VK_K:             if (Shift = [ssCtrl]) and (vmode = cw) then ProcessMacro(' KN ');
  VK_M:             if Shift = [ssCtrl] then ProcessMacro('%m ');
  VK_N:             if Shift = [ssCtrl] then ProcessMacro('%n ');
  VK_R:             if Shift = [ssCtrl] then ProcessMacro('%r ');
  VK_S:             if (Shift = [ssCtrl]) and (vmode = cw) then ProcessMacro(' SK ');
  VK_X:             if Shift = [ssCtrl] then ProcessMacro('%s ');
  end;
end;

procedure TfrmMain.TypeAheadPaste(Sender: TObject);
begin
	if Clipboard.HasFormat(CF_TEXT) then
		ProcessMacro(Clipboard.AsText);
end;

procedure TfrmMain.SetFrequency(f: string; m: integer; extra: string );
var
  p, md, dm: integer;
  fs: string;
begin
  fs := '';
  dm := dmode;
  if m > 0 then
  begin
    if f = '' then
      md := mode
    else if m > 1 then
      md := m
    else if StrToFloat(f) < 10.0 then
      md := 1
    else
      md := 2;
  end;
  if (f <> '') and ValidFreq(f,3) then
  begin
    disablepolling := true;
    Delay(200);
    fs := '00000'+f+'000000';
    p := Pos(DecimalSeparator,fs);
    Delete(fs,p,1);
    if p > 6 then
      Delete(fs,1,p-6);
    fs := 'FA'+Copy(fs,1,11)+';';
    SendSerial(fs);
    Delay(500);
    fs := '';
    if (m > 0) and (Pos('MD',UpperCase(extra)) = 0) then
      fs := Format('MD%d;',[md]);
  end;
  if extra <> '' then
    fs := fs + extra;
  if fs <> '' then
    SendSerial(fs);
  if (radio in [k3,kx3]) and (m in [6,9]) then
  begin
    Delay(500);
    SendSerial(Format('DT%d;',[dm]));
    dmode := dm;
  end;
  if not (frmTrace.Showing and frmTrace.cbDisablePolling.Checked) then
    disablepolling := false;
end;

procedure TfrmMain.SendSerial(s: string);
var
  cmdstr, cmd, c, snd: string;
  p: integer;
begin
  cmdstr := s;
  snd := '';
  repeat
    p := Pos(';',cmdstr);
    if p > 2 then
    begin
      cmd := Copy(cmdstr,1,p);
      c := UpperCase(Copy(cmd,1,2));
      case Pos(c,'WTFAFBDS') of
      1:  begin
            if Length(snd) > 2 then
            begin
              SerialPort.SendString(snd);
              if commtrace then
                frmTrace.AddLine('-> '+snd);
            end;
            Delay(500);
            snd := '';
            cmd := '';
          end;
      3:  if (vfoa = 1) then
          begin
            cmd[1] := 'F';
            cmd[2] := 'B';
          end;
      5:  if (vfoa = 1) then
          begin
            cmd[1] := 'F';
            cmd[2] := 'A';
          end;
      7:  pp := 0;
      end;
      snd := snd + cmd;
      Delete(cmdstr,1,p);
    end
    else
      cmdstr := '';
  until Length(cmdstr) = 0;
  if Length(snd) > 2 then
  begin
    SerialPort.SendString(snd);
    if commtrace then
      frmTrace.AddLine('-> '+snd);
  end;
end;

{$IFNDEF WINDOWS}
procedure TfrmMain.SetupIPC;
begin
  msgid := msgget(TKey(1238), &0666 or IPC_CREAT);
  ipcactive := msgid <> -1;
  if ipcactive then
  begin
    bmpIPC.Visible := true;
    bmpIPC.Transparent := true;
  end;
end;

procedure TfrmMain.GetIPCData;
var
  status: integer;
  msgtyp: longint;
begin
  msgtyp := 0;
  status := msgrcv(msgid, @msgbuf, 1024, msgtyp, MSG_NOERROR or IPC_NOWAIT);
  if (status <> -1) and (msgbuf.mtype = 88) then
  begin
    processingipc := true;
    ProcessIPCData;
    processingipc := false;
  end;
end;

procedure TfrmMain.ProcessIPCData;
var
  p, i: integer;
  msg, msgitem, item, value, mtmp: string;
  dd,mm,yyyy: integer;
  datestr, callstr, freqstr, modestr, rstsstr, rstrstr, namestr, qthstr, gridstr, notes: string;
  ts, tf: TDateTime;
begin
  ts := 0.0; tf := 0.0;
  msg := StrPas(msgbuf.mtext);
  repeat
    p := Pos(#1,msg);
    if p > 0 then
    begin
      msgitem := Copy(msg,1,p-1);
      Delete(msg,1,p);
      p := Pos(':',msgitem);
      if p > 0 then
      begin
        item := UpperCase(Copy(msgitem,1,p-1));
        Delete(msgitem,1,p);
        value := msgitem;
        case Pos(item,'DATENDTIMECALLMHZMODETXRXNAMEQTHLOCATORNOTES') of
        1:  if Length(value) = 11 then
            begin
              dd := StrToIntDef(Copy(value,1,2),0);
              mm := 0;
              mtmp := UpperCase(Copy(value,4,3));
              for i := 1 to 12 do
                if mtmp = UpperCase(ShortMonthNames[i]) then mm := i;
              yyyy := StrToIntDef(Copy(value,8,4),0);
              if (dd<>0) and (mm<>0) and (yyyy<>0) then
                datestr := Format('%4d%s%.2d%s%.2d',[yyyy,DateSeparator,mm,DateSeparator,dd]);
            end;
        3:  if Length(value) = 4 then
              tf := (StrToIntDef(Copy(value,1,2),0)*3600+StrToIntDef(Copy(value,3,2),0)*60) / 86400.0;
        7:  if Length(value) = 4 then
            begin
              ts := (StrToIntDef(Copy(value,1,2),0)*3600+StrToIntDef(Copy(value,3,2),0)*60) / 86400.0;
              tf := ts;
            end;
        11: callstr := UpperCase(value);
        15: freqstr := value;
        18: modestr := value;
        22: rstsstr := value;
        24: rstrstr := value;
        26: if Length(value) > 1 then
              namestr := UpperCase(value[1]) + LowerCase(Copy(value,2,31));
        30: if Length(value) > 1 then
              qthstr := UpperCase(value[1]) + LowerCase(Copy(value,2,31));
        33: if Length(value) >= 4 then
              gridstr := UpperCase(Copy(value,1,2)) + LowerCase(Copy(value,3,4));
        40: notes := value;
        end;
      end;
    end
    else
      msg := '';
  until msg = '';
  FillChar(msgbuf,SizeOf(msgbuf),#0);
  if callstr = 'TEST' then
    StatusBar.Caption := 'IPC communication is working'
  else
  begin
    if (rstsstr <> '') and (rstrstr <> '') then
    begin
      if not qsostarted then
      begin
        btnLogStartClick(Self);
        Delay(200);
      end;
    end;
    if datestr <> '' then edDate.Text := datestr;
    if (ts > 0.0) and (edTime.Text <> '') then
    begin
      timestarted := Trunc(Now)+ts;
      edTime.Text := FormatDateTime('hh:nn',ts);
    end;
    if tf > 0.0 then
      timefinished := Trunc(Now)+tf;
    if callstr <> '' then edCall.Text := callstr;
    if (freqstr <> '') and ValidFreq(freqstr) then edFreq.Text := Format('%5.3f',[StrToFloat(freqstr)]);
    if modestr <> '' then
    begin
      if modestr[1] = 'P' then modestr := 'B' + modestr;
      try
        cbMode.ItemIndex := cbMode.Items.IndexOf(modestr);
      except
      end;
    end;
    if rstsstr <> '' then edRSTs.Text := rstsstr;
    if rstrstr <> '' then edRSTr.Text := rstrstr;
    if namestr <> '' then edName.Text := namestr;
    if qthstr <> '' then edQTH.Text := StringReplace(CapText(qthstr), 'Nr ', 'nr ', [rfReplaceAll]);
    if gridstr <> '' then edGrid.Text := gridstr;
    if notes <> '' then edNotes.Text := notes;
    Delay(200);
    if qsostarted then
      btnLogSaveClick(Self)
    else if (callstr <> '') and (modestr <> '') and (freqstr <> '') then
      edCallExit(Self);
  end;
end;
{$ENDIF}

initialization
  {$I main.lrs}
  {$IFDEF WINDOWS} {$I res\cursors.lrs} {$ENDIF}

end.

