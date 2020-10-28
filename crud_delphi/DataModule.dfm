object DM: TDM
  OldCreateOrder = False
  Left = 518
  Top = 224
  Height = 112
  Width = 210
  object ZConn: TZConnection
    ControlsCodePage = cGET_ACP
    AutoEncodeStrings = True
    TransactIsolationLevel = tiReadCommitted
    Port = 0
    Database = 'db.sqlite'
    Protocol = 'sqlite-3'
    LibraryLocation = 'sqlite3.dll'
    Left = 24
    Top = 16
  end
  object ZQuery: TZQuery
    Connection = ZConn
    Params = <>
    Left = 88
    Top = 16
  end
  object DS: TDataSource
    DataSet = ZQuery
    Left = 144
    Top = 16
  end
end
