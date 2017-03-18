unit Pessoa;

interface

uses
    SysUtils;

type
    IPessoa = interface(IInterface)
        procedure setCodigo(codigo : integer);
        function getCodigo : integer;
        procedure setNome(nome : string);
        function getNome : string;
        procedure setEmail(email:string);
        function getEmail : string;
    end;

implementation

end.


