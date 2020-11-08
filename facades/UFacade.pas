unit UFacade;

interface

uses
  SysUtils, UUser, UPerson, UPhysicalPerson, UPhysicalPersonList,
  UUserController, UPhysicalPersonController, UFacadeValidationData, UFactory;

type
  TFacade = class
  private
    class function NewInstance: TObject; override;
  public
    class function getInstance: TFacade;
    destructor Destroy;
    function Insert_PhysicalPerson(
               cpf: string;
               name: string;
               email: string;
               status: integer;
               comment: string;
               salary: currency;
               birthday: TDateTime;
               gender: char
             ): Variant;
    function Edit_PhysicalPerson(
               id: Integer;
               name: string;
               email: string;
               status: integer;
               comment: string;
               salary: currency;
               birthday: TDateTime;
               gender: char
             ): Variant;
    function Get_PhysicalPerson_By_Name(name:string): TPhysicalPersonList;
    function Get_PhysicalPerson_By_ID(id: integer): TPhysicalPerson;
    function Delete_PhysicalPerson(id:integer):integer;
    function Login(username:string; password:string): integer;
  end;

var
  _instance: TFacade;

implementation

uses Variants;

{ SINGLETON }
class function TFacade.NewInstance: TObject;
begin
  if not Assigned(_instance) then
  begin
    _instance := TFacade(inherited NewInstance);
  end;
  result := _instance;
end;
 
class function TFacade.getInstance: TFacade;
begin
  result := TFacade.Create;
end;
{ SINGLETON }


function TFacade.Insert_PhysicalPerson(
                   cpf: string;
                   name: string;
                   email: string;
                   status: integer;
                   comment: string;
                   salary: currency;
                   birthday: TDateTime;
                   gender: char
                 ): Variant;
var
  ctr: TPhysicalPersonController;
  pp: TPhysicalPerson;
  return: Variant;
begin
  pp := TFactory.Create.CreatePhysicalPerson(0, cpf, name, email, status,
                          comment, salary, birthday, gender, Now);

  return := TFacadeValidationData.Create.ValidatePhysicalPerson(pp, False);
  if return = '' then
    return := TPhysicalPersonController.Create(pp).Insert_PhysicalPerson;

  result := return;
end;

function TFacade.Edit_PhysicalPerson(
                   id: Integer;
                   name: string;
                   email: string;
                   status: integer;
                   comment: string;
                   salary: currency;
                   birthday: TDateTime;
                   gender: char
                 ): Variant;
var
  ctr: TPhysicalPersonController;
  pp: TPhysicalPerson;
  return: Variant;
begin
  pp := TFactory.Create.CreatePhysicalPerson(id, '', name, email, status,
                          comment, salary, birthday, gender, Now);

  return := TFacadeValidationData.Create.ValidatePhysicalPerson(pp, True);
  if return = '' then
    return := TPhysicalPersonController.Create(pp).Edit_PhysicalPerson;

  result := return;
end;

function TFacade.Get_PhysicalPerson_By_Name(name:string): TPhysicalPersonList;
var
   ctr : TPhysicalPersonController;
   pp : TPhysicalPerson;
   list: TPhysicalPersonList;
begin
   pp := TFactory.Create.CreatePhysicalPerson(0, '', name, '', 0, '', 0, Now,
                           'M', Now);
   ctr := TPhysicalPersonController.Create(pp);
   result := ctr.Get_PhysicalPerson_By_Name;
end;

function TFacade.Get_PhysicalPerson_By_ID(id: integer): TPhysicalPerson;
var
   ctr : TPhysicalPersonController;
   pp : TPhysicalPerson;
begin
   pp := TFactory.Create.CreatePhysicalPerson(id, '', '', '', 0, '', 0, Now,
                           'M', Now);
   ctr := TPhysicalPersonController.Create(pp);
   result := ctr.Get_PhysicalPerson_By_ID;
end;

function TFacade.Delete_PhysicalPerson(id: integer): integer;
var
  pp: TPhysicalPerson;
begin
  pp := TFactory.Create.CreatePhysicalPerson(id, '', '', '', 0, '', 0, Now,
                          'M', Now);
  result := TPhysicalPersonController.Create(pp).Delete_PhysicalPerson;
end;

function TFacade.Login(username, password: string): integer;
var
  ctr: TUserController;
  usu: TUser;
begin
  ctr := TUserController.Create(TFactory.Create.CreateUser(0, username, password));
  if ctr.Login <> NIL then
    result := 1
  else
    result := 0;
end;

destructor TFacade.Destroy;
begin
  _instance:= nil;
  inherited;
end;

end.
