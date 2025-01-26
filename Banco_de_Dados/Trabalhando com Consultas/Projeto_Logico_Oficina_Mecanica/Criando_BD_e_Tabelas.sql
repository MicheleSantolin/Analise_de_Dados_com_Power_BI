-- CREATE DATABASE Oficina_Mecanica;
USE Oficina_Mecanica;

-- Após criar o database, caso queira conferir a criação:
-- show databases;


-- A ordem de criação das tabelas foi: Service, Part, Vehicle, Client, ServiceOrder, ServiceOrder_Part, Mechanic, Team.       
show databases;

-- Criando Tabela de Cliente
CREATE TABLE Client (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45) NOT NULL,
    Contact CHAR(11) NOT NULL,  
    Address VARCHAR(45) NOT NULL,
    CPF CHAR(11),  
    CNPJ CHAR(14), 
    ClientType ENUM('PF', 'PJ') NOT NULL,  -- Tipo de cliente: 'PF' ou 'PJ'
    Vehicle_idVehicle INT NOT NULL,
    FOREIGN KEY (Vehicle_idVehicle) REFERENCES Vehicle(idVehicle),
    CONSTRAINT unique_cnpj UNIQUE (CNPJ),
    CONSTRAINT unique_cpf UNIQUE (CPF),
    CONSTRAINT check_cpf_cnpj CHECK (
        (ClientType = 'PF' AND CPF IS NOT NULL AND CPF != '' AND (CNPJ IS NULL OR CNPJ = '')) OR
        (ClientType = 'PJ' AND CNPJ IS NOT NULL AND CNPJ != '' AND (CPF IS NULL OR CPF = ''))
    )
);
-- DESC Client;

-- Criando Tabela de Veículo
CREATE TABLE Vehicle (
   idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    LicensePlate VARCHAR(45) NOT NULL,
    Model VARCHAR(45) NOT NULL,
    Brand VARCHAR(45) NOT NULL,
    Year VARCHAR(45) NOT NULL
);
-- DESC VEHICLE;

-- Criando Tabela de Ordem de Serviço 
CREATE TABLE ServiceOrder (
    idServiceOrder INT AUTO_INCREMENT PRIMARY KEY,
    IssueDate DATE NOT NULL,
    CompletionDate DATE NOT NULL,
    TotalAmount FLOAT NOT NULL,
    Status ENUM('Em andamento', 'Concluído') NOT NULL,
    idVehicle INT NOT NULL,
    Service_idService INT NOT NULL,
    Part_Code INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (idVehicle) REFERENCES Vehicle(idVehicle),
    FOREIGN KEY (Service_idService) REFERENCES Service(idService)
);
-- DESC ServiceOrder;

-- Criando Tabela de Serviço
CREATE TABLE Service (
    idService INT AUTO_INCREMENT PRIMARY KEY,
    Description VARCHAR(45),
    LaborCost FLOAT
);
-- DESC Service;

-- Criando Tabela de Peças
CREATE TABLE Part (
    Code INT AUTO_INCREMENT PRIMARY KEY,
    Description VARCHAR(45) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);
-- DEsC Part;

-- Criando Tabela Ordem de Serviço e Peça
CREATE TABLE ServiceOrder_Part (
    idServiceOrder INT AUTO_INCREMENT NOT NULL,
    partCode INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (idServiceOrder, partCode),
    FOREIGN KEY (idServiceOrder) REFERENCES ServiceOrder(idServiceOrder) ON DELETE CASCADE,
    FOREIGN KEY (partCode) REFERENCES Part(Code)
);
-- DESC ServiceOrder_Part;

-- Criando Tabela de Mecânico 
CREATE TABLE Mechanic (
    idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(45) NOT NULL,
    Specialty VARCHAR(45) NOT NULL
);
-- DESC Mechanic;

-- Criando Tabela de Equipe
CREATE TABLE Team (
    idTeam INT AUTO_INCREMENT PRIMARY KEY,
    TeamName VARCHAR(45) NOT NULL,
    Mechanic_idMechanic INT NOT NULL,
    ServiceOrder_idServiceOrder INT NOT NULL,
    FOREIGN KEY (Mechanic_idMechanic) REFERENCES Mechanic(idMechanic),
    FOREIGN KEY (ServiceOrder_idServiceOrder) REFERENCES ServiceOrder(idServiceOrder)
);
-- DESC Team; 
