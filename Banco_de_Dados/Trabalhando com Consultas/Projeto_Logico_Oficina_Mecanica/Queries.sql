-- Antes de inciar, comandos que podem vir a serem uteis:
-- show databases;
-- show tables;


-- iniciando o banco de dados para popular a tabela inicialmente.
use Oficina_Mecanica;

-- Consultas SQL

-- 1 - Recuperar veículos de um determinado cliente (filtro):
SELECT Vehicle.LicensePlate, Vehicle.Model, Vehicle.Brand
FROM Vehicle
JOIN Client ON Vehicle.idVehicle = Client.Vehicle_idVehicle
WHERE Client.Name = 'João da Silva';

-- 2 - Recuperar informações de Serviço e o valor total de cada serviço (expressão derivada):
SELECT idService, Description, LaborCost, LaborCost * 1.1 AS ServiceWithTax
FROM Service;


-- 3 - Ordenar clientes por nome de forma ascendente:
SELECT Name, Contact FROM Client
ORDER BY Name ASC;

-- 4 - Ordenar veículos por ano de fabricação em ordem decrescente:
SELECT LicensePlate, Model, Brand, Year FROM Vehicle
ORDER BY Year DESC;


-- 5 - Recuperar a soma do valor total de todos os serviços em andamento:
SELECT SUM(TotalAmount) AS TotalAmountInProgress
FROM ServiceOrder
WHERE Status = 'Em andamento';


-- 6 - Recuperar os detalhes da ordem de serviço, incluindo o nome do veículo e descrição do serviço:
SELECT ServiceOrder.idServiceOrder, ServiceOrder.IssueDate, Service.Description, Vehicle.LicensePlate
FROM ServiceOrder
JOIN Vehicle ON ServiceOrder.idVehicle = Vehicle.idVehicle
JOIN Service ON ServiceOrder.Service_idService = Service.idService;

-- 7 - Recuperar peças usadas em cada ordem de serviço, com detalhes do código da peça e quantidade:
SELECT ServiceOrder.idServiceOrder, Part.Description, ServiceOrder_Part.Quantity
FROM ServiceOrder_Part
JOIN ServiceOrder ON ServiceOrder_Part.idServiceOrder = ServiceOrder.idServiceOrder
JOIN Part ON ServiceOrder_Part.partCode = Part.Code;

-- 8 - Qual é o valor total gasto por cada cliente no último ano?
SELECT Client.Name, SUM(ServiceOrder.TotalAmount) AS TotalSpentLastYear
FROM ServiceOrder
JOIN Vehicle ON ServiceOrder.idVehicle = Vehicle.idVehicle
JOIN Client ON Vehicle.idVehicle = Client.Vehicle_idVehicle
WHERE ServiceOrder.IssueDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY Client.Name
ORDER BY TotalSpentLastYear DESC;

-- 9 - Qual é o serviço mais caro já realizado?
SELECT Service.Description, MAX(ServiceOrder.TotalAmount) AS MostExpensiveService
FROM ServiceOrder
JOIN Service ON ServiceOrder.Service_idService = Service.idService
GROUP BY Service.Description
ORDER BY MostExpensiveService DESC
LIMIT 1;
 
 -- 10 -  Serviços que nunca foram utilizados?
 SELECT Service.Description
FROM Service
LEFT JOIN ServiceOrder ON Service.idService = ServiceOrder.Service_idService
WHERE ServiceOrder.idServiceOrder IS NULL;