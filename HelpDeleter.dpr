library HelpDeleter;

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, Registry;

{$R *.res}

function Info: PChar; StdCall;
begin
Result:=
'AUT=TB'+#13#10+
'VER=1.00'+#13#10+
'INF=Удаляет из меню "Пуск" пункт "Справка и поддержка"...                Для удаления измените параметр "DO=X" на "DO=X", для добавки на "DO=V"...'+#13#10+
'PRS=OK'+#13#10+
'DO=X';
end;

procedure Venik; StdCall;
var
 Reg: TRegistry;
 S: TStringList;
begin
try
 S:=TStringList.Create;
 S.LoadFromFile('PRS.tmp');
 if S.Values['DO']='X' then
  begin
   Reg:=TRegistry.Create;
   Reg.RootKey:=HKEY_CURRENT_USER;
   Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',False);
   Reg.WriteInteger('NoSMHelp',1);
   Reg.CloseKey;
   Reg.Free;
  end
 else
  if S.Values['DO']='V' then
   begin
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\Explorer',False);
    Reg.WriteInteger('NoSMHelp',0);
    Reg.CloseKey;
    Reg.Free;
   end;
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
