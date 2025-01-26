-- Antes de inciar, comandos que podem vir a serem uteis:
-- show databases;
-- show tables;

-- iniciando o banco de dados para popular a tabela inicialmente.
use Oficina_Mecanica;


-- Inserindo dados na tabela Part
INSERT INTO Part (Description, Price) VALUES
('Óleo de motor', 30.00),
('Pneu', 150.00),
('Amortecedor', 180.00),
('Filtro de ar', 25.00),
('Velas de ignição', 15.00),
('Correia dentada', 60.00),
('Filtro de óleo', 20.00),
('Bateria', 180.00),
('Cabo de vela', 10.00),
('Pastilha de freio', 80.00),
('Disco de freio', 200.00),
('Compressor de ar condicionado', 750.00),
('Tinta automotiva', 120.00),
('Bateria 60Ah', 300.00),
('Scanner de diagnóstico', 500.00),
('Radiador', 350.00),
('Filtro de combustível', 40.00),
('Correia alternador', 50.00);
-- Select * from Part;

-- Inserindo dados na tabela Vehicle
INSERT INTO Vehicle (LicensePlate, Model, Brand, Year) VALUES
('ABC1234', 'Fusca', 'Volkswagen', '1974'),
('XYZ5678', 'Civic', 'Honda', '2018'),
('LMN8901', 'Onix', 'Chevrolet', '2020'),
('JKL4321', 'Ka', 'Ford', '2015'),
('PQR6789', 'HB20', 'Hyundai', '2017'),
('STU1234', 'Tucson', 'Hyundai', '2022'),
('DEF5678', 'Corolla', 'Toyota', '2021'),
('GHI9012', 'Palio', 'Fiat', '2013'),
('JKL3456', 'Ranger', 'Ford', '2019'),
('MNO6789', 'Spin', 'Chevrolet', '2018'),
('PQR1234', 'Gol', 'Volkswagen', '2017'),
('STU9876', 'Civic', 'Honda', '2023');
-- Select * from Vehicle;

-- Inserindo dados na tabela Client
INSERT INTO Client (Name, Contact, Address, CPF, CNPJ, ClientType, Vehicle_idVehicle) VALUES
('João da Silva', '11987654321', 'Rua A, 123', '12345678901', NULL, 'PF', 1),
('Maria Oliveira', '11923456789', 'Rua B, 456', '98765432101', NULL, 'PF', 2),
('Empresa X', '1122334455', 'Avenida C, 789', NULL, '12345678000195', 'PJ', 3),
('Ricardo Souza', '11987654322', 'Rua D, 321', '23456789012', NULL, 'PF', 4),
('Ana Silva', '11912345678', 'Rua E, 789', '12345678902', NULL, 'PF', 5),
('Loja Y', '11987654310', 'Avenida F, 123', NULL, '98765432000187', 'PJ', 6),
('Pedro Santos', '11999887766', 'Rua G, 321', '34567890123', NULL, 'PF', 7);
-- Select * from Client;

-- Inserindo dados na tabela Service
INSERT INTO Service (Description, LaborCost) VALUES
('Troca de óleo', 50.00),
('Reparo de suspensão', 200.00),
('Alinhamento e balanceamento', 150.00),
('Troca de filtro de ar', 40.00),
('Troca de correia dentada', 220.00),
('Reparo de motor', 500.00),
('Troca de pastilha de freio', 120.00),
('Reparo de embreagem', 300.00),
('Manutenção de ar condicionado', 180.00),
('Pintura automotiva', 450.00),
('Troca de bateria', 70.00),
('Diagnóstico eletrônico', 60.00);
-- Select * from Service;

-- Inserindo dados na tabela ServiceOrder
INSERT INTO ServiceOrder (IssueDate, CompletionDate, TotalAmount, Status, idVehicle, Service_idService, Part_Code, Quantity) VALUES
('2025-01-20', '2025-01-22', 250.00, 'Em andamento', 1, 1, 1, 2), 
('2025-01-15', '2025-01-17', 400.00, 'Concluído', 2, 2, 2, 4),
('2025-01-18', '2025-01-19', 500.00, 'Concluído', 3, 3, 3, 3),
('2025-01-21', '2025-01-23', 350.00, 'Em andamento', 4, 4, 4, 1),
('2025-01-16', '2025-01-18', 450.00, 'Concluído', 5, 5, 5, 2),
('2025-01-19', '2025-01-20', 600.00, 'Concluído', 6, 6, 6, 4);
 -- Select * from ServiceOrder;

-- Inserindo dados na tabela ServiceOrder_Part
INSERT INTO ServiceOrder_Part (idServiceOrder, partCode, Quantity) VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2),
(6, 6, 4);
 -- Select * from ServiceOrder_Part; 

-- Inserindo dados na tabela Mechanic
INSERT INTO Mechanic (Name, Specialty) VALUES
('Carlos Pereira', 'Mecânica Geral'),
('Felipe Souza', 'Suspensão e direção'),
('Ana Lima', 'Elétrica automotiva'),
('João Silva', 'Mecânica de motores'),
('Bruna Costa', 'Transmissão e câmbio'),
('Roberto Martins', 'Eletrônica automotiva');
-- Select * from Mechanic;

-- Inserindo dados na tabela Team
INSERT INTO Team (TeamName, Mechanic_idMechanic, ServiceOrder_idServiceOrder) VALUES
('Equipe A', 1, 1),
('Equipe B', 2, 2),
('Equipe C', 3, 3),
('Equipe D', 4, 4),
('Equipe E', 5, 5),
('Equipe F', 6, 6);
-- Select * from Team;