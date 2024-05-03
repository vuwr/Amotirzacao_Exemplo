object FSimuladorPUModelo: TFSimuladorPUModelo
  Left = 0
  Top = 0
  Caption = 'Nova Simula'#231#227'o - Pagamento '#249'nico'
  ClientHeight = 402
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 16
  object DBGrid1: TDBGrid
    Left = 200
    Top = 224
    Width = 320
    Height = 120
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Pnl1: TPanel
    Left = 0
    Top = 0
    Width = 637
    Height = 73
    Align = alTop
    TabOrder = 1
    ExplicitLeft = -1
    ExplicitTop = -2
    object LbCapital: TLabel
      Left = 15
      Top = 14
      Width = 39
      Height = 16
      Caption = 'Capital'
    end
    object Label2: TLabel
      Left = 152
      Top = 14
      Width = 58
      Height = 16
      Caption = 'Tx Juro %'
    end
    object Label3: TLabel
      Left = 240
      Top = 14
      Width = 36
      Height = 16
      Caption = 'Meses'
    end
    object EdtCapital: TEdit
      Left = 15
      Top = 31
      Width = 120
      Height = 24
      TabOrder = 0
      OnExit = EdtCapitalExit
    end
    object BtnSimular: TButton
      Left = 470
      Top = 14
      Width = 130
      Height = 40
      Caption = 'Simular'
      TabOrder = 3
      OnClick = BtnSimularClick
    end
    object EdtTxJuros: TEdit
      Left = 152
      Top = 31
      Width = 69
      Height = 24
      TabOrder = 1
      OnExit = EdtTxJurosExit
    end
    object EdtMeses: TEdit
      Left = 240
      Top = 31
      Width = 70
      Height = 24
      TabOrder = 2
      OnExit = EdtMesesExit
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 637
    Height = 305
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    ExplicitHeight = 329
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 635
      Height = 303
      Align = alClient
      DataSource = DS
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = GridDrawColumnCell
    end
  end
  object PnlTotal: TPanel
    Left = 0
    Top = 378
    Width = 637
    Height = 24
    Align = alBottom
    TabOrder = 3
    Visible = False
    ExplicitTop = 76
    object LbmC: TLabel
      Left = 15
      Top = 5
      Width = 121
      Height = 16
      Caption = 'Montante Calculado: '
    end
    object LbTotal: TLabel
      Left = 138
      Top = 5
      Width = 151
      Height = 16
      Caption = 'O Total de Pagamento: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DS: TDataSource
    Left = 384
    Top = 296
  end
end
