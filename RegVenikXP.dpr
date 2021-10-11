program RegVenikXP;

uses
  Forms,
  CMAIN in 'CMAIN.pas' {FMAIN},
  CINF in 'CINF.pas' {FINF};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RegVenik XP';
  Application.CreateForm(TFMAIN, FMAIN);
  Application.CreateForm(TFINF, FINF);
  Application.Run;
end.
