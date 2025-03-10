unit UConsultar.Vendas;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Grids,
  Vcl.DBGrids, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client,
  UPedidos.Modell,
  Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TF_CONSULTAR_VENDAS = class(TForm)
    P_CONTAINNER: TPanel;
    P_RODAPE: TPanel;
    SB_SAIR: TSpeedButton;
    P_TOPO: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    SB_EDITAR_ITEM: TSpeedButton;
    Label15: TLabel;
    Label20: TLabel;
    E_CLIENTES: TEdit;
    E_CODIGO_CLIENTE: TEdit;
    P_CONSULTAR: TPanel;
    DBG_CONSULTAR: TDBGrid;
    DataSource1: TDataSource;
    procedure BConsultarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure SB_SAIRClick(Sender: TObject);
    procedure SB_EDITAR_ITEMClick(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label15Click(Sender: TObject);
  private
    procedure ConsultarVendas;
  public
    { Public declarations }
  end;

var
  F_CONSULTAR_VENDAS: TF_CONSULTAR_VENDAS;

implementation

{$R *.dfm}

procedure TF_CONSULTAR_VENDAS.BConsultarClick(Sender: TObject);
begin
  ConsultarVendas;
end;

procedure TF_CONSULTAR_VENDAS.BFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TF_CONSULTAR_VENDAS.ConsultarVendas;
var
  NomeParcial: String;
  Codigo: Integer;
begin
  with DM_PEDIDOS_VENDAS.FDQConsultaVendas do
  begin
    Close;
    SQL.Clear;

    if (E_CODIGO_CLIENTE.Text <> '') then
    begin
      Codigo := StrToIntDef(E_CODIGO_CLIENTE.Text, 0);
      SQL.Text :=
        'SELECT P.Numero AS NumeroPedido, P.DataEmissao, P.ValorTotal, ' +
        'C.Nome AS NomeCliente ' +
        'FROM Pedido P ' +
        'JOIN Cliente C ON P.CodigoCliente = C.Codigo ' +
        'WHERE C.Codigo = :Codigo';
      ParamByName('Codigo').AsInteger := Codigo;
    end
    else if (E_CLIENTES.Text <> '') then
    begin
      NomeParcial := '%' + E_CLIENTES.Text + '%';
      SQL.Text :=
        'SELECT P.Numero AS NumeroPedido, P.DataEmissao, P.ValorTotal, ' +
        'C.Nome AS NomeCliente ' +
        'FROM Pedido P ' +
        'JOIN Cliente C ON P.CodigoCliente = C.Codigo ' +
        'WHERE C.Nome LIKE :Nome';
      ParamByName('Nome').AsString := NomeParcial;
    end
    else
    begin
      ShowMessage('Por favor, informe o nome ou c�digo do cliente.');
      Exit;
    end;

    Open;

    if IsEmpty then
      ShowMessage('Nenhuma venda encontrada para o cliente informado.');
  end;
end;


procedure TF_CONSULTAR_VENDAS.Label15Click(Sender: TObject);
begin
  ConsultarVendas;
end;

procedure TF_CONSULTAR_VENDAS.Label20Click(Sender: TObject);
begin
  ConsultarVendas;
end;

procedure TF_CONSULTAR_VENDAS.SB_EDITAR_ITEMClick(Sender: TObject);
begin
  ConsultarVendas;
end;

procedure TF_CONSULTAR_VENDAS.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

end.
