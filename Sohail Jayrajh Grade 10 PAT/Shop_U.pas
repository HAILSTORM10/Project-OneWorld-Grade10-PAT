unit Shop_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, pngimage, ExtCtrls;

type
  TfrmShop = class(TForm)
    redUserInfo: TRichEdit;
    imgReturn: TImage;
    chkJPDays: TCheckBox;
    chkJPMonths: TCheckBox;
    chkJPNouns: TCheckBox;
    chkAfriNouns: TCheckBox;
    chkAfriMonths: TCheckBox;
    chkAfriDays: TCheckBox;
    bntBuy: TButton;
    chkJPNum: TCheckBox;
    chkAfriNum: TCheckBox;
    lblPrice: TLabel;
    Image1: TImage;
    btnClose: TButton;
    imgHelp: TImage;
    procedure imgReturnClick(Sender: TObject);
    procedure bntBuyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShop: TfrmShop;
   sChkBoxes: array [1 .. 8] of TCheckBox; // Global to be used in frmDash

implementation

uses LogIn_U, Dashboard_U, Help_U;
{$R *.dfm}

procedure TfrmShop.bntBuyClick(Sender: TObject);
VAR
  sUser, sPass, sCourses: String;
  i, iPoints: integer;
begin


  redUserInfo.Clear;
  sUser := frmlogin.sUser;
  sPass := frmlogin.sPass;

  for i := 1 to 8 do
  begin

    // If an item is checked, buy it

    if sChkBoxes[i].Checked = True then
    begin

      if frmlogin.iPoints >= 200 then // Check if user Has enough points
      begin

        frmlogin.iPoints := frmlogin.iPoints - 200;
        frmlogin.sCourses[i] := '1';

      end
      else
      begin
        ShowMessage('You do not have enough points!');
      end; // End Point Check


      // Hides Purchased items

      if frmlogin.sCourses[i] = '0' then
      begin
        sChkBoxes[i].Visible := True;
      end
      else
      begin
        sChkBoxes[i].Checked := False;
        sChkBoxes[i].Visible := False;
      end;
    end; // End Purchase IF

  end; // END For

  // Display new infromation on Dashboard
  frmDash.lblPoints.Caption := ('Points: ' + IntTOStr(frmlogin.iPoints));

  for i := 1 to 8 do // Enable New Buttons
  begin
    if frmlogin.sCourses[i] = '1' then
    begin
      sAvailableCourses[i].Visible := True;
    end
    else
    begin
      sAvailableCourses[i].Visible := False;
    end;
  end; // End New buttons

  // Save New Points and Course Information
  AssignFile(frmlogin.tUsin, 'Userinfo.txt');
  Reset(frmlogin.tUsin);
  redUserInfo.PlainText := True;

  redUserInfo.Lines.Add(frmlogin.sUser);
  redUserInfo.Lines.Add(frmlogin.sPass);
  redUserInfo.Lines.Add(IntTOStr(frmlogin.iPoints));
  redUserInfo.Lines.Add(frmlogin.sCourses);

  Reset(frmlogin.tUsin);

  Repeat
    ReadLN(frmlogin.tUsin, sUser);
    ReadLN(frmlogin.tUsin, sPass);
    ReadLN(frmlogin.tUsin, iPoints);
    ReadLN(frmlogin.tUsin, sCourses);

    if (sUser <> frmlogin.sUser) AND (sPass <> frmlogin.sPass) then
    begin
      redUserInfo.Lines.Add(sUser);
      redUserInfo.Lines.Add(sPass);
      redUserInfo.Lines.Add(IntTOStr(iPoints));
      redUserInfo.Lines.Add(frmlogin.sCourses);
    end;
  Until EOF(frmlogin.tUsin);

  CloseFile(frmlogin.tUsin);
  redUserInfo.Lines.SaveToFile('Userinfo.txt'); ;

end;


procedure TfrmShop.btnCloseClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfrmShop.imgHelpClick(Sender: TObject);
Var
  tReviews: Textfile;
  sReviews: String;
begin
frmShop.Hide;
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

procedure TfrmShop.imgReturnClick(Sender: TObject);
begin
  frmShop.Hide;
  frmDash.Show;
  frmDash.lblPoints.Caption := 'Points: ' + IntTOStr(frmlogin.iPoints);
end;

end.
