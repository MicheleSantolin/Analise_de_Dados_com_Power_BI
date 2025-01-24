-- crianção do banco de dados para o cenário de E-commece
create database ecommerce;
use ecommerce;

-- cria tabela cliente
create table client (
	idClient int auto_increment primary key,
	Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);


 -- cria tabela produto
  -- size = dimensão do produto
create table product(
	idProduct int auto_increment primary key,
	Pname varchar(50) not null,
    Classification_kids bool default false,
    Category enum('Eletrônico', 'Roupas', 'Brinquedos', 'Alimentos', 'Calçados', 'Petshop', 'Móveis') not null, 
	Reviews float default 0,
    Size varchar(10)
);

 -- cria tabela pedido;
create table orders (
	idOrder int auto_increment primary key,
    idOrderClient int,
    OrderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 10,
    PaymentCash bool default false,
    constraint fk_order_client foreign key (idOrderClient) references client(idClient)
);

-- cria tabela pagamento;
create table payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,            
    idOrder INT NOT NULL,                               
    PaymentMethod ENUM('Cartão Débito', 'Cartão Crédito', 'Dinheiro', 'Pix') NOT NULL, 
    PaymentDate DATE NOT NULL,                           
    PaymentStatus ENUM('Pendente', 'Pago', 'Cancelado') NOT NULL, 
    foreign key (idOrder) references orders(idOrder)     
);

-- cria tabela estoque;
create table  productStorage(
	idProdStorage int auto_increment primary key,
    StorageLocation varchar(255),
    Quantity int default 0
);

-- Cria tabela fornecedor;
create table supplier(
    idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
	Contact char(11) not null,
	constraint unique_supplier unique(CNPJ)
);

-- cria tabela vendedor;
create table seller(
    idSeller int auto_increment primary key,  
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(11),
    Location varchar(255),
    Contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
    
);

-- Cria tabela Produtos_venderor(Terceiro)
create table productSeller(
	idPseller int,
    idProduct int,
    ProdQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint	fk_product_product foreign key (idProduct) references product(idProduct)

);

-- Cria tabela Produto/Pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem Estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),  
    constraint  fk_productorder_seller foreign key (idPOproduct) REFERENCES product(idProduct), 
    constraint fk_productorder_order foreign key (idPOorder) REFERENCES orders(idOrder)
);

-- cria tabela Produto_em_Estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

