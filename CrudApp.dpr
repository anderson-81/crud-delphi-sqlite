program CrudApp;

uses
  Forms,
  UPerson in 'models\UPerson.pas',
  UPhysicalPerson in 'models\UPhysicalPerson.pas',
  UPhysicalPersonList in 'models\UPhysicalPersonList.pas',
  UJuridicalPerson in 'models\UJuridicalPerson.pas',
  UUser in 'models\UUser.pas',
  UAppController in 'controllers\UAppController.pas',
  UPersonController in 'controllers\UPersonController.pas',
  UPhysicalPersonController in 'controllers\UPhysicalPersonController.pas',
  UUserController in 'controllers\UUserController.pas',
  UFacade in 'facades\UFacade.pas',
  UFacadeValidationData in 'facades\UFacadeValidationData.pas',
  UFactory in 'factories\UFactory.pas',
  UDataSourceFactory in 'factories\UDataSourceFactory.pas',
  md5 in 'libs\md5.pas',
  PCRE in 'libs\PCRE.pas',
  pcre_dll in 'libs\pcre_dll.pas',
  TrayIcon in 'libs\TrayIcon.pas',
  FLogin in 'forms\FLogin.pas' {FrmLogin},
  FPrincipal in 'forms\FPrincipal.pas' {FrmPrincipal},
  FRegistration in 'forms\FRegistration.pas' {FrmRegistration},
  FSearch in 'forms\FSearch.pas' {FrmSearch},
  FSplash in 'forms\FSplash.pas' {FrmSplash},
  FReport in 'reports\FReport.pas' {FrmReport},
  UConnection in 'database\UConnection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CrudApp';
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.
