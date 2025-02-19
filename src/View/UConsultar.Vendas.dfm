object F_CONSULTAR_VENDAS: TF_CONSULTAR_VENDAS
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 426
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object P_CONTAINNER: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 426
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    StyleElements = []
    ExplicitWidth = 670
    ExplicitHeight = 483
    object P_RODAPE: TPanel
      Left = 0
      Top = 380
      Width = 631
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitTop = 387
      ExplicitWidth = 687
      DesignSize = (
        631
        46)
      object SB_SAIR: TSpeedButton
        Left = 507
        Top = 3
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
        ExplicitLeft = 563
      end
    end
    object P_TOPO: TPanel
      Left = 0
      Top = 0
      Width = 631
      Height = 54
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 686
      object Label5: TLabel
        Left = 150
        Top = 16
        Width = 40
        Height = 15
        Caption = 'Cliente:'
      end
      object Label6: TLabel
        Left = 25
        Top = 16
        Width = 42
        Height = 15
        Caption = 'C'#243'digo:'
      end
      object SB_EDITAR_ITEM: TSpeedButton
        Left = 521
        Top = 10
        Width = 80
        Height = 37
        Flat = True
        OnClick = SB_EDITAR_ITEMClick
      end
      object Label15: TLabel
        Left = 535
        Top = 12
        Width = 51
        Height = 15
        Caption = 'Consultar'
        OnClick = Label15Click
      end
      object Label20: TLabel
        Left = 545
        Top = 26
        Width = 32
        Height = 15
        Caption = 'Venda'
        OnClick = Label20Click
      end
      object E_CLIENTES: TEdit
        Left = 196
        Top = 13
        Width = 319
        Height = 23
        TabOrder = 1
      end
      object E_CODIGO_CLIENTE: TEdit
        Left = 73
        Top = 13
        Width = 72
        Height = 23
        TabOrder = 0
      end
    end
    object P_CONSULTAR: TPanel
      Left = 0
      Top = 54
      Width = 631
      Height = 326
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = 248
      ExplicitTop = 240
      ExplicitWidth = 185
      ExplicitHeight = 41
      object DBG_CONSULTAR: TDBGrid
        Left = 0
        Top = 0
        Width = 631
        Height = 326
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
        Columns = <
          item
            Expanded = False
            FieldName = 'NumeroPedido'
            Title.Caption = 'Pedido'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomeCliente'
            Title.Caption = 'Cliente'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DataEmissao'
            Title.Caption = 'Data Emissao'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            Title.Caption = 'Valor Total'
            Visible = True
          end>
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = DM_PEDIDOS_VENDAS.FDQConsultaVendas
    Left = 584
    Top = 73
  end
end
