unit FRegistration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DateUtils, UFacade, Mask, rxToolEdit,
  rxCurrEdit, DBCtrls;

type
  TFrmRegistration = class(TForm)
    lblTitle: TLabel;
    lblCPF: TLabel;
    lblName: TLabel;
    lblEmail: TLabel;
    lblSalary: TLabel;
    lblBirthday: TLabel;
    lblGender: TLabel;
    lblComment: TLabel;
    lblCreateAtTitle: TLabel;
    lblCreateAt: TLabel;
    lblStatus: TLabel;
    edtName: TEdit;
    edtEmail: TEdit;
    currEdtSalary: TCurrencyEdit;
    dtpBirthday: TDateTimePicker;
    cmbGender: TComboBox;
    rbTrue: TRadioButton;
    rbFalse: TRadioButton;
    btnClean: TButton;
    gpBoxOperations: TGroupBox;
    btnEdit: TButton;
    btnDelete: TButton;
    btnSearch: TButton;
    btnInsert: TButton;
    mskEdtCPF: TMaskEdit;
    memoComment: TMemo;
    procedure FormShow(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCleanClick(Sender: TObject);
    procedure mskEdtCPFEnter(Sender: TObject);
  private
    { Private declarations }
    birthday : TDateTime;
    id : integer;
    facade: TFacade;
    edition: boolean;
    Constructor create;
    procedure ClearFields;
    procedure ToggleCPF(opc: boolean);
    function getGender: char;
    function getStatus: integer;
    function getSalary: Currency;
  public
    { Public declarations }
    procedure SetRegisterForEdition(
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
  end;

var
  FrmRegistration: TFrmRegistration;

implementation

uses FSearch, Math, TypInfo;

{$R *.dfm}

Constructor TFrmRegistration.Create;
begin
  facade := TFacade.getInstance;
end;

procedure TFrmRegistration.FormShow(Sender: TObject);
begin
  ClearFields;
end;

procedure TFrmRegistration.btnInsertClick(Sender: TObject);
var
  return: variant;
  errors: string;
begin
  return := TFacade.getInstance.Insert_PhysicalPerson(
                                  mskEdtCPF.Text,
                                  edtName.Text,
                                  edtEmail.Text,
                                  getStatus,
                                  memoComment.Text,
                                  getSalary,
                                  dtpBirthday.Date,
                                  getGender
                                );

  if VarType(return) = varInteger then
  begin
    if return = 1 then
    begin
      Application.MessageBox('Successfully inserted.', 'Information',
                              MB_OK+MB_ICONINFORMATION);
      ClearFields;
    end
    else
      Application.MessageBox('Error inserting.', 'Error', MB_OK+MB_ICONERROR);
  end
  else
  begin
    errors := return;
    Application.MessageBox(PAnsiChar(errors), 'Attention',
                           MB_OK+MB_ICONWARNING);
  end;
end;

procedure TFrmRegistration.btnSearchClick(Sender: TObject);
begin
  try
    FrmSearch := TFrmSearch.create(Application);
    Visible := False;
    FrmSearch.frmReg := self;
    FrmSearch.ShowModal;
  finally
    Visible := True;
    FrmSearch.Release;
    FrmSearch := nil;
  end;
end;

procedure TFrmRegistration.btnEditClick(Sender: TObject);
var
  return: variant;
  errors: string;
begin
  if MessageDlg('Do you want edit this record?', mtConfirmation, [mbyes,mbno],0)
                = mryes then
  begin
    return := TFacade.getInstance.Edit_PhysicalPerson(
                                    id,
                                    edtName.Text,
                                    edtEmail.Text,
                                    getStatus,
                                    memoComment.Text,
                                    getSalary,
                                    dtpBirthday.Date,
                                    getGender
                                  );

    if VarType(return) = varInteger then
    begin
      if return = 1 then
        Application.MessageBox('Successfully edited.', 'Information',
                               MB_OK+MB_ICONINFORMATION)
      else
        Application.MessageBox('Error editing.', 'Error', MB_OK+MB_ICONERROR);
    end
    else
    begin
      errors := return;
      Application.MessageBox(PAnsiChar(errors), 'Attention',
                             MB_OK+MB_ICONWARNING);
    end;
  end;
end;

procedure TFrmRegistration.btnDeleteClick(Sender: TObject);
var
  return: variant;
begin
  if MessageDlg('Do you want delete this record?', mtConfirmation,
                 [mbyes,mbno],0) = mryes then
  begin
    return := TFacade.getInstance.Delete_PhysicalPerson(id);
    if VarType(return) = varInteger then
    begin
      if return = 1 then
      begin
        Application.MessageBox('Successfully deleted.', 'Information',
                               MB_OK+MB_ICONINFORMATION);
        edition := False;
        ClearFields;
      end
      else
        Application.MessageBox('Error deleting.', 'Error', MB_OK+MB_ICONERROR);
    end;
  end;
end;


procedure TFrmRegistration.btnCleanClick(Sender: TObject);
begin
  if MessageDlg('Do you want clear the form??', mtConfirmation, [mbyes,mbno],0)
     = mryes then
  begin
    edition := False;
    ClearFields;
  end;
end;

procedure TFrmRegistration.ClearFields;
begin
  if edition = False then
  begin
    id := 0;
    mskEdtCPF.Text := '';
    ToggleCPF(False);
    edtName.Text := '';
    edtEmail.Text := '';
    currEdtSalary.Value := 0.00;
    birthday := IncYear(Now, -18);
    dtpBirthday.Date := birthday;
    cmbGender.ItemIndex := 0;
    rbTrue.Checked := True;
    memoComment.Text := '';
    lblCreateAt.Caption := '';
    mskEdtCPF.SetFocus;
    btnEdit.Enabled := False;
    btnDelete.Enabled := False;
    btnInsert.Enabled := True;
  end;
end;

function TFrmRegistration.getGender: char;
begin
  if cmbGender.ItemIndex = 0 then result := 'M' else result := 'F';
end;

function TFrmRegistration.getStatus: integer;
begin
  if rbTrue.Checked then result := 1 else result := 0;
end;

function TFrmRegistration.getSalary: Currency;
begin
  try
    result := StrToCurr(currEdtSalary.Text);
  Except
    result := 0;
  end;
end;

procedure TFrmRegistration.SetRegisterForEdition(
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
  mskEdtCPF.Text := cpf;
  ToggleCPF(True);
  edtName.Text := name;
  edtEmail.Text := email;
  if status = 1 then rbTrue.Checked := True else rbFalse.Checked := True;
  memoComment.Text := comment;
  currEdtSalary.Text := CurrTostr(salary);
  dtpBirthday.Date := birthday;
  if(gender = 'M') then
    cmbGender.ItemIndex := 0
  else
    cmbGender.ItemIndex := 1;
  lblCreateAt.Caption := DateTimeToStr(createAt);
  btnEdit.Enabled := True;
  btnDelete.Enabled := True;
  btnInsert.Enabled := False;
  edition := True;
end;

procedure TFrmRegistration.ToggleCPF(opc: boolean);
begin
  mskEdtCPF.ReadOnly := opc;
  if opc then mskEdtCPF.Color := clSilver else mskEdtCPF.Color := clWindow;
end;

procedure TFrmRegistration.mskEdtCPFEnter(Sender: TObject);
begin
  if mskEdtCPF.ReadOnly then edtName.SetFocus;
end;

end.




