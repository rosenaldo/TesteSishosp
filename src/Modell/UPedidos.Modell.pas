unit UPedidos.Modell;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM_PEDIDOS_VENDAS = class(TDataModule)
    FDConnection1: TFDConnection;
    FDClientes: TFDTable;
    FDItemPedido: TFDTable;
    FDPedido: TFDTable;
    FDProduto: TFDTable;
    FDClientesCodigo: TFDAutoIncField;
    FDClientesNome: TStringField;
    FDClientesCidade: TStringField;
    FDClientesUF: TStringField;
    FDPedidoNumero: TFDAutoIncField;
    FDPedidoDataEmissao: TStringField;
    FDPedidoCodigoCliente: TIntegerField;
    FDPedidoValorTotal: TFloatField;
    FDProdutoCodigo: TFDAutoIncField;
    FDProdutoDescricao: TStringField;
    FDProdutoPrecoVenda: TFloatField;
    FDItemPedidoIncremento: TFDAutoIncField;
    FDItemPedidoNumeroPedido: TIntegerField;
    FDItemPedidoCodigoProduto: TIntegerField;
    FDItemPedidoDescricao: TStringField;
    FDItemPedidoQuantidade: TIntegerField;
    FDItemPedidoValorUnitario: TFloatField;
    FDItemPedidoValorTotal: TFloatField;
    FDQMaxNumeroPedido: TFDQuery;
    FDQMaxNumeroPedidoMaxNumero: TLargeintField;
    FDTempItemPedido: TFDMemTable;
    FDTempItemPedidoCodigoProduto: TIntegerField;
    FDTempItemPedidoDescricao: TStringField;
    FDTempItemPedidoQuantidade: TIntegerField;
    FDTempItemPedidoValorUnitario: TCurrencyField;
    FDTempItemPedidoValorTotal: TCurrencyField;
    FDQConsultaVendas: TFDQuery;
    FDQConsultaVendasNumeroPedido: TFDAutoIncField;
    FDQConsultaVendasDataEmissao: TStringField;
    FDQConsultaVendasValorTotal: TFloatField;
    FDQConsultaVendasNomeCliente: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_PEDIDOS_VENDAS: TDM_PEDIDOS_VENDAS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
