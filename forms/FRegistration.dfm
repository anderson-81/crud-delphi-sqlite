object FrmRegistration: TFrmRegistration
  Left = 656
  Top = 91
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registration System - Registration'
  ClientHeight = 661
  ClientWidth = 484
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
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
  object lblName: TLabel
    Left = 16
    Top = 128
    Width = 52
    Height = 20
    Caption = 'Name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblEmail: TLabel
    Left = 16
    Top = 192
    Width = 50
    Height = 20
    Caption = 'Email:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSalary: TLabel
    Left = 16
    Top = 256
    Width = 56
    Height = 20
    Caption = 'Salary:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblBirthday: TLabel
    Left = 16
    Top = 320
    Width = 72
    Height = 20
    Caption = 'Birthday:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblGender: TLabel
    Left = 256
    Top = 320
    Width = 66
    Height = 20
    Caption = 'Gender:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCPF: TLabel
    Left = 16
    Top = 64
    Width = 40
    Height = 20
    Caption = 'CPF:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStatus: TLabel
    Left = 256
    Top = 512
    Width = 59
    Height = 20
    Caption = 'Status:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblComment: TLabel
    Left = 16
    Top = 384
    Width = 82
    Height = 20
    Caption = 'Comment:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCreateAtTitle: TLabel
    Left = 16
    Top = 512
    Width = 83
    Height = 20
    Caption = 'Create At:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCreateAt: TLabel
    Left = 16
    Top = 536
    Width = 7
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtName: TEdit
    Left = 16
    Top = 152
    Width = 450
    Height = 32
    MaxLength = 45
    TabOrder = 1
  end
  object edtEmail: TEdit
    Left = 16
    Top = 216
    Width = 450
    Height = 32
    MaxLength = 45
    TabOrder = 2
  end
  object dtpBirthday: TDateTimePicker
    Left = 16
    Top = 344
    Width = 210
    Height = 32
    Date = 0.104147546298918300
    Time = 0.104147546298918300
    TabOrder = 4
  end
  object cmbGender: TComboBox
    Left = 256
    Top = 344
    Width = 210
    Height = 32
    BevelKind = bkFlat
    Style = csDropDownList
    ItemHeight = 24
    ItemIndex = 0
    TabOrder = 5
    Text = 'Male'
    Items.Strings = (
      'Male'
      'Female')
  end
  object btnClean: TButton
    Tag = 11
    Left = 368
    Top = 16
    Width = 100
    Height = 30
    Cursor = crHandPoint
    Caption = 'Clean'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btnCleanClick
  end
  object currEdtSalary: TCurrencyEdit
    Left = 16
    Top = 280
    Width = 450
    Height = 32
    TabOrder = 3
  end
  object gpBoxOperations: TGroupBox
    Left = 16
    Top = 576
    Width = 450
    Height = 70
    Caption = 'Operations'
    TabOrder = 8
    object btnEdit: TButton
      Left = 112
      Top = 27
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Edit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 8
      Top = 27
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Delete'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object btnSearch: TButton
      Left = 238
      Top = 27
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Search'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnSearchClick
    end
    object btnInsert: TButton
      Left = 342
      Top = 27
      Width = 100
      Height = 30
      Cursor = crHandPoint
      Caption = 'Insert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clOlive
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnInsertClick
    end
  end
  object rbTrue: TRadioButton
    Left = 392
    Top = 536
    Width = 70
    Height = 17
    Caption = 'True'
    Checked = True
    TabOrder = 7
    TabStop = True
  end
  object rbFalse: TRadioButton
    Left = 312
    Top = 536
    Width = 70
    Height = 17
    Caption = 'False'
    TabOrder = 10
  end
  object mskEdtCPF: TMaskEdit
    Left = 16
    Top = 88
    Width = 450
    Height = 32
    EditMask = '!999\.999\.999\-99;0;_'
    MaxLength = 14
    TabOrder = 0
    OnEnter = mskEdtCPFEnter
  end
  object memoComment: TMemo
    Left = 16
    Top = 408
    Width = 450
    Height = 90
    MaxLength = 200
    ScrollBars = ssVertical
    TabOrder = 6
  end
end
