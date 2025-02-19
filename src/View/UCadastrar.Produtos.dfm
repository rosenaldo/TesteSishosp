object F_CADASTRAR_PRODUTOS: TF_CADASTRAR_PRODUTOS
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'F_CADASTRAR_PRODUTOS'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object P_CONTAINER: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    Align = alClient
    TabOrder = 0
    object P_TOPO: TPanel
      Left = 1
      Top = 1
      Width = 638
      Height = 128
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
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
        Width = 51
        Height = 15
        Caption = 'Produtos:'
      end
      object Label3: TLabel
        Left = 16
        Top = 80
        Width = 80
        Height = 15
        Caption = 'Valor de Venda:'
      end
      object E_CODIGO: TEdit
        Left = 64
        Top = 37
        Width = 81
        Height = 23
        ReadOnly = True
        TabOrder = 0
      end
      object E_PRODUTO: TEdit
        Left = 206
        Top = 37
        Width = 329
        Height = 23
        TabOrder = 1
      end
      object E_VALOR_VENDA: TMaskEdit
        Left = 103
        Top = 75
        Width = 79
        Height = 23
        TabOrder = 2
        Text = ''
        OnKeyPress = E_VALOR_VENDAKeyPress
      end
    end
    object P_RODAPE: TPanel
      Left = 1
      Top = 416
      Width = 638
      Height = 63
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        638
        63)
      object SB_NOVO_PRODUTO: TSpeedButton
        Left = 16
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_NOVO_PRODUTOClick
      end
      object SB_SALVAR_PRODUTOS: TSpeedButton
        Left = 118
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_SALVAR_PRODUTOSClick
      end
      object SB_EDITAR_PRODUTO: TSpeedButton
        Left = 212
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_EDITAR_PRODUTOClick
      end
      object SB_EXCLUIR_PRODUTO: TSpeedButton
        Left = 308
        Top = 16
        Width = 77
        Height = 38
        Flat = True
        OnClick = SB_EXCLUIR_PRODUTOClick
      end
      object SB_SAIR: TSpeedButton
        Left = 553
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
      Top = 129
      Width = 638
      Height = 287
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object DBG_CLIENTES: TDBGrid
        Left = 0
        Top = 0
        Width = 638
        Height = 287
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
            FieldName = 'Descricao'
            Title.Caption = 'Produto'
            Width = 302
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PrecoVenda'
            Title.Caption = 'Valor de Venda'
            Width = 190
            Visible = True
          end>
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = DM_PEDIDOS_VENDAS.FDProduto
    Left = 609
    Top = 1
  end
end
