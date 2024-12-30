CREATE TABLE Cliente (
    Codigo INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    UF VARCHAR(2) NOT NULL
);

-- Tabela Produto
CREATE TABLE Produto (
    Codigo INTEGER PRIMARY KEY AUTOINCREMENT,
    Descricao VARCHAR(100) NOT NULL,
    PrecoVenda REAL NOT NULL
);

-- Tabela Pedido
CREATE TABLE Pedido (
    Numero INTEGER PRIMARY KEY AUTOINCREMENT,
    DataEmissao VARCHAR(100) NOT NULL,
    CodigoCliente INTEGER NOT NULL,
    ValorTotal REAL NOT NULL,
    FOREIGN KEY (CodigoCliente) REFERENCES Cliente (Codigo)
);

-- Tabela ItemPedido
CREATE TABLE ItemPedido (
    Incremento INTEGER PRIMARY KEY AUTOINCREMENT,
    NumeroPedido INTEGER NOT NULL,
    CodigoProduto INTEGER NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    Quantidade INTEGER NOT NULL,
    ValorUnitario REAL NOT NULL,
    ValorTotal REAL NOT NULL,
    FOREIGN KEY (NumeroPedido) REFERENCES Pedido (Numero),
    FOREIGN KEY (CodigoProduto) REFERENCES Produto (Codigo)
);

-- Índices para melhorar a performance nas buscas
CREATE INDEX idx_Pedido_CodigoCliente ON Pedido (CodigoCliente);
CREATE INDEX idx_ItemPedido_NumeroPedido ON ItemPedido (NumeroPedido);
CREATE INDEX idx_ItemPedido_CodigoProduto ON ItemPedido (CodigoProduto);




-- Consutar vendas realizadas
SELECT 
  P.Numero AS NumeroPedido, 
  P.DataEmissao, 
  P.ValorTotal, 
  C.Nome AS NomeCliente
FROM 
  Pedido P
JOIN 
  Cliente C ON P.CodigoCliente = C.Codigo
WHERE 
  C.Nome LIKE :Nome OR C.Codigo = :Codigo;
