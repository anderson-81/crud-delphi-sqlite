unit FSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, FRegistration, DataModule, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection;

type
  TFrmSearch = class(TForm)
    txtDataSearch: TEdit;
    rdForName: TRadioButton;
    rdForID: TRadioButton;
    lblData: TLabel;
    btnSearch: TButton;
    DBPF: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure txtDataSearchChange(Sender: TObject);
    procedure rdForNameClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure DBPFDblClick(Sender: TObject);
    procedure rdForIDClick(Sender: TObject);
  private
    DM : TDM;
    { Private declarations }
    procedure ClearSearch;
    procedure Get_PhysicalPerson_By_ID(id:integer);
    procedure Get_PhysicalPerson_By_Name(name:string);
  public
    frmReg: TFrmRegistration;
    { Public declarations }
  end;

var
  FrmSearch: TFrmSearch;


implementation



{$R *.dfm}

procedure TFrmSearch.ClearSearch;
begin
   self.DBPF.Visible := false;
   self.DBPF.DataSource := NIL;
   self.rdForName.Checked := true;
   self.txtDataSearch.text := '';
end;

procedure TFrmSearch.txtDataSearchChange(Sender: TObject);
begin
    if(txtDataSearch.Text <> '') then
    begin
      self.btnSearch.Enabled := true;
      if(self.rdForID.Checked) then
      begin
         try
             StrToInt(self.txtDataSearch.text);
         except
             self.txtDataSearch.text := '';
         end;
      end;
    end
    else
      self.btnSearch.Enabled := false;
end;

procedure TFrmSearch.FormCreate(Sender: TObject);
begin
   ClearSearch; 
end;

 {
procedure TFrmSearch.DBPFDblClick(Sender: TObject);
begin
    self.Visible := false;
    if (frmReg = nil) then
    begin
      try
         FrmRegistration := TFrmRegistration.create (Application);
         self.Visible := false;
         FrmRegistration.PreparedRegisterForEdition(1, 'Anderson', 'andconc@globo.com', 3000, Now, 'M');
         FrmRegistration.ShowModal;
      finally
         FrmRegistration.Release;
         FrmRegistration := nil;
         self.Close;
      end;
    end
    else
    begin
      frmReg.PreparedRegisterForEdition(1, 'Anderson', 'andconc@globo.com', 3000, Now, 'M');
      self.Close;
    end;
end;

}

{
procedure TFrmSearch.btnSearchClick(Sender: TObject);
var
   pf : TPessoaFisica;
   list : TListaPessoaFisica;
begin
    if (self.rdForName.Checked) then
    begin
       pf := TCadastro.Buscar_PessoaFisica_PorCodigo(StrToInt(self.txtDataSearch.Text));
       if pf <> nil then
       begin
          self.DBPF.DataSource := pf;
          self.DBPF.Visible := true;
       end;
    end
    else
    begin
       list := TCadastro.Buscar_PessoaFisica_PorNome(self.txtDataSearch.Text);
       if list <> nil then
       begin
          self.DBPF.DataSource := list;
          self.DBPF.Visible := true;
       end;
    end;
end;
}

procedure TFrmSearch.Get_PhysicalPerson_By_ID(id:integer);
begin
   DM := TDM.Create(NIL);
   try
      DM.ZQuery.SQL.Clear;
      DM.ZQuery.SQL.Add('SELECT * FROM PERSON INNER JOIN PHYSICALPERSON ON PERSON.ID = PHYSICALPERSON.PERSON_ID WHERE PERSON.ID = :ID');
      DM.ZQuery.ParamByName('ID').AsInteger := id;
      DM.ZQuery.Open;
      if(DM.ZQuery.RecordCount > 0) then
      begin
         self.DBPF.DataSource := DM.DS;
         self.DBPF.Visible := true;
      end
      else
      begin
         Application.MessageBox('Nothing result.', 'Information', MB_OK+MB_ICONINFORMATION);
      end;
   except
       Application.MessageBox('Error search.', 'Error', MB_OK+MB_ICONERROR);
   end;
end;


procedure TFrmSearch.Get_PhysicalPerson_By_Name(name:string);
begin
   DM := TDM.Create(NIL);
   try
      DM.ZQuery.SQL.Clear;
      DM.ZQuery.SQL.Add('SELECT * FROM PERSON INNER JOIN PHYSICALPERSON ON PERSON.ID = PHYSICALPERSON.PERSON_ID WHERE PERSON.NAME LIKE :NAME');
      DM.ZQuery.ParamByName('NAME').AsString := name + '%';
      DM.ZQuery.Open;
      if(DM.ZQuery.RecordCount > 0) then
      begin
         self.DBPF.DataSource :=  DM.DS;
         self.DBPF.Visible := true;
      end
      else
      begin
         Application.MessageBox('Nothing result.', 'Information', MB_OK+MB_ICONINFORMATION);
      end;
   except
       Application.MessageBox('Error search.', 'Error', MB_OK+MB_ICONERROR);
   end;
end;

procedure TFrmSearch.btnSearchClick(Sender: TObject);
begin
    if (self.rdForID.Checked) then
    begin
       if (self.txtDataSearch.Text <> '') then
          self.Get_PhysicalPerson_By_ID(StrToInt(self.txtDataSearch.Text))
       else
          Application.MessageBox('Required field for search by id is empty.', 'Atention', MB_OK+MB_ICONWARNING);
    end
    else
       self.Get_PhysicalPerson_By_Name(self.txtDataSearch.Text);
end;

procedure TFrmSearch.rdForNameClick(Sender: TObject);
begin
   self.DBPF.Visible := false;
   self.DBPF.DataSource := NIL;
   self.txtDataSearch.text := '';
end;

procedure TFrmSearch.DBPFDblClick(Sender: TObject);
begin
    self.Visible := false;
    if (frmReg = nil) then
    begin
      try
         FrmRegistration := TFrmRegistration.create (Application);
         self.Visible := false;
         FrmRegistration.PreparedRegisterForEdition(self.DBPF.Fields[0].AsInteger, self.DBPF.Fields[1].AsString, self.DBPF.Fields[2].AsString, self.DBPF.Fields[3].AsCurrency, self.DBPF.Fields[4].AsDateTime, self.DBPF.Fields[5].AsString);
         DM.ZQuery.Close;
         FreeAndNil(DM);
         FrmRegistration.ShowModal;
      finally
         FrmRegistration.Release;
         FrmRegistration := nil;
         self.Close;
      end;
    end
    else
    begin
      frmReg.PreparedRegisterForEdition(self.DBPF.Fields[0].AsInteger, self.DBPF.Fields[1].AsString, self.DBPF.Fields[2].AsString, self.DBPF.Fields[3].AsCurrency, self.DBPF.Fields[4].AsDateTime, self.DBPF.Fields[5].AsString);
      DM.ZQuery.Close;
      FreeAndNil(DM);
      self.Close;
    end;
end;

procedure TFrmSearch.rdForIDClick(Sender: TObject);
begin
   self.DBPF.Visible := false;
   self.DBPF.DataSource := NIL;
   self.txtDataSearch.text := '';
end;

end.
