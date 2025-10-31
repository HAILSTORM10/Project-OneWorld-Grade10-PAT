unit Help_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, pngimage, ExtCtrls;

type
  TfrmHelp = class(TForm)
    btnClose: TButton;
    redGeneral: TRichEdit;
    imgBack: TImage;
    imgHelp: TImage;
    pgcHelp: TPageControl;
    General: TTabSheet;
    Welcome: TTabSheet;
    redWelcome: TRichEdit;
    LogIn: TTabSheet;
    redLogin: TRichEdit;
    TabSheet1: TTabSheet;
    Lessons: TTabSheet;
    Shop: TTabSheet;
    TabSheet2: TTabSheet;
    redDash: TRichEdit;
    redLesson: TRichEdit;
    redShop: TRichEdit;
    redAdmin: TRichEdit;
    TabSheet3: TTabSheet;
    redReviews: TRichEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure imgHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHelp: TfrmHelp;

implementation

uses LogIn_U;

{$R *.dfm}

procedure TfrmHelp.btnCloseClick(Sender: TObject);
begin
Application.Terminate
end;

procedure TfrmHelp.imgHelpClick(Sender: TObject);
begin
frmHelp.Hide;
frmlogin.show;
end;

end.
