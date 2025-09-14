program PAT_P;

uses
  Forms,
  Welcome_U in 'Welcome_U.pas' {frmWelcome},
  LogIn_U in 'LogIn_U.pas' {frmLogIn},
  Dashboard_U in 'Dashboard_U.pas' {frmDash},
  Help_U in 'Help_U.pas' {frmHelp},
  Jap_U in 'Jap_U.pas' {frmJap};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelcome, frmWelcome);
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(TfrmDash, frmDash);
  Application.CreateForm(TfrmHelp, frmHelp);
  Application.CreateForm(TfrmJap, frmJap);
  Application.Run;
end.
