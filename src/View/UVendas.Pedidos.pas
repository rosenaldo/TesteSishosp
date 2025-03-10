unit UVendas.Pedidos;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Cliente.Classe, ItemPedidos.Classe, Pedido.Classe, Produto.Classe,
  Repositorio.Inter, UCadastrar.Produtos, UPedidos.Modell, System.Classes,
  Winapi.Windows, Vcl.Menus, Repositorio.Produto, Servico.Pedido.Classe,
  UConsultar.Vendas;

type
  TF_PEDIDOS = class(TForm)
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    Image1: TImage;
    P_RODAPE: TPanel;
    SB_CADASTRAR_CLIENTES: TSpeedButton;
    SB_CADASTRAR_PRODUTOS: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SB_SAIR: TSpeedButton;
    E_CLIENTES: TEdit;
    Label5: TLabel;
    E_CODIGO_CLIENTE: TEdit;
    Label6: TLabel;
    E_QUANTIDADE: TEdit;
    Label7: TLabel;
    E_CODIGO_PRODUTO: TEdit;
    Label8: TLabel;
    E_VALOR: TEdit;
    Label10: TLabel;
    P_GRID: TPanel;
    DBG_VENDAS: TDBGrid;
    DataSource1: TDataSource;
    P_TOTALIZADOR: TPanel;
    Label11: TLabel;
    L_TOTAL: TLabel;
    SB_ADICIONAR_ITEM: TSpeedButton;
    SB_SALVAR_PEDIDO: TSpeedButton;
    SB_CANCELAR_PEDIDO: TSpeedButton;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    SpeedButton1: TSpeedButton;
    SB_CANCELAR_ITEM: TSpeedButton;
    SB_EDITAR_ITEM: TSpeedButton;
    Label15: TLabel;
    Label20: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    SpeedButton2: TSpeedButton;
    Label21: TLabel;
    Label22: TLabel;
    procedure SB_SAIRClick(Sender: TObject);
    procedure SB_CADASTRAR_PRODUTOSClick(Sender: TObject);
    procedure SB_SALVAR_PEDIDOClick(Sender: TObject);
    procedure k(Sender: TObject);
    procedure SB_ADICIONAR_ITEMClick(Sender: TObject);
    procedure SB_CADASTRAR_CLIENTESClick(Sender: TObject);
    procedure E_CODIGO_CLIENTEExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label13Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure SB_CANCELAR_ITEMClick(Sender: TObject);
    procedure SB_EDITAR_ITEMClick(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label22Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
  private
    ServicoPedido: IServicoPedido;
    RepositorioCliente: IRepositorio<TCliente>;
    RepositorioProduto: IRepositorio<TProduto>;

    procedure AtualizarTotalizador;
    procedure CarregarGrade;
    procedure CarregarClientes;
    function ObterDescricaoProduto(CodigoProduto: Integer): String;
    procedure CadastrarProdutos;
    procedure CadastrarClientes;
    procedure ConsultarVendas;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AServicoPedido: IServicoPedido;
      ARepositorioCliente: IRepositorio<TCliente>;
      ARepositorioProduto: IRepositorio<TProduto>); reintroduce;
    procedure AdicionarItem;
    procedure EditarItem;
    procedure ExcluirItem;
    procedure SalvarPedido;
    procedure CancelarPedido;
    procedure LimparEdits;
    { Public declarations }
  end;

var
  F_PEDIDOS: TF_PEDIDOS;

implementation

{$R *.dfm}

uses UCadastrar.Clientes;

procedure TF_PEDIDOS.AdicionarItem;
var
  Produto: TProduto;
begin

  try

    Produto := RepositorioProduto.ObterPorID(StrToInt(E_CODIGO_PRODUTO.Text));
    if Assigned(Produto) then
    begin
      ServicoPedido.AdicionarProduto(Produto, StrToInt(E_QUANTIDADE.Text),
        StrToFloat(E_VALOR.Text));
      AtualizarTotalizador;
      CarregarGrade;
    end
    else
      ShowMessage('Produto n�o encontrado.');

    E_CODIGO_PRODUTO.Clear;
    E_QUANTIDADE.Clear;
    E_VALOR.Clear;

  except
    on E: Exception do
      ShowMessage('Verifique as informa��es do pedido');
  end;

end;

procedure TF_PEDIDOS.AtualizarTotalizador;
var
  Total: Currency;
begin
  Total := ServicoPedido.ObterTotal;
  L_TOTAL.Caption := Format('Total: %.2f', [Total]);
end;

