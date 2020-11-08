unit FPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, FRegistration, FSearch, FLogin, DB, ADODB, RXShell,
  jpeg, ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Registration1: TMenuItem;
    PhysicalPerson1: TMenuItem;
    oRegister1: TMenuItem;
    oSearch1: TMenuItem;
    Report1: TMenuItem;
    PopupMenu1: TPopupMenu;
    RxTrayIcon1: TRxTrayIcon;
    Image1: TImage;
    Exit2: TMenuItem;
    N1: TMenuItem;
    MinimizetoTrayIcon1: TMenuItem;
    procedure oRegister1Click(Sender: TObject);
    procedure oSearch1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Report1Click(Sender: TObject);
    procedure RxTrayIcon1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure MinimizetoTrayIcon1Click(Sender: TObject);
  private
    { Private Attributes }
    flagClose : integer;
    formLogin: TFrmLogin;
    { Private Methods    }
    procedure HideForTrayIcon;
  public
    { Public Methods     }
    Constructor Create(formLogin : TFrmLogin); overload;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses FReport;

{$R *.dfm}

Constructor TFrmPrincipal.Create(formLogin: TFrmLogin);
begin
  self.formLogin := formLogin;
end;

procedure TFrmPrincipal.oRegister1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmRegistration, FrmRegistration);
    FrmRegistration.ShowModal;
  finally
    FrmRegistration.Release;
    FrmRegistration := nil;
  end;
end;

procedure TFrmPrincipal.oSearch1Click(Sender: TObject);
var
  FrmSearch : TFrmSearch;
begin
  try
    FrmSearch := TFrmSearch.Create(Application);
    FrmSearch.ShowModal;
  finally
    if flagClose <> 1 then
    begin
      FrmSearch.Release;
      FrmSearch := nil;
    end;
  end;
end;

procedure TFrmPrincipal.HideForTrayIcon;
begin
  Hide;
  RxTrayIcon1.Show;
  flagClose := 1;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Do you want to exit the System?', mtConfirmation,
     [mbyes,mbno],0) = mryes then
    Application.Terminate
  else
  begin
    MessageDlg('Minimized to tray icon.', mtInformation, [mbOK],0);
    HideForTrayIcon;
  end;
end;

procedure TFrmPrincipal.Report1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmReport, FrmReport);
    FrmReport.CreateReport;
  finally
    FrmReport.Release;
    FrmReport := nil;
  end;
end;

procedure TFrmPrincipal.RxTrayIcon1DblClick(Sender: TObject);
begin
  Show;
  RxTrayIcon1.Hide;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  RxTrayIcon1.Hide;
end;

procedure TFrmPrincipal.Exit1Click(Sender: TObject);
begin
  if MessageDlg('Do you want to exit the System?', mtConfirmation,
                 [mbyes,mbno],0) = mryes then
    Application.Terminate;
end;

procedure TFrmPrincipal.MinimizetoTrayIcon1Click(Sender: TObject);
begin
  HideForTrayIcon;
end;

end.                                                                                                         |
