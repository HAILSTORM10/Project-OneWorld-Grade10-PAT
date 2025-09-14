unit LogIn_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TfrmLogIn = class(TForm)
    btnLogin: TButton;
    lblUser: TLabel;
    lblPass: TLabel;
    edtUser: TEdit;
    edtPass: TEdit;
    lblLogin: TLabel;
    btnClose: TButton;
    imgHelp: TImage;
    imgReturn: TImage;
    btnCreate: TButton;
    imgBack: TImage;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure imgReturnClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iPoints : Integer;
  end;

//  CONST
//  sCourseOptions : Array[1..3] of string = ('Test', 'Yeah, test', 'wow, an array') ;

var
  frmLogIn: TfrmLogIn;
  tUsin: TextFile;
  sUser, sPass: String;
  i : Integer;
  bExists: Boolean;

implementation

uses Dashboard_U, Help_U, Welcome_U;
{$R *.dfm}

procedure TfrmLogIn.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogIn.btnCreateClick(Sender: TObject);
begin

  if NOT FILEEXISTS('Userinfo.txt') then
  begin
    AssignFile(tUsin, 'Userinfo.txt');
    Rewrite(tUsin);
    WriteLN(tUsin, edtUser.Text);
    WriteLN(tUsin, edtPass.Text);
    WriteLN(tUsin, '0');
    ShowMessage('User Succesfully Created');
  end
  else
  begin
    AssignFile(tUsin, 'Userinfo.txt');
    Append(tUsin);
    WriteLN(tUsin, edtUser.Text);
    WriteLN(tUsin, edtPass.Text);
    WriteLN(tUsin, '0');
    ShowMessage('User Succesfully Created');
  end;
  CloseFile(tUsin);
end;

procedure TfrmLogIn.btnLoginClick(Sender: TObject);
begin

  if NOT FILEEXISTS('Userinfo.txt') then
  begin
    ShowMessage('Please Create a User');
  end
  else
  begin
    AssignFile(tUsin, 'Userinfo.txt');
    Reset(tUsin);

    repeat
      ReadLN(tUsin, sUser);
      ReadLN(tUsin, sPass);
      ReadLN(tUsin, iPoints);
    until (EOF(tUsin)) OR (sUser = edtUser.Text) AND (sPass = edtPass.Text);

    // Admin Check

    if (edtUser.Text = 'Admin')  AND (edtPass.Text = 'Admin@123')then
    begin
     ShowMessage('You got it, boss!');
      frmLogIn.Hide;
      frmDash.show;
      frmDash.btnadmin.visible := true ;
    end
    else if (sUser = edtUser.Text) And (sPass = edtPass.Text) then // Normal user Check
    begin
      ShowMessage('Succsess!');
      frmLogIn.Hide;
      frmDash.show;
    end // END EXIST CHECK IF
    else if Not(sUser = edtUser.Text) then
    begin
      ShowMessage('Username Does Not Exist!');
    end
    else
    begin
      ShowMessage('Password is Incorrect!');
    end; // END EVERYTHING

    CloseFile(tUsin);
    frmDash.lblHeader.caption := ('Good to See you Again, ' + sUser + ' !');
    frmDash.lblPoints.caption := ('Points: ' + IntToStr(iPoints));
  end;
end;

procedure TfrmLogIn.FormCreate(Sender: TObject);
begin
imgBack.SendToBack;
end;

procedure TfrmLogIn.imgHelpClick(Sender: TObject);
begin
  frmLogIn.Hide;
  frmHelp.show;
end;

procedure TfrmLogIn.imgReturnClick(Sender: TObject);
begin
  frmLogIn.Hide;
  frmWelcome.show;
end;

end.
