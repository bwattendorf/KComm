unit prop;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF UNIX}
  CThreads,
  {$ENDIF}
  Classes, SysUtils;

type
  TPropItems = array[0..11] of string;

  TPropDataReadyEvent = procedure of object;

  TPropThread = class(TThread)
  protected
    procedure Execute; override;
  public
    call, rig: string;
    OnPropDataReady: TPropDataReadyEvent;
    constructor Create;
  end;

var
  PropThread: TPropThread;
  PropItems: TPropItems;
  (*
    PropItems[0]:   KComm latest version number
    PropItems[1]:   not used
    PropItems[2]:   WWV update date
    PropItems[3]:   Daily sunspot number
    PropItems[4]:   10.7cm solar flux
    PropItems[5]:   A index (+ delta)
    PropItems[6]:   K index (+ delta)
    PropItems[7]:   LF propagation forecast
    PropItems[8]:   MF propagation forecast
    PropItems[9]:   HF propagation forecast
    PropItems[10]:  Solar forecast (short)
    PropItems[11]:  Solar forecast (long)
  *)

implementation

uses
  HTTPSend, SynaCode, Main, Utils;

const
  propurl = 'http://www.g4ilo.com/kcomm_chk.php?call=%s&rig=%s&platform=%s&version=%s';

constructor TPropThread.Create;
begin
	FreeOnTerminate := true;
  OnPropDataReady := nil;
  inherited Create(true);
end;

procedure TPropThread.Execute;
var
  i, p: integer;
  res: TStringList;
  data, platform: string;
begin
  res := TStringList.Create;
  try
    {$IFDEF WINDOWS}
      platform := WinVerString[Ord(GetWinVersion)];
    {$ELSE}
      platform := 'Linux';
    {$ENDIF}
    if HttpGetText(Format(propurl,[call,EncodeURL(rig),EncodeURL(platform),sVerNo]),res) then
    begin
      data := res.Text;
      i := 0;
      repeat
        p := Pos('|',data);
        if p > 0 then
        begin
          PropItems[i] := StripTags(Copy(data,1,p-1));
          Delete(data,1,p);
        end;
        Inc(i);
      until (p=0) or (i > 11);
      if Assigned(OnPropDataReady) then
        Synchronize(OnPropDataReady);
    end;
  finally
    res.Destroy;
  end;
end;

end.

