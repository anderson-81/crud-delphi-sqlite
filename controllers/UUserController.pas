unit UUserController;

interface

uses
  SysUtils, UConnection, UUser, md5;

type
  TUserController = class
  private
    conn: TConnection;
    usu: TUser;
  public
    Constructor Create(usu: TUser); overload;
    function Login: TUser;
  end;

implementation

constructor TUserController.Create(usu: TUser);
begin
  self.usu := usu;
  conn := TConnection.getInstance;
end;

function TUserController.Login: TUser;
var
  return: TUser;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add(' SELECT * FROM user              ');
    conn.ZQuery.SQL.Add(' WHERE user.username = :username ');
    conn.ZQuery.SQL.Add(' AND user.password = :password   ');
    conn.ZQuery.ParamByName('username')
                           .AsString := MD5Print(MD5String(usu.getUsername));
    conn.ZQuery.ParamByName('password')
                           .AsString := MD5Print(MD5String(usu.getPassword));
    conn.ZQuery.Open;
    if conn.ZQuery.RecordCount > 0 then
      return := usu
    else
      return := NIL;

    conn.ZQuery.Close;
    result := return;
   except
     conn.ZQuery.Close;
     result := NIL;
   end;
end;

end.
 