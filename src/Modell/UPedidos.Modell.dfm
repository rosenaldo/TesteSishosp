object DM_PEDIDOS_VENDAS: TDM_PEDIDOS_VENDAS
  Height = 456
  Width = 629
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\sqlite\VendasPedidos'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object FDClientes: TFDTable
    IndexFieldNames = 'Codigo'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Cliente'
    Left = 64
    Top = 144
    object FDClientesCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDClientesNome: TStringField
      FieldName = 'Nome'
      Origin = 'Nome'
      Required = True
      Size = 100
    end
    object FDClientesCidade: TStringField
      FieldName = 'Cidade'
      Origin = 'Cidade'
      Required = True
      Size = 100
    end
    object FDClientesUF: TStringField
      FieldName = 'UF'
      Origin = 'UF'
      Required = True
      Size = 2
    end
  end
  object FDItemPedido: TFDTable
    IndexFieldNames = 'Incremento'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'ItemPedido'
    Left = 64
    Top = 208
    object FDItemPedidoIncremento: TFDAutoIncField
      FieldName = 'Incremento'
      Origin = 'Incremento'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDItemPedidoNumeroPedido: TIntegerField
      FieldName = 'NumeroPedido'
      Origin = 'NumeroPedido'
      Required = True
    end
    object FDItemPedidoCodigoProduto: TIntegerField
      FieldName = 'CodigoProduto'
      Origin = 'CodigoProduto'
      Required = True
    end
    object FDItemPedidoDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Required = True
      Size = 100
    end
    object FDItemPedidoQuantidade: TIntegerField
      FieldName = 'Quantidade'
      Origin = 'Quantidade'
      Required = True
    end
    object FDItemPedidoValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
      Origin = 'ValorUnitario'
      Required = True
    end
    object FDItemPedidoValorTotal: TFloatField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
  end
  object FDPedido: TFDTable
    Active = True
    IndexFieldNames = 'Numero'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Pedido'
    Left = 152
    Top = 145
    object FDPedidoNumero: TFDAutoIncField
      FieldName = 'Numero'
      Origin = 'Numero'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDPedidoDataEmissao: TStringField
      FieldName = 'DataEmissao'
      Origin = 'DataEmissao'
      Required = True
      Size = 100
    end
    object FDPedidoCodigoCliente: TIntegerField
      FieldName = 'CodigoCliente'
      Origin = 'CodigoCliente'
      Required = True
    end
    object FDPedidoValorTotal: TFloatField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
  end
  object FDProduto: TFDTable
    Active = True
    IndexFieldNames = 'Codigo'
    Connection = FDConnection1
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'Produto'
    Left = 152
    Top = 208
    object FDProdutoCodigo: TFDAutoIncField
      FieldName = 'Codigo'
      Origin = 'Codigo'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDProdutoDescricao: TStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Required = True
      Size = 100
    end
    object FDProdutoPrecoVenda: TFloatField
      FieldName = 'PrecoVenda'
      Origin = 'PrecoVenda'
      Required = True
    end
  end
  object FDQMaxNumeroPedido: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT MAX(Numero) AS MaxNumero FROM Pedido')
    Left = 288
    Top = 152
    object FDQMaxNumeroPedidoMaxNumero: TLargeintField
      AutoGenerateValue = arDefault
      FieldName = 'MaxNumero'
      Origin = 'MaxNumero'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDTempItemPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 288
    Top = 208
    object FDTempItemPedidoCodigoProduto: TIntegerField
      FieldName = 'CodigoProduto'
    end
    object FDTempItemPedidoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FDTempItemPedidoQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object FDTempItemPedidoValorUnitario: TCurrencyField
      FieldName = 'ValorUnitario'
    end
    object FDTempItemPedidoValorTotal: TCurrencyField
      FieldName = 'ValorTotal'
    end
  end
  object FDQConsultaVendas: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT '
      '  P.Numero AS NumeroPedido, '
      '  P.DataEmissao, '
      '  P.ValorTotal, '
      '  C.Nome AS NomeCliente'
      'FROM '
      '  Pedido P'
      'JOIN '
      '  Cliente C ON P.CodigoCliente = C.Codigo')
    Left = 64
    Top = 288
    object FDQConsultaVendasNumeroPedido: TFDAutoIncField
      FieldName = 'NumeroPedido'
      Origin = 'Numero'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQConsultaVendasDataEmissao: TStringField
      FieldName = 'DataEmissao'
      Origin = 'DataEmissao'
      Required = True
      Size = 100
    end
    object FDQConsultaVendasValorTotal: TFloatField
      FieldName = 'ValorTotal'
      Origin = 'ValorTotal'
      Required = True
    end
    object FDQConsultaVendasNomeCliente: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NomeCliente'
      Origin = 'Nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
end
