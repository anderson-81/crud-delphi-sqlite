object FrmLogin: TFrmLogin
  Left = 470
  Top = 274
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registration System - Login'
  ClientHeight = 241
  ClientWidth = 384
  Color = clGradientActiveCaption
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
    Top = 120
    Width = 92
    Height = 24
    Caption = 'Username:'
  end
  object lblPassword: TLabel
    Left = 16
    Top = 48
    Width = 87
    Height = 24
    Caption = 'Password:'
  end
  object lblTitle: TLabel
    Left = 16
    Top = 8
    Width = 66
    Height = 29
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtUsername: TEdit
    Left = 16
    Top = 80
    Width = 350
    Height = 32
    TabOrder = 0
    Text = 'admin'
  end
  object txtPassword: TEdit
    Left = 16
    Top = 152
    Width = 350
    Height = 32
    PasswordChar = '*'
    TabOrder = 1
    Text = 'admin'
  end
  object btnLogin: TButton
    Left = 267
    Top = 200
    Width = 100
    Height = 30
    Cursor = crHandPoint
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnLoginClick
  end
  object btnCancel: TButton
    Left = 160
    Top = 200
    Width = 100
    Height = 30
    Cursor = crHandPoint
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
