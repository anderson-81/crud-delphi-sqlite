unit Controle;

interface

uses
    PessoaFisica, SysUtils, ListaPessoaFisica, DataModule, Usuario, md5;


type
    TControle = class
    private
       pf : TPessoaFisica;
       usu : TUsuario;
       DM : TDM;
       function GerarCodigo:integer;
       function IncluirPessoa(codigo:integer; nome:string; email:string):integer;
       function EditarPessoa(codigo:integer; nome:string; email:string):integer;
       function ExcluirPessoa(codigo:integer):integer;
       function IncluirPessoaFisica:integer;
       function EditarPessoaFisica:integer;
       function ExcluirPessoaFisica:integer;
    public
       Constructor Create(pf:TPessoaFisica); overload;
       Constructor Create(usu:TUsuario); overload;
       function Incluir_PessoaFisica:integer;
       function Editar_PessoaFisica:integer;
       function Excluir_PessoaFisica:integer;
       //function Buscar_PessoaFisica_PorCodigo:TPessoaFisica;
       //function Buscar_PessoaFisica_PorNome:TListaPessoaFisica;
       function Efetuar_Login: TUsuario;
    end;

implementation



{ TControle }

//Return Array
{
function TControle.Buscar_PessoaFisica_PorCodigo: TPessoaFisica;
var
   pf_r : TPessoaFisica;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('SELECT * FROM PESSOA INNER JOIN PESSOAFISICA ON PESSOA.CODIGO = PESSOAFISICA.PESSOA_CODIGO WHERE PESSOA.CODIGO = :CODIGO');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := self.pf.getCodigo;
      self.DM.ZQuery.Open;
      self.DM.ZQuery.Next;
      if(self.DM.ZQuery.Eof <> false) then
      begin
         pf_r := TPessoaFisica.Create;
         pf_r.setCodigo(self.DM.ZQuery.Fields[0].AsInteger);
         pf_r.setNome(self.DM.ZQuery.Fields[1].AsString);
         pf_r.setEmail(self.DM.ZQuery.Fields[2].AsString);
         pf_r.setRenda(self.DM.ZQuery.Fields[5].AsCurrency);
         pf_r.setdataNasc(self.DM.ZQuery.Fields[6].AsDateTime);
         pf_r.setSexo(self.DM.ZQuery.Fields[7].AsString[1]);
         result := pf_r;
      end
      else
         result := NIL;
   except
      result := NIL;
   end;
end;
}

function TControle.Efetuar_Login: TUsuario;
var
   usu_r : TUsuario;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('SELECT * FROM USUARIO WHERE USUARIO.LOGIN = :LOGIN AND USUARIO.SENHA = :SENHA');
      self.DM.ZQuery.ParamByName('LOGIN').AsString := self.usu.getLogin;
      self.DM.ZQuery.ParamByName('SENHA').AsString := MD5Print(MD5String(self.usu.getSenha));
      self.DM.ZQuery.Open;
      self.DM.ZQuery.First;
      if not self.DM.ZQuery.Eof <> false then
      begin
         usu_r := TUsuario.Create;
         usu_r.setCodigo(self.DM.ZQuery.Fields[0].AsInteger);
         usu_r.setLogin(self.DM.ZQuery.Fields[1].AsString);
         self.DM.ZQuery.Close;
         FreeAndNil(DM);
         result := usu_r;
      end
      else
      begin
        self.DM.ZQuery.Close;
        FreeAndNil(DM);
        result := NIL;
      end;
   except
      self.DM.ZQuery.Close;
      FreeAndNil(DM);
      result := NIL;
   end;
end;


//Return Array
{
function TControle.Buscar_PessoaFisica_PorNome: TListaPessoaFisica;
var
   lista : TListaPessoaFisica;
   pf_r : TPessoaFisica;
   i : integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('SELECT * FROM PESSOA INNER JOIN PESSOAFISICA ON PESSOA.CODIGO = PESSOAFISICA.PESSOA_CODIGO WHERE PESSOA.NOME LIKE :NOME');
      self.DM.ZQuery.ParamByName('NOME').AsString := self.pf.getNome + '%';
      self.DM.ZQuery.Open;
      if(self.DM.ZQuery.RecordCount > 0) then
      begin
         i := 0;
         setLength(lista, self.DM.ZQuery.RecordCount);
         self.DM.ZQuery.First;
         while NOT self.DM.ZQuery.Eof do
         begin
            pf_r := TPessoaFisica.Create;
            pf_r.setCodigo(self.DM.ZQuery.Fields[0].AsInteger);
            pf_r.setNome(self.DM.ZQuery.Fields[1].AsString);
            pf_r.setEmail(self.DM.ZQuery.Fields[2].AsString);
            pf_r.setRenda(self.DM.ZQuery.Fields[5].AsCurrency);
            pf_r.setdataNasc(self.DM.ZQuery.Fields[6].AsDateTime);
            pf_r.setSexo(self.DM.ZQuery.Fields[7].AsString[1]);
            lista[i] := pf_r;
            i := i + 1;
            self.DM.ZQuery.Next;
         end;
         result := lista;
      end
      else
         result := NIL;
   except
      result := NIL;
   end;
end;
}


