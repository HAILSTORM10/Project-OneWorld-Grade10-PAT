unit Welcome_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, IOUtils;

type
  TfrmWelcome = class(TForm)
    btnGo: TButton;
    lblWelcome: TLabel;
    lblSubWelcome: TLabel;
    Button1: TButton;
    imgBack: TImage;
    imgHelp: TImage;
    procedure btnGoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelcome: TfrmWelcome;

implementation

uses LogIn_U, Help_U, Lesson_U, Dashboard_U;
{$R *.dfm}

procedure TfrmWelcome.btnGoClick(Sender: TObject);
Var
  tSetUp: TextFile;
  sLine, path: String;
begin
  frmWelcome.Hide;
  frmLogIN.Show;

  for path in TDirectory.GetFiles('Custom\') do
  begin
    frmdash.cmbCustom.Items.Add(Copy(path, 8, POS('.txt', path) - 4))
  end;





end;

procedure TfrmWelcome.Button1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmWelcome.FormCreate(Sender: TObject);
begin
  imgBack.SendToBack;
end;

procedure TfrmWelcome.imgHelpClick(Sender: TObject);
begin
  frmWelcome.Hide;
  frmHelp.Show;
end;

end.
