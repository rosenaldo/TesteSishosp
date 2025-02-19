object F_CADASTRAR_CLIENTES: TF_CADASTRAR_CLIENTES
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'F_CADASTRAR_CLIENTES'
  ClientHeight = 480
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object P_CONTAINER: TPanel
    Left = 0
    Top = 0
    Width = 698
    Height = 480
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 640
    object P_TOPO: TPanel
      Left = 1
      Top = 1
      Width = 696
      Height = 144
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 638
      object Label1: TLabel
        Left = 16
        Top = 40
        Width = 42
        Height = 15
        Caption = 'C'#243'digo:'
      end
      object Label2: TLabel
        Left = 151
        Top = 40
        Width = 40
        Height = 15
        Caption = 'Cliente:'
      end
      object Label3: TLabel
        Left = 16
        Top = 80
        Width = 40
        Height = 15
        Caption = 'Cidade:'
      end
      object Label4: TLabel
        Left = 418
        Top = 82
        Width = 17
        Height = 15
        Caption = 'UF:'
      end
      object E_CODIGO: TEdit
        Left = 64
        Top = 37
        Width = 81
        Height = 23
        ReadOnly = True
        TabOrder = 0
      end
      object E_CLIENTES: TEdit
        Left = 197
        Top = 37
        Width = 329
        Height = 23
        TabOrder = 1
      end
      object E_CIDADE: TEdit
        Left = 64
        Top = 77
        Width = 348
        Height = 23
        TabOrder = 2
      end
      object E_UF: TEdit
        Left = 445
        Top = 77
        Width = 81
        Height = 23
        TabOrder = 3
      end
    end
    object P_RODAPE: TPanel
      Left = 1
      Top = 416
      Width = 696
      Height = 63
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitWidth = 638
      DesignSize = (
        696
        63)
      object SB_NOVO_CLIENTES: TSpeedButton
        Left = 16
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_NOVO_CLIENTESClick
      end
      object SB_SALVAR_CLIENTES: TSpeedButton
        Left = 118
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_SALVAR_CLIENTESClick
      end
      object SB_EDITAR_CLIENTES: TSpeedButton
        Left = 212
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_EDITAR_CLIENTESClick
      end
      object SB_EXCLUIR_CLIENTES: TSpeedButton
        Left = 308
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_EXCLUIR_CLIENTESClick
      end
      object SB_SAIR: TSpeedButton
        Left = 611
        Top = 12
        Width = 77
        Height = 38
        Anchors = [akTop, akRight]
        Caption = 'Sair'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        ParentFont = False
        OnClick = SB_SAIRClick
        ExplicitLeft = 553
      end
      object Label5: TLabel
        Left = 39
        Top = 25
        Width = 29
        Height = 15
        Caption = 'Novo'
      end
      object Label6: TLabel
        Left = 134
        Top = 25
        Width = 31
        Height = 15
        Caption = 'Salvar'
      end
      object Label7: TLabel
        Left = 234
        Top = 25
        Width = 30
        Height = 15
        Caption = 'Editar'
      end
      object Label8: TLabel
        Left = 329
        Top = 25
        Width = 35
        Height = 15
        Caption = 'Excluir'
      end
    end
    object P_GRID: TPanel
      Left = 1
      Top = 145
      Width = 696
      Height = 271
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitWidth = 638
      object DBG_CLIENTES: TDBGrid
        Left = 0
        Top = 0
        Width = 696
        Height = 271
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = DBG_CLIENTESCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            Title.Caption = 'C'#243'digo'
            Width = 91
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Title.Caption = 'Cliente'
            Width = 302
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Cidade'
            Width = 190
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Visible = True
          end>
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = DM_PEDIDOS_VENDAS.FDClientes
    Left = 609
    Top = 1
  end
end
