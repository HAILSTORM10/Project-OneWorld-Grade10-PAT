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
VAR
  iSpecial: Integer;
  bAllowed: Boolean;
begin

  Repeat

    sUser := InputBox('Create a User', 'What is your name?', '');

    for i := 1 to Length(sUser) do
    begin

      if NOT(sUser[i] IN ['A' .. 'Z', 'a' .. 'z', ' ']) then
      begin // Yes
        ShowMessage('Username cannot contain special characters!');
        bAllowed := False;
      end
      else
      begin
        bAllowed := True;
      end;
    end;

  Until bAllowed = True;

  repeat
  begin

    sPass := InputBox('Create a User', 'What is your password?', '');

    if Length(sPass) <= 8 then // Password Longer (or equal) than 8?
    begin // Yes

      ShowMessage('Password must be atleast 8 characters!');
      // sPass := ' ';

    end; // End Password check

    for i := 1 to Length(sPass) do // Special Characters Check
    begin

      if NOT(sPass[i] IN ['A' .. 'Z', 'a' .. 'z']) then
      begin
        bAllowed := True;
      end
      else
      begin
        bAllowed := False;
      end;
    end; // END FOR Special Check

  end;
  until bAllowed = True; // END Pass While

  AssignFile(tUsin, 'Userinfo.txt'); // Start Saving User Details

  if NOT FILEEXISTS('Userinfo.txt') then // File Exists?
  begin // No, Create it
    Rewrite(tUsin);
  end
  else
  begin // Yes, add to it
    Append(tUsin);
  end; // End if Exists

  WriteLN(tUsin, sUser);
  WriteLN(tUsin, sPass);
  WriteLN(tUsin, '0');
  WriteLN(tUsin, '10001000');
  ShowMessage('User Succesfully Created');

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
    until (EOF(tUsin)) OR (sUser = edtUser.text) AND (sPass = edtPass.text);

    // Admin Check

    if (edtUser.text = 'Admin') AND (edtPass.text = 'Admin@123') then
    begin
      ShowMessage('You got it, boss!');
      frmLogIn.Hide;
      frmDash.show;
      frmDash.btnadmin.visible := True;
      iPoints := 100000;
      sCourses := '11111111';

    end
    else if (sUser = edtUser.text) And (sPass = edtPass.text) then
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
          sAvailableCourses[i].visible := True;
        end
        else
        begin
          sAvailableCourses[i].visible := False;
        end;
      end; // End Course Check

    end // END EXIST CHECK IF
    else if Not(sUser = edtUser.text) then
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
