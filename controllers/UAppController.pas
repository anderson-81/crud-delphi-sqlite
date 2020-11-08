unit UAppController;

interface

uses
  UConnection;

type
  TAppController = class
  private
    conn: TConnection;
  public
    Constructor Create;
    function CheckIfExistInDatabase(table: string; column: string;
                                    value: string): boolean;

    function CheckIfNotExistInDatabase(table: string; column: string;
                                       value: string): boolean;
  end;

implementation

Constructor TAppController.Create;
begin
  conn := TConnection.getInstance;
end;

{ Check if CPF or e-mail is registered (Only string data at the moment). }
function TAppController.CheckIfExistInDatabase(table: string; column: string;
                                               value: string): boolean;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add('SELECT * FROM ');
    conn.ZQuery.SQL.Add( table  );
    conn.ZQuery.SQL.Add('WHERE ');
    conn.ZQuery.SQL.Add( column );
    conn.ZQuery.SQL.Add(' = '   );
    conn.ZQuery.SQL.Add(':VALUE');
    conn.ZQuery.ParamByName('VALUE').AsString := value;
    conn.ZQuery.Open;
    result := conn.ZQuery.RecordCount > 0;
  except
    result := False;
    Exit;
  end;
end;

function TAppController.CheckIfNotExistInDatabase(table: string; column: string;
                                                  value: string): boolean;
begin
  result := not CheckIfExistInDatabase(table, column, value);
end;

end.
