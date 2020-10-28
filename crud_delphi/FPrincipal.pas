unit FPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, FRegistration, FSearch, DB, ADODB, RXShell;

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
    Exit2: TMenuItem;
    RxTrayIcon1: TRxTrayIcon;
    procedure oRegister1Click(Sender: TObject);
    procedure oSearch1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Report1Click(Sender: TObject);
    procedure RxTrayIcon1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    flagClose : integer;
    //formLogin: TFrmLogin; 
    { Private declarations }

    procedure HideForTrayIcon;
   
  public
    { Public declarations }
    //Constructor Create (formLogin : TFrmLogin);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses FReport;

{$R *.dfm}

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
      FrmSearch := TFrmSearch.Create (Application);
      FrmSearch.ShowModal;
   finally
      if(flagClose <> 1) then
      begin
        FrmSearch.Release;
        FrmSearch := nil;
      end;
   end;
end;

procedure TFrmPrincipal.Exit1Click(Sender: TObject);
begin
   if MessageDlg('Do you want to exit the System?', mtConfirmation, [mbyes,mbno],0) = mryes then
   begin
       Application.Terminate;
   end;
end;

procedure TFrmPrincipal.HideForTrayIcon;
begin
   self.Hide;
   self.RxTrayIcon1.Show;
   self.flagClose := 1;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
   if MessageDlg('Do you want to exit the System?', mtConfirmation, [mbyes,mbno],0) = mryes then
   begin
      Application.Terminate;
   end
   else
      Self.HideForTrayIcon;
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
   self.Show;
   self.RxTrayIcon1.Hide;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
   self.RxTrayIcon1.Hide; 
end;

end.                                                                                                         |
