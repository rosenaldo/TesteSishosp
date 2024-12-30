unit ItemPedidos.Classe;

interface

type
  TItemPedido = class
  private
    FIncremento: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Integer;
    FValorUnitario: Currency;
    FValorTotal: Currency;
  public
    property Incremento: Integer read FIncremento write FIncremento;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

end.
