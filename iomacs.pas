unit iomacs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 

function _SIOWR(itype: char; nr,size: DWord): DWord;

implementation

const
  _IOC_WRITE= 1;
  _IOC_READ	= 2;

function _IOC(dir: DWord; itype: char; nr,size: DWord): DWord;
begin
  Result := (dir shl 30) or (size shl 16) or (Ord(itype) shl 8) or nr;
end;

function _SIOWR(itype: char; nr,size: DWord): DWord;
begin
  Result := _IOC(_IOC_READ or _IOC_WRITE,itype,nr,size);
end;

end.

