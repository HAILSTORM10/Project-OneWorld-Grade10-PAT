unit Jap_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

type
  TfrmJap = class(TForm)
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
    procedure imgReturnClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  CONST
    sCorrectMotivation : Array[1..6] of String = ('Good Job1', 'You got it!', 'On the money!', 'As expected!', 'Keep it up!', 'Excelsior!');
    sIncorrectMotivation : Array[1..6] of string = ('Better luck next time!', 'Lock in!', 'Skill issue!', 'Keep trying!', 'Don`t give up!', 'Chin up!');
var
  frmJap: TfrmJap;
  tJPNum: TextFile;
  iNewPoints, iNum : Integer;
  sQuestion, sAnswer, sTest: String;


implementation

uses LogIn_U, Dashboard_U;
{$R *.dfm}

procedure TfrmJap.btnCheckClick(Sender: TObject);
begin

  // Check if there are more questions

  if Not EOF(frmDash.tJP) then
  begin

     iNum := Random(6)+1 ;

    if UPPERCASE(
    edtAns.text) = sAnswer then     // Check If answer is Correct
    begin
      lblFeedback.Caption := sCorrectMotivation[iNum];
      INC(iNewPoints, 10);
      lblNewPoints.Caption := 'Points: + ' + IntTOStr(iNewPoints);
    end // END IF Correct
    else
    begin
      lblFeedback.Caption := sIncorrectMotivation[iNum];
    end;  // END Answer Check

    ReadLN(frmDash.tJP, sQuestion);
    ReadLN(frmDash.tJP, sAnswer);
    lblQues.Caption := sQuestion;
  end
  else
  begin
  ShowMessage('Course Complete!, you earned ' + IntToStr(iNewPoints) + ' new points!');
  frmJAP.Hide;
  FrmDash.Show         ;
  frmLogIn.iPoints := frmLogIn.iPoints + iNewPoints;
  FrmDash.lblPoints.Caption := ('Points: ' + IntToStr(frmLogIn.iPoints));
  CloseFile(frmDash.tJP);
  end;

end;

procedure TfrmJap.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmJap.btnStartClick(Sender: TObject);
begin

  reset(frmDash.tJP);
  ReadLN(frmDash.tJP, sQuestion);
  ReadLN(frmDash.tJP, sAnswer);
  lblQues.Caption := sQuestion;
  iNewPoints := 0;

  frmJap.btnCheck.Show;
  frmJap.edtAns.Show;
  frmJap.lblQues.Show;
end;

procedure TfrmJap.imgReturnClick(Sender: TObject);
begin
  frmJap.Hide;
  frmDash.Show;
end;

end.
