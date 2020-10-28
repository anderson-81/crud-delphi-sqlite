unit Controller;

interface

uses
    PhysicalPerson, SysUtils, PhysicalPersonList, DataModule, User, md5;

type
    TController = class
    private
       pp : TPhysicalPerson;
       usu : TUser;
       DM : TDM;
       function GenerateID:integer;
       function InsertPerson(id:integer; name:string; email:string):integer;
       function EditPerson(id:integer; name:string; email:string):integer;
       function DeletePerson(id:integer):integer;
       function InsertPhysicalPerson:integer;
       function EditPhysicalPerson:integer;
       function DeletePhysicalPerson:integer;
    public
       Constructor Create(pp:TPhysicalPerson); overload;
       Constructor Create(usu:TUser); overload;
       function Insert_PhysicalPerson:integer;
       function Edit_PhysicalPerson:integer;
       function Delete_PhysicalPerson:integer;
       function Login: TUser;
    end;

implementation

function TController.Login: TUser;
var
   usu : TUser;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('SELECT * FROM user WHERE user.username = :username AND user.password = :password');
      self.DM.ZQuery.ParamByName('username').AsString := self.usu.getUsername;
      self.DM.ZQuery.ParamByName('password').AsString := MD5Print(MD5String(self.usu.getPassword));
      self.DM.ZQuery.Open;
      self.DM.ZQuery.First;
      if not self.DM.ZQuery.Eof <> false then
      begin
         usu := TUser.Create;
         usu.setId(self.DM.ZQuery.Fields[0].AsInteger);
         usu.setUsername(self.DM.ZQuery.Fields[1].AsString);
         self.DM.ZQuery.Close;
         FreeAndNil(self.DM);
         result := usu;
      end
      else
      begin
        self.DM.ZQuery.Close;
        FreeAndNil(self.DM);
        result := NIL;
      end;
   except
      self.DM.ZQuery.Close;
      FreeAndNil(self.DM);
      result := NIL;
   end;
end;

function TController.Edit_PhysicalPerson: integer;
begin
   try
      self.DM.ZConn.StartTransaction;
   except
      result := -1;
   end;
   if(self.EditPerson(self.pp.getId, self.pp.getName, self.pp.getEmail) = 1) then
   begin
      if(self.EditPhysicalPerson = 1) then
      begin
         self.DM.ZConn.Commit;
         self.DM.ZQuery.Close;
         FreeAndNil(self.DM);
         result := 1;
      end
      else
      begin
         self.DM.ZConn.Rollback;
         self.DM.ZQuery.Close;
         FreeAndNil(self.DM);
         result := -1;
      end;
    end
    else
    begin
       self.DM.ZConn.Rollback;
       self.DM.ZQuery.Close;
       FreeAndNil(self.DM);
       result := -1;
    end;
end;

function TController.EditPerson(id: integer; name,
  email: string): integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('UPDATE PERSON SET NAME = :NAME, EMAIL = :EMAIL WHERE ID = :ID');
      self.DM.ZQuery.ParamByName('ID').AsInteger := id;
      self.DM.ZQuery.ParamByName('NAME').AsString := name;
      self.DM.ZQuery.ParamByName('EMAIL').AsString := email;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TController.EditPhysicalPerson: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('UPDATE PHYSICALPERSON SET SALARY = :SALARY, BIRTHDAY = :BIRTHDAY, GENDER = :GENDER WHERE ID = :ID');
      self.DM.ZQuery.ParamByName('ID').AsInteger := self.pp.getId;
      self.DM.ZQuery.ParamByName('SALARY').AsCurrency := self.pp.getSalary;
      self.DM.ZQuery.ParamByName('BIRTHDAY').AsDateTime := self.pp.getBirthday;
      self.DM.ZQuery.ParamByName('GENDER').AsString := self.pp.getGender;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TController.DeletePhysicalPerson: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('DELETE FROM PHYSICALPERSON WHERE ID = :ID');
      self.DM.ZQuery.ParamByName('ID').AsInteger := self.pp.getID;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TController.DeletePerson(ID: integer): integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('DELETE FROM PERSON WHERE ID = :ID');
      self.DM.ZQuery.ParamByName('ID').AsInteger := ID;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TController.Delete_PhysicalPerson: integer;
