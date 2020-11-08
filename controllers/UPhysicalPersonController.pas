unit UPhysicalPersonController;

interface

uses
  SysUtils, UConnection, DB, UPerson, UPhysicalPerson,
  UPhysicalPersonList, UUser, UPersonController, UFactory, md5;

type
  TPhysicalPersonController = class(TPersonController)
  private
    { ATTRIBUTES }
    pp: TPhysicalPerson;
    conn: TConnection;

    { PERSON }
    function InsertPerson: Integer;
    function EditPerson: Integer;
    function DeletePerson: Integer;

    { PHYSICALPERSON }
    function InsertPhysicalPerson: Integer;
    function EditPhysicalPerson: Integer;
    function DeletePhysicalPerson: Integer;

    { SEARCH }
    function GenerateID: Integer;
    function GetRegisterFromRow(fields: TFields): TPhysicalPerson;
  public
    Constructor Create(pp: TPhysicalPerson); overload;

    { TRANSACTION }
    function Insert_PhysicalPerson: Integer;
    function Edit_PhysicalPerson: Integer;
    function Delete_PhysicalPerson: Integer;

    { SEARCH }
    function Get_PhysicalPerson_By_Name: TPhysicalPersonList;
    function Get_PhysicalPerson_By_ID: TPhysicalPerson;

    { COMMIT AND ROLLBACK }
    function Rollback: Integer;
    function Commit: Integer;
  end;

implementation

{ CONSTRUCTORS }

constructor TPhysicalPersonController.Create(pp: TPhysicalPerson);
begin
  self.pp := pp;
  conn := TConnection.getInstance;
end;

{ PRIVATE METHODS }

{ PERSON }

function TPhysicalPersonController.GenerateID: integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add('SELECT MAX(ID) + 1 FROM PERSON');
    conn.ZQuery.Open;
    result := conn.ZQuery.Fields[0].AsInteger;
  except
    result := 1;
  end;
end;

function TPhysicalPersonController.InsertPerson: Integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add(' INSERT INTO PERSON (ID, NAME, EMAIL, STATUS, COMMENT, CREATEAT) VALUES (:ID, :NAME, :EMAIL, :STATUS, :COMMENT, :CREATEAT); ');
    conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
    conn.ZQuery.ParamByName('NAME').AsString := pp.getName;
    conn.ZQuery.ParamByName('EMAIL').AsString := pp.getEmail;
    conn.ZQuery.ParamByName('STATUS').AsInteger := pp.getStatus;
    conn.ZQuery.ParamByName('COMMENT').AsString := pp.getComment ;
    conn.ZQuery.ParamByName('CREATEAT').AsDateTime := pp.getCreateAt;
    conn.ZQuery.ExecSQL;
    result :=  1;
  except
    result := -1;
  end;
end;

function TPhysicalPersonController.EditPerson: integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add(' UPDATE PERSON SET    ');
    conn.ZQuery.SQL.Add('   NAME = :NAME,      ');
    conn.ZQuery.SQL.Add('   EMAIL = :EMAIL,    ');
    conn.ZQuery.SQL.Add('   STATUS = :STATUS,  ');
    conn.ZQuery.SQL.Add('   COMMENT = :COMMENT ');
    conn.ZQuery.SQL.Add(' WHERE ID = :ID;      ');
    conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
    conn.ZQuery.ParamByName('NAME').AsString := pp.getName;
    conn.ZQuery.ParamByName('EMAIL').AsString := pp.getEmail;
    conn.ZQuery.ParamByName('STATUS').AsInteger := pp.getStatus;
    conn.ZQuery.ParamByName('COMMENT').AsString := pp.getComment;
    conn.ZQuery.ExecSQL;
    result :=  1;
  except
    result := -1;
  end;
end;

function TPhysicalPersonController.DeletePerson: integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add('DELETE FROM PERSON WHERE ID = :ID');
    conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
    conn.ZQuery.ExecSQL;
    result :=  1;
  except
    result := -1;
  end;
end;

{ PHYSICALPERSON }

function TPhysicalPersonController.InsertPhysicalPerson: integer;
begin
  try
   conn.ZQuery.SQL.Clear;
   conn.ZQuery.SQL.Add('INSERT INTO PHYSICALPERSON  ');
   conn.ZQuery.SQL.Add('(ID, PERSON_ID, CPF, SALARY, BIRTHDAY, GENDER) ');
   conn.ZQuery.SQL.Add('VALUES ( :ID, :ID, :CPF, :SALARY, :BIRTHDAY, ');
   conn.ZQuery.SQL.Add(':GENDER); ');
   conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
   conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
   conn.ZQuery.ParamByName('CPF').AsString := pp.getCPF;
   conn.ZQuery.ParamByName('SALARY').AsCurrency := pp.getSalary;
   conn.ZQuery.ParamByName('BIRTHDAY').AsDateTime := pp.getBirthday;
   conn.ZQuery.ParamByName('GENDER').AsString := pp.getGender;
   conn.ZQuery.ExecSQL;
   result :=  1;
  except
    result := -1;
  end;
end;

