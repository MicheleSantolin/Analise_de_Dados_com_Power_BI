-- Antes de inciar, comandos que podem vir a serem uteis:
-- show databases;
-- show tables;


-- iniciando o banco de dados para popular a tabela inicialmente.
use ecommerce;


-- Inserindo dados na Tabela de client (Cliente):
insert into client (Fname, Minit, Lname, CPF, Address)
		values
              ('João', 'A', 'Silva', '12345678901', 'Rua das Flores, 123'),
			  ('Maria', 'B', 'Santos', '98765432109', 'Avenida Brasil, 456'),
			  ('Pedro', 'C', 'Oliveira', '45678912345', 'Rua dos Coqueiros, 789'),
			  ('Ana', 'D', 'Costa', '32165498701', 'Avenida Paulista, 1010'),
			  ('Carlos', 'E', 'Pereira', '65412398701', 'Rua das Palmeiras, 202');
--  select * from client;              


-- Inserindo dados na Tabela de product (Produto):
insert into product (Pname, Classification_kids, Category, Reviews, Size)
	   values
			 ('Smartphone', false, 'Eletrônico', 4.5, 'Médio'),
		     ('Camiseta', false, 'Roupas', 4.0, 'Pequeno'),
		     ('Boneca', true, 'Brinquedos', 4.7, 'Pequeno'),
		     ('Arroz', false, 'Alimentos', 4.2, 'Grande'),
			 ('Tênis', false, 'Calçados', 4.8, 'Médio'),
		     ('Ração para Cães', false, 'Petshop', 4.6, 'Pequeno'),
			 ('Sofá', false, 'Móveis', 4.3, 'Grande');
-- select * from product;              
 
 
-- Inserindo dados na Tabela de orders (Pedido):
insert into orders (idOrderClient, OrderStatus, OrderDescription, SendValue, PaymentCash)
	  values
			(1, 'Confirmado', 'Compra de smartphone', 10.0, false),
			(2, 'Em processamento', 'Compra de camiseta', 10.0, true),
			(3, 'Cancelado', 'Compra de boneca', 10.0, false),
			(4, 'Confirmado', 'Compra de arroz', 10.0, true),
			(5, 'Em processamento', 'Compra de tênis', 10.0, false),
            (2, default, null, 10.0, false);
-- select * from orders;     


-- Inserindo dados na Tabela de payments (Pagamento):
insert into payments (idOrder, PaymentMethod, PaymentDate, PaymentStatus)
		values
		  (1, 'Cartão Crédito', '2023-10-01', 'Pago'),
		  (2, 'Dinheiro', '2023-10-02', 'Pendente'),
		  (3, 'Pix', '2023-10-03', 'Cancelado'),
		  (4, 'Cartão Débito', '2023-10-04', 'Pago'),
		  (5, 'Cartão Crédito', '2023-10-05', 'Pendente');
-- select * from payments;     

         
-- Inserindo dados na Tabela de productStorage (Estoque):
insert into productStorage (StorageLocation, Quantity)
		values
         ('São Paulo', 100),
		 ('Rio de Janeiro', 50),
		 ('Belo Horizonte', 75),
	 	 ('Curitiba', 60),
		 ('Porto Alegre', 90);
 -- select * from productStorage;        
        
        
-- Inserindo dados na Tabela de supplier (Fornecedor):
insert into  supplier (SocialName, CNPJ, Contact)
	   values
		('Fornecedor Eletrônicos Ltda', '123456789012345', '11987654321'),
		('Fornecedor Roupas S.A.', '987654321098765', '21987654321'),
		('Fornecedor Brinquedos ME', '456789123456789', '31987654321'),
		('Fornecedor Alimentos Ltda', '321654987012345', '41987654321'),
		('Fornecedor Calçados S.A.', '654123987012345', '51987654321');
-- select * from supplier;
     
        
-- Inserindo dados na Tabela de seller (Vendedor):
insert into seller (SocialName, AbstName, CNPJ, CPF, Location, Contact)
	  values
	   ('Loja de Eletrônicos', 'Eletrônicos Ltda', '123456789012345', NULL, 'São Paulo', '11987654321'),
       ('Loja de Roupas', 'Roupas S.A.', '987654321098765', NULL, 'Rio de Janeiro', '21987654321'),
       ('Loja de Brinquedos', 'Brinquedos ME', '456789123456789', NULL, 'Belo Horizonte', '31987654321'),
       ('Loja de Alimentos', 'Alimentos Ltda', '321654987012345', NULL, 'Curitiba', '41987654321'),
       ('Loja de Calçados', 'Calçados S.A.', '654123987012345', NULL, 'Porto Alegre', '51987654321');
--  select * from seller;    
        
        
-- Inserindo dados na Tabela de (Produto/Vendedor):
insert into productSeller (idPseller, idProduct, ProdQuantity)
	values
	 (1, 17, 10),  -- Vendedor 1 vende Smartphone
	 (2, 24, 20),  -- Vendedor 2 vende Camiseta
	 (3, 23, 15),  -- Vendedor 3 vende Boneca
	 (4, 18, 50),  -- Vendedor 4 vende Arroz
	 (5, 15, 30);  -- Vendedor 5 vende Tênis
 select * from productSeller;
            

-- Inserindo dados na Tabela de productOrder (Produto/Pedido):
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
	values
     (15, 1, 1, 'Disponível'),  -- Pedido 1 contém Smartphone
     (22, 2, 2, 'Disponível'),  -- Pedido 2 contém Camiseta
     (21, 3, 1, 'Sem Estoque'), -- Pedido 3 contém Boneca
     (17, 4, 5, 'Disponível'),  -- Pedido 4 contém Arroz
     (19, 5, 1, 'Disponível');  -- Pedido 5 contém Tênis
 select * from productOrder;     

                
-- Inserindo dados na Tabela de storageLocation (Localização do Estoque):
insert into storageLocation (idLproduct, idLstorage, location)
	values
	 (15, 1, 'São Paulo'),  -- Smartphone no estoque de São Paulo
	 (16, 2, 'Rio de Janeiro'),  -- Camiseta no estoque do Rio de Janeiro
     (17, 3, 'Belo Horizonte'),  -- Boneca no estoque de Belo Horizonte
     (18, 4, 'Curitiba'),  -- Arroz no estoque de Curitiba
     (19, 5, 'Porto Alegre');  -- Tênis no estoque de Porto Alegre
 --  select * from storageLocation;     
        
        
-- Inserindo dados na Tabela de productSupplier (Produto/Fornecedor):
insert into productSupplier (idPsSupplier, idPsProduct, quantity)
	values
	 (1, 15, 100),  -- Fornecedor 1 fornece Smartphone
     (2, 16, 200),  -- Fornecedor 2 fornece Camiseta
     (3, 17, 150),  -- Fornecedor 3 fornece Boneca
     (4, 18, 500),  -- Fornecedor 4 fornece Arroz
     (5, 19, 300);  -- Fornecedor 5 fornece Tênis
 -- select * from productSupplier;
     
     
     
     