begin
   try
      self.DM.ZConn.StartTransaction;
   except
      result := -1;
   end;
   if(self.DeletePhysicalPerson = 1) then
   begin
      if(self.DeletePerson(self.pp.getID) = 1) then
      begin
         self.DM.ZConn.Commit;
         self.DM.ZQuery.Close;
         FreeAndNil(self.DM);
         result := 1;
      end
      else
      begin
         self.DM.ZConn.Rollback;
         self.DM.ZQuery.Close;
         FreeAndNil(self.DM);
         result := -1;
      end;
    end
    else
    begin
       self.DM.ZConn.Rollback;
       self.DM.ZQuery.Close;
       FreeAndNil(self.DM);
       result := -1;
    end;
end;

function TController.GenerateID: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('SELECT MAX(ID) + 1 FROM PERSON');
      self.DM.ZQuery.Open;
      result := self.DM.ZQuery.Fields[0].AsInteger;
   except
      result := 1;
   end;
end;

function TController.Insert_PhysicalPerson: integer;
var
   id : integer;
begin
   id := self.GenerateID;
   if(id > 0) then
   begin
      self.pp.setID(id);
      try
         self.DM.ZConn.StartTransaction;
      except
         result := -1;
      end;
      if(self.InsertPerson(self.pp.getID, self.pp.getName, self.pp.getEmail) = 1) then
      begin
         if(self.InsertPhysicalPerson = 1) then
         begin
            self.DM.ZConn.Commit;
            self.DM.ZQuery.Close;
            FreeAndNil(self.DM);
            result := 1;
         end
         else
         begin
            self.DM.ZConn.Rollback;
            self.DM.ZQuery.Close;
            FreeAndNil(self.DM);
            result := -1;
         end;
      end
      else
      begin
         self.DM.ZConn.Rollback;
         self.DM.ZQuery.Close;
         FreeAndNil(self.DM);
         result := -1;
      end;
   end
   else
   begin
      self.DM.ZConn.Rollback;
      self.DM.ZQuery.Close;
      FreeAndNil(self.DM);
      result := -1;
   end;
end;

function TController.InsertPerson(ID: integer; name,
  email: string): integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('INSERT INTO PERSON VALUES (:ID, :NAME, :EMAIL)');
      self.DM.ZQuery.ParamByName('ID').AsInteger := ID;
      self.DM.ZQuery.ParamByName('NAME').AsString := name;
      self.DM.ZQuery.ParamByName('EMAIL').AsString := email;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

function TController.InsertPhysicalPerson: integer;
begin
   try
      self.DM.ZQuery.SQL.Clear;
      self.DM.ZQuery.SQL.Add('INSERT INTO PHYSICALPERSON VALUES (:ID, :ID, :SALARY, :BIRTHDAY, :GENDER)');
      self.DM.ZQuery.ParamByName('ID').AsInteger := self.pp.getID;
      self.DM.ZQuery.ParamByName('ID').AsInteger := self.pp.getID;
      self.DM.ZQuery.ParamByName('SALARY').AsCurrency := self.pp.getSalary;
      self.DM.ZQuery.ParamByName('BIRTHDAY').AsDateTime := self.pp.getBirthday;
      self.DM.ZQuery.ParamByName('GENDER').AsString := self.pp.getGender;
      self.DM.ZQuery.ExecSQL;
      result :=  1;
   except
      result := -1;
   end;
end;

constructor TController.Create(pp: TPhysicalPerson);
begin
    self.pp := pp;
    self.DM := TDM.Create(NIL);
end;

constructor TController.Create(usu: TUser);
begin
    self.usu := usu;
    self.DM := TDM.Create(NIL);
end;

end.
 

