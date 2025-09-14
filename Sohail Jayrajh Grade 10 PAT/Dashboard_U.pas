unit Dashboard_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls;

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
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
    procedure imgReturnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnJapNumClick(Sender: TObject);
    procedure btnJapDaysClick(Sender: TObject);
    procedure btnJapMonthsClick(Sender: TObject);
    procedure btnJapNounsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tJP : Textfile;
//    sActiveCourse : string;
  end;

var
  frmDash: TfrmDash;

implementation

uses Help_U, LogIn_U, Jap_U;

{$R *.dfm}

procedure TfrmDash.btnCloseClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfrmDash.btnJapDaysClick(Sender: TObject);
begin

//Load File For Days and Preps Scene
AssignFile(tJP, 'Jap\JPDays.txt');
frmJap.btnCheck.hide;
frmJap.edtANS.hide;
frmJap.lblQues.hide;
frmJap.Show;
frmDash.Hide;
end;

procedure TfrmDash.btnJapMonthsClick(Sender: TObject);
begin

//Load File For Months and Preps Scene
AssignFile(tJP, 'Jap\JPMonths.txt');
frmJap.btnCheck.hide;
frmJap.edtANS.hide;
frmJap.lblQues.hide;
frmJap.Show;
frmDash.Hide;

end;

procedure TfrmDash.btnJapNounsClick(Sender: TObject);
begin

//Load File For Nouns and Preps Scene
AssignFile(tJP, 'Jap\JPNouns.txt');
frmJap.btnCheck.hide;
frmJap.edtANS.hide;
frmJap.lblQues.hide;
frmJap.Show;
frmDash.Hide;

end;

procedure TfrmDash.btnJapNumClick(Sender: TObject);
begin

//Load File For Numbers and Preps Scene
AssignFile(tJP, 'Jap\JPNumbers.txt');
frmJap.btnCheck.hide;
frmJap.edtANS.hide;
frmJap.lblQues.hide;
frmJap.Show;
frmDash.Hide;

end;

procedure TfrmDash.Button1Click(Sender: TObject);
begin
ShowMessage(sUser);
end;

procedure TfrmDash.FormCreate(Sender: TObject);
begin
imgBack.SendToBack;
lblHeader.Caption := ('Good to See you Again, ' + sUser + ' !') ;
end;


procedure TfrmDash.imgHelpClick(Sender: TObject);
begin
frmDash.Hide;
frmHelp.Show;
end;

procedure TfrmDash.imgReturnClick(Sender: TObject);
begin
frmDash.Hide;
frmLogin.show;
end;

end.