procedure TF_PEDIDOS.CancelarPedido;
begin
  try
    if MessageDlg('Deseja realmente cancelar este pedido?', mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then
    begin
      LimparEdits;

      DM_PEDIDOS_VENDAS.FDTempItemPedido.DisableControls;
      try
        DBG_VENDAS.DataSource.DataSet.Delete;
        DM_PEDIDOS_VENDAS.FDTempItemPedido.Close;
        DM_PEDIDOS_VENDAS.FDTempItemPedido.Open;
        DM_PEDIDOS_VENDAS.FDTempItemPedido.EmptyDataSet;
      finally
        DM_PEDIDOS_VENDAS.FDTempItemPedido.EnableControls;
      end;

      L_TOTAL.Caption := 'Total: 0,00';

      ShowMessage('Pedido cancelado com sucesso!');
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao cancelar o pedido: ' + E.Message);
  end;
end;

procedure TF_PEDIDOS.CarregarClientes;
var
  Codigo: Integer;
  NomeParcial: String;
begin
  try
    DM_PEDIDOS_VENDAS.FDClientes.Close;

    if E_CODIGO_CLIENTE.Text <> '' then
    begin
      Codigo := StrToIntDef(E_CODIGO_CLIENTE.Text, 0);
      DM_PEDIDOS_VENDAS.FDClientes.SQL.Text :=
        'SELECT Codigo, Nome, Cidade, UF FROM Cliente WHERE Codigo = :Codigo';
      DM_PEDIDOS_VENDAS.FDClientes.ParamByName('Codigo').AsInteger := Codigo;
    end
    else if E_CLIENTES.Text <> '' then
    begin
      NomeParcial := '%' + E_CLIENTES.Text + '%';
      DM_PEDIDOS_VENDAS.FDClientes.SQL.Text :=
        'SELECT Codigo, Nome, Cidade, UF FROM Cliente WHERE Nome LIKE :Nome';
      DM_PEDIDOS_VENDAS.FDClientes.ParamByName('Nome').AsString := NomeParcial;
    end
    else
    begin
      ShowMessage('Por favor, informe o c�digo do cliente.');
      Exit;
    end;

    DM_PEDIDOS_VENDAS.FDClientes.Open;

    if not DM_PEDIDOS_VENDAS.FDClientes.IsEmpty then
    begin
      if E_CODIGO_CLIENTE.Text <> '' then
      begin
        if DM_PEDIDOS_VENDAS.FDClientes.Locate('Codigo', Codigo, []) then
          E_CLIENTES.Text := DM_PEDIDOS_VENDAS.FDClientes.FieldByName
            ('Nome').AsString
        else
          ShowMessage('Cliente n�o encontrado para o c�digo informado.');
      end
      else if E_CLIENTES.Text <> '' then
      begin
        DM_PEDIDOS_VENDAS.FDClientes.First;
        E_CODIGO_CLIENTE.Text := DM_PEDIDOS_VENDAS.FDClientes.FieldByName
          ('Codigo').AsString;
      end;
    end
    else
    begin
      ShowMessage('Cliente n�o encontrado.');
      E_CLIENTES.Clear;
      E_CODIGO_CLIENTE.Clear;
    end;
  finally
    DM_PEDIDOS_VENDAS.FDClientes.Close;
  end;
end;

procedure TF_PEDIDOS.CarregarGrade;
var
  Item: TItemPedido;
  ValorTotalPedido: Currency;
begin
  ValorTotalPedido := 0;

  DM_PEDIDOS_VENDAS.FDTempItemPedido.Close;
  DM_PEDIDOS_VENDAS.FDTempItemPedido.Open;

  for Item in ServicoPedido.ObterItens do
  begin
    ValorTotalPedido := ValorTotalPedido + Item.ValorTotal;

    with DM_PEDIDOS_VENDAS.FDTempItemPedido do
    begin
      Append;
      FieldByName('CodigoProduto').AsInteger := Item.CodigoProduto;
      FieldByName('Descricao').AsString :=
        ObterDescricaoProduto(Item.CodigoProduto);
      FieldByName('Quantidade').AsInteger := Item.Quantidade;
      FieldByName('ValorUnitario').AsCurrency := Item.ValorUnitario;
      FieldByName('ValorTotal').AsCurrency := Item.ValorTotal;
      Post;
    end;
  end;

end;

function TF_PEDIDOS.ObterDescricaoProduto(CodigoProduto: Integer): String;
var
  Produto: TProduto;
begin
  Produto := RepositorioProduto.ObterPorID(CodigoProduto);
  if Assigned(Produto) then
    Result := Produto.Descricao
  else
    Result := 'Produto n�o encontrado';
end;

constructor TF_PEDIDOS.Create(AOwner: TComponent;
  AServicoPedido: IServicoPedido; ARepositorioCliente: IRepositorio<TCliente>;
  ARepositorioProduto: IRepositorio<TProduto>);
begin
  inherited Create(AOwner);
  ServicoPedido := AServicoPedido;
  RepositorioCliente := ARepositorioCliente;
  RepositorioProduto := ARepositorioProduto;
  CarregarClientes;
end;

procedure TF_PEDIDOS.EditarItem;
var
  Incremento: Integer;
  Quantidade: Integer;
  ValorUnitario: Currency;
  Item: TItemPedido;
  I: Integer;
begin
  with DM_PEDIDOS_VENDAS do
  begin
    if FDTempItemPedido.IsEmpty then
    begin
      ShowMessage('Nenhum item selecionado para editar.');
      Exit;
    end;

    Incremento := FDTempItemPedido.FieldByName('CodigoProduto').AsInteger;

    try
      FDTempItemPedido.Edit;
      Quantidade := DBG_VENDAS.DataSource.DataSet.FieldByName('Quantidade')
        .AsInteger;
      ValorUnitario := DBG_VENDAS.DataSource.DataSet.FieldByName
        ('ValorUnitario').AsCurrency;

      FDTempItemPedido.FieldByName('ValorTotal').AsCurrency := Quantidade *
        ValorUnitario;
      FDTempItemPedido.Post;

      // Inicializa Item como nil antes do loop
      Item := nil;
      for I := 0 to ServicoPedido.ObterItens.Count - 1 do
      begin
        if ServicoPedido.ObterItens[I].CodigoProduto = Incremento then
        begin
          Item := ServicoPedido.ObterItens[I];
          Break;
        end;
      end;

      // Verifica se o Item foi encontrado antes de tentar acessar suas propriedades
      if Assigned(Item) then
      begin
        Item.Quantidade := Quantidade;
        Item.ValorUnitario := ValorUnitario;
        Item.ValorTotal := Quantidade * ValorUnitario;
      end
      else
      begin
        ShowMessage('Erro: Item n�o encontrado na lista de itens.');
        Exit;
      end;

      AtualizarTotalizador;

      ShowMessage('Item editado com sucesso.');
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao editar item: ' + E.Message);
        FDTempItemPedido.Cancel;
      end;
    end;
  end;
end;

procedure TF_PEDIDOS.ExcluirItem;
var
  Incremento: Integer;
begin
  Incremento := DBG_VENDAS.DataSource.DataSet.FieldByName('CodigoProduto')
    .AsInteger;
  if MessageDlg('Deseja realmente excluir o item selecionado?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    ServicoPedido.RemoverProduto(Incremento);
    DBG_VENDAS.DataSource.DataSet.Delete;
    AtualizarTotalizador;
  end;

end;

procedure TF_PEDIDOS.E_CODIGO_CLIENTEExit(Sender: TObject);
begin
  CarregarClientes;
end;

procedure TF_PEDIDOS.FormCreate(Sender: TObject);
begin
  RepositorioProduto := TRepositorioProduto.Create(DM_PEDIDOS_VENDAS.FDProduto);
  ServicoPedido := TServicoPedido.Create;
end;

procedure TF_PEDIDOS.Label12Click(Sender: TObject);
begin
  AdicionarItem;
end;

procedure TF_PEDIDOS.Label13Click(Sender: TObject);
begin
  AdicionarItem;
end;

procedure TF_PEDIDOS.Label15Click(Sender: TObject);
begin
  EditarItem;
end;

procedure TF_PEDIDOS.Label16Click(Sender: TObject);
begin
  SalvarPedido;
end;

procedure TF_PEDIDOS.Label17Click(Sender: TObject);
begin
  SalvarPedido;
end;

procedure TF_PEDIDOS.Label18Click(Sender: TObject);
begin
  CancelarPedido;
end;

procedure TF_PEDIDOS.Label19Click(Sender: TObject);
begin
  CancelarPedido;
end;

procedure TF_PEDIDOS.Label1Click(Sender: TObject);
begin
  CadastrarClientes;
end;

procedure TF_PEDIDOS.Label20Click(Sender: TObject);
begin
  EditarItem;
end;

procedure TF_PEDIDOS.Label21Click(Sender: TObject);
begin
  ConsultarVendas;
end;

procedure TF_PEDIDOS.Label22Click(Sender: TObject);
begin
  ConsultarVendas;
end;

procedure TF_PEDIDOS.Label2Click(Sender: TObject);
begin
  CadastrarClientes;
end;

procedure TF_PEDIDOS.Label3Click(Sender: TObject);
begin
  CadastrarProdutos;
end;

procedure TF_PEDIDOS.Label4Click(Sender: TObject);
begin
  CadastrarProdutos;
end;

procedure TF_PEDIDOS.LimparEdits;
begin
  E_CODIGO_CLIENTE.Clear;
  E_CLIENTES.Clear;
  E_CODIGO_PRODUTO.Clear;
  E_QUANTIDADE.Clear;
  E_VALOR.Clear;
end;

procedure TF_PEDIDOS.ConsultarVendas;
begin
  F_CONSULTAR_VENDAS := TF_CONSULTAR_VENDAS.Create(nil);
  try
    F_CONSULTAR_VENDAS.ShowModal;
  finally
    F_CONSULTAR_VENDAS.Free;
  end;
end;

procedure TF_PEDIDOS.CadastrarClientes;
begin
  F_CADASTRAR_CLIENTES := TF_CADASTRAR_CLIENTES.Create(nil);
  try
    F_CADASTRAR_CLIENTES.ShowModal;
  finally
    F_CADASTRAR_CLIENTES.Free;
  end;
end;

procedure TF_PEDIDOS.CadastrarProdutos;
begin
  F_CADASTRAR_PRODUTOS := TF_CADASTRAR_PRODUTOS.Create(nil);
  try
    F_CADASTRAR_PRODUTOS.ShowModal;
  finally
    F_CADASTRAR_PRODUTOS.Free;
  end;
end;

procedure TF_PEDIDOS.SalvarPedido;
var
  Item: TItemPedido;
  NovoNumeroPedido: Integer;
  ValorTotalPedido: Currency;
begin
  ValorTotalPedido := 0;

  for Item in ServicoPedido.ObterItens do
    ValorTotalPedido := ValorTotalPedido + Item.ValorTotal;

  with DM_PEDIDOS_VENDAS.FDPedido do
  begin
    DisableControls;
    try

      Append;
      FieldByName('DataEmissao').AsString := DateToStr(Now);
      FieldByName('CodigoCliente').AsInteger := StrToInt(E_CODIGO_CLIENTE.Text);
      FieldByName('ValorTotal').AsCurrency := ValorTotalPedido;
      Post;

    finally
      EnableControls;
    end;
  end;
  DM_PEDIDOS_VENDAS.FDQMaxNumeroPedido.Close;
  DM_PEDIDOS_VENDAS.FDQMaxNumeroPedido.Open;
  NovoNumeroPedido := DM_PEDIDOS_VENDAS.FDQMaxNumeroPedido.FieldByName
    ('MaxNumero').AsInteger;

  with DM_PEDIDOS_VENDAS.FDItemPedido do
  begin
    DisableControls;
    try
      Close;
      Open;
      for Item in ServicoPedido.ObterItens do
      begin
        Append;
        FieldByName('CodigoProduto').AsInteger := Item.CodigoProduto;
        FieldByName('NumeroPedido').AsInteger := NovoNumeroPedido;
        FieldByName('Descricao').AsString :=
          ObterDescricaoProduto(Item.CodigoProduto);
        FieldByName('Quantidade').AsInteger := Item.Quantidade;
        FieldByName('ValorUnitario').AsCurrency := Item.ValorUnitario;
        FieldByName('ValorTotal').AsCurrency := Item.ValorTotal;
        Post;
      end;
    finally
      EnableControls;
    end;
  end;
  LimparEdits;

  DM_PEDIDOS_VENDAS.FDTempItemPedido.EmptyDataSet;
  ShowMessage('Pedido salvo com sucesso.');
end;

procedure TF_PEDIDOS.SB_ADICIONAR_ITEMClick(Sender: TObject);
begin
  AdicionarItem;
end;

procedure TF_PEDIDOS.SB_CADASTRAR_CLIENTESClick(Sender: TObject);
begin
  CadastrarClientes;
end;

procedure TF_PEDIDOS.SB_CADASTRAR_PRODUTOSClick(Sender: TObject);
begin
  CadastrarProdutos;
end;

procedure TF_PEDIDOS.SB_CANCELAR_ITEMClick(Sender: TObject);
begin
  ExcluirItem;
end;

procedure TF_PEDIDOS.SB_EDITAR_ITEMClick(Sender: TObject);
begin
  EditarItem;
end;

procedure TF_PEDIDOS.k(Sender: TObject);
begin
  CancelarPedido;
end;

procedure TF_PEDIDOS.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

procedure TF_PEDIDOS.SB_SALVAR_PEDIDOClick(Sender: TObject);
begin
  SalvarPedido;
end;

procedure TF_PEDIDOS.SpeedButton2Click(Sender: TObject);
begin
  ConsultarVendas;
end;

end.
