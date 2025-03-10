unit UCadastrar.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons;

type
  TF_CADASTRAR_CLIENTES = class(TForm)
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_RODAPE: TPanel;
    P_GRID: TPanel;
    DBG_CLIENTES: TDBGrid;
    DataSource1: TDataSource;
    E_CODIGO: TEdit;
    E_CLIENTES: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    E_CIDADE: TEdit;
    E_UF: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    SB_NOVO_CLIENTES: TSpeedButton;
    SB_SALVAR_CLIENTES: TSpeedButton;
    SB_EDITAR_CLIENTES: TSpeedButton;
    SB_EXCLUIR_CLIENTES: TSpeedButton;
    SB_SAIR: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure SB_SAIRClick(Sender: TObject);
    procedure SB_SALVAR_CLIENTESClick(Sender: TObject);
    procedure SB_EDITAR_CLIENTESClick(Sender: TObject);
    procedure SB_EXCLUIR_CLIENTESClick(Sender: TObject);
    procedure SB_NOVO_CLIENTESClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBG_CLIENTESCellClick(Column: TColumn);
  private
    procedure CadastrarCliente;
    procedure EditarCliente;
    procedure ExcluirCliente;
    procedure CarregarClientes;
    procedure NovoCliente;
    procedure LimparEdits;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_CADASTRAR_CLIENTES: TF_CADASTRAR_CLIENTES;

implementation

{$R *.dfm}

uses UPedidos.Modell;

procedure TF_CADASTRAR_CLIENTES.SB_SALVAR_CLIENTESClick(Sender: TObject);
begin
  CadastrarCliente;
end;

procedure TF_CADASTRAR_CLIENTES.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

procedure TF_CADASTRAR_CLIENTES.SB_EDITAR_CLIENTESClick(Sender: TObject);
begin
  EditarCliente;
end;

procedure TF_CADASTRAR_CLIENTES.SB_EXCLUIR_CLIENTESClick(Sender: TObject);
begin
  ExcluirCliente;
end;

procedure TF_CADASTRAR_CLIENTES.SB_NOVO_CLIENTESClick(Sender: TObject);
begin
  SB_SALVAR_CLIENTES.Enabled := True;
  NovoCliente;
end;

procedure TF_CADASTRAR_CLIENTES.CadastrarCliente;
begin
  if Trim(E_CLIENTES.Text) = '' then
  begin
    ShowMessage('O nome do cliente � obrigat�rio.');
    Exit;
  end;

  if Trim(E_CIDADE.Text) = '' then
  begin
    ShowMessage('A cidade do cliente � obrigat�ria.');
    Exit;
  end;

  if Trim(E_UF.Text) = '' then
  begin
    ShowMessage('O UF do cliente � obrigat�rio.');
    Exit;
  end;

  with DM_PEDIDOS_VENDAS.FDClientes do
  begin
    SQL.Text :=
      'INSERT INTO Cliente (Nome, Cidade, UF) VALUES (:Nome, :Cidade, :UF)';
    ParamByName('Nome').AsString := E_CLIENTES.Text;
    ParamByName('Cidade').AsString := E_CIDADE.Text;
    ParamByName('UF').AsString := E_UF.Text;
    ExecSQL;

    LimparEdits;
    ShowMessage('Cliente cadastrado com sucesso!');
    CarregarClientes;

  end;
end;

procedure TF_CADASTRAR_CLIENTES.EditarCliente;

begin
  if DataSource1.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione um cliente para editar.');
    Exit;
  end;

  with DM_PEDIDOS_VENDAS.FDClientes do
  begin
    SQL.Text :=
      'UPDATE Cliente SET Nome = :Nome, Cidade = :Cidade, UF = :UF WHERE Codigo = :Codigo';
    ParamByName('Nome').AsString := E_CLIENTES.Text;
    ParamByName('Cidade').AsString := E_CIDADE.Text;
    ParamByName('UF').AsString := E_UF.Text;
    ParamByName('Codigo').AsInteger := StrToInt(E_CODIGO.Text);
    ExecSQL;

    LimparEdits;
    ShowMessage('Cliente atualizado com sucesso!');
    CarregarClientes;

  end;

end;

procedure TF_CADASTRAR_CLIENTES.ExcluirCliente;
begin
  if DataSource1.DataSet.IsEmpty then
  begin
    ShowMessage('Selecione um cliente para excluir.');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir este cliente?', mtConfirmation,
    [mbYes, mbNo], 0) = mrNo then
    Exit;

  with DM_PEDIDOS_VENDAS.FDClientes do
  begin
    SQL.Text := 'DELETE FROM Cliente WHERE Codigo = :Codigo';
    ParamByName('Codigo').AsInteger := StrToInt(E_CODIGO.Text);
    ExecSQL;

    LimparEdits;
    ShowMessage('Cliente exclu�do com sucesso!');
    CarregarClientes;
  end;

end;

procedure TF_CADASTRAR_CLIENTES.FormCreate(Sender: TObject);
begin
  CarregarClientes;
end;

procedure TF_CADASTRAR_CLIENTES.CarregarClientes;
begin
  with DM_PEDIDOS_VENDAS.FDClientes do
  begin
    SQL.Text := 'SELECT * FROM Cliente';
    Open;
  end;
end;

procedure TF_CADASTRAR_CLIENTES.DBG_CLIENTESCellClick(Column: TColumn);
begin
  if not DataSource1.DataSet.IsEmpty then
  begin
    SB_SALVAR_CLIENTES.Enabled := False;
    E_CODIGO.Text := DataSource1.DataSet.FieldByName('Codigo').AsString;
    E_CLIENTES.Text := DataSource1.DataSet.FieldByName('Nome').AsString;
    E_CIDADE.Text := DataSource1.DataSet.FieldByName('Cidade').AsString;
    E_UF.Text := DataSource1.DataSet.FieldByName('UF').AsString;
  end;
end;

procedure TF_CADASTRAR_CLIENTES.NovoCliente;
begin
  LimparEdits;

  E_CLIENTES.SetFocus;
end;

procedure TF_CADASTRAR_CLIENTES.LimparEdits;
begin
  E_CODIGO.Clear;
  E_CLIENTES.Clear;
  E_CIDADE.Clear;
  E_UF.Clear;
end;

end.
