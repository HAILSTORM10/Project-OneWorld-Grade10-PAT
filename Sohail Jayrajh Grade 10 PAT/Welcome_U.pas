unit Welcome_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

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

uses LogIn_U, Help_U;

{$R *.dfm}

procedure TfrmWelcome.btnGoClick(Sender: TObject);
begin
frmWelcome.Hide;
frmLogIN.Show;
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
