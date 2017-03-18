object FrmRegistration: TFrmRegistration
  Left = 482
  Top = 100
  BorderStyle = bsToolWindow
  Caption = 'Registration System - Registration'
  ClientHeight = 357
  ClientWidth = 449
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 24
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 98
    Height = 24
    Caption = 'Registration'
  end
  object Label2: TLabel
    Left = 16
    Top = 40
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
  object Label3: TLabel
    Left = 16
    Top = 104
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
  object Label4: TLabel
    Left = 16
    Top = 168
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
  object Label5: TLabel
    Left = 16
    Top = 232
    Width = 112
    Height = 20
    Caption = 'Date Of Birth:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 256
    Top = 232
    Width = 56
    Height = 20
    Caption = 'Genre:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtName: TEdit
    Left = 16
    Top = 64
    Width = 416
    Height = 32
    TabOrder = 0
  end
  object txtEmail: TEdit
    Tag = 1
    Left = 16
    Top = 128
    Width = 416
    Height = 32
    TabOrder = 1
    OnExit = txtEmailExit
  end
  object txtSalary: TEdit
    Tag = 2
    Left = 16
    Top = 192
    Width = 416
    Height = 32
    TabOrder = 2
    OnChange = txtSalaryChange
  end
  object dtDateBirth: TDateTimePicker
    Tag = 3
    Left = 16
    Top = 256
    Width = 175
    Height = 32
    Date = 42572.104147546300000000
    Time = 42572.104147546300000000
    TabOrder = 3
    OnExit = dtDateBirthExit
  end
  object cmbGenre: TComboBox
    Tag = 4
    Left = 256
    Top = 256
    Width = 175
    Height = 32
    BevelKind = bkFlat
    Style = csDropDownList
    ItemHeight = 24
    ItemIndex = 0
    TabOrder = 4
    Text = 'Male'
    Items.Strings = (
      'Male'
      'Female')
  end
  object btnSearch: TButton
    Tag = 6
    Left = 224
    Top = 312
    Width = 100
    Height = 30
    Caption = 'Search'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btnSearchClick
  end
  object btnEdit: TButton
    Tag = 7
    Left = 120
    Top = 312
    Width = 100
    Height = 30
    Caption = 'Edit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Tag = 8
    Left = 16
    Top = 312
    Width = 100
    Height = 30
    Caption = 'Delete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = btnDeleteClick
  end
  object btnInsert: TButton
    Tag = 5
    Left = 328
    Top = 312
    Width = 100
    Height = 30
    Caption = 'Insert'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = btnInsertClick
  end
  object Button1: TButton
    Left = 360
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 9
    OnClick = Button1Click
  end
end
