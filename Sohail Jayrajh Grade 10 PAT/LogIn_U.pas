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
    iPoints: Integer;
    tUsin: TextFile;
    sUser, sPass, sCourses: String;
  end;

var
  frmLogIn: TfrmLogIn;
  i: Integer;
  bExists: Boolean;
  sAvailableCourses: Array [1 .. 8] of TButton;

implementation

uses Dashboard_U, Help_U, Welcome_U;
{$R *.dfm}

procedure TfrmLogIn.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogIn.btnCreateClick(Sender: TObject);
begin

  AssignFile(tUsin, 'Userinfo.txt');

  if NOT FILEEXISTS('Userinfo.txt') then
  begin
    Rewrite(tUsin);
    WriteLN(tUsin, edtUser.Text);
    WriteLN(tUsin, edtPass.Text);
    WriteLN(tUsin, '0');
    WriteLN(tUsin, '10001000');
    ShowMessage('User Succesfully Created');
  end
  else
  begin
    Append(tUsin);
    WriteLN(tUsin, edtUser.Text);
    WriteLN(tUsin, edtPass.Text);
    WriteLN(tUsin, '0');
    WriteLN(tUsin, '10001000');
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
    AssignFile(tUsin, 'Userinfo.txt'); // Clossed in Shop_U  No it isn't
    Reset(tUsin);

    repeat
      ReadLN(tUsin, sUser);
      ReadLN(tUsin, sPass);
      ReadLN(tUsin, iPoints);
      ReadLN(tUsin, sCourses);
    until (EOF(tUsin)) OR (sUser = edtUser.Text) AND (sPass = edtPass.Text);

    // Admin Check

    if (edtUser.Text = 'Admin') AND (edtPass.Text = 'Admin@123') then
    begin
      ShowMessage('You got it, boss!');
      frmLogIn.Hide;
      frmDash.show;
      frmDash.btnadmin.visible := true;
      iPoints := 100000;
      sCourses := '11111111';

    end
    else if (sUser = edtUser.Text) And (sPass = edtPass.Text) then
    // Normal user Check
    begin
      ShowMessage('Succsess!');
      frmLogIn.Hide;
      frmDash.show;

      // Checks what courses should be available to this user

      sAvailableCourses[1] := frmDash.btnJapNum;
      sAvailableCourses[2] := frmDash.btnJapDays;
      sAvailableCourses[3] := frmDash.btnJapMonths;
      sAvailableCourses[4] := frmDash.btnJapNouns;
      sAvailableCourses[5] := frmDash.btnAfriNum;
      sAvailableCourses[6] := frmDash.btnAfriDays;
      sAvailableCourses[7] := frmDash.btnAfriMonths;
      sAvailableCourses[8] := frmDash.btnAfriNouns;

      for i := 1 to 8 do
      begin
        if sCourses[i] = '1' then
        begin
          sAvailableCourses[i].visible := true;
        end
        else
        begin
          sAvailableCourses[i].visible := False;
        end;
      end; // End Course Check

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
