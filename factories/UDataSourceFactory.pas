unit UDataSourceFactory;

interface

uses
  SysUtils, Variants, DB, DBClient, UFacade, UPhysicalPersonList,
  UPhysicalPerson;

type
  TDataSourceFactory = class
  private

  public
    function CreatePhysicalPersonDataSourceFromTheList
             (list: TPhysicalPersonList): TDataSource;
  end;

implementation

function TDataSourceFactory.CreatePhysicalPersonDataSourceFromTheList
                            (list: TPhysicalPersonList): TDataSource;
var
  i: Integer;
  dataSource: TDataSource;
  clientDataSet: TClientDataSet;
begin
  { CLIENTDATASET }
  clientDataSet := TClientDataSet.Create(NIL);

  clientDataSet.FieldDefs.Add('ID', ftInteger);
  clientDataSet.FieldDefs.Add('CPF', ftString, 11);
  clientDataSet.FieldDefs.Add('NAME', ftString, 45);
  clientDataSet.FieldDefs.Add('EMAIL', ftString, 45);
  clientDataSet.FieldDefs.Add('STATUS', ftInteger);
  clientDataSet.FieldDefs.Add('COMMENT', ftString, 200);
  clientDataSet.FieldDefs.Add('SALARY', ftCurrency);
  clientDataSet.FieldDefs.Add('BIRTHDAY', ftDate);
  clientDataSet.FieldDefs.Add('GENDER', ftString, 1);
  clientDataSet.FieldDefs.Add('CREATEAT', ftDate);
  clientDataSet.CreateDataSet;

  For i := 0 to (Length(list) - 1) do
  begin
    clientDataSet.Append;
    clientDataSet.FieldByName('ID').AsInteger := list[i].getID;
    clientDataSet.FieldByName('CPF').AsString := list[i].getCPF;
    clientDataSet.FieldByName('NAME').AsString := list[i].getName;
    clientDataSet.FieldByName('EMAIL').AsString := list[i].getEmail;
    clientDataSet.FieldByName('STATUS').AsInteger := list[i].getStatus;
    clientDataSet.FieldByName('COMMENT').AsString := list[i].getComment;
    clientDataSet.FieldByName('SALARY').AsCurrency := list[i].getSalary;
    clientDataSet.FieldByName('BIRTHDAY').AsDateTime := list[i].getBirthday;
    clientDataSet.FieldByName('GENDER').AsString := list[i].getGender;
    clientDataSet.FieldByName('CREATEAT').AsDateTime := list[i].getCreateAt;
  end;

  { POST TO CLIENTDATASET }
  clientDataSet.Post;

  { FIRST }
  clientDataSet.First;

  { DATASOURCE DEFINITION }
  dataSource := TDataSource.Create(NIL);
  dataSource.DataSet := clientDataSet;

  { RESULT }
  result := dataSource;
end;

end.
 