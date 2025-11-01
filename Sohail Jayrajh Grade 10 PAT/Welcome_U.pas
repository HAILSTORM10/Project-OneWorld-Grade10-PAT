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
  tSetUp, tReviews: TextFile;
  sLine, path, sReviews: String;
begin
  frmWelcome.Hide;
  frmLogIN.Show;

  for path in TDirectory.GetFiles('Custom\') do
  // List custom courses on Dashboard
  begin
    frmdash.cmbCustom.Items.Add(Copy(path, 8, POS('.txt', path) - 4))
  end;

  // Load Reviews

  if FileExists('Reviews.txt') then
  begin

    AssignFile(tReviews, 'Reviews.txt');
    Reset(tReviews);
    frmHelp.redReviews.Lines.clear;

    while NOT EOF(tReviews) do
    begin
      ReadLn(tReviews, sReviews);
      frmHelp.redReviews.Lines.Add(sReviews);
    end;

    CloseFile(tReviews);
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
Var
  tReviews: TextFile;
  sReviews: String;
begin
  frmWelcome.Hide;
  frmHelp.Show;



  // Load Reviews

  if FileExists('Reviews.txt') then
  begin

    AssignFile(tReviews, 'Reviews.txt');
    Reset(tReviews);
    frmHelp.redReviews.Lines.clear;
    while NOT EOF(tReviews) do
    begin
      ReadLn(tReviews, sReviews);
      frmHelp.redReviews.Lines.Add(sReviews);
    end;

    CloseFile(tReviews);
  end;

end;

end.
