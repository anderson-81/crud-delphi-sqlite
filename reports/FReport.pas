unit FReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, QRCtrls, ExtCtrls, DB, UFacade, UPhysicalPersonList, UDataSourceFactory;

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
  private
    { Private Methods   }
    procedure SetDataSetToReport(dataSet: TDataSet);
  public
    { Public Attributes }
    procedure CreateReport;
  end;

var
  FrmReport: TFrmReport;

implementation

{$R *.dfm}

procedure TFrmReport.CreateReport;
var
  list: TPhysicalPersonList;
begin
  list := TFacade.getInstance.Get_PhysicalPerson_By_Name('');
  if Length(list) > 0 then
  begin
    SetDataSetToReport(TDataSourceFactory.Create
                         .CreatePhysicalPersonDataSourceFromTheList(list)
                         .DataSet);
    QuickRep1.Preview;
  end
  else
    Application.MessageBox('No records found.', 'Information',
                            MB_OK+MB_ICONINFORMATION);
end;

procedure TFrmReport.SetDataSetToReport(dataSet: TDataSet);
var
  i: integer;
begin
  For i := 0 to self.ComponentCount - 1 do
  begin
    if Components[i].ClassType = TQRDBText then
      (Components[i] as TQRDBText).DataSet := dataSet;
  end;
  QuickRep1.DataSet := dataSet;
end;

end.
