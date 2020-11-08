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
  public
  end;

var
  FrmSplash: TFrmSplash;

implementation

uses FLogin;

{$R *.dfm}

procedure TFrmSplash.Timer1Timer(Sender: TObject);
begin
  try
    FrmLogin := TFrmLogin.create(Application);
    Visible := false;
    Timer.Destroy;
    FrmLogin.ShowModal;
  finally
    FrmLogin.Release;
    FrmLogin := nil;
    Close;
  end;
end;

end.
