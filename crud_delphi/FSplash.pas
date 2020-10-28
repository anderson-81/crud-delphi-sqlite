unit FSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TFrmSplash = class(TForm)
    image: TImage;
    timer: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;


implementation

uses FLogin;

{$R *.dfm}

procedure TFrmSplash.Timer1Timer(Sender: TObject);
begin
   try
      FrmLogin := TFrmLogin.create ( Application );
      self.Visible := false;
      Timer.Destroy;
      FrmLogin.ShowModal;
   finally
      FrmLogin.Release;
      FrmLogin := nil;
      self.Close;
   end;
end;

end.
