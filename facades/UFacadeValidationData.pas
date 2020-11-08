unit UFacadeValidationData;

interface

uses
  SysUtils, UPerson, UPhysicalPerson, UUser, UAppController, PCRE, pcre_dll,
  Variants, DateUtils, Classes;

type
  TFacadeValidationData = class
  private
    errors: string;
    { SINGLETON }
    class function NewInstance: TFacadeValidationData;

    function CheckIfIsNullOrEmpty(data: Variant): boolean;
    function CheckIfIsNotNullOrEmpty(data: Variant): boolean;
    function CheckIfStringSizeIsValid(min: integer; max: integer;
                                      data: string): boolean;
    function CheckRegex(pattern: string; data: string): boolean;
    function CheckIsOnNumericRange(min: double; max: double;
                                   num: double): boolean;
    function CheckYear(pdate: TDateTime; year: integer): boolean;
    function CheckIfExistInDatabase(table: string; column: string;
                                    value: string): boolean;

    { ERRORS }
    procedure SetError(error: string);

    { SPECIFIC VALIDATIONS }
    function ValidateCPF(CPF: string): boolean;
  public
    class function getInstance: TFacadeValidationData;
    function ValidatePhysicalPerson(pp: TPhysicalPerson;
                                    edition: boolean): Variant;
    function ValidateUser(user: TUser): Variant;
  end;

var
  instance : TFacadeValidationData;

implementation

uses Math, UFacade;

{ SINGLETON }
class function TFacadeValidationData.NewInstance: TFacadeValidationData;
begin
  if not Assigned(instance) then
  begin
    instance := TFacadeValidationData(inherited NewInstance);
  end;
  result := instance;
end;
 
class function TFacadeValidationData.getInstance: TFacadeValidationData;
begin
  result := TFacadeValidationData.Create;
end;
{ SINGLETON }

{ PUBLIC }
function TFacadeValidationData.ValidatePhysicalPerson(pp: TPhysicalPerson;
                                                      edition: boolean)
                                                      : Variant;
var
  temp: TPhysicalPerson;
begin
  if edition then
  begin
    { ID }
    if CheckIfIsNullOrEmpty(pp.getID) then
      SetError('ID is Empty.')
    else
    begin
      if not CheckIsOnNumericRange(1, MaxInt, pp.getID) then
        SetError('Invalid ID.');
    end;
  end;

  if not edition then
  begin
    { CPF }
    if CheckIfIsNullOrEmpty(pp.getCPF) then
      SetError('CPF is empty.')
    else
    begin
      if CheckIfStringSizeIsValid(11, 11, pp.getCPF) then
      begin
        if CheckRegex('([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}' +
                      '[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}' +
                      '[-]?[0-9]{2})', pp.getCPF) then
        begin
          if ValidateCPF(pp.getCPF) then
          begin
            if CheckIfExistInDatabase('physicalperson', 'cpf', pp.getCPF) then
              SetError('CPF already registered.')
          end
          else
            SetError('Invalid CPF.')
        end
        else
          SetError('Invalid CPF.')
      end
      else
        SetError('Invalid character quantity for CPF.')
    end;
  end;

  { NAME }
  if CheckIfIsNullOrEmpty(pp.getName) then
    SetError('Name is Empty.')
  else
  begin
    if not CheckIfStringSizeIsValid(3, 45, pp.getName) then
      SetError('Invalid character quantity for name. [MIN: 3 | MAX: 45]')
  end;

  { EMAIL }
  if CheckIfIsNullOrEmpty(pp.getEmail) then
    SetError('E-mail is empty.')
  else
  begin
    if not CheckIfStringSizeIsValid(7, 45, pp.getEmail) then
      SetError('Invalid character quantity for e-mail.')
    else
    begin
      if not CheckRegex('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\' +
                        '.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$', pp.getEmail) then
        SetError('Invalid e-mail.')
      else
      begin
        if not edition then
        begin
          if CheckIfExistInDatabase('person', 'email', pp.getEmail) then
            SetError('E-mail already registered.');
        end
        else
        begin
          temp := TFacade.getInstance.Get_PhysicalPerson_By_ID(pp.getID);
          if pp.getEmail <> temp.getEmail then
          begin
            if CheckIfExistInDatabase('person', 'email', pp.getEmail) then
              SetError('E-mail already registered.');
          end;
        end;
      end
    end
  end;

  {SALARY}
  if CheckIfIsNullOrEmpty(pp.getSalary) then
    SetError('Salary is empty.')
  else
  begin
    if not CheckIsOnNumericRange(0, MaxDouble, pp.getSalary) then
      SetError('Invalid salary.')
  end;

  { BIRTHDAY }
  if CheckIfIsNullOrEmpty(pp.getBirthday) then
    SetError('Birthday is Empty.')
  else
  begin
    if not CheckYear(pp.getBirthday, -18) then
      SetError('Invalid Birthday. Only people over 18 can be registered.')
  end;

  { GENDER }
  if CheckIfIsNullOrEmpty(pp.getGender) then
    SetError('Gender is Empty.')
  else
  begin
    if not CheckIfStringSizeIsValid(1, 1, pp.getGender) then
      SetError('Invalid character quantity for gender.')
    else
      if not CheckRegex('[M{1},F{1}]', pp.getGender) then
        SetError('Gender is empty.');
  end;

  { COMMENT }
  if CheckIfIsNullOrEmpty(pp.getComment) then
    SetError('Comment is Empty.');
  
  { STATUS }
  if CheckIfIsNullOrEmpty(pp.getStatus) then
    SetError('Status is empty.')
  else
  begin
    if CheckRegex('/^[01]$/', IntToStr(pp.getStatus)) then
      SetError('Invalid status.');
  end;

  result := errors;
