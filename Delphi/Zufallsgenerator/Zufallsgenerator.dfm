object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Vincent3000'
  ClientHeight = 490
  ClientWidth = 705
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNone
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object LabelLastNo: TLabel
    Left = 89
    Top = 13
    Width = 18
    Height = 15
    Caption = #8197#8197#8197#8197#8197#8197
    Color = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
  end
  object LabelLastNoTx: TLabel
    Left = 0
    Top = 8
    Width = 75
    Height = 21
    Caption = 'Letzte Zahl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = 0
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
  end
  object LabelNowNoTx: TLabel
    Left = 128
    Top = 8
    Width = 90
    Height = 21
    Caption = 'Aktuelle Zahl'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = 0
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object LabelNowNo: TLabel
    Left = 235
    Top = 13
    Width = 18
    Height = 15
    Caption = #8197#8197#8197#8197#8197#8197
    Color = clYellow
    ParentColor = False
    Transparent = False
  end
  object ButtonGen: TButton
    Left = 0
    Top = 385
    Width = 369
    Height = 49
    Caption = 'generieren'
    TabOrder = 0
    OnClick = ButtonGenClick
  end
  object StringGridNo: TStringGrid
    Left = 0
    Top = 48
    Width = 369
    Height = 331
    ColCount = 10
    DefaultColWidth = 35
    DefaultRowHeight = 35
    Enabled = False
    FixedCols = 0
    RowCount = 9
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goFixedRowDefAlign]
    TabOrder = 1
    OnDrawCell = StringGridNoDrawCell
  end
  object ListBox1: TListBox
    Left = 375
    Top = 48
    Width = 121
    Height = 434
    ItemHeight = 15
    TabOrder = 2
  end
end
