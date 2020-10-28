unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DateUtils, Facade, Mask, rxToolEdit,
  rxCurrEdit;

type
  TFrmRegistration = class(TForm)
    lblTitle: TLabel;
    lblName: TLabel;
    lblEmail: TLabel;
    lblSalary: TLabel;
    lblBirthday: TLabel;
    lblGender: TLabel;
    txtName: TEdit;
    txtEmail: TEdit;
    dtBirthday: TDateTimePicker;
    cmbGender: TComboBox;
    btnInsert: TButton;
    btnSearch: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    btnClean: TButton;
    currSalary: TCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure txtEmailExit(Sender: TObject);
    procedure dtBirthdayExit(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnCleanClick(Sender: TObject);
  private
    { Private declarations }
    birthday : TDateTime;
    id : integer;
    function ValidateEmail(const s: string): Boolean;
    procedure ClearFieldsInsert;
    function FieldTestEmpty:integer;
  public
    { Public declarations }
    procedure PreparedRegisterForEdition(id:integer; name:string; email:string; salary:currency; birthday:TDateTime; gender:String);
  end;

var
  FrmRegistration: TFrmRegistration;

implementation

uses FSearch;

{$R *.dfm}

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
   self.birthday := IncYear(Now,-18);
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
   self.id := 0;
   self.txtName.Text := '';
   self.txtEmail.Text := '';
   self.currSalary.Text := '';
   self.cmbGender.ItemIndex := 0;
   self.dtBirthday.Date := self.birthday;
   self.btnEdit.Enabled := false;
   self.btnDelete.Enabled := false;
   self.btnInsert.Enabled := true;
end;

procedure TFrmRegistration.dtBirthdayExit(Sender: TObject);
begin
   if dtBirthday.Date > self.birthday then
   begin
      dtBirthday.SetFocus;
      Application.MessageBox('Invalid Birthday.','Atention', 0);
   end;
end;

procedure TFrmRegistration.btnCleanClick(Sender: TObject);
begin
    self.ClearFieldsInsert;
end;

procedure TFrmRegistration.PreparedRegisterForEdition(id: integer; name,
  email: string; salary:currency; birthday: TDateTime; gender: String);
begin
    self.id := id;
    self.txtName.Text := name;
    self.txtEmail.Text := email;
    self.currSalary.Text := CurrTostr(salary);
    self.dtBirthday.Date := birthday;
    if(gender = 'M') then
      self.cmbGender.ItemIndex := 0
    else
      self.cmbGender.ItemIndex := 1;

   self.btnEdit.Enabled := true;
   self.btnDelete.Enabled := true;
   self.btnInsert.Enabled := false;
end;

function TFrmRegistration.FieldTestEmpty:integer;
begin
   if (self.txtName.Text <> '') then
      if (self.txtEmail.Text <> '') then
        if (self.currSalary.Text <> '') then
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
   gender : char;
begin
   if (FieldTestEmpty = 1) then
   begin
      if self.cmbGender.Text = 'Male' then
         gender := 'M'
      else
         gender := 'F';

      if TFacade.Insert_PhysicalPerson(self.txtName.Text, self.txtEmail.Text, StrToCurr(self.currSalary.Text), self.dtBirthday.Date, gender) = 1 then
      begin
         Application.MessageBox('Successfully inserted.', 'Information', MB_OK+MB_ICONINFORMATION);
         ClearFieldsInsert;
      end
      else
         Application.MessageBox('Error inserting.', 'Error', MB_OK+MB_ICONERROR);
   end
   else
     Application.MessageBox('Required Fields is empty.', 'Atention', MB_OK+MB_ICONWARNING);
end;


procedure TFrmRegistration.btnEditClick(Sender: TObject);
var
   gender : char;
begin
   if (FieldTestEmpty = 1) then
   begin
      if self.cmbGender.Text = 'Male' then
         gender := 'M'
      else
         gender := 'F';

      if TFacade.Edit_PhysicalPerson(id, self.txtName.Text, self.txtEmail.Text, StrToCurr(self.currSalary.Text), self.dtBirthday.Date, gender) = 1 then
      begin
         Application.MessageBox('Successfully edited.', 'Information', MB_OK+MB_ICONINFORMATION);
      end
      else
         Application.MessageBox('Error editing.', 'Error', MB_OK+MB_ICONERROR);
   end
   else
     Application.MessageBox('Required Fields is empty.', 'Atention', MB_OK+MB_ICONWARNING);
end;

procedure TFrmRegistration.btnDeleteClick(Sender: TObject);
begin
   if TFacade.Delete_PhysicalPerson(id) = 1 then
   begin
      Application.MessageBox('Successfully deleted.', 'Information', MB_OK+MB_ICONINFORMATION);
      ClearFieldsInsert;
   end
   else
      Application.MessageBox('Error deleting.', 'Error', MB_OK+MB_ICONERROR);
end;

procedure TFrmRegistration.btnSearchClick(Sender: TObject);
begin
   try
      FrmSearch := TFrmSearch.create(Application);
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




