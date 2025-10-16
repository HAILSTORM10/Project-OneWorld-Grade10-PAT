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
  object btnFeedback: TButton
    Left = 864
    Top = 392
    Width = 75
    Height = 25
    Caption = 'btnFeedback'
    TabOrder = 0
    OnClick = btnFeedbackClick
  end
  object rgpFeedback: TRadioGroup
    Left = 816
    Top = 192
    Width = 185
    Height = 105
    Caption = 'Select Type of Feedback To Add:'
    Items.Strings = (
      'Correct Answer Feedback'
      'Incorrect Answer Feedback')
    TabOrder = 1
  end
  object edtFeedback: TEdit
    Left = 856
    Top = 336
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edtFeedback'
  end
end
