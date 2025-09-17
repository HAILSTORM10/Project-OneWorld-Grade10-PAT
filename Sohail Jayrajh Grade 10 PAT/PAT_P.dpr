program PAT_P;

uses
  Forms,
  Welcome_U in 'Welcome_U.pas' {frmWelcome},
  LogIn_U in 'LogIn_U.pas' {frmLogIn},
  Dashboard_U in 'Dashboard_U.pas' {frmDash},
  Help_U in 'Help_U.pas' {frmHelp},
  Lesson_U in 'Lesson_U.pas' {frmLesson},
  Shop_U in 'Shop_U.pas' {frmShop};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmDash, frmDash);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TfrmLesson, frmLesson);
  Application.CreateForm(TfrmShop, frmShop);
  Application.Run;
end.
