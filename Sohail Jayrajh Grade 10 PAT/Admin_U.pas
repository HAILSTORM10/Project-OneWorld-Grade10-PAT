unit Admin_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmAdmin = class(TForm)
    btnFeedback: TButton;
    rgpFeedback: TRadioGroup;
    edtFeedback: TEdit;
    procedure btnFeedbackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses Lesson_U;
{$R *.dfm}

procedure TfrmAdmin.btnFeedbackClick(Sender: TObject);
Var
  tFile: TextFile;
begin




  // Add Items to Feedback in Lesson

  // if rgpFeedback.ItemIndex < 1 then // If no item selected
  // begin
  //
  // ShowMessage('Please Select Feedback Type');
  //
  // end // End No Item
  // else if rgpFeedback.ItemIndex = 1 then // If Positive selected
  // begin
  //
  //
  //
  // end
  // else
  // SHowMessage('This Message Already Exists!');

  case rgpFeedback.ItemIndex of
    1: // If Positive is Chosen
      begin

        AssignFile(tFile, 'Admin Config\Positive Feedback.txt');

        if Not FileExists('Admin Config\Positive Feedback.txt') then
        begin

          Rewrite(tFile);
          WriteLN(tFile, edtFeedback.text);

        end
        else
        begin

          Append(tFile);
          WriteLN(tFile, edtFeedback.text);

        end;
      end; // END Case 1

  end; // End Process

end;

end.
