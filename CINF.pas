unit CINF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFINF = class(TForm)
    L04: TLabel;
    VERL: TLabel;
    L05: TLabel;
    INFM: TMemo;
    BCLS: TButton;
    AUTR: TLabel;
    L06: TLabel;
    procedure BCLSClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FINF: TFINF;

implementation

{$R *.dfm}

procedure TFINF.BCLSClick(Sender: TObject);
begin
FINF.Close;
end;

end.
