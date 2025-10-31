unit Lesson_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, ComCtrls;

type
  TfrmLesson = class(TForm)
    imgReturn: TImage;
    imgHelp: TImage;
    btnClose: TButton;
    lblQues: TLabel;
    btnCheck: TButton;
    edtAns: TEdit;
    btnStart: TButton;
    btnLearn: TButton;
    lblFeedback: TLabel;
    lblNewPoints: TLabel;
    redOut: TRichEdit;
    imgBack: TImage;
    procedure imgReturnClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnLearnClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  // CONST

var
  frmLesson: TfrmLesson;
  // tJPNum: TextFile;
  iNewPoints, iNum: Integer;
  sQuestion, sAnswer, sTest: String;
  sCorrectMotivation: Array [1 .. 6] of String = (
    'Good Job!',
    'You got it!',
    'On the money!',
    'As expected!',
    'Keep it up!',
    'Excelsior!'
  );
  sIncorrectMotivation: Array [1 .. 6] of String = (
    'Better Luck Next Time!',
    'Lock in!',
    'Skill issue!',
    'Keep trying!',
    'Don`t give up!',
    'Chin up!'
  );

implementation

uses LogIn_U, Dashboard_U, Shop_U, Help_U;
{$R *.dfm}

procedure TfrmLesson.btnCheckClick(Sender: TObject);
Var
  sUser, sPass, sCourses: String;
  iPoints: Integer;
  tFeedback: TextFile;
begin


  // Check if there are more questions

  if Not EOF(frmDash.tLesson) then
  begin

    iNum := Random(6) + 1;

    if UPPERCASE(edtAns.text) = sAnswer then // Check If answer is Correct
    begin
      lblFeedback.Caption := sCorrectMotivation[iNum];
      INC(iNewPoints, 10); // Award Points
      lblNewPoints.Caption := 'Points: + ' + IntTOStr(iNewPoints);
    end
    // END IF Correct
    else // If incorrect
    begin
      lblFeedback.Caption := sIncorrectMotivation[iNum];
    end;
    // END Answer Check

    // Set Up Next question
    edtAns.Clear;
    ReadLN(frmDash.tLesson, sQuestion);
    ReadLN(frmDash.tLesson, sAnswer);
    lblQues.Caption := sQuestion;

  end
  else // If the file is ended
  begin

    ShowMessage('Course Complete!, you earned ' + IntTOStr(iNewPoints)
        + ' new points!');

    frmLesson.Hide;
    frmDash.Show;

    btnStart.Visible := True;
    btnLearn.Visible := True;
    btnCheck.Visible := False;
    frmLesson.btnCheck.Hide;
    frmLesson.edtAns.Hide;
    frmLesson.lblQues.Hide;
    frmLogIn.iPoints := frmLogIn.iPoints + iNewPoints;
    frmDash.lblPoints.Caption := ('Points: ' + IntTOStr(frmLogIn.iPoints));
    CloseFile(frmDash.tLesson);



    // Save New Point Information

    AssignFile(frmLogIn.tUsin, 'Userinfo.txt');
    Reset(frmLogIn.tUsin);
    frmShop.redUserInfo.PlainText := True;

    frmShop.redUserInfo.Lines.Add(frmLogIn.sUser); // Add information to redOut to export to file
    frmShop.redUserInfo.Lines.Add(frmLogIn.sPass);
    frmShop.redUserInfo.Lines.Add(IntTOStr(frmLogIn.iPoints));
    frmShop.redUserInfo.Lines.Add(frmLogIn.sCourses);

    Reset(frmLogIn.tUsin);

    Repeat // Preserve other data in file

      ReadLN(frmLogIn.tUsin, sUser);
      ReadLN(frmLogIn.tUsin, sPass);
      ReadLN(frmLogIn.tUsin, iPoints);
      ReadLN(frmLogIn.tUsin, sCourses);

      if NOT(sUser = frmLogIn.sUser) AND NOT(sPass = frmLogIn.sPass) then
      // begin
      // frmShop.redUserInfo.PlainText := True;
      // end
      // else
      begin
        frmShop.redUserInfo.Lines.Add(sUser);
        frmShop.redUserInfo.Lines.Add(sPass);
        frmShop.redUserInfo.Lines.Add(IntTOStr(iPoints));
        frmShop.redUserInfo.Lines.Add(sCourses);
      end;

    Until EOF(frmLogIn.tUsin);

    CloseFile(frmLogIn.tUsin);
    frmShop.redUserInfo.Lines.SaveToFile('Userinfo.txt'); ;

  end;

end;

procedure TfrmLesson.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLesson.btnLearnClick(Sender: TObject);
begin

  redOut.Clear;
  redOut.Visible := True;
  Reset(frmDash.tLesson);

  while Not EOF(frmDash.tLesson) do    // Display Question and Answe
  begin
    ReadLN(frmDash.tLesson, sQuestion);
    ReadLN(frmDash.tLesson, sAnswer);
    redOut.Lines.Add(sQuestion + #9 + ' - ' + #9 + LowerCase(sAnswer));
  end;

end;

procedure TfrmLesson.btnStartClick(Sender: TObject);
begin

  btnStart.Visible := False;         // Hides uneeded components
  btnLearn.Visible := False;
  redOut.Visible := False;
  btnCheck.Visible := True;
  lblFeedback.Visible := True;
  lblNewPoints.Visible := True;

  Reset(frmDash.tLesson);                                       // Sets up First Question
  ReadLN(frmDash.tLesson, sQuestion);
  ReadLN(frmDash.tLesson, sAnswer);
  lblQues.Caption := sQuestion;
  iNewPoints := 0;

  frmLesson.btnCheck.Show;             // Shows Needed components
  frmLesson.edtAns.Show;
  frmLesson.lblQues.Show;
end;

procedure TfrmLesson.imgHelpClick(Sender: TObject);
begin

  frmLesson.Hide;
  frmHelp.Show;

  // Reset Lesson form for later use
  btnStart.Visible := True;
  btnLearn.Visible := True;
  btnCheck.Visible := False;
  frmLesson.btnCheck.Hide;
  frmLesson.edtAns.Hide;
  frmLesson.lblQues.Hide;
  frmLogIn.iPoints := frmLogIn.iPoints + iNewPoints;
  frmDash.lblPoints.Caption := ('Points: ' + IntTOStr(frmLogIn.iPoints));
  CloseFile(frmDash.tLesson);

end;

procedure TfrmLesson.imgReturnClick(Sender: TObject);
begin

  // Reset Lesson form for later use

  frmLesson.Hide;
  frmDash.Show;

  btnStart.Visible := True;
  btnLearn.Visible := True;
  btnCheck.Visible := False;
  frmLesson.btnCheck.Hide;
  frmLesson.edtAns.Hide;
  frmLesson.lblQues.Hide;
  frmLogIn.iPoints := frmLogIn.iPoints + iNewPoints;
  frmDash.lblPoints.Caption := ('Points: ' + IntTOStr(frmLogIn.iPoints));
  CloseFile(frmDash.tLesson);

end;

end.
