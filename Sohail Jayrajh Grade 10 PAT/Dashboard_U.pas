unit Dashboard_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, jpeg;

type
  TfrmDash = class(TForm)
    btnClose: TButton;
    lblHeader: TLabel;
    imgHelp: TImage;
    imgBack: TImage;
    imgReturn: TImage;
    lblPoints: TLabel;
    lblJAP: TLabel;
    lblAfri: TLabel;
    btnJapNum: TButton;
    btnAfriNum: TButton;
    btnAdmin: TButton;
    btnJapDays: TButton;
    btnJapMonths: TButton;
    btnJapNouns: TButton;
    btnAfriDays: TButton;
    btnAfriMonths: TButton;
    btnAfriNouns: TButton;
    imgShop: TImage;
    lblCustom: TLabel;
    cmbCustom: TComboBox;
    btnCustom: TButton;
    imgRate: TImage;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
    procedure imgReturnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnJapNumClick(Sender: TObject);
    procedure btnJapDaysClick(Sender: TObject);
    procedure btnJapMonthsClick(Sender: TObject);
    procedure btnJapNounsClick(Sender: TObject);
    procedure btnAfriNumClick(Sender: TObject);
    procedure btnAfriDaysClick(Sender: TObject);
    procedure btnAfriMonthsClick(Sender: TObject);
    procedure btnAfriNounsClick(Sender: TObject);
    procedure imgShopClick(Sender: TObject);
    procedure btnCustomClick(Sender: TObject);
    procedure btnAdminClick(Sender: TObject);
    procedure imgRateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tLesson: Textfile; // File Closed in Lesson_U

  end;

var
  frmDash: TfrmDash;

implementation

uses Help_U, LogIn_U, Lesson_U, Shop_U, Admin_U;
{$R *.dfm}

procedure TfrmDash.btnAdminClick(Sender: TObject);
VAr
  sUser, sPass, sCourses: String;
  iPoints: integer;
begin

  frmDash.Hide;
  frmAdmin.show;

end;

procedure TfrmDash.btnAfriDaysClick(Sender: TObject);
begin
  // Load File For Days and Preps Scene
  AssignFile(tLesson, 'Afri\AfriDays.txt');
  frmLesson.show;
  frmDash.Hide;
end;

procedure TfrmDash.btnAfriMonthsClick(Sender: TObject);
begin

  // Load File For Months and Preps Scene
  AssignFile(tLesson, 'Afri\AfriMonths.txt');
  frmLesson.show;
  frmDash.Hide;

end;

procedure TfrmDash.btnAfriNounsClick(Sender: TObject);
begin
  // Load File For Nouns and Preps Scene
  AssignFile(tLesson, 'Afri\AfriNouns.txt');
  frmLesson.show;
  frmDash.Hide;

end;

procedure TfrmDash.btnAfriNumClick(Sender: TObject);
begin
  // Load File For Numbers and Preps Scene
  AssignFile(tLesson, 'Afri\AfriNumbers.txt');
  frmLesson.show;
  frmDash.Hide;
end;

procedure TfrmDash.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmDash.btnCustomClick(Sender: TObject);
VAR
  sCustomLesson: String;
