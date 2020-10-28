program ProjectDelphi;

uses
  Forms,
  Facade in 'Facade.pas',
  Controller in 'Controller.pas',
  DataModule in 'DataModule.pas' {DM: TDataModule},
  FLogin in 'FLogin.pas' {FrmLogin},
  FPrincipal in 'FPrincipal.pas' {FrmPrincipal},
  FRegistration in 'FRegistration.pas' {FrmRegistration},
  FReport in 'FReport.pas' {FrmReport},
  FSearch in 'FSearch.pas' {FrmSearch},
  FSplash in 'FSplash.pas' {FrmSplash},
  PhysicalPersonList in 'PhysicalPersonList.pas',
  md5 in 'md5.pas',
  Person in 'Person.pas',
  PhysicalPerson in 'PhysicalPerson.pas',
  User in 'User.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RegSys v1.0';
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.
