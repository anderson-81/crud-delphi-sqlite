program ProjectDelphi;

uses
  Forms,
  Cadastro in 'Cadastro.pas',
  Controle in 'Controle.pas',
  DataModule in 'DataModule.pas' {DM: TDataModule},
  FLogin in 'FLogin.pas' {FrmLogin},
  FPrincipal in 'FPrincipal.pas' {FrmPrincipal},
  FRegistration in 'FRegistration.pas' {FrmRegistration},
  FReport in 'FReport.pas' {FrmReport},
  FSearch in 'FSearch.pas' {FrmSearch},
  FSplash in 'FSplash.pas' {FrmSplash},
  ListaPessoaFisica in 'ListaPessoaFisica.pas',
  md5 in 'md5.pas',
  Pessoa in 'Pessoa.pas',
  PessoaFisica in 'PessoaFisica.pas',
  Usuario in 'Usuario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'RegSys v1.0';
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.
