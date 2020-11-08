unit UPhysicalPerson;

interface

uses
  SysUtils, UPerson;

type
  TPhysicalPerson = class(TPerson)
  private
    id: integer;
    email: string;
    name: string;
    status: integer;
    comment: string;
    createAt: TDateTime;
    cpf: string;
    salary: currency;
    birthday: TDateTime;
    gender: char;
  public
    Constructor Create(
      id: integer;
      cpf: string;
      name: string;
      email: string;
      status: integer;
      comment: string;
      salary: currency;
      birthday: TDateTime;
      gender: char;
      createAt: TDateTime
    );
    procedure setID(id: integer); override;
    function getID: integer; override;
    procedure setName(name: string); override;
    function getName: string; override;
    procedure setEmail(email: string); override;
    function getEmail: string; override;
    procedure setStatus(status: integer); override;
    function getStatus: integer; override;
    procedure setComment(comment: string); override;
    function getComment: string; override;
    procedure setCreateAt(createAt: TDateTime); override;
    function getCreateAt: TDateTime; override;
    procedure setCPF(cpf: string);
    function getCPF: string;
    procedure setSalary(salary: currency);
    function getSalary: currency;
    procedure setBirthday(birthday: TDateTime);
    function getBirthday: TDateTime;
    procedure setGender(gender: char);
    function getGender: char;
  end;

implementation
{ TPhysicalPerson }

Constructor TPhysicalPerson.Create(
              id: integer;
              cpf: string;
              name: string;
              email: string;
              status: integer;
              comment: string;
              salary: currency;
              birthday: TDateTime;
              gender: char;
              createAt: TDateTime
            );
begin
  self.id := id;
  self.cpf := cpf;
  self.name := name;
  self.email := email;
  self.status := status;
  self.comment := comment;
  self.salary := salary;
  self.birthday := birthday;
  self.gender := gender;
  self.createAt := createAt;
end;

{ PERSON }

procedure TPhysicalPerson.setID(id: integer);
begin
  self.id := id;
end;

function TPhysicalPerson.getID: integer; 
begin
  result := self.id;
end;

procedure TPhysicalPerson.setName(name: string);
begin
  self.name := name;
end;

function TPhysicalPerson.getName: string; 
begin
  result := self.name;
end;

procedure TPhysicalPerson.setEmail(email: string);
begin
  self.email := email;
end;

function TPhysicalPerson.getEmail: string;
begin
  result := self.email;
end;

procedure TPhysicalPerson.setStatus(status: integer);
begin
  self.status := status;
end;

function TPhysicalPerson.getStatus: integer;
begin
  result := self.status;
end;

procedure TPhysicalPerson.setComment(comment: string);
begin
  self.comment := comment;
end;

function TPhysicalPerson.getComment: string;
begin
  result := self.comment;
end;

procedure TPhysicalPerson.setCreateAt(createAt: TDateTime);
begin
  self.createAt := createAt;
end;

function TPhysicalPerson.getCreateAt: TDateTime;
begin
  result := self.createAt;
end;

{ PHYSICALPERSON }

procedure TPhysicalPerson.setCPF(cpf: string);
begin
  self.cpf := cpf;
end;

function TPhysicalPerson.getCPF: string;
begin
  result := self.cpf;
end;

procedure TPhysicalPerson.setSalary(salary: currency);
begin
  self.salary := salary;
end;

function TPhysicalPerson.getSalary: currency;
begin
  result := self.salary;
end;

procedure TPhysicalPerson.setBirthday(birthday: TDateTime);
begin
  self.birthday := birthday;
end;

function TPhysicalPerson.getBirthday: TDateTime;
begin
  result := self.birthday;
end;

function TPhysicalPerson.getGender: char;
begin
  result := self.gender;
end;

procedure TPhysicalPerson.setGender(gender: char);
begin
  self.gender := gender;
end;

end.

