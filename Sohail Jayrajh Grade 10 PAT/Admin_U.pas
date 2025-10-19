unit Admin_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmAdmin = class(TForm)
    btnUsers: TButton;
    rgpUsers: TRadioGroup;
    btnCustom: TButton;
    redOut: TRichEdit;
    btnClose: TButton;
    procedure btnUsersClick(Sender: TObject);
    procedure btnCustomClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses Lesson_U, Dashboard_U, LogIn_U;
{$R *.dfm}

procedure TfrmAdmin.btnCloseClick(Sender: TObject);
begin
  frmAdmin.Hide;
end;

procedure TfrmAdmin.btnCustomClick(Sender: TObject);
VAR
  sName, sQues, sAns, sNum, path, sline: String;
  tNewCourse, tCMBSelection: Textfile;
  iNum, i: Integer;
begin

  repeat // Get Name of File
    sName := InputBox('Create New Course', 'What is the courses Name?', '');

    if FileExists('Custom\' + sName + '.txt') then // Check if it already exists
    begin
      ShowMessage('A course with that name already exists!');
      sName := '';
    end;
  until Not(sName = '');

  repeat // Get number of questions

    sNum := InputBox('Create New Course', 'How Many Questions?', '0');

    for i := 1 to length(sNum) do // Ensure Whole number is given
    begin

      if NOT(sNum[i] IN ['0' .. '9']) then
      begin
        ShowMessage('Please enter a number');
      end
      else
        iNum := StrToInt(sNum);
    end;

  until (iNum > 0); // Must be > than zero

  AssignFIle(tNewCourse, 'Custom\' + sName + '.txt');
  // Create file and prep for writing
  Rewrite(tNewCourse);

  for i := 1 to iNum do
  begin

    repeat // Get Question and Ensure it's not blank
      sQues := InputBox('Create New Course', 'What is the Question?', '');
    until Not(sQues = '');

    WriteLN(tNewCourse, sQues);

    repeat // Get Question and Ensure it's not blank
      sAns := InputBox('Create New Course', 'What is the Answer?', '');
    until Not(sAns = '');

    WriteLN(tNewCourse, UpperCase(sAns))

  end;

  CloseFile(tNewCourse);

  frmdash.cmbCustom.Items.Add(sName + '.txt');

end;

procedure TfrmAdmin.btnUsersClick(Sender: TObject);
Var
  tFile: Textfile;
  sUser, sPass, sCourses: String;
  iPoints: Integer;
begin

  AssignFIle(frmlogIn.tUsIN, 'UserInfo.txt');
  Reset(frmlogIn.tUsIN);

  repeat
    ReadLN(frmlogIn.tUsIN, sUser);
    ReadLN(frmlogIn.tUsIN, sPass);
    ReadLN(frmlogIn.tUsIN, iPoints);
    ReadLN(frmlogIn.tUsIN, sCourses);
  until frmlogIn.sUser = rgpUsers.Items[rgpUsers.itemindex];

  with redOut do
  begin
    Lines.Clear;
    Lines.Add('Username: ' + #9 + sUser);
    Lines.Add('Password: ' + #9 + sPass);
    Lines.Add('Points: ' + #9 + #9 + IntToStr(iPoints));
    Lines.Add('Password: ' + #9 + sCourses);
  end;

  CloseFile(frmlogIn.tUsIN);

end;

end.
