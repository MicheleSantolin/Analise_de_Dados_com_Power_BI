-- Antes de inciar, comandos que podem vir a serem uteis:
-- show databases;
-- show tables;


-- iniciando o banco de dados para realizar as queries.
-- use ecommerce;


-- 1. Quantos pedidos foram feitos por cada cliente?
SELECT 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) AS NomeCliente, 
    COUNT(DISTINCT o.idOrder) AS TotalPedidos,
    GROUP_CONCAT(
        CONCAT(p.Pname, ' (', po.poQuantity, ' un)') 
        SEPARATOR ', '
    ) AS ProdutosComprados
FROM client c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
LEFT JOIN productOrder po ON o.idOrder = po.idPOorder
LEFT JOIN product p ON po.idPOproduct = p.idProduct
GROUP BY c.idClient
ORDER BY TotalPedidos DESC;

-- 2. Algum vendedor também é fornecedor?
SELECT 
    s.idSeller, 
    s.SocialName AS NomeVendedor, 
    s.CNPJ AS CNPJ_Vendedor, 
    su.idSupplier, 
    su.SocialName AS NomeFornecedor, 
    su.CNPJ AS CNPJ_Fornecedor
FROM seller s
JOIN supplier su ON s.CNPJ = su.CNPJ;



-- 3. Relação de produtos, fornecedores e estoques:
SELECT 
    p.Pname AS NomeProduto, 
    s.SocialName AS Fornecedor, 
    ps.quantity AS QuantidadeFornecida, 
    sl.location AS LocalEstoque, 
    ps2.Quantity AS QuantidadeEmEstoque
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier s ON ps.idPsSupplier = s.idSupplier
JOIN storageLocation sl ON p.idProduct = sl.idLproduct
JOIN productStorage ps2 ON sl.idLstorage = ps2.idProdStorage;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos:
SELECT 
    s.SocialName AS Fornecedor, 
    p.Pname AS Produto
FROM supplier s
JOIN productSupplier ps ON s.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct
ORDER BY Fornecedor, Produto;

-- 5. Valor total gasto por cada cliente (atributo derivado):
SELECT 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) AS NomeCliente, 
    SUM(o.SendValue) AS TotalGasto
FROM client c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
ORDER BY TotalGasto DESC;

-- 6. Pedidos com valor de frete superior a 15 (filtro com WHERE):
SELECT 
    idOrder, 
    idOrderClient, 
    SendValue
FROM orders
WHERE SendValue > 15;

-- 7. Produtos mais vendidos (ordenados por quantidade):
SELECT 
    p.Pname AS NomeProduto, 
    SUM(po.poQuantity) AS TotalVendido
FROM product p
JOIN productOrder po ON p.idProduct = po.idPOproduct
GROUP BY p.idProduct
ORDER BY TotalVendido DESC;

-- 8. Clientes que fizeram mais de 2 pedidos (filtro com HAVING):
SELECT 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) AS NomeCliente, 
    p.Pname AS NomeProduto, 
    SUM(po.poQuantity) AS QuantidadeComprada
FROM client c
JOIN orders o ON c.idClient = o.idOrderClient
JOIN productOrder po ON o.idOrder = po.idPOorder
JOIN product p ON po.idPOproduct = p.idProduct
GROUP BY c.idClient, p.Pname
HAVING QuantidadeComprada > 0
ORDER BY c.idClient, QuantidadeComprada DESC;


-- 9. Relação de produtos e seus estoques (junção de tabelas):
SELECT 
    p.Pname AS NomeProduto, 
    sl.location AS LocalEstoque, 
    ps.Quantity AS QuantidadeEmEstoque
FROM product p
JOIN storageLocation sl ON p.idProduct = sl.idLproduct
JOIN productStorage ps ON sl.idLstorage = ps.idProdStorage;

-- 10. Fornecedores que fornecem mais de 100 unidades de um produto (filtro com HAVING):
SELECT 
    s.SocialName AS Fornecedor, 
    p.Pname AS Produto, 
    ps.quantity AS QuantidadeFornecida
FROM supplier s
JOIN productSupplier ps ON s.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct
GROUP BY s.idSupplier, p.idProduct
HAVING ps.quantity > 100;

-- 11. Pedidos com status "Cancelado" (filtro com WHERE):
SELECT 
    idOrder, 
    idOrderClient, 
    OrderStatus
FROM orders
WHERE OrderStatus = 'Cancelado';

-- 12. Produtos sem estoque (filtro com WHERE):
SELECT 
    p.Pname AS NomeProduto
FROM product p
JOIN productOrder po ON p.idProduct = po.idPOproduct
WHERE po.poStatus = 'Sem Estoque';

-- 13. Média de valor de frete por cliente (atributo derivado):
SELECT 
    c.idClient, 
    CONCAT(c.Fname, ' ', c.Lname) AS NomeCliente, 
    AVG(o.SendValue) AS MediaFrete
FROM client c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
ORDER BY MediaFrete DESC;
