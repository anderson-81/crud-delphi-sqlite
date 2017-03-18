unit FLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FSplash, Cadastro;

type
  TFrmLogin = class(TForm)
    txtLogin: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtPass: TEdit;
    btnLogin: TButton;
    btnCancel: TButton;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure ClearFields;
    function TestFields : integer;
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
   self.txtLogin.text := '';
   self.txtPass.text := '';
end;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
   if self.TestFields = 1 then
   begin
      if TCadastro.Efetuar_Login(self.txtLogin.Text, self.txtPass.Text) = 1 then
      begin
        try
          FrmPrincipal := TFrmPrincipal.create (Application);
          self.Visible := false;
          FrmPrincipal.StatusBar1.Panels[0].Text := 'User logged in: ' + self.txtLogin.Text;
          FrmPrincipal.StatusBar1.Panels[1].Text := DateTimeToStr(Now);
          ClearFields;
          FrmPrincipal.ShowModal;
        except
          FrmPrincipal.Release;
          FrmPrincipal := nil;
        end;
      end
      else
        Application.MessageBox('No Authorization', 'Atention', MB_OK+MB_ICONWARNING);
   end
   else
       Application.MessageBox('Required Fields is empty.', 'Atention', MB_OK+MB_ICONWARNING);
end;

procedure TFrmLogin.btnCancelClick(Sender: TObject);
begin
    if MessageDlg('Do you want to exit the System?', mtConfirmation, [mbyes,mbno],0) = mryes then
    begin
       self.Close;
    end;
end;

function TFrmLogin.TestFields : integer;
begin
   if (self.txtLogin.Text <> '') AND (self.txtPass.Text <> '') then
      result := 1
   else
      result := 0;
end;

end.
