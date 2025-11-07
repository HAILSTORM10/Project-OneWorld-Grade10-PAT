unit Admin_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, pngimage, Spin;

type
  TfrmAdmin = class(TForm)
    btnUsers: TButton;
    rgpUsers: TRadioGroup;
    btnCustom: TButton;
    redOut: TRichEdit;
    btnClose: TButton;
    imgReturn: TImage;
    imgHelp: TImage;
    spnCustom: TSpinEdit;
    edtCustom: TEdit;
    lblCustom: TLabel;
    imgTest: TImage;
    lbxDeleteCourse: TListBox;
    btnDeleteCourse: TButton;
    lblDeleteCourse: TLabel;
    Label1: TLabel;
    procedure btnUsersClick(Sender: TObject);
    procedure btnCustomClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure imgReturnClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
    procedure btnDeleteCourseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses Lesson_U, Dashboard_U, LogIn_U, Help_U;
{$R *.dfm}

procedure TfrmAdmin.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmAdmin.btnCustomClick(Sender: TObject);
VAR
  sName, sQues, sAns: String;
  tNewCourse: Textfile;
  iNumQuestions, i: Integer;
begin

  sName := edtCustom.Text;

  if sName = '' then // Check if Name is Suitable
  begin
    ShowMessage('Please name your course using the provided edit box');
    exit;
  end
  else if FileExists('Custom\' + sName + '.txt') then
  begin
    ShowMessage('A course with that name already exists!');
    exit;
  end
  else // If it is suitable, move on
  begin
    iNumQuestions := spnCustom.Value;
  end;

  AssignFIle(tNewCourse, 'Custom\' + sName + '.txt');
  // Create file and prep for writing
  Rewrite(tNewCourse);

  for i := 1 to iNumQuestions do
  begin

    repeat // Get Question and Ensure it's not blank
      sQues := InputBox('Create New Course', 'What is the Question?', '');
      if sQues = '' then
        showMessage('Please enter something');
    until Not(sQues = '');

    WriteLN(tNewCourse, sQues);

    repeat // Get Question and Ensure it's not blank
      sAns := InputBox('Create New Course', 'What is the Answer?', '');
      if sQues = '' then
        showMessage('Please enter something');
    until Not(sAns = '');

    WriteLN(tNewCourse, UpperCase(sAns))

  end;

  CloseFile(tNewCourse);

  frmdash.cmbCustom.Items.Add(sName + '.txt');
  lbxDeleteCourse.Items.Add(sName + '.txt');

end;

procedure TfrmAdmin.btnDeleteCourseClick(Sender: TObject);
VAR
  sConfirm: String;
begin

  if lbxDeleteCourse.ItemIndex = -1 then // Ensure a course is selected
  begin
    ShowMessage('Select a course above');
  end
  else
  begin

    sConfirm := InputBox('You are about to delete a course!',
      // Get confirmation from user
      'Once a course is deleted, it cannot be restored!' + #13 + #13 + ' Delete it? Yes/No',
      'No');

    if UpperCase(sConfirm) = 'YES' then // If Confirmed, move on
    begin

      frmdash.cmbCustom.Items.Delete(lbxDeleteCourse.ItemIndex);
      DeleteFile('Custom\' + lbxDeleteCourse.Items[lbxDeleteCourse.ItemIndex]);
      lbxDeleteCourse.Items.Delete(lbxDeleteCourse.ItemIndex);
      ShowMessage('Successfully deleted course!');

    end
    else // Don't delete course
      ShowMessage('Understood, the course will not be deleted');

  end;

end;

procedure TfrmAdmin.btnUsersClick(Sender: TObject);
Var
  sUser, sPass, sCourses: String;
  iPoints: Integer;
begin

  if rgpUsers.ItemIndex = -1 then // Ensure that a user is selected
  begin
    ShowMessage('No User selected');
    exit;
  end;

  AssignFIle(frmlogIn.tUsIN, 'UserInfo.txt');
  Reset(frmlogIn.tUsIN);

  repeat
    ReadLN(frmlogIn.tUsIN, sUser); // Read information until User is matched
    ReadLN(frmlogIn.tUsIN, sPass);
    ReadLN(frmlogIn.tUsIN, iPoints);
    ReadLN(frmlogIn.tUsIN, sCourses);
  until sUser = rgpUsers.Items[rgpUsers.ItemIndex];

  with redOut do // Display Users information
  begin
    Lines.Clear;
    Lines.Add('Username: ' + #9 + sUser);
    Lines.Add('Password: ' + #9 + sPass);
    Lines.Add('Points: ' + #9 + #9 + IntToStr(iPoints));
    Lines.Add('Password: ' + #9 + sCourses);
  end;

  CloseFile(frmlogIn.tUsIN);

end;

procedure TfrmAdmin.imgHelpClick(Sender: TObject);
Var
  tReviews: Textfile;
  sReviews: String;
begin
  frmAdmin.Hide;
  frmhelp.show;

  frmhelp.redReviews.Lines.Clear; // Load Reviews

  if FileExists('Reviews.txt') then
  begin
    AssignFIle(tReviews, 'Reviews.txt');
    Reset(tReviews);

    while NOT EOF(tReviews) do
    begin
      ReadLN(tReviews, sReviews);
      frmhelp.redReviews.Lines.Add(sReviews);
    end;

    CloseFile(tReviews);
  end
  else
    frmhelp.redReviews.Lines.Add(
      'Be the first to leave a review using your dashboard!');

end;

procedure TfrmAdmin.imgReturnClick(Sender: TObject);
begin
  frmAdmin.Hide;
  frmdash.show;
end;

end.
