object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'frmAdmin'
  ClientHeight = 681
  ClientWidth = 1264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnUsers: TButton
    Left = 936
    Top = 360
    Width = 75
    Height = 25
    Caption = 'btnUsers'
    TabOrder = 0
    OnClick = btnUsersClick
  end
  object rgpUsers: TRadioGroup
    Left = 800
    Top = 80
    Width = 185
    Height = 105
    Caption = 'Select a User To View Their Details'
    TabOrder = 1
  end
  object btnCustom: TButton
    Left = 264
    Top = 160
    Width = 75
    Height = 25
    Caption = 'btnCustom'
    TabOrder = 2
    OnClick = btnCustomClick
  end
  object redOut: TRichEdit
    Left = 536
    Top = 240
    Width = 217
    Height = 129
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'redOut')
    ParentFont = False
    TabOrder = 3
  end
end
