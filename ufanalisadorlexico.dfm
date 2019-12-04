object FAnalisadorLexico: TFAnalisadorLexico
  Left = 0
  Top = 0
  Caption = 'Analisador L'#233'xico'
  ClientHeight = 504
  ClientWidth = 1170
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    1170
    504)
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 283
    Height = 488
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Dados'
    TabOrder = 0
    DesignSize = (
      283
      488)
    object Label1: TLabel
      Left = 12
      Top = 24
      Width = 49
      Height = 16
      Caption = 'Entrada:'
    end
    object Label3: TLabel
      Left = 12
      Top = 103
      Width = 96
      Height = 16
      Caption = 'Lista de Palavras'
    end
    object Label2: TLabel
      Left = 12
      Top = 426
      Width = 54
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = 'Consulta:'
      ExplicitTop = 436
    end
    object shp_status: TShape
      Left = 12
      Top = 477
      Width = 262
      Height = 3
      Brush.Color = clRed
      Pen.Color = clWhite
      Pen.Style = psClear
      Pen.Width = 0
    end
    object lbl_obs: TLabel
      Left = 141
      Top = 435
      Width = 130
      Height = 11
      Anchors = [akRight, akBottom]
      Caption = '*Digite "Espa'#231'o" para consultar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 445
    end
    object edt_entrada: TEdit
      Left = 12
      Top = 46
      Width = 262
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      CharCase = ecLowerCase
      TabOrder = 0
      OnChange = edt_entradaChange
      OnKeyDown = edt_entradaKeyDown
      OnKeyPress = edt_entradaKeyPress
    end
    object btn_add: TButton
      Left = 186
      Top = 74
      Width = 88
      Height = 34
      Anchors = [akTop, akRight]
      Caption = 'Adicionar'
      TabOrder = 1
      OnClick = btn_addClick
    end
    object btn_limpar: TButton
      Left = 106
      Top = 397
      Width = 81
      Height = 34
      Anchors = [akRight, akBottom]
      Caption = 'Limpar'
      TabOrder = 2
      OnClick = btn_limparClick
    end
    object lst_vw: TListView
      Left = 12
      Top = 125
      Width = 262
      Height = 266
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <>
      RowSelect = True
      SortType = stText
      TabOrder = 3
      ViewStyle = vsList
    end
    object btn_remover: TButton
      Left = 193
      Top = 397
      Width = 81
      Height = 34
      Anchors = [akRight, akBottom]
      Caption = 'Remover'
      TabOrder = 4
      OnClick = btn_removerClick
    end
    object edt_busca: TEdit
      Left = 12
      Top = 448
      Width = 262
      Height = 24
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 5
      OnKeyDown = edt_buscaKeyDown
      OnKeyPress = edt_buscaKeyPress
    end
  end
  object stg_analisador: TStringGrid
    Left = 297
    Top = 8
    Width = 865
    Height = 488
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 27
    DefaultColWidth = 30
    Enabled = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 1
  end
end
