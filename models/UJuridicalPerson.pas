unit UJuridicalPerson;

interface

uses
  SysUtils, UPerson;

type
  TJuridicalPerson = class(TPerson)
  private
    id : integer;
    cnpj : string;
    name : string;
    companyName : string;
    email : string;
    comment : string;
    status : boolean;
    createAt : TDateTime;
  public
    Constructor Create(id : integer; cnpj : string; name : string;
    companyName : string; email : string;  comment : string; status : boolean;
    createAt : TDateTime);
    procedure setId(id : integer); override;
    function getId: integer; override;
    procedure setCNPJ(cnpj : string);
    function getCNPJ: string;
    procedure setName(name : string); override;
    function getName: string; override;
    procedure setCompanyName(companyName : string);
    function getCompanyName : string;
    procedure setEmail(email : string); override;
    function getEmail: string; override;
    procedure setComment(comment : string);
    function getComment: string;
    procedure setStatus(status : boolean);
    function getStatus: boolean;
    procedure setCreateAt(createAt : TDateTime);
    function getCreateAt: TDateTime;
  end;

implementation

Constructor TJuridicalPerson.Create(id: integer; cnpj: string; name: string;
    companyName: string; email: string; comment: string; status: boolean;
    createAt: TDateTime);
begin
  self.id := id;
  self.cnpj := cnpj;
  self.name := name;
  self.companyName := companyName;
  self.email := email;
  self.comment := comment;
  self.status := status;
  self.createAt := createAt;
end;

procedure TJuridicalPerson.setId(id: integer);
begin
  self.id := id;
end;

function TJuridicalPerson.getId: integer;
begin
  result := self.id;
end;

procedure TJuridicalPerson.setCNPJ(cnpj: string);
begin
  self.cnpj := cnpj;
end;

function TJuridicalPerson.getCNPJ: string;
begin
  result := self.cnpj;
end;

procedure TJuridicalPerson.setName(name: string);
begin
  self.name := name;
end;

function TJuridicalPerson.getName: string;
begin
  result := self.name;
end;

procedure TJuridicalPerson.setCompanyName(companyName: string);
begin
  self.companyName := companyName;
end;

function TJuridicalPerson.getCompanyName: string;
begin
  result := self.companyName;
end;

procedure TJuridicalPerson.setEmail(email: string);
begin
  self.email := email;
end;

function TJuridicalPerson.getEmail: string;
begin
  result := self.email;
end;

procedure TJuridicalPerson.setComment(comment: string);
begin
  self.comment := comment;
end;

function TJuridicalPerson.getComment: string;
begin
  result := self.comment;
end;

procedure TJuridicalPerson.setStatus(status: boolean);
begin
  self.status := status;
end;

function TJuridicalPerson.getStatus: boolean;
begin
  result := self.status;
end;

procedure TJuridicalPerson.setCreateAt(createAt: TDateTime);
begin
  self.createAt := createAt;
end;

function TJuridicalPerson.getCreateAt: TDateTime;
begin
  result := self.createAt;
end;

end.
