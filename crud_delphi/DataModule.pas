unit DataModule;

interface

uses
  SysUtils, Classes, DB, ADODB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZAbstractConnection, ZConnection;

type
  TDM = class(TDataModule)
    ZConn: TZConnection;
    ZQuery: TZQuery;
    DS: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