function TPhysicalPersonController.EditPhysicalPerson: integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add(' UPDATE PHYSICALPERSON SET ');
    conn.ZQuery.SQL.Add('   SALARY = :SALARY,       ');
    conn.ZQuery.SQL.Add('   BIRTHDAY = :BIRTHDAY,   ');
    conn.ZQuery.SQL.Add('   GENDER = :GENDER        ');
    conn.ZQuery.SQL.Add(' WHERE ID = :ID;           ');
    conn.ZQuery.ParamByName('ID').AsInteger := pp.getId;
    conn.ZQuery.ParamByName('SALARY').AsCurrency := pp.getSalary;
    conn.ZQuery.ParamByName('BIRTHDAY').AsDateTime := pp.getBirthday;
    conn.ZQuery.ParamByName('GENDER').AsString := pp.getGender;
    conn.ZQuery.ExecSQL;
    result :=  1;
  except
    result := -1;
  end;
end;

function TPhysicalPersonController.DeletePhysicalPerson: integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add('DELETE FROM PHYSICALPERSON WHERE ID = :ID; ');
    conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
    conn.ZQuery.ExecSQL;
    result :=  1;
  except
    result := -1;
  end;
end;

{ TRANSACTIONS }

function TPhysicalPersonController.Insert_PhysicalPerson: integer;
var
  id : integer;
begin
  id := GenerateID;
  if(id > 0) then
  begin
    pp.setID(id);
    try
      conn.StartTransaction;
    except
      result := -1;
    end;
    if InsertPerson = 1 then
    begin
      if InsertPhysicalPerson = 1 then
        result := Commit
      else
        result := Rollback;
    end
    else
      result := Rollback;
  end
  else
     result := Rollback;
end;

function TPhysicalPersonController.Edit_PhysicalPerson: integer;
begin
  try
    conn.StartTransaction;
  except
    result := -1;
  end;
  if EditPerson = 1 then
  begin
    if EditPhysicalPerson = 1 then
      result := Commit
    else
      result := Rollback;
  end
  else
    result := Rollback;
end;

function TPhysicalPersonController.Delete_PhysicalPerson: integer;
begin
  try
    conn.StartTransaction;
  except
    result := Rollback;
  end;
  if DeletePhysicalPerson = 1 then
  begin
    if DeletePerson = 1 then
      result := Commit
    else
      result := Rollback;
  end
  else
    result := Rollback;
end;

function TPhysicalPersonController.Rollback: Integer;
begin
  conn.Rollback;
  conn.ZQuery.Close;
  result := -1;
end;

function TPhysicalPersonController.Commit: Integer;
begin
  conn.Commit;
  conn.ZQuery.Close;
  result := 1;
end;

function TPhysicalPersonController.Get_PhysicalPerson_By_Name:
                                   TPhysicalPersonList;
var
  list: TPhysicalPersonList;
  i : integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add('SELECT PERSON.ID, CPF, NAME, EMAIL, STATUS, ');
    conn.ZQuery.SQL.Add('COMMENT, SALARY, BIRTHDAY, GENDER, CREATEAT FROM ');
    conn.ZQuery.SQL.Add('PERSON INNER JOIN PHYSICALPERSON ');
    conn.ZQuery.SQL.Add('ON PERSON.ID = PHYSICALPERSON.PERSON_ID ');
    conn.ZQuery.SQL.Add('WHERE PERSON.NAME LIKE :NAME ');
    conn.ZQuery.ParamByName('NAME').AsString := pp.getName + '%';
    conn.ZQuery.Open;
    if(conn.ZQuery.RecordCount > 0) then
    begin
      i := 0;
      conn.ZQuery.First;
      SetLength(list, conn.ZQuery.RecordCount);
      while not conn.ZQuery.Eof do
      begin
        list[i] := GetRegisterFromRow(conn.ZQuery.Fields);
        conn.ZQuery.Next;
        i := i + 1;
      end;
      result := list;
    end
    else
      result := NIL;
  except
    Exit;
  end;
end;

function TPhysicalPersonController.Get_PhysicalPerson_By_ID: TPhysicalPerson;
var
  i : integer;
begin
  try
    conn.ZQuery.SQL.Clear;
    conn.ZQuery.SQL.Add('SELECT PERSON.ID, CPF, NAME, EMAIL, STATUS, ');
    conn.ZQuery.SQL.Add('COMMENT, SALARY, BIRTHDAY, GENDER, CREATEAT FROM ');
    conn.ZQuery.SQL.Add('PERSON INNER JOIN PHYSICALPERSON ');
    conn.ZQuery.SQL.Add('ON PERSON.ID = PHYSICALPERSON.PERSON_ID ');
    conn.ZQuery.SQL.Add('WHERE PERSON.ID = :ID ');
    conn.ZQuery.ParamByName('ID').AsInteger := pp.getID;
    conn.ZQuery.Open;
    if(conn.ZQuery.RecordCount > 0) then
    begin
      conn.ZQuery.First;
      while not conn.ZQuery.Eof do
      begin
        pp := GetRegisterFromRow(conn.ZQuery.Fields);
        conn.ZQuery.Next;
      end;
      result := pp;
    end
    else
      result := NIL;
  except
    Exit;
  end;
end;

function TPhysicalPersonController.GetRegisterFromRow(fields: TFields):
                                     TPhysicalPerson;
var
  gender: char;
begin
  if fields[8].AsString = 'M' then gender := 'M' else gender := 'F';

  result := TFactory.Create.CreatePhysicalPerson(
    fields[0].AsInteger,
    fields[1].AsString,
    fields[2].AsString,
    fields[3].AsString,
    fields[4].AsInteger,
    fields[5].AsString,
    fields[6].AsCurrency,
    fields[7].AsDateTime,
    gender,
    fields[9].AsDateTime
  );
end;

end.
 

