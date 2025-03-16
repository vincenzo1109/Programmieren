object Form1: TForm1
  Left = 192
  Top = 125
  Width = 575
  Height = 585
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 184
    Top = 16
    Width = 128
    Height = 33
    Caption = 'Nimmspiel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 96
    Top = 192
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 192
    Top = 192
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object PaintBox1: TPaintBox
    Left = 312
    Top = 56
    Width = 233
    Height = 265
  end
  object Edit1: TEdit
    Left = 16
    Top = 64
    Width = 145
    Height = 41
    Hint = 'Nimm 1-3 Streichh'#246'lzer'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 208
    Top = 88
    Width = 89
    Height = 33
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 16
    Top = 120
    Width = 145
    Height = 37
    TabOrder = 2
    Text = 'Edit2'
  end
end
