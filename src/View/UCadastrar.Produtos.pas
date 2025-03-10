unit UCadastrar.Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TF_CADASTRAR_PRODUTOS = class(TForm)
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_RODAPE: TPanel;
    P_GRID: TPanel;
    DBG_CLIENTES: TDBGrid;
    DataSource1: TDataSource;
    E_CODIGO: TEdit;
    E_PRODUTO: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SB_NOVO_PRODUTO: TSpeedButton;
    SB_SALVAR_PRODUTOS: TSpeedButton;
    SB_EDITAR_PRODUTO: TSpeedButton;
    SB_EXCLUIR_PRODUTO: TSpeedButton;
    SB_SAIR: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    E_VALOR_VENDA: TMaskEdit;
    procedure SB_SAIRClick(Sender: TObject);
    procedure SB_NOVO_PRODUTOClick(Sender: TObject);
    procedure SB_SALVAR_PRODUTOSClick(Sender: TObject);
    procedure SB_EDITAR_PRODUTOClick(Sender: TObject);
    procedure SB_EXCLUIR_PRODUTOClick(Sender: TObject);
    procedure E_VALOR_VENDAKeyPress(Sender: TObject; var Key: Char);
    procedure DBG_CLIENTESCellClick(Column: TColumn);
  private
    procedure LimparEdits;
    procedure NovoProduto;
    procedure SalvarProduto;
    procedure CarregarProduto;
    procedure EditarProduto;
    procedure ExcluirProduto;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_CADASTRAR_PRODUTOS: TF_CADASTRAR_PRODUTOS;

implementation

{$R *.dfm}

uses UPedidos.Modell;

procedure TF_CADASTRAR_PRODUTOS.SB_EDITAR_PRODUTOClick(Sender: TObject);
begin
  EditarProduto;
end;

procedure TF_CADASTRAR_PRODUTOS.SB_EXCLUIR_PRODUTOClick(Sender: TObject);
begin
  ExcluirProduto;
end;

procedure TF_CADASTRAR_PRODUTOS.SB_NOVO_PRODUTOClick(Sender: TObject);
begin
  NovoProduto;
end;

procedure TF_CADASTRAR_PRODUTOS.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

procedure TF_CADASTRAR_PRODUTOS.SB_SALVAR_PRODUTOSClick(Sender: TObject);
begin
  SalvarProduto;
end;

procedure TF_CADASTRAR_PRODUTOS.NovoProduto;
begin
  SB_SALVAR_PRODUTOS.Enabled := True;
  LimparEdits;

  E_PRODUTO.SetFocus;
end;

procedure TF_CADASTRAR_PRODUTOS.LimparEdits;
begin
  E_CODIGO.Clear;
  E_PRODUTO.Clear;
  E_VALOR_VENDA.Clear;
end;

PROCEDURE TF_CADASTRAR_PRODUTOS.SalvarProduto;
begin
  if Trim(E_PRODUTO.Text) = '' then
  begin
    ShowMessage('A descri��o do produto � obrigat�rio.');
    Exit;
  end;

  if Trim(E_VALOR_VENDA.Text) = '' then
  begin
    ShowMessage('O valor de venda � obrigat�ria.');
    Exit;
  end;

  with DM_PEDIDOS_VENDAS.FDProduto do
  begin
    SQL.Text :=
      'INSERT INTO Produto (Descricao, PrecoVenda) VALUES (:Descricao, :PrecoVenda)';
    ParamByName('Descricao').AsString := E_PRODUTO.Text;
    ParamByName('PrecoVenda').AsString := E_VALOR_VENDA.Text;
    ExecSQL;

    LimparEdits;
    ShowMessage('Produto cadastrado com sucesso!');
    CarregarProduto;

  end;
end;

procedure TF_CADASTRAR_PRODUTOS.CarregarProduto;
begin
  with DM_PEDIDOS_VENDAS.FDProduto do
  begin
    SQL.Text := 'SELECT * FROM Produto';
    Open;
  end;
end;

procedure TF_CADASTRAR_PRODUTOS.DBG_CLIENTESCellClick(Column: TColumn);
begin
  if not DataSource1.DataSet.IsEmpty then
  begin
    SB_SALVAR_PRODUTOS.Enabled := False;
    E_CODIGO.Text := DataSource1.DataSet.FieldByName('Codigo').AsString;
    E_PRODUTO.Text := DataSource1.DataSet.FieldByName('Descricao').AsString;
    E_VALOR_VENDA.Text := DataSource1.DataSet.FieldByName('PrecoVenda')
      .AsString;
  end;
end;

procedure TF_CADASTRAR_PRODUTOS.EditarProduto;

begin
  if DataSource1.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione um Produto para editar.');
    Exit;
  end;

  with DM_PEDIDOS_VENDAS.FDProduto do
  begin
    SQL.Text :=
      'UPDATE Produto SET Descricao = :Descricao, PrecoVenda = :PrecoVenda WHERE Codigo = :Codigo';
    ParamByName('Descricao').AsString := E_PRODUTO.Text;
    ParamByName('PrecoVenda').AsString := E_VALOR_VENDA.Text;
    ParamByName('Codigo').AsInteger := StrToInt(E_CODIGO.Text);
    ExecSQL;

    LimparEdits;
    ShowMessage('Produto atualizado com sucesso!');
    CarregarProduto;

  end;

end;

procedure TF_CADASTRAR_PRODUTOS.ExcluirProduto;
begin
  if DataSource1.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione um Produto para excluir.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este Produto?', mtConfirmation,
    [mbYes, mbNo], 0) = mrNo then
    Exit;

  with DM_PEDIDOS_VENDAS.FDProduto do
  begin
    SQL.Text := 'DELETE FROM Produto WHERE Codigo = :Codigo';
    ParamByName('Codigo').AsInteger := StrToInt(E_CODIGO.Text);
    ExecSQL;

    LimparEdits;
    ShowMessage('Produto exclu�do com sucesso!');
    CarregarProduto;
  end;

end;

procedure TF_CADASTRAR_PRODUTOS.E_VALOR_VENDAKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', '.', #8]) then
    Key := #0;

  if Key = '.' then
    Key := ',';
end;

end.
