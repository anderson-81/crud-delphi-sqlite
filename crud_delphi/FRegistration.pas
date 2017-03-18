unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DateUtils, Cadastro;

type
  TFrmRegistration = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtName: TEdit;
    Label3: TLabel;
    txtEmail: TEdit;
    Label4: TLabel;
    txtSalary: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    dtDateBirth: TDateTimePicker;
    cmbGenre: TComboBox;
    btnSearch: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    btnInsert: TButton;
    Button1: TButton;
    procedure txtSalaryChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtEmailExit(Sender: TObject);
    procedure dtDateBirthExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
    //formSearch : TFrmSearch;
    dateBirth : TDateTime;
    code : integer;
    function ValidateEmail(const s: string): Boolean;
    procedure ClearFieldsInsert;
    function FieldTestEmpty:integer;


  public
    { Public declarations }
    procedure PreparedRegisterForEdition(code:integer; name:string; email:string; salary:currency; dateBirth:TDateTime; genre:String);
  end;

var
  FrmRegistration: TFrmRegistration;

implementation

uses FSearch;

{$R *.dfm}

procedure TFrmRegistration.txtSalaryChange(Sender: TObject);
begin
    if(self.txtSalary.Text <> '') then
    begin
        try
            StrToCurr(self.txtSalary.Text);
        except
            self.txtSalary.Text := '';
        end;
    end;
end;

//Source Code: http://www.swissdelphicenter.ch/en/showcode.php?id=249

function TFrmRegistration.ValidateEmail(const s: string): Boolean;
var
  i: Integer;
  c: string;
begin // ' ', ä, ö, ü, ß, [, ], (, ), : in EMail-Address
  Result := (Trim(s) = '') or (Pos(' ', AnsiLowerCase(s)) > 0) or
    (Pos('ä', AnsiLowerCase(s)) > 0) or (Pos('ö', AnsiLowerCase(s)) > 0) or
    (Pos('ü', AnsiLowerCase(s)) > 0) or (Pos('ß', AnsiLowerCase(s)) > 0) or
    (Pos('[', AnsiLowerCase(s)) > 0) or (Pos(']', AnsiLowerCase(s)) > 0) or
    (Pos('(', AnsiLowerCase(s)) > 0) or (Pos(')', AnsiLowerCase(s)) > 0) or
    (Pos(':', AnsiLowerCase(s)) > 0);
  if Result then Exit; // @ not in EMail-Address;
  i      := Pos('@', s);
  Result := (i = 0) or (i = 1) or (i = Length(s));
  if Result then Exit;
  Result := (Pos('@', Copy(s, i + 1, Length(s) - 1)) > 0);
  if Result then Exit; // Domain <= 1
  c      := Copy(s, i + 1, Length(s));
  Result := Length(c) <= 1;
  if Result then Exit;
  i      := Pos('.', c);
  Result := (i = 0) or (i = 1) or (i = Length(c));
end;


procedure TFrmRegistration.FormCreate(Sender: TObject);
begin
   self.dateBirth := IncYear(Now,-18);
   ClearFieldsInsert;
end;

procedure TFrmRegistration.txtEmailExit(Sender: TObject);
begin
    if(txtEmail.Text <> '') then
    begin
      if ValidateEmail(txtEmail.Text) <> false then
      begin
        txtEmail.SetFocus;
        Application.MessageBox('Invalid Email.','Atention', 0);
      end;
    end;
end;

procedure TFrmRegistration.ClearFieldsInsert;
begin
   self.code := 0;
   self.txtName.Text := '';
   self.txtEmail.Text := '';
   self.txtSalary.Text := '';
   self.dtDateBirth.Date := self.dateBirth;
   self.cmbGenre.ItemIndex := 0;
   self.btnEdit.Enabled := false;
   self.btnDelete.Enabled := false;
   self.btnInsert.Enabled := true;
end;

procedure TFrmRegistration.dtDateBirthExit(Sender: TObject);
begin
   if dtDateBirth.Date > self.dateBirth then
   begin
      dtDateBirth.SetFocus;
      Application.MessageBox('Invalid Date of Birth.','Atention', 0);
   end;
end;

procedure TFrmRegistration.Button1Click(Sender: TObject);
begin
    self.ClearFieldsInsert;
end;

procedure TFrmRegistration.PreparedRegisterForEdition(code: integer; name,
  email: string; salary:currency; dateBirth: TDateTime; genre: String);
begin
    self.code := code;
    self.txtName.Text := name;
    self.txtEmail.Text := email;
    self.txtSalary.Text := CurrTostr(salary);
    self.dtDateBirth.Date := dateBirth;
    if(genre = 'M') then
      self.cmbGenre.ItemIndex := 0
    else
      self.cmbGenre.ItemIndex := 1;

   self.btnEdit.Enabled := true;
   self.btnDelete.Enabled := true;
   self.btnInsert.Enabled := false;
end;

function TFrmRegistration.FieldTestEmpty:integer;
begin
   if (self.txtName.Text <> '') then
      if (self.txtEmail.Text <> '') then
        if (self.txtSalary.Text <> '') then
          result := 1
        else
          result := 0
      else
        result := 0
   else
     result := 0;
end;


procedure TFrmRegistration.btnInsertClick(Sender: TObject);
var
   genre : char;
begin
   if (FieldTestEmpty = 1) then
   begin
      if self.cmbGenre.Text = 'Male' then
         genre := 'M'
      else
         genre := 'F';

      if TCadastro.Incluir_PessoaFisica(self.txtName.Text, self.txtEmail.Text, StrToCurr(self.txtSalary.Text), self.dtDateBirth.Date, genre) = 1 then
      begin
         Application.MessageBox('Successful insert.', 'Information', MB_OK+MB_ICONINFORMATION);
         ClearFieldsInsert;
      end
      else
         Application.MessageBox('Error insert.', 'Error', MB_OK+MB_ICONERROR);
   end
   else
     Application.MessageBox('Required Fields is empty.', 'Atention', MB_OK+MB_ICONWARNING);
end;

procedure TFrmRegistration.btnEditClick(Sender: TObject);
var
   genre : char;
begin
   if (FieldTestEmpty = 1) then
   begin
      if self.cmbGenre.Text = 'Male' then
         genre := 'M'
      else
         genre := 'F';

      if TCadastro.Editar_PessoaFisica(code, self.txtName.Text, self.txtEmail.Text, StrToCurr(self.txtSalary.Text), self.dtDateBirth.Date, genre) = 1 then
      begin
         Application.MessageBox('Successful edition.', 'Information', MB_OK+MB_ICONINFORMATION);
      end
      else
         Application.MessageBox('Error edition.', 'Error', MB_OK+MB_ICONERROR);
   end
   else
     Application.MessageBox('Required Fields is empty.', 'Atention', MB_OK+MB_ICONWARNING);
end;

procedure TFrmRegistration.btnDeleteClick(Sender: TObject);
begin
   if TCadastro.Excluir_PessoaFisica(code) = 1 then
   begin
      Application.MessageBox('Successful delete.', 'Information', MB_OK+MB_ICONINFORMATION);
      ClearFieldsInsert;
   end
   else
      Application.MessageBox('Error delete.', 'Error', MB_OK+MB_ICONERROR);
end;

procedure TFrmRegistration.btnSearchClick(Sender: TObject);
begin
   try
      FrmSearch := TFrmSearch.create (Application);
      self.Visible := false;
      FrmSearch.frmReg := self;
      FrmSearch.ShowModal;
   finally
      self.Visible := true;
      FrmSearch.Release;
      FrmSearch := nil;
   end;
end;

end.