begin

  // Loads file For a custom lesson

  AssignFile(tLesson, 'Custom\' + cmbCustom.items[cmbCustom.ItemIndex]);
  frmLesson.show;
  frmDash.Hide;

end;

procedure TfrmDash.btnJapDaysClick(Sender: TObject);
begin

  // Load File For Days and Preps Scene
  AssignFile(tLesson, 'Jap\JPDays.txt');
  frmLesson.show;
  frmDash.Hide;
end;

procedure TfrmDash.btnJapMonthsClick(Sender: TObject);
begin

  // Load File For Months and Preps Scene
  AssignFile(tLesson, 'Jap\JPMonths.txt');
  frmLesson.show;
  frmDash.Hide;

end;

procedure TfrmDash.btnJapNounsClick(Sender: TObject);
begin

  // Load File For Nouns and Preps Scene
  AssignFile(tLesson, 'Jap\JPNouns.txt');
  frmLesson.show;
  frmDash.Hide;

end;

procedure TfrmDash.btnJapNumClick(Sender: TObject);
begin

  // Load File For Numbers and Preps Scene
  AssignFile(tLesson, 'Jap\JPNumbers.txt');
  frmLesson.show;
  frmDash.Hide;

end;

procedure TfrmDash.Button1Click(Sender: TObject);
begin
  ShowMessage(frmlogIn.sUser);
end;

procedure TfrmDash.FormCreate(Sender: TObject);
begin
  imgBack.SendToBack;
  lblHeader.Caption := ('Good to See you Again, ' + frmlogIn.sUser + ' !');
end;

procedure TfrmDash.imgHelpClick(Sender: TObject);
Var
  tReviews: Textfile;
  sReviews: String;
begin
  frmDash.Hide;
  frmHelp.show;

  frmHelp.redReviews.Lines.clear;   // Load Reviews

  if FileExists('Reviews.txt') then
  begin
    AssignFile(tReviews, 'Reviews.txt');
    Reset(tReviews);

    while NOT EOF(tReviews) do
    begin
      ReadLn(tReviews, sReviews);
      frmHelp.redReviews.Lines.Add(sReviews);
    end;

    CloseFile(tReviews);
  end
  else
  frmHelp.redReviews.Lines.Add('Be the first to leave a review using your dashboard!');

end;

procedure TfrmDash.imgRateClick(Sender: TObject);
VAr
  sReview, sRating: String;
  rRating: Real;
  i: integer;
  cAllowed: Char;
  tReviews: Textfile;
begin
  // Prompt User to enter a few words
  sReview := InputBox('Give us a Review!', 'How do you feel about the app?',
    '');

  if sReview = '' then
  begin
    ShowMessage('Please Write something!');
    exit;
  end;

  sRating := InputBox('Give us a Review!', 'Rate the app out of 100', ' ');
  // Ask for rating between 0 - 100

  for i := 1 to Length(sRating) do

    if sRating[i] IN ['0' .. '9'] then
    begin
      cAllowed := 'Y';
    end
    else
      cAllowed := 'N';

  if (cAllowed = 'Y') AND NOT(StrToFloat(sRating) > 100) then
  // Did they enter a valid number
  begin
    rRating := StrToFloat(sRating);
    rRating := rRating / 10;
  end
  else
  begin
    ShowMessage('Enter only numbers less than 100');
    exit;
  end;
  // Add Rating to RichEdit in The Help form


  if Not FIleExists('Reviews.txt') then
     begin
       frmHelp.redReviews.Lines.clear;
     end;

  frmHelp.redReviews.Lines.Add('"' + sReview + '" ' + FloatToStrF(rRating,
      FFFixed, 8, 1) + '/10 - ' + frmlogIn.sUser);

  frmHelp.redReviews.Lines.SaveToFile('Reviews.txt'); // Saves to reviews file
  //
  // AssignFile(tReviews, 'Reviews.txt');      // updates review
  // Reset(tReviews);

end;

procedure TfrmDash.imgReturnClick(Sender: TObject);

begin
  frmDash.Hide;
  frmlogIn.show;
  btnAdmin.Visible := False;

  frmLogin.bLoggedIN := False; // Logs out user

end;

procedure TfrmDash.imgShopClick(Sender: TObject);
Var
  i: integer;

begin

  frmShop.show;
  frmDash.Hide;

  // Adds Check Boxes to Array for shop

  sChkBoxes[1] := frmShop.chkJPNum;
  sChkBoxes[2] := frmShop.chkJPDays;
  sChkBoxes[3] := frmShop.chkJPMonths;
  sChkBoxes[4] := frmShop.chkJPNouns;
  sChkBoxes[5] := frmShop.chkAfriNum;
  sChkBoxes[6] := frmShop.chkAfriDays;
  sChkBoxes[7] := frmShop.chkAfriMonths;
  sChkBoxes[8] := frmShop.chkAfriNouns;

  // Hides Purchased items
  for i := 1 to 8 do
  begin
    if frmlogIn.sCourses[i] = '0' then
    begin
      sChkBoxes[i].Visible := True;
    end
    else
    begin
      sChkBoxes[i].Checked := False;
      sChkBoxes[i].Visible := False;
    end;
  end; // End Purchase IF

end;

end.
