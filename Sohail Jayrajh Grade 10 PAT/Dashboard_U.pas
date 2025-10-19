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
  private
    { Private declarations }
  public
    { Public declarations }
    tLesson: Textfile; // File Closed in Lesson_U
    // sActiveCourse : string;
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

  frmAdmin.show;

  // Preps rgpUsers

  AssignFile(frmlogIn.tUsIN, 'UserInfo.txt');
  Reset(frmlogIn.tUsIN);

  while NOT EOF(frmlogIn.tUsIN) do
  begin

    ReadLN(frmlogIn.tUsIN, sUser);
    ReadLN(frmlogIn.tUsIN, sPass);
    ReadLN(frmlogIn.tUsIN, iPoints);
    ReadLN(frmlogIn.tUsIN, sCourses);

    frmAdmin.rgpUsers.items.add(sUser); // Puts Users in radio group

  end;

  CloseFile(frmlogIn.tUsIN);

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
begin
  frmDash.Hide;
  frmHelp.show;
end;

procedure TfrmDash.imgReturnClick(Sender: TObject);
begin
  frmDash.Hide;
  frmlogIn.show;
end;

procedure TfrmDash.imgShopClick(Sender: TObject);
Var
i : integer;

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
