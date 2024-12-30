unit Repositorio.Produto;

interface

uses
  Produto.Classe, System.SysUtils, FireDAC.Comp.Client, Generics.Collections,
  Repositorio.Inter;

type
  TRepositorioProduto = class(TInterfacedObject, IRepositorio<TProduto>)
  private
    FTable: TFDTable;
  public
    constructor Create(ATable: TFDTable);
    function ObterPorID(ID: Integer): TProduto;
    function Listar: TList<TProduto>;
    procedure Inserir(Entidade: TProduto);
    procedure Atualizar(Entidade: TProduto);
    procedure Excluir(ID: Integer);
  end;

implementation

{ TRepositorioProduto }

constructor TRepositorioProduto.Create(ATable: TFDTable);
begin
  if not Assigned(ATable) then
    raise Exception.Create('Instância de TFDTable não fornecida.');
  FTable := ATable;
end;

function TRepositorioProduto.ObterPorID(ID: Integer): TProduto;
begin
  Result := nil;

  // Garante que a tabela esteja fechada antes de aplicar o filtro
  FTable.Close;
  FTable.Filter := Format('Codigo = %d', [ID]);
  FTable.Filtered := True;
  FTable.Open;

  try
    if not FTable.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo := FTable.FieldByName('Codigo').AsInteger;
      Result.Descricao := FTable.FieldByName('Descricao').AsString;
      Result.PrecoVenda := FTable.FieldByName('PrecoVenda').AsFloat;
    end;
  finally
    // Remove o filtro para evitar interferências futuras
    FTable.Filtered := False;
  end;
end;

function TRepositorioProduto.Listar: TList<TProduto>;
var
  Produto: TProduto;
begin
  Result := TList<TProduto>.Create;

  FTable.Open;
  FTable.First;

  while not FTable.Eof do
  begin
    Produto := TProduto.Create;
    Produto.Codigo := FTable.FieldByName('Codigo').AsInteger;
    Produto.Descricao := FTable.FieldByName('Descricao').AsString;
    Produto.PrecoVenda := FTable.FieldByName('PrecoVenda').AsFloat;
    Result.Add(Produto);
    FTable.Next;
  end;
end;

procedure TRepositorioProduto.Inserir(Entidade: TProduto);
begin
  raise Exception.Create('Inserir não implementado.');
end;

procedure TRepositorioProduto.Atualizar(Entidade: TProduto);
begin
  raise Exception.Create('Atualizar não implementado.');
end;

procedure TRepositorioProduto.Excluir(ID: Integer);
begin
  raise Exception.Create('Excluir não implementado.');
end;

end.

