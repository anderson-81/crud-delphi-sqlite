unit PhysicalPerson;

interface

uses
    Person, SysUtils;

type
    TPhysicalPerson = class(TInterfacedObject, IPerson)
    private
        id : integer;
        name : string;
        email : string;
        salary : currency;
        birthday : TDateTime;
        gender : char;
    public
        procedure setID(id : integer);
        function getID : integer;
        procedure setName(name : string);
        function getName : string;
        procedure setEmail(email:string);
        function getEmail : string;
        procedure setSalary(salary:currency);
        function getSalary : currency;
        procedure setBirthday(birthday:TDateTime);
        function getBirthday : TDateTime;
        procedure setGender(gender:char);
        function getGender : char;
    end;

implementation
{ TPhysicalPerson }

function TPhysicalPerson.getID: integer;
begin
  result := self.id;
end;

function TPhysicalPerson.getBirthday: TDateTime;
begin
  result := self.birthday;
end;

function TPhysicalPerson.getEmail: string;
begin
  result := self.email;
end;

function TPhysicalPerson.getName: string;
begin
  result := self.name;
end;

function TPhysicalPerson.getSalary: currency;
begin
  result := self.salary;
end;

function TPhysicalPerson.getGender: char;
begin
  result := self.gender;
end;

procedure TPhysicalPerson.setID(id: integer);
begin
  self.id := id;
end;

procedure TPhysicalPerson.setBirthday(birthday: TDateTime);
begin
  self.birthday := birthday;
end;

procedure TPhysicalPerson.setEmail(email: string);
begin
  self.email := email;
end;

procedure TPhysicalPerson.setName(name: string);
begin
  self.name := name;
end;

procedure TPhysicalPerson.setSalary(salary: currency);
begin
  self.salary := salary;
end;

procedure TPhysicalPerson.setGender(gender: char);
begin
  self.gender := gender;
end;

end.

