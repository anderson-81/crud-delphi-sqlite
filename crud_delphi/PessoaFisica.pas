unit PessoaFisica;

interface

uses
    Pessoa, SysUtils;

type
    TPessoaFisica = class(TInterfacedObject, IPessoa)
    private
        codigo : integer;
        nome : string;
        email : string;
        renda : currency;
        dataNasc : TDateTime;
        sexo : char;
    public
        procedure setCodigo(codigo : integer);
        function getCodigo : integer;
        procedure setNome(nome : string);
        function getNome : string;
        procedure setEmail(email:string);
        function getEmail : string;
        procedure setRenda(renda:currency);
        function getRenda : currency;
        procedure setdataNasc(dataNasc:TDateTime);
        function getdataNasc : TDateTime;
        procedure setSexo(sexo:char);
        function getSexo : char;
    end;

implementation
{ TPessoaFisica }

function TPessoaFisica.getCodigo: integer;
begin
  result := self.codigo;
end;

function TPessoaFisica.getdataNasc: TDateTime;
begin
  result := self.dataNasc;
end;

function TPessoaFisica.getEmail: string;
begin
  result := self.email;
end;

function TPessoaFisica.getNome: string;
begin
  result := self.nome;
end;

function TPessoaFisica.getRenda: currency;
begin
  result := self.renda;
end;

function TPessoaFisica.getSexo: char;
begin
  result := self.sexo;
end;

procedure TPessoaFisica.setCodigo(codigo: integer);
begin
  self.codigo := codigo;
end;

procedure TPessoaFisica.setdataNasc(dataNasc: TDateTime);
begin
  self.dataNasc := dataNasc;
end;

procedure TPessoaFisica.setEmail(email: string);
begin
  self.email := email;
end;

procedure TPessoaFisica.setNome(nome: string);
begin
  self.nome := nome;
end;

procedure TPessoaFisica.setRenda(renda: currency);
begin
  self.renda := renda;
end;

procedure TPessoaFisica.setSexo(sexo: char);
begin
  self.sexo := sexo;
end;

end.

