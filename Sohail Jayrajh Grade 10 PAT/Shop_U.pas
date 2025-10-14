unit Shop_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, pngimage, ExtCtrls;

type
  TfrmShop = class(TForm)
    btnBuyDays: TButton;
    lblDays: TLabel;
    lblMonths: TLabel;
    lblNouns: TLabel;
    btnBuyMonths: TButton;
    btnBuyNouns: TButton;
    redUserInfo: TRichEdit;
    imgReturn: TImage;
    procedure btnBuyDaysClick(Sender: TObject);
    procedure imgReturnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShop: TfrmShop;

implementation

uses LogIn_U, Dashboard_U;
{$R *.dfm}

procedure TfrmShop.btnBuyDaysClick(Sender: TObject);
Var
  sUser, sPass: String;
begin

  redUserInfo.Clear;
  sUser := frmlogin.sUser;
  sPass := frmlogin.sPass;

  if frmlogin.sCourses[2] = '0' then
  begin

    frmlogin.iPoints := frmlogin.iPoints - 200;

    frmlogin.sCourses[2] := '1';

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
      ReadLN(frmlogin.tUsin, frmlogin.iPoints);
      ReadLN(frmlogin.tUsin, frmlogin.sCourses);

      if (sUser = frmlogin.sUser) AND (sPass = frmlogin.sPass) then
      begin
        redUserInfo.PlainText := True;
      end
      else
      begin
        redUserInfo.Lines.Add(sUser);
        redUserInfo.Lines.Add(sPass);
        redUserInfo.Lines.Add(IntTOStr(frmlogin.iPoints));
        redUserInfo.Lines.Add(frmlogin.sCourses);
      end;
    Until EOF(frmlogin.tUsin);

    // while NOT(sUser = frmlogin.sUser) AND NOT(sPass = frmlogin.sPass) do
    // begin
    //
    // end; // END While check

    // Repeat
    // begin
    //
    // ReadLN(frmlogin.tUsin, sUser);
    // ReadLN(frmlogin.tUsin, sPass);
    // ReadLN(frmlogin.tUsin, frmlogin.iPoints);
    // ReadLN(frmlogin.tUsin, frmlogin.sCourses);
    //
    // redUserInfo.Lines.Add(sUser);
    // redUserInfo.Lines.Add(sPass);
    // redUserInfo.Lines.Add(IntTOStr(frmlogin.iPoints));
    // redUserInfo.Lines.Add(frmlogin.sCourses);
    // end;
    // Until EOF(frmlogin.tUsin); // END  Repeat

    CloseFIle(frmlogin.tUsin);
    redUserInfo.Lines.SaveToFile('Userinfo.txt'); ;
  end
  else
    Showmessage('You already own this!');

end;

procedure TfrmShop.imgReturnClick(Sender: TObject);
begin
  frmShop.Hide;
  frmDash.Show;
  frmDash.lblPoints.Caption := 'Points: ' + IntTOStr(frmlogin.iPoints);
end;

end.
