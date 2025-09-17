unit Shop_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmShop = class(TForm)
    btnBuyDays: TButton;
    lblDays: TLabel;
    lblMonths: TLabel;
    lblNouns: TLabel;
    btnBuyMonths: TButton;
    btnBuyNouns: TButton;
    redUserInfo: TRichEdit;
    procedure btnBuyDaysClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShop: TfrmShop;

implementation

uses LogIn_U;
{$R *.dfm}

procedure TfrmShop.btnBuyDaysClick(Sender: TObject);
Var
  sUser, sPass, sPoints, sCourse: String;
begin

  if frmLogIn.sCourses[2] = '0' then
  begin

    frmLogIn.sCourses[2] := '1';

    AssignFile(frmLogIn.tUsin, 'Userinfo.txt');
    redUserInfo.PlainText := True;
    redUserInfo.Lines.Add(frmLogIn.sUser);
    redUserInfo.Lines.Add(frmLogIn.sPass);
    redUserInfo.Lines.Add(IntTOStr(frmLogIn.iPoints));
    redUserInfo.Lines.Add(frmLogIn.sCourses);

    Repeat
    begin
      ReadLN(frmLogIn.tUsin, sUser);
      ReadLN(frmLogIn.tUsin, sPass);
      ReadLN(frmLogIn.tUsin, sPoints);
      ReadLN(frmLogIn.tUsin, sCourse);

      redUserInfo.Lines.Add(sUser);
      redUserInfo.Lines.Add(sPass);
      redUserInfo.Lines.Add(sPoints);
      redUserInfo.Lines.Add(sCourse);
    end;
    Until EOF(frmLogIn.tUsin); ;

    redUserINfo.lines.SaveToFile('Userinfo.txt');

  end;

end;

end.
