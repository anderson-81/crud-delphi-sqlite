unit Usuario;

interface

type
    TUsuario = class
    private
       codigo : integer;
       login : string;
       senha : string;
    public
       procedure setCodigo(codigo:integer);
       function getCodigo:integer;
       procedure setLogin(login:string);
       function getLogin:string;
       procedure setSenha(senha:string);
       function getSenha:string;
    end;

implementation

{ TUsuario }

function TUsuario.getCodigo: integer;
begin
   result := self.codigo;
end;

function TUsuario.getLogin: string;
begin
   result := self.login;
end;

function TUsuario.getSenha: string;
begin
   result := self.senha;
end;

procedure TUsuario.setCodigo(codigo: integer);
begin
  self.codigo := codigo;
end;

procedure TUsuario.setLogin(login: string);
begin
  self.login := login;
end;

procedure TUsuario.setSenha(senha: string);
begin
  self.senha := senha;
end;

end.
