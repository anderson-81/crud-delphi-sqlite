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
    rdForCode: TRadioButton;
    Label1: TLabel;
    btnSearch: TButton;
    DBPF: TDBGrid;
    procedure txtDataSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
   
    procedure btnSearchClick(Sender: TObject);
    procedure rdForCodeClick(Sender: TObject);
    procedure rdForNameClick(Sender: TObject);
    procedure DBPFDblClick(Sender: TObject);
    //procedure btnSearchClick(Sender: TObject);
  private
    DM : TDM;
    { Private declarations }
    procedure ClearSearch;
    procedure Buscar_PessoaFisica_PorCodigo(codigo:integer);
    procedure Buscar_PessoaFisica_PorNome(nome:string);

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
      if(self.rdForCode.Checked) then
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

procedure TFrmSearch.Buscar_PessoaFisica_PorCodigo(codigo:integer);
begin
   DM := TDM.Create(NIL);
   try
      DM.ZQuery.SQL.Clear;
      DM.ZQuery.SQL.Add('SELECT * FROM PESSOA INNER JOIN PESSOAFISICA ON PESSOA.CODIGO = PESSOAFISICA.PESSOA_CODIGO WHERE PESSOA.CODIGO = :CODIGO');
      DM.ZQuery.ParamByName('CODIGO').AsInteger := codigo;
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


procedure TFrmSearch.Buscar_PessoaFisica_PorNome(nome:string);
begin
   DM := TDM.Create(NIL);
   try
      DM.ZQuery.SQL.Clear;
      DM.ZQuery.SQL.Add('SELECT * FROM PESSOA INNER JOIN PESSOAFISICA ON PESSOA.CODIGO = PESSOAFISICA.PESSOA_CODIGO WHERE PESSOA.NOME LIKE :NOME');
      DM.ZQuery.ParamByName('NOME').AsString := nome + '%';
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
    if (self.rdForCode.Checked) then
    begin
       if (self.txtDataSearch.Text <> '') then
          self.Buscar_PessoaFisica_PorCodigo(StrToInt(self.txtDataSearch.Text))
       else
          Application.MessageBox('Required field for search by code is empty.', 'Atention', MB_OK+MB_ICONWARNING);
    end
    else
       self.Buscar_PessoaFisica_PorNome(self.txtDataSearch.Text);
end;

procedure TFrmSearch.rdForCodeClick(Sender: TObject);
begin
   self.DBPF.Visible := false;
   self.DBPF.DataSource := NIL;
   self.txtDataSearch.text := '';
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




end.