function TControle.Editar_PessoaFisica: integer;
begin
   try
      self.DM.ZConn.StartTransaction;
   except
      result := -1;
   end;
   if(self.EditarPessoa(self.pf.getCodigo, self.pf.getNome, self.pf.getEmail) = 1) then
   begin
      if(self.EditarPessoaFisica = 1) then
      begin
         self.DM.ZConn.Commit;
         self.DM.ZQuery.Close;
         FreeAndNil(DM);
         result := 1;
      end
      else
      begin
         self.DM.ZConn.Rollback;
         self.DM.ZQuery.Close;
         FreeAndNil(DM);
         result := -1;
      end;
    end
    else
    begin
       self.DM.ZConn.Rollback;
       self.DM.ZQuery.Close;
       FreeAndNil(DM);
       result := -1;
    end;
end;

function TControle.EditarPessoa(codigo: integer; nome,
  email: string): integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('UPDATE PESSOA SET NOME = :NOME, EMAIL = :EMAIL WHERE CODIGO = :CODIGO');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := codigo;
      self.DM.ZQuery.ParamByName('NOME').AsString := nome;
      self.DM.ZQuery.ParamByName('EMAIL').AsString := email;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TControle.EditarPessoaFisica: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('UPDATE PESSOAFISICA SET RENDA = :RENDA, DATANASC = :DATANASC, SEXO = :SEXO WHERE CODIGO = :CODIGO');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := self.pf.getCodigo;
      self.DM.ZQuery.ParamByName('RENDA').AsCurrency := self.pf.getRenda;
      self.DM.ZQuery.ParamByName('DATANASC').AsDateTime := self.pf.getdataNasc;
      self.DM.ZQuery.ParamByName('SEXO').AsString := self.pf.getSexo;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TControle.Excluir_PessoaFisica: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('DELETE FROM PESSOAFISICA WHERE CODIGO = :CODIGO');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := self.pf.getCodigo;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TControle.ExcluirPessoa(codigo: integer): integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('DELETE FROM PESSOA WHERE CODIGO = :CODIGO');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := codigo;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TControle.ExcluirPessoaFisica: integer;
begin
   try
      self.DM.ZConn.StartTransaction;
   except
      result := -1;
   end;
   if(self.ExcluirPessoaFisica = 1) then
   begin
      if(self.ExcluirPessoa(self.pf.getCodigo) = 1) then
      begin
         self.DM.ZConn.Commit;
         self.DM.ZQuery.Close;
         FreeAndNil(DM);
         result := 1;
      end
      else
      begin
         self.DM.ZConn.Rollback;
         self.DM.ZQuery.Close;
         FreeAndNil(DM);
         result := -1;
      end;
    end
    else
    begin
       self.DM.ZConn.Rollback;
       self.DM.ZQuery.Close;
       FreeAndNil(DM);
       result := -1;
    end;
end;

function TControle.GerarCodigo: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('SELECT MAX(CODIGO) + 1 FROM PESSOA');
      self.DM.ZQuery.Open;
      result := self.DM.ZQuery.Fields[0].AsInteger;
   except
      result := 1;
   end;
end;

function TControle.Incluir_PessoaFisica: integer;
var
   codigo : integer;
begin
   codigo := self.GerarCodigo;
   if(codigo > 0) then
   begin
      self.pf.setCodigo(codigo);
      try
         self.DM.ZConn.StartTransaction;
      except
         result := -1;
      end;
      if(self.IncluirPessoa(self.pf.getCodigo, self.pf.getNome, self.pf.getEmail) = 1) then
      begin
         if(self.IncluirPessoaFisica = 1) then
         begin
            self.DM.ZConn.Commit;
            self.DM.ZQuery.Close;
            FreeAndNil(DM);
            result := 1;
         end
         else
         begin
            self.DM.ZConn.Rollback;
            self.DM.ZQuery.Close;
            FreeAndNil(DM);
            result := -1;
         end;
      end
      else
      begin
         self.DM.ZConn.Rollback;
         self.DM.ZQuery.Close;
         FreeAndNil(DM);
         result := -1;
      end;
   end
   else
   begin
      self.DM.ZConn.Rollback;
      self.DM.ZQuery.Close;
      FreeAndNil(DM);
      result := -1;
   end;
end;

function TControle.IncluirPessoa(codigo: integer; nome,
  email: string): integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('INSERT INTO PESSOA VALUES (:CODIGO, :NOME, :EMAIL)');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := codigo;
      self.DM.ZQuery.ParamByName('NOME').AsString := nome;
      self.DM.ZQuery.ParamByName('EMAIL').AsString := email;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TControle.IncluirPessoaFisica: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('INSERT INTO PESSOAFISICA VALUES (:CODIGO, :CODIGO, :RENDA, :DATANASC, :SEXO)');
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := self.pf.getCodigo;
      self.DM.ZQuery.ParamByName('CODIGO').AsInteger := self.pf.getCodigo;
      self.DM.ZQuery.ParamByName('RENDA').AsCurrency := self.pf.getRenda;
      self.DM.ZQuery.ParamByName('DATANASC').AsDateTime := self.pf.getdataNasc;
      self.DM.ZQuery.ParamByName('SEXO').AsString := self.pf.getSexo;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

constructor TControle.Create(pf: TPessoaFisica);
begin
    self.pf := pf;
    self.DM := TDM.Create(NIL);
end;

constructor TControle.Create(usu: TUsuario);
begin
    self.usu := usu;
    self.DM := TDM.Create(NIL);
end;


end.
 

