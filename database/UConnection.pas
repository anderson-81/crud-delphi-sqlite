unit UConnection;

interface

uses
  SysUtils, DB, ZDataset, ZConnection, Classes;

type                                                                            
  TConnection = class
  private
    ZConn: TZConnection;
    class function NewInstance: TObject; override;
    procedure setConnectionConfiguration;
  public
    ZQuery: TZQuery;
    DS: TDataSource;
    class function getInstance: TConnection;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

var
  instance: TConnection;

implementation

uses ZAbstractConnection;

{ SINGLETON }
class function TConnection.NewInstance: TObject;
begin
  if not Assigned(instance) then
  begin
    instance := TConnection(inherited NewInstance);
    instance.setConnectionConfiguration;
  end;
  result := instance;
end;
 
class function TConnection.getInstance: TConnection;
var
  conn: TConnection;
begin
  conn := TConnection.Create;
  result := conn;
end;
{ SINGLETON }


procedure TConnection.setConnectionConfiguration;
begin
  if not Assigned(ZConn) then
  begin
    ZConn := TZConnection.Create(NIL);
    ZConn.LibraryLocation := 'sqlite3.dll';
    ZConn.Database := 'db.db';
    ZConn.Protocol := 'sqlite-3';
  end;

  if not Assigned(ZQuery) then
  begin
    ZQuery := TZQuery.Create(NIL);
    ZQuery.Connection := ZConn;
  end;
end;

procedure TConnection.StartTransaction;
begin
  ZConn.StartTransaction;
end;

procedure TConnection.Commit;
begin
  ZConn.Commit;
end;

procedure TConnection.Rollback;
begin
  ZConn.Rollback;
end;

end.
