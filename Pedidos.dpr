program Pedidos;

uses
  Vcl.Forms,
  UVendas.Pedidos in 'src\View\UVendas.Pedidos.pas' {F_PEDIDOS},
  UPedidos.Modell in 'src\Modell\UPedidos.Modell.pas' {DM_PEDIDOS_VENDAS: TDataModule},
  Cliente.Classe in 'src\Class\Cliente.Classe.pas',
  Produto.Classe in 'src\Class\Produto.Classe.pas',
  ItemPedidos.Classe in 'src\Class\ItemPedidos.Classe.pas',
  Pedido.Classe in 'src\Class\Pedido.Classe.pas',
  Repositorio.Inter in 'src\Interface\Repositorio.Inter.pas',
  UCadastrar.Produtos in 'src\View\UCadastrar.Produtos.pas' {F_CADASTRAR_PRODUTOS},
  UCadastrar.Clientes in 'src\View\UCadastrar.Clientes.pas' {F_CADASTRAR_CLIENTES},
  Servico.Pedido.Classe in 'src\Class\Servico.Pedido.Classe.pas',
  Repositorio.Produto in 'src\Class\Repositorio.Produto.pas',
  UConsultar.Vendas in 'src\View\UConsultar.Vendas.pas' {F_CONSULTAR_VENDAS};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM_PEDIDOS_VENDAS, DM_PEDIDOS_VENDAS);
  Application.CreateForm(TF_PEDIDOS, F_PEDIDOS);
  Application.CreateForm(TF_CONSULTAR_VENDAS, F_CONSULTAR_VENDAS);
  Application.Run;
end.
