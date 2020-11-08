unit FSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBClient, DB, FRegistration,
  UFacade, UPhysicalPersonList, UPhysicalPerson, UDataSourceFactory;

type
  TFrmSearch = class(TForm)
    txtDataSearch: TEdit;
    rdForName: TRadioButton;
    rdForID: TRadioButton;
    lblData: TLabel;
    btnSearch: TButton;
    DBGridPP: TDBGrid;
    lblTitle: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure txtDataSearchChange(Sender: TObject);
    procedure rdForNameClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure DBGridPPDblClick(Sender: TObject);
    procedure DBGridPPDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure rdForIDClick(Sender: TObject);
  private
    { Private Attributes }
    facade: TFacade;

    { Private Methods }
    Constructor Create;
    procedure ClearSearch;
    procedure SetSelectedRecordOnForm(frmReg: TFrmRegistration;
                                      pp: TPhysicalPerson);
    procedure RdClick(enable: boolean);
    procedure ToggleVisibilityDBGrid(option: boolean);
    procedure Get_PhysicalPerson_By_Name(name: string);
    procedure Get_PhysicalPerson_By_ID(id: integer);
  public
    { Public Attributes }
    frmReg: TFrmRegistration;
  end;

var
  FrmSearch: TFrmSearch;

implementation

{$R *.dfm}

Constructor TFrmSearch.Create;
begin
  facade := TFacade.getInstance;
end;

procedure TFrmSearch.FormCreate(Sender: TObject);
begin
  ClearSearch;
end;

procedure TFrmSearch.ClearSearch;
begin
  DBGridPP.Visible := False;
  DBGridPP.DataSource := NIL;
  rdForName.Checked := True;
  txtDataSearch.text := '';
end;

procedure TFrmSearch.txtDataSearchChange(Sender: TObject);
begin
  if rdForID.Checked then
  begin
    btnSearch.Enabled := False;
    if txtDataSearch.Text <> '' then
    begin
      try
        StrToInt(txtDataSearch.text);
        btnSearch.Enabled := True;
      except
        txtDataSearch.text := '';
      end;
    end;
  end
  else
    btnSearch.Enabled := True;
end;

procedure TFrmSearch.ToggleVisibilityDBGrid(option: boolean);
begin
  if option then
    DBGridPP.Visible := True
  else
  begin
    DBGridPP.Visible := False;
    DBGridPP.DataSource := NIL;
  end;
end;

procedure TFrmSearch.btnSearchClick(Sender: TObject);
begin
  btnSearch.Enabled := False;
  
  ToggleVisibilityDBGrid(False);
  if (rdForID.Checked) then
  begin
    if (txtDataSearch.Text <> '') then
      Get_PhysicalPerson_By_ID(StrToInt(txtDataSearch.Text))
    else
      Application.MessageBox('Required field for search by id is empty.',
                             'Atention', MB_OK+MB_ICONWARNING);
  end
  else
    Get_PhysicalPerson_By_Name(txtDataSearch.Text);

  btnSearch.Enabled := True;
end;

procedure TFrmSearch.Get_PhysicalPerson_By_ID(id: integer);
var
  list: TPhysicalPersonList;
  pp: TPhysicalPerson;
begin
  pp := TFacade.getInstance.Get_PhysicalPerson_By_ID(id);
  if pp <> NIL then
  begin
    SetLength(list, 1);
    list[0] := pp;
    DBGridPP.DataSource := TDataSourceFactory
                             .Create
                             .CreatePhysicalPersonDataSourceFromTheList(list);
    ToggleVisibilityDBGrid(True);
  end
  else
    Application.MessageBox('No records found.', 'Information',
                            MB_OK+MB_ICONINFORMATION);
end;

procedure TFrmSearch.Get_PhysicalPerson_By_Name(name: string);
var
  list: TPhysicalPersonList;
begin
  list := TFacade.getInstance.Get_PhysicalPerson_By_Name(name);
  if Length(list) > 0 then
  begin
    DBGridPP.DataSource := TDataSourceFactory
                             .Create
                             .CreatePhysicalPersonDataSourceFromTheList(list);
    ToggleVisibilityDBGrid(True);
  end
  else
    Application.MessageBox('No records found.', 'Information',
                            MB_OK+MB_ICONINFORMATION);
end;

procedure TFrmSearch.rdForNameClick(Sender: TObject);
begin
  RdClick(True);
end;

procedure TFrmSearch.RdClick(enable: boolean);
begin
  DBGridPP.Visible := False;
  DBGridPP.DataSource := NIL;
  txtDataSearch.text := '';
  btnSearch.Enabled := enable;
  txtDataSearch.SetFocus;
end;

procedure TFrmSearch.DBGridPPDblClick(Sender: TObject);
var
  pp: TPhysicalPerson;
begin
  pp := TFacade.getInstance
                  .Get_PhysicalPerson_By_ID(DBGridPP.Fields[0].AsInteger);
  if pp <> NIL then
  begin
    if (frmReg = nil) then
    begin
      try
        FrmRegistration := TFrmRegistration.create(Application);
        SetSelectedRecordOnForm(FrmRegistration, pp);
        Visible := False;
        FrmRegistration.ShowModal;
      finally
        FrmRegistration.Release;
        FrmRegistration := nil;
        Close;
      end;
    end
    else
    begin
      SetSelectedRecordOnForm(frmReg, pp);
      Close;
    end;
  end
  else
  begin
    Application.MessageBox('No records found.', 'Information',
                            MB_OK+MB_ICONINFORMATION);
    ClearSearch;
  end;
end;

procedure TFrmSearch.SetSelectedRecordOnForm(frmReg: TFrmRegistration;
                                             pp: TPhysicalPerson);
begin
  frmReg.SetRegisterForEdition(
           pp.getID,
           pp.getCPF,
           pp.getName,
           pp.getEmail,
           pp.getStatus,
           pp.getComment,
           pp.getSalary,
           pp.getBirthday,
           pp.getGender,
           pp.getCreateAt
        );
end;

procedure TFrmSearch.DBGridPPDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  {Remove Horizontal}
  ShowScrollBar(DBGridPP.Handle,SB_HORZ,False);
end;

procedure TFrmSearch.rdForIDClick(Sender: TObject);
begin
  RdClick(False);
end;

end.
