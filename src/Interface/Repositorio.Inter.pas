unit Repositorio.Inter;

interface

uses Cliente.Classe, ItemPedidos.Classe, Pedido.Classe, Produto.Classe,
  UPedidos.Modell, Generics.Collections;

type
  IRepositorio<T> = interface
    ['{053F3FED-9E20-4A9B-846B-58CD9133BED5}']
    function ObterPorID(ID: Integer): T;
    function Listar: TList<T>;
    procedure Inserir(Entidade: T);
    procedure Atualizar(Entidade: T);
    procedure Excluir(ID: Integer);
  end;

  IServicoPedido = interface
    ['{2C228776-1B62-47B9-8D2A-4399BE49867A}']
    procedure AdicionarProduto(Produto: TProduto; Quantidade: Integer;
      ValorUnitario: Currency);
    procedure RemoverProduto(Incremento: Integer);
    procedure SalvarPedido(Pedido: TPedido);
    function ObterTotal: Currency;
    procedure LimparItens;
    function ObterItens: TList<TItemPedido>;
  end;

implementation

end.
