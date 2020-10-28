object FrmLogin: TFrmLogin
  Left = 470
  Top = 274
  Width = 350
  Height = 230
  BorderStyle = bsSizeToolWin
  Caption = 'Registration System - Login'
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 24
  object lblUsername: TLabel
    Left = 16
    Top = 16
    Width = 52
    Height = 24
    Caption = 'Username:'
  end
  object lblPassword: TLabel
    Left = 16
    Top = 80
    Width = 87
    Height = 24
    Caption = 'Password:'
  end
  object txtUsername: TEdit
    Left = 16
    Top = 40
    Width = 300
    Height = 32
    TabOrder = 0
    Text = 'admin'
  end
  object txtPassword: TEdit
    Left = 16
    Top = 104
    Width = 300
    Height = 32
    PasswordChar = '*'
    TabOrder = 1
    Text = '121181'
  end
  object btnLogin: TButton
    Left = 240
    Top = 152
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object btnCancel: TButton
    Left = 160
    Top = 152
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