end;

function TFacadeValidationData.ValidateUser(user: TUser): Variant;
begin
  result := true;
end;
{ PUBLIC }

{ PRIVATE }
function TFacadeValidationData.CheckIfIsNullOrEmpty(data: Variant): boolean;
begin
  result := ((VarToStr(data) = '') or (data = Null) or
            (Length(VarToStr(data)) = 0));

end;

function TFacadeValidationData.CheckIfIsNotNullOrEmpty(data: Variant): boolean;
begin
  result := not ((VarToStr(data) = '') or (data = Null) or
                (Length(VarToStr(data)) = 0));
end;

function TFacadeValidationData.CheckIfStringSizeIsValid(min: integer;
                                                        max: integer;
                                                        data: string): boolean;
begin
  result := ((Length(data) >= min) and (Length(data) <= max));
end;

function TFacadeValidationData.CheckRegex(pattern: string;
                                          data: string): boolean;
begin
  Result := RegexCreate(pattern).Match(data, [rmoAnchored]).Success and
            (RegexCreate(pattern).Match(data, [rmoAnchored]).Length =
            Length(data));
end;

function TFacadeValidationData.CheckIsOnNumericRange(min: double;
                                                     max: double;
                                                     num: double) : boolean;
begin
  result := ((num >= min) and (num <= max));
end;

function TFacadeValidationData.CheckYear(pdate: TDateTime;
                                         year: integer): boolean;
begin
  result := (pdate <= IncYear(Now, year));
end;

function TFacadeValidationData.CheckIfExistInDatabase(table: string;
                                                      column: string;
                                                      value: string): boolean;
begin
  result := TAppController.Create.CheckIfExistInDatabase(table, column, value);
end;

procedure TFacadeValidationData.SetError(error: string);
begin
  errors := errors + #13#10 + error;
end;
{ PRIVATE }

{ SPECIFIC VALIDATIONS }
function TFacadeValidationData.ValidateCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
  // length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              ValidateCPF := false;
              exit;
            end;

  // try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
    { *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      // StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

    { *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then ValidateCPF := true
    else ValidateCPF := false;
  except
    ValidateCPF := false
  end;
end;
{ SPECIFIC VALIDATIONS }

end.
