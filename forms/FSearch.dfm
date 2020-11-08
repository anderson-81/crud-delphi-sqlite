object FrmSearch: TFrmSearch
  Left = 328
  Top = 213
  BorderStyle = bsToolWindow
  Caption = 'Registration System - Search'
  ClientHeight = 561
  ClientWidth = 684
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 24
  object lblData: TLabel
    Left = 16
    Top = 72
    Width = 133
    Height = 24
    Caption = 'Data for Search:'
  end
  object lblTitle: TLabel
    Left = 16
    Top = 16
    Width = 173
    Height = 36
    Caption = 'Registration'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -31
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtDataSearch: TEdit
    Left = 16
    Top = 104
    Width = 480
    Height = 32
    TabOrder = 0
    OnChange = txtDataSearchChange
  end
  object rdForName: TRadioButton
    Tag = 2
    Left = 440
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
    Left = 560
    Top = 16
    Width = 113
    Height = 17
    Caption = 'For Code'
    TabOrder = 2
    OnClick = rdForIDClick
  end
  object btnSearch: TButton
    Tag = 3
    Left = 504
    Top = 104
    Width = 170
    Height = 32
    Cursor = crHandPoint
    Caption = 'SEARCH'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnSearchClick
  end
  object DBGridPP: TDBGrid
    Left = 0
    Top = 161
    Width = 684
    Height = 400
    Align = alBottom
    Anchors = [akTop]
    Color = clGradientInactiveCaption
    Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -19
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridPPDrawColumnCell
    OnDblClick = DBGridPPDblClick
    Columns = <
      item
        Alignment = taCenter
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
        Alignment = taCenter
        Expanded = False
        FieldName = 'BIRTHDAY'
        Title.Alignment = taCenter
        Title.Color = clSkyBlue
        Width = 200
        Visible = True
      end>
  end
end
