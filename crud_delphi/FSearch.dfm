object FrmSearch: TFrmSearch
  Left = 425
  Top = 238
  BorderStyle = bsToolWindow
  Caption = 'Registration System - Search'
  ClientHeight = 522
  ClientWidth = 684
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 24
  object lblData: TLabel
    Left = 16
    Top = 56
    Width = 133
    Height = 24
    Caption = 'Data for Search:'
  end
  object txtDataSearch: TEdit
    Left = 16
    Top = 80
    Width = 650
    Height = 32
    TabOrder = 0
    OnChange = txtDataSearchChange
  end
  object rdForName: TRadioButton
    Tag = 2
    Left = 448
    Top = 16
    Width = 113
    Height = 17
    Caption = 'For Name'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = rdForNameClick
  end
  object rdForID: TRadioButton
    Tag = 1
    Left = 568
    Top = 16
    Width = 113
    Height = 17
    Caption = 'For Code'
    TabOrder = 2
    OnClick = rdForIDClick
  end
  object btnSearch: TButton
    Tag = 3
    Left = 472
    Top = 120
    Width = 195
    Height = 25
    Caption = 'SEARCH'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnSearchClick
  end
  object DBPF: TDBGrid
    Left = 0
    Top = 162
    Width = 684
    Height = 360
    Align = alBottom
    Color = clMoneyGreen
    Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnDblClick = DBPFDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Color = clSkyBlue
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Color = clSkyBlue
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SALARY'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'BIRTHDAY'
        Title.Alignment = taCenter
        Title.Color = clSkyBlue
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GENDER'
        Visible = False
      end>
  end
end
