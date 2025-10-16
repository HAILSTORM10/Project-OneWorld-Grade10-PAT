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

//CONST


var
  frmLesson: TfrmLesson;
  tJPNum: TextFile;
  iNewPoints, iNum: Integer;
  sQuestion, sAnswer, sTest: String;
  sCorrectMotivation: Array of String;

  sIncorrectMotivation: Array [1 .. 6] of string = ('Better luck next time!',
    'Lock in!', 'Skill issue!', 'Keep trying!', 'Don`t give up!', 'Chin up!');

implementation

uses LogIn_U, Dashboard_U, Shop_U;
{$R *.dfm}

procedure TfrmLesson.btnCheckClick(Sender: TObject);
Var
  sUser, sPass: String;
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

    edtAns.Clear;
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
    btnCheck.Visible := False;
    frmLesson.btnCheck.Hide;
    frmLesson.edtAns.Hide;
    frmLesson.lblQues.Hide;
    frmLogIn.iPoints := frmLogIn.iPoints + iNewPoints;
    frmDash.lblPoints.Caption := ('Points: ' + IntTOStr(frmLogIn.iPoints));
    CloseFile(frmDash.tLesson);



// Save New Point Information

    AssignFile(frmlogin.tUsin, 'Userinfo.txt');
    Reset(frmlogin.tUsin);
    frmShop.redUserInfo.PlainText := True;

    frmShop.redUserInfo.Lines.Add(frmlogin.sUser);
    frmShop.redUserInfo.Lines.Add(frmlogin.sPass);
    frmShop.redUserInfo.Lines.Add(IntTOStr(frmlogin.iPoints));
    frmShop.redUserInfo.Lines.Add(frmlogin.sCourses);

    Reset(frmlogin.tUsin);

    Repeat
      ReadLN(frmlogin.tUsin, sUser);
      ReadLN(frmlogin.tUsin, sPass);
      ReadLN(frmlogin.tUsin, frmlogin.iPoints);
      ReadLN(frmlogin.tUsin, frmlogin.sCourses);

      if (sUser = frmlogin.sUser) AND (sPass = frmlogin.sPass) then
      begin
        frmShop.redUserInfo.PlainText := True;
      end
      else
      begin
        frmShop.redUserInfo.Lines.Add(sUser);
        frmShop.redUserInfo.Lines.Add(sPass);
        frmShop.redUserInfo.Lines.Add(IntTOStr(frmlogin.iPoints));
        frmShop.redUserInfo.Lines.Add(frmlogin.sCourses);
      end;
    Until EOF(frmlogin.tUsin);

    CloseFile(frmlogin.tUsin);
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
  btnCheck.Visible := True;
  lblFeedback.Visible := True;
  lblNewPoints.Visible := True;


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
