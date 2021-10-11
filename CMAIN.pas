unit CMAIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls;

type
  TFMAIN = class(TForm)
    XPM: TXPManifest;
    ACTL: TComboBox;
    BOK: TButton;
    BINF: TButton;
    BEX: TButton;
    PRS: TMemo;
    L01: TLabel;
    L02: TLabel;
    L: TListBox;
    procedure BEXClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ACTLSelect(Sender: TObject);
    procedure BINFClick(Sender: TObject);
    procedure BOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMAIN: TFMAIN;
  DLLLIST: TStrings;

type
 TInfo=function: PChar;
 TVenik=procedure;

implementation

uses CINF;

{$R *.dfm}

procedure GetDllInfoTxt;
begin
FINF.AUTR.Caption:=FMAIN.L.Items.Values['AUT'];
FINF.VERL.Caption:=FMAIN.L.Items.Values['VER'];
FINF.INFM.Text:=FMAIN.L.Items.Values['INF'];
end;

procedure GetDllInfoPrs;
var
 HndDLLHandle: THandle;
 Info: TInfo;
 N: Integer;
begin
N:=0;
try
 HndDLLHandle:=LoadLibrary(PChar(FMAIN.ACTL.Items.Strings[FMAIN.ACTL.ItemIndex]+'.dll'));
 if HndDLLHandle<>0 then
  begin
   @Info:=GetProcAddress(HndDLLHandle,'Info');
   if Addr(Info)<>nil then
    begin
     FMAIN.L.Items.Clear;
     FMAIN.L.Items.SetText(Info);
     if FMAIN.L.Items.Values['PRS']='NO' then
      begin
       FMAIN.PRS.Clear;
      end
     else
      begin
       if FMAIN.L.Items.Count>4 then
        begin
         N:=4;
         FMAIN.PRS.Clear;
         while N<>FMAIN.L.Items.Count do
          begin
           FMAIN.PRS.Lines.Add(FMAIN.L.Items.Strings[N]);
           N:=N+1;
          end;
        end;
      end;
    end
   else Application.MessageBox('Function not exists...','RegVenik XP',MB_TOPMOST+MB_ICONERROR);
  end
 else
 Application.MessageBox('DLL not found...','RegVenik XP',MB_TOPMOST+MB_ICONERROR);
finally
 FreeLibrary(HndDLLHandle);
end;
end;  

procedure ShowFilesACTL(Folder: String; Mask: String; Atr: Integer);
var
 SR: TSearchRec;
 S: String;
begin
if FindFirst(Folder+'\'+Mask,Atr,SR)=0 then
 repeat
  begin
   S:=SR.Name;
   Delete(S,Length(S)-3,4);
   FMAIN.ACTL.Items.Add(S);
  end
 until FindNext(SR)<>0;
FindClose(SR);
end;

procedure StartVenik;
var
 HndDLLHandle: THandle;
 Venik: TVenik;
begin
FMAIN.PRS.Lines.SaveToFile('Prs.tmp');
try
 HndDLLHandle:=LoadLibrary(PChar(FMAIN.ACTL.Items.Strings[FMAIN.ACTL.ItemIndex]+'.dll'));
 if HndDLLHandle<>0 then
  begin
   @Venik:=GetProcAddress(HndDLLHandle,'Venik');
   if Addr(Venik)<>nil then
    begin
     Venik;
    end
   else Application.MessageBox('Function not exists...','RegVenik XP',MB_TOPMOST+MB_ICONERROR);
  end
 else
 Application.MessageBox('DLL not found...','RegVenik XP',MB_TOPMOST+MB_ICONERROR);
finally
 FreeLibrary(HndDLLHandle);
end;
end;

procedure TFMAIN.BEXClick(Sender: TObject);
begin
FMAIN.Close;
end;

procedure TFMAIN.FormCreate(Sender: TObject);
begin
ShowFilesACTL(SysUtils.GetCurrentDir,'*.dll',faAnyFile);
if ACTL.Items.Count<>0 then
 begin
  ACTL.ItemIndex:=0;
  GetDllInfoPrs;
 end;
end;

procedure TFMAIN.ACTLSelect(Sender: TObject);
begin
GetDllInfoPrs;
end;

procedure TFMAIN.BINFClick(Sender: TObject);
begin
GetDllInfoTxt;
FINF.ShowModal;
end;

procedure TFMAIN.BOKClick(Sender: TObject);
begin
StartVenik;
end;

end.
