unit Facade;

interface

uses
    PhysicalPerson, PhysicalPersonList, Controller, User, DataModule;

type
    TFacade = class
    public
       class function Insert_PhysicalPerson(name:string;email:string;salary:currency;birthday:TDateTime;gender:char):integer;
       class function Edit_PhysicalPerson(id:integer;name:string;email:string;salary:currency;birthday:TDateTime;gender:char):integer;
       class function Delete_PhysicalPerson(id:integer):integer;
       class function Login(username:string;password:string):integer;
    end;


implementation

class function TFacade.Insert_PhysicalPerson(name,
  email: string; salary: currency; birthday: TDateTime;
  gender: char): integer;
var
   ctr : TController;
   pp : TPhysicalPerson;
begin
   pp := TPhysicalPerson.Create;
   pp.setName(name);
   pp.setEmail(email);
   pp.setSalary(salary);
   pp.setBirthday(birthday);
   pp.setGender(gender);
   ctr := TController.Create(pp);
   result := ctr.Insert_PhysicalPerson;
end;

class function TFacade.Edit_PhysicalPerson(id: integer; name,
  email: string; salary: currency; birthday: TDateTime;
  gender: char): integer;
var
   ctr : TController;
   pp : TPhysicalPerson;
begin
   pp := TPhysicalPerson.Create;
   pp.setId(id);
   pp.setName(name);
   pp.setEmail(email);
   pp.setSalary(salary);
   pp.setBirthday(birthday);
   pp.setGender(gender);
   ctr := TController.Create(pp);
   result := ctr.Edit_PhysicalPerson;
end;

class function TFacade.Delete_PhysicalPerson(id: integer): integer;
var
   ctr : TController;
   pp : TPhysicalPerson;
begin
   pp := TPhysicalPerson.Create;
   pp.setId(id);
   ctr := TController.Create(pp);
   result := ctr.Delete_PhysicalPerson;
end;

class function TFacade.Login(username, password: string): integer;
var
   ctr : TController;
   usu : TUser;
begin
   usu := TUser.Create;
   usu.setUsername(username);
   usu.setPassword(password);
   ctr := TController.Create(usu);
   if ctr.Login <> NIL then
      result := 1
   else
      result := 0;
end;

end.
