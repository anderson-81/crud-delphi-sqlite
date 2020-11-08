unit FLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FSplash, UFacade;

type
  TFrmLogin = class(TForm)
    lblUsername: TLabel;
    lblPassword: TLabel;
    txtPassword: TEdit;
    txtUsername: TEdit;
    btnLogin: TButton;
    btnCancel: TButton;
    lblTitle: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure ClearFields;
    function TestFields: integer;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses FPrincipal;

{$R *.dfm}

procedure TFrmLogin.ClearFields;
begin
  txtUsername.text := '';
  txtPassword.text := '';
end;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
  if TestFields = 1 then
  begin
    if TFacade.getInstance.Login(txtUsername.Text, txtPassword.Text) = 1 then
    begin
      try
        FrmPrincipal := TFrmPrincipal.Create(Application);
        Visible := false;
        FrmPrincipal.StatusBar1.Panels[0].Text := 'User logged in: ' +
                                                  txtUsername.Text;
        FrmPrincipal.StatusBar1.Panels[1].Text := DateTimeToStr(Now);
        ClearFields;
        FrmPrincipal.ShowModal;
      except
        FrmPrincipal.Release;
        FrmPrincipal := nil;
      end;
    end
    else
      Application.MessageBox('Invalid username and password.', 'Atention',
                              MB_OK+MB_ICONWARNING);
  end
  else
    Application.MessageBox('Required Fields is empty.', 'Atention',
                            MB_OK+MB_ICONWARNING);
end;

procedure TFrmLogin.btnCancelClick(Sender: TObject);
begin
  if MessageDlg('Do you want to exit the System?', mtConfirmation,
                 [mbyes,mbno],0) = mryes then
    Close;
end;

function TFrmLogin.TestFields: integer;
begin
  if (txtUsername.Text <> '') And (txtPassword.Text <> '') then
    result := 1
  else
    result := 0;
end;

end.
