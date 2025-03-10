unit Servico.Pedido.Classe;

interface

uses
  Generics.Collections, ItemPedidos.Classe, Produto.Classe, Pedido.Classe,
  Repositorio.Inter;

type
  TServicoPedido = class(TInterfacedObject, IServicoPedido)
  private
    FItensPedido: TList<TItemPedido>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarProduto(Produto: TProduto; Quantidade: Integer;
      ValorUnitario: Currency);
    procedure RemoverProduto(Incremento: Integer);
    procedure SalvarPedido(Pedido: TPedido);
    procedure LimparItens;
    function ObterTotal: Currency;
    function ObterItens: TList<TItemPedido>;
  end;

implementation

uses
  System.SysUtils;

constructor TServicoPedido.Create;
begin
  inherited;
  FItensPedido := TList<TItemPedido>.Create;
end;

destructor TServicoPedido.Destroy;
begin
  FItensPedido.Free;
  inherited;
end;

procedure TServicoPedido.LimparItens;
begin
  FItensPedido.Clear;
end;

procedure TServicoPedido.AdicionarProduto(Produto: TProduto;
  Quantidade: Integer; ValorUnitario: Currency);
var
  Item: TItemPedido;
begin
  Item := TItemPedido.Create;
  Item.CodigoProduto := Produto.Codigo;
  Item.Quantidade := Quantidade;
  Item.ValorUnitario := ValorUnitario;
  Item.ValorTotal := Quantidade * ValorUnitario;
  FItensPedido.Add(Item);
end;

procedure TServicoPedido.RemoverProduto(Incremento: Integer);
var
  Item: TItemPedido;
begin
  for Item in FItensPedido do
  begin
    FItensPedido.Remove(Item);
    Break;
  end;
end;

procedure TServicoPedido.SalvarPedido(Pedido: TPedido);
begin
  // Implementar l�gica para salvar o pedido e os itens no banco de dados.
end;

function TServicoPedido.ObterItens: TList<TItemPedido>;
begin
  Result := FItensPedido;
end;

function TServicoPedido.ObterTotal: Currency;
var
  Item: TItemPedido;
begin
  Result := 0;
  for Item in FItensPedido do
    Result := Result + Item.ValorTotal;
end;

end.
