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
    procedure imgReturnClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnLearnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

CONST
  sCorrectMotivation: Array [1 .. 6] of String = ('Good Job1', 'You got it!',
    'On the money!', 'As expected!', 'Keep it up!', 'Excelsior!');
  sIncorrectMotivation: Array [1 .. 6] of string = ('Better luck next time!',
    'Lock in!', 'Skill issue!', 'Keep trying!', 'Don`t give up!', 'Chin up!');

var
  frmLesson: TfrmLesson;
  tJPNum: TextFile;
  iNewPoints, iNum: Integer;
  sQuestion, sAnswer, sTest: String;

implementation

uses LogIn_U, Dashboard_U;
{$R *.dfm}

procedure TfrmLesson.btnCheckClick(Sender: TObject);
begin

  // Check if there are more questions

  if Not EOF(frmDash.tLesson) then
  begin

    iNum := Random(6) + 1;

    if UPPERCASE(edtAns.text) = sAnswer then // Check If answer is Correct
    begin
      lblFeedback.Caption := sCorrectMotivation[iNum];
      INC(iNewPoints, 10);
      lblNewPoints.Caption := 'Points: + ' + IntTOStr(iNewPoints);
    end // END IF Correct
    else
    begin
      lblFeedback.Caption := sIncorrectMotivation[iNum];
    end; // END Answer Check

    ReadLN(frmDash.tLesson, sQuestion);
    ReadLN(frmDash.tLesson, sAnswer);
    lblQues.Caption := sQuestion;
  end
  else
  begin
    ShowMessage('Course Complete!, you earned ' + IntTOStr(iNewPoints)
        + ' new points!');

    frmLesson.Hide;
    frmDash.Show;

    btnStart.Visible := True;
    btnLearn.Visible := True;
    frmLesson.btnCheck.Hide;
    frmLesson.edtAns.Hide;
    frmLesson.lblQues.Hide;
    frmLogIn.iPoints := frmLogIn.iPoints + iNewPoints;
    frmDash.lblPoints.Caption := ('Points: ' + IntTOStr(frmLogIn.iPoints));
    CloseFile(frmDash.tLesson);

    AssignFile(frmLogIn.tUsin, 'Userinfo.txt');
    reset(frmLogIn.tUsin);
    redOut.PlainText := True;
    redOut.Lines.Add(frmLogIn.sUser);
    redOut.Lines.Add(frmLogIn.sPass);
    redOut.Lines.Add(IntTOStr(frmLogIn.iPoints));

    Repeat
    begin



    end;
    Until EOF(frmLogIn.tUsin);

      redOut.Lines.Savetofile('Userinfo.txt');

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
  reset(frmDash.tLesson);

  while Not EOF(frmDash.tLesson) do
  begin
    ReadLN(frmDash.tLesson, sQuestion);
    ReadLN(frmDash.tLesson, sAnswer);
    redOut.Lines.Add(sQuestion + #9 + ' - ' + #9 + LowerCase(sAnswer));
  end;

end;

procedure TfrmLesson.btnStartClick(Sender: TObject);
begin

  btnStart.Visible := False;
  btnLearn.Visible := False;
  redOut.Visible := False;

  reset(frmDash.tLesson);
  ReadLN(frmDash.tLesson, sQuestion);
  ReadLN(frmDash.tLesson, sAnswer);
  lblQues.Caption := sQuestion;
  iNewPoints := 0;

  frmLesson.btnCheck.Show;
  frmLesson.edtAns.Show;
  frmLesson.lblQues.Show;
end;

procedure TfrmLesson.imgReturnClick(Sender: TObject);
begin
  frmLesson.Hide;
  frmDash.Show;
end;

end.
