unit Pedido.Classe;

interface

type
  TPedido = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    FValorTotal: Currency;
  public
    property Numero: Integer read FNumero write FNumero;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

end.
