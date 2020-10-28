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
    qrlhID: TQRLabel;
    qrlhNAME: TQRLabel;
    qrlhEMAIL: TQRLabel;
    qrlhSALARY: TQRLabel;
    qrlhBIRTHDAY: TQRLabel;
    qrlhGENDER: TQRLabel;
    qrlID: TQRDBText;
    qrlNAME: TQRDBText;
    qrlEMAIL: TQRDBText;
    qrlSALARY: TQRDBText;
    qrlBIRTHDAY: TQRDBText;
    qrlGENDER: TQRDBText;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateReport;
  end;

var
  FrmReport: TFrmReport;

implementation

{$R *.dfm}

procedure TFrmReport.CreateReport;
begin
   DM := TDM.Create(NIL);
   try
      DM.ZQuery.SQL.Clear;
      DM.ZQuery.SQL.Add('SELECT * FROM PERSON INNER JOIN PHYSICALPERSON ON PERSON.ID = PHYSICALPERSON.PERSON_ID WHERE PERSON.NAME LIKE :NAME');
      DM.ZQuery.ParamByName('NAME').AsString := '%';
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

end.
