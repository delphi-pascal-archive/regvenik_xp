library PdkLibXP;

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, Registry;

{$R *.res}

function Info: PChar; StdCall;
begin
Result:=
'AUT=TB'+#13#10+
'VER=1.00'+#13#10+
'INF=Добавляет в контекстное меню Windows XP пункты о подключении или отключении файлов библиотек...'+#13#10+
'PRS=NO';
end;

procedure Venik; StdCall;
var
 Reg: TRegistry;
begin
try
 Reg:=TRegistry.Create;
 Reg.RootKey:=HKEY_CLASSES_ROOT;
 Reg.OpenKey('ocxfile\Shell\Регистрация\command',True);
 Reg.WriteString('','regsvr32.exe \"%1\"');
 Reg.CloseKey;
 Reg.Free;
 Reg:=TRegistry.Create;
 Reg.RootKey:=HKEY_CLASSES_ROOT;
 Reg.OpenKey('ocxfile\Shell\Анрегистрация\command',True);
 Reg.WriteString('','@="regsvr32.exe /u \"%1\""');
 Reg.CloseKey;
 Reg.Free;
 Beep;
 Application.MessageBox('Действие было выполнено успешно!!!','ProgSelect.dll',MB_TOPMOST+MB_ICONINFORMATION);
except
 Beep;
 Application.MessageBox('Действие было выполнено с ошибкой!!!','ProgSelect.dll',MB_TOPMOST+MB_ICONERROR);
end;
end;

exports
 Info,
 Venik;

begin
end.
