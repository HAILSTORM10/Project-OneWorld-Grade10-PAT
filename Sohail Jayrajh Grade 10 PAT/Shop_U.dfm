object frmShop: TfrmShop
  Left = 0
  Top = 0
  Caption = 'frmShop'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblDays: TLabel
    Left = 48
    Top = 40
    Width = 133
    Height = 13
    Caption = 'Japanese Days - 200 Points'
  end
  object lblMonths: TLabel
    Left = 48
    Top = 80
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object lblNouns: TLabel
    Left = 48
    Top = 120
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object btnBuyDays: TButton
    Left = 216
    Top = 35
    Width = 75
    Height = 25
    Caption = 'btnJapBuyDays'
    TabOrder = 0
    OnClick = btnBuyDaysClick
  end
  object btnBuyMonths: TButton
    Left = 216
    Top = 75
    Width = 75
    Height = 25
    Caption = 'btnBuyMonths'
    TabOrder = 1
  end
  object btnBuyNouns: TButton
    Left = 216
    Top = 115
    Width = 75
    Height = 25
    Caption = 'btnBuyNouns'
    TabOrder = 2
  end
  object redUserInfo: TRichEdit
    Left = 297
    Top = 134
    Width = 185
    Height = 89
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
