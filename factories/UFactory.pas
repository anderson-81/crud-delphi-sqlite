unit UFactory;

interface

uses
  UUser, UPerson, UPhysicalPerson, UJuridicalPerson;

type
  TFactory = class
  private
  public
    function CreateUser(
               id: integer;
               username: string;
               password: string
              ): TUser;
             
    function CreatePhysicalPerson(
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
             ): TPhysicalPerson;
            
    function CreateJuridicalPerson(
               id: integer;
               cnpj: string;
               name: string;
               companyName: string;
               email: string;
               comment: string;
               status: boolean;
               createAt: TDateTime
             ): TJuridicalPerson;
  end;

implementation

function TFactory.CreateUser(
                    id: integer;
                    username: string;
                    password: string
                  ): TUser;
begin
  result := TUser.Create(id, username, password);
end;

function TFactory.CreatePhysicalPerson(
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
                  ): TPhysicalPerson;
begin
  result := TPhysicalPerson.Create(id, cpf, name, email, status, comment,
                                   salary, birthday, gender, createAt);
end;

function TFactory.CreateJuridicalPerson(id: integer; cnpj: string; name: string;
                                        companyName: string; email: string;
                                        comment: string; status: boolean;
                                        createAt: TDateTime): TJuridicalPerson;
begin
  result := TJuridicalPerson.Create(id, cnpj, name, companyName, email,
                                    comment, status, createAt);
end;

end.
