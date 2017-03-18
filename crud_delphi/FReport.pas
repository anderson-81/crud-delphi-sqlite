unit FReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, DataModule, DB;

type
  TFrmReport = class(TForm)
    QuickRep1: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Buscar_PessoaFisica_PorNome(nome:string);
  public
    { Public declarations }
  end;

var
  FrmReport: TFrmReport;

implementation

{$R *.dfm}

procedure TFrmReport.Buscar_PessoaFisica_PorNome(nome:string);
begin
   DM := TDM.Create(NIL);
   try
      DM.ZQuery.SQL.Clear;
      DM.ZQuery.SQL.Add('SELECT * FROM PESSOA INNER JOIN PESSOAFISICA ON PESSOA.CODIGO = PESSOAFISICA.PESSOA_CODIGO WHERE PESSOA.NOME LIKE :NOME');
      DM.ZQuery.ParamByName('NOME').AsString := nome + '%';
      DM.ZQuery.Open;
      if(DM.ZQuery.RecordCount < 1) then
      begin
         Application.MessageBox('Nothing result.', 'Information', MB_OK+MB_ICONINFORMATION);
         DM.ZQuery.Close;
         FreeAndNil(DM);
         self.Close;
      end
      else
      begin
         self.QuickRep1.Preview;
      end;
   except
       Application.MessageBox('Error Report.', 'Error', MB_OK+MB_ICONERROR);
       DM.ZQuery.Close;
       FreeAndNil(DM);
       self.Close;
   end;
end;


procedure TFrmReport.FormCreate(Sender: TObject);
begin
   self.Buscar_PessoaFisica_PorNome(''); 
end;

end.
