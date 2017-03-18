unit Cadastro;

interface

uses
    PessoaFisica, ListaPessoaFisica, Controle, Usuario, DataModule;

type
    TCadastro = class
    public
       class function Incluir_PessoaFisica(nome:string;email:string;renda:currency;dataNasc:TDateTime;sexo:char):integer;
       class function Editar_PessoaFisica(codigo:integer;nome:string;email:string;renda:currency;dataNasc:TDateTime;sexo:char):integer;
       class function Excluir_PessoaFisica(codigo:integer):integer;
       //class function Buscar_PessoaFisica_PorCodigo(codigo:integer):TPessoaFisica;
       //class function Buscar_PessoaFisica_PorNome(nome:string):TListaPessoaFisica;
       class function Efetuar_Login(login:string;senha:string):integer;
    end;


implementation

{ TCadastro }

{ TCadastro }

{
class function TCadastro.Buscar_PessoaFisica_PorCodigo(codigo:integer): TPessoaFisica;
var
   ctr : TControle;
   pf : TPessoaFisica;
begin
   pf := TPessoaFisica.Create;
   pf.setCodigo(codigo);
   ctr := TControle.Create(pf);
   result := ctr.Buscar_PessoaFisica_PorCodigo;
end;

class function TCadastro.Buscar_PessoaFisica_PorNome(nome:string): TListaPessoaFisica;
var
   ctr : TControle;
   pf : TPessoaFisica;
begin
   pf := TPessoaFisica.Create;
   pf.setNome(nome);
   ctr := TControle.Create(pf);
   result := ctr.Buscar_PessoaFisica_PorNome;
end;
}

class function TCadastro.Editar_PessoaFisica(codigo: integer; nome,
  email: string; renda: currency; dataNasc: TDateTime;
  sexo: char): integer;
var
   ctr : TControle;
   pf : TPessoaFisica;
begin
   pf := TPessoaFisica.Create;
   pf.setCodigo(codigo);
   pf.setNome(nome);
   pf.setEmail(email);
   pf.setRenda(renda);
   pf.setdataNasc(dataNasc);
   pf.setSexo(sexo);
   ctr := TControle.Create(pf);
   result := ctr.Editar_PessoaFisica;
end;

class function TCadastro.Efetuar_Login(login, senha: string): integer;
var
   ctr : TControle;
   usu : TUsuario;
begin
   usu := TUsuario.Create;
   usu.setLogin(login);
   usu.setSenha(senha);
   ctr := TControle.Create(usu);
   if ctr.Efetuar_Login <> NIL then
      result := 1
   else
      result := 0;
end;

class function TCadastro.Excluir_PessoaFisica(codigo: integer): integer;
var
   ctr : TControle;
   pf : TPessoaFisica;
begin
   pf := TPessoaFisica.Create;
   pf.setCodigo(codigo);
   ctr := TControle.Create(pf);
   result := ctr.Excluir_PessoaFisica;
end;

class function TCadastro.Incluir_PessoaFisica(nome, email: string;
  renda: currency; dataNasc: TDateTime; sexo: char): integer;
var
   ctr : TControle;
   pf : TPessoaFisica;
begin
   pf := TPessoaFisica.Create;
   pf.setNome(nome);
   pf.setEmail(email);
   pf.setRenda(renda);
   pf.setdataNasc(dataNasc);
   pf.setSexo(sexo);
   ctr := TControle.Create(pf);
   result := ctr.Incluir_PessoaFisica;
end;




end.
