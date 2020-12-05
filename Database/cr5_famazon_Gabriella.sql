

DROP DATABASE IF EXISTS cr5_famazon_Gabriella;
CREATE DATABASE IF NOT EXISTS cr5_famazon_Gabriella;
USE cr5_famazon_Gabriella;

drop table if exists category;

CREATE TABLE category (
  cat_id 			varchar(5) NOT NULL primary key,
  category_name 		varchar(15) NOT NULL,
  description 			varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

drop table if exists customers;
CREATE TABLE customers (
  customer_id 			int unsigned not null auto_increment primary key,
  user_name 			varchar(15) NOT NULL,
  first_name 			varchar(20) NOT NULL,
  last_name 			varchar(20) NOT NULL,
  email 			varchar(20) NOT NULL,
  registration 			date NOT NULL,
  country 			varchar(30) NOT NULL,
  city 				varchar(30) NOT NULL,
  zip_code 			varchar(15) NOT NULL,
  address 			varchar(70) NOT NULL,
  account_number 		varchar(40)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

drop table if exists supplier;
CREATE TABLE supplier (
  sup_id 			int unsigned not null auto_increment primary key,
  name 				varchar(30) not null,
  phone 			varchar(15),
  address 			varchar(60),
  email 			varchar(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
drop table if exists products;

CREATE TABLE products (
  prod_id 			int unsigned not null auto_increment primary key,
  fk_category_cat_id 		varchar(5) NOT NULL ,
  fk_supplier_sup_id		int unsigned,
  prod_name 			varchar(30) not null,
  description 			varchar(150),
  price 			float not null,
  picture_url 			varchar(100),
  min_stock 			int,
  stock 			int,
foreign key (fk_category_cat_id) references category (cat_id) on delete cascade on update cascade,
foreign key (fk_supplier_sup_id) references supplier (sup_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


drop table if exists wishlist;

CREATE TABLE wishlist (
  fk_customers_customer_id 	int unsigned not null ,
  fk_products_prod_id 		int unsigned NOT NULL ,
primary key(fk_customers_customer_id, fk_products_prod_id),
foreign key (fk_customers_customer_id) references customers (customer_id) on delete cascade on update cascade,
foreign key (fk_products_prod_id) references products (prod_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


drop table if exists orders;
CREATE TABLE orders (
  order_nr 			int unsigned not null auto_increment primary key,
  fk_customers_customer_id 	int unsigned NOT NULL,
  country 			varchar(30) NOT NULL,
  city 				varchar(30) NOT NULL,
  zip_code 			varchar(15) NOT NULL,
  address 			varchar(70) NOT NULL,
  account_number 		varchar(40),
  total_price 			float ,
  orderdate			date,
  payed				ENUM('open','closed'),
  foreign key (fk_customers_customer_id) references customers (customer_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

drop table if exists order_items;

CREATE TABLE order_items(
  order_item_nr 		int unsigned not null auto_increment primary key,
  fk_orders_order_nr 		int unsigned not null ,
  fk_products_prod_id 		int unsigned NOT NULL , 
  price				float,
  quantity 			int,
foreign key (fk_orders_order_nr) references orders (order_nr) on delete cascade on update cascade,
foreign key (fk_products_prod_id) references products (prod_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





drop table if exists newstocks;
CREATE TABLE newstocks (
  delivery_id 			int unsigned not null auto_increment primary key,
  fk_supplier_sup_id 		int unsigned not null,
  ddate 			date,
foreign key (fk_supplier_sup_id) references supplier (sup_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


drop table if exists delivery_items;
CREATE TABLE delivery_items (
  item_nr 			int unsigned not null auto_increment primary key,
  fk_products_prod_id 		int unsigned NOT NULL ,
  fk_newstocks_delivery_id 	int unsigned not null,
  quantity			int,
  total_price 			float,
foreign key (fk_products_prod_id) references products (prod_id) on delete cascade on update cascade,
foreign key (fk_newstocks_delivery_id) references newstocks (delivery_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


drop table if exists companies;
CREATE TABLE companies (
  company_id 			int unsigned not null auto_increment primary key,
  name 				varchar(30) not null,
  phone 			varchar(15),
  address 			varchar(60),
  email 			varchar(20)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


drop table if exists shipments;

CREATE TABLE shipments(
  shipment_id 			int unsigned not null auto_increment primary key,
  fk_orders_order_nr 		int unsigned not null ,
  fk_companies_company_id 	int unsigned NOT NULL ,
  start 			date,
  end 				date,
  status 			ENUM ('waiting','shipping','delivered'),
foreign key (fk_orders_order_nr) references orders (order_nr) on delete cascade on update cascade,
foreign key (fk_companies_company_id ) references companies (company_id) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





INSERT INTO `category` (`cat_id`, `category_name`, `description`) 
	VALUES ('A1001', 'Samsung', 'all type of mobilephones of the company Samsung');
INSERT INTO `category` (`cat_id`, `category_name`, `description`) 
	VALUES 
	('A1002', 'Tablets', 'all tablets from the company Samsung'), 
	('B1001', 'Tshirts', 'nice thshirts from Guess');


INSERT INTO `companies` (`company_id`, `name`, `phone`, `address`, `email`)
 VALUES 
(NULL, 'shipping company1', '123456789', 'somewhere', 'shipping1@gmail.com'), 
(NULL, 'shipping company2', '1234567888', 'somewhere2', 'shipping2@gmail.com'), 
(NULL, 'shipping company3', '987654321', 'somewhere3', 'shipping3@gmail.com');

INSERT INTO `customers` (`customer_id`, `user_name`, `first_name`, `last_name`, `email`,
 `registration`, `country`, `city`, `zip_code`, `address`, `account_number`) 
VALUES 
(NULL, 'Katrin1', 'Katrin', 'Burger', 'katrin@gmail.com', '2020-11-29', 'Austria', 'Wien', '1010', 'somewhere in wien', 'AT222-12345678-11111111-1111111'),
(NULL, 'Peter1', 'Peter', 'Hartlieb', 'peter@gmail.com', '2020-12-01', 'Austria', 'Salzburg', '5022', 'somewhere in Salzburg', 'AT222-12345678-11111111-88888888'), 
(NULL, 'Falco99', 'Falco', 'Leey', 'falco@gmail.com', '2020-12-02', 'Germany', 'Hamburg', '88888', 'somewhere in Hamburg', 'DE999-999999999-88888888'); 

INSERT INTO `supplier` (`sup_id`, `name`, `phone`, `address`, `email`) 
VALUES (NULL, 'supplier1', '111111111111', 'somewhere supplier', 'supplier1@chello.at'), 
(NULL, 'supplier2', '222222222222', 'somewhere supplier 2 city', 'supplier2@gmail.com'), 
(NULL, 'supplier3', '33333333333', 'somewhere supplier3', 'supplier3@gmail.com');

INSERT INTO `products` (`prod_id`, `fk_category_cat_id`, `fk_supplier_sup_id`,`prod_name`, `description`, `price`, `picture_url`, `min_stock`, `stock`) 
VALUES (NULL, 'A1001',1, 'Samsung galaxy S8', 'nice S8 mobile phone ', '290.00', NULL, '0', '5');
INSERT INTO `products` (`prod_id`, `fk_category_cat_id`,`fk_supplier_sup_id`, `prod_name`, `description`, `price`, `picture_url`, `min_stock`, `stock`) 
VALUES (NULL, 'A1001', 1,'Samsung Galaxy S9', 'very nice samsung galaxy s9 including pulse messer', '', 350.00, '5', '4');
INSERT INTO `products` (`prod_id`, `fk_category_cat_id`,`fk_supplier_sup_id`, `prod_name`, `description`, `price`, `picture_url`, `min_stock`, `stock`) 
VALUES (NULL, 'A1002',1, 'Samsung tablet', 'new full functioning tablet', '500.00', NULL, '20', '19');
INSERT INTO `products` (`prod_id`, `fk_category_cat_id`,`fk_supplier_sup_id`, `prod_name`, `description`, `price`, `picture_url`, `min_stock`, `stock`) 
VALUES (NULL, 'B1001',2, 'red tshirt', 'red tshirt, bio material', '22.00', NULL, '20', '22');



INSERT INTO `newstocks` (`delivery_id`, `fk_supplier_sup_id`, `ddate`) 
VALUES (NULL, '1', '2020-12-02'), (NULL, '1', '2020-12-03'), 
(NULL, '2', '2020-12-03');

INSERT INTO `delivery_items` (`item_nr`, `fk_products_prod_id`, `fk_newstocks_delivery_id`, `quantity`, `total_price`)
 VALUES (NULL, '1', '1', '5', '1000.00');
INSERT INTO `delivery_items` (`item_nr`, `fk_products_prod_id`, `fk_newstocks_delivery_id`, `quantity`, `total_price`) 
VALUES (NULL, '4', '2', '2', '500.00');
INSERT INTO `delivery_items` (`item_nr`, `fk_products_prod_id`, `fk_newstocks_delivery_id`, `quantity`, `total_price`) 
VALUES (NULL, '2', '3', '10', '200.00');

INSERT INTO `orders` (`order_nr`, `fk_customers_customer_id`, `country`, `city`, `zip_code`, `address`, `account_number`, `total_price`,`orderdate`,`payed`) 
VALUES 
(NULL, '1', 'Austria', 'Wien', '1010', 'Somewhere in Wien', 'AT222-12345678-11111111-1111111', '312.00','2020-12-01','closed');

INSERT INTO `order_items` (`order_item_nr`, `fk_orders_order_nr`, `fk_products_prod_id`, `price`, `quantity`) VALUES (NULL, '1', '4', '22.00', '1');
INSERT INTO `order_items` (`order_item_nr`, `fk_orders_order_nr`, `fk_products_prod_id`, `price`, `quantity`) VALUES (NULL, '1', '1', '290.00', '1');

INSERT INTO `orders` (`order_nr`, `fk_customers_customer_id`, `country`, `city`, `zip_code`, `address`, `account_number`, `total_price`,`orderdate`,`payed`) 
VALUES (NULL, '3', 'Germany', 'Hamburg', '888888', 'somewhere in Hamburg', 'DE777777777777777', '22.00','2020-12-01','closed');

INSERT INTO `order_items` (`order_item_nr`, `fk_orders_order_nr`, `fk_products_prod_id`, `price`, `quantity`) VALUES (NULL, '2', '4', '22.00', '1');

INSERT INTO `orders` (`order_nr`, `fk_customers_customer_id`, `country`, `city`, `zip_code`, `address`, `account_number`, `total_price`,`orderdate`,`payed`) 
VALUES 
(NULL, '2', 'Austria', 'Salzburg', '5555', 'somewhere in Salzburg', 'AT222-12345678-11111111-888888888', '22.00','2020-12-01','closed');
INSERT INTO `order_items` (`order_item_nr`, `fk_orders_order_nr`, `fk_products_prod_id`, `price`, `quantity`) VALUES (NULL, '3', '4', '22.00', '1');

INSERT INTO `shipments` (`shipment_id`, `fk_orders_order_nr`, `fk_companies_company_id`, `start`, `end`, `status`) 
VALUES (NULL, '1', '1', '2020-12-05', NULL, 'shipping'), 
(NULL, '2', '1', '2020-12-07', NULL, 'waiting'), 
(NULL, '3', '1', '2020-12-03', '2020-12-04', 'delivered');

INSERT INTO `wishlist` (`fk_customers_customer_id`, `fk_products_prod_id`)
 VALUES ('1', '3'), ('1', '4'), ('1', '2');
INSERT INTO `wishlist` (`fk_customers_customer_id`, `fk_products_prod_id`) VALUES ('2', '3'), ('2', '4');
INSERT INTO `wishlist` (`fk_customers_customer_id`, `fk_products_prod_id`) VALUES ('3', '3');
INSERT INTO `customers` (`customer_id`, `user_name`, `first_name`, `last_name`, `email`, `registration`, `country`, `city`, `zip_code`, `address`, `account_number`) 
VALUES (NULL, 'Theodora1', 'Theodora', 'Müller', 'tmüller@gmail.at', '2020-12-01', 'Austria', 'Vienna', '1080', 'Lerchenfelder str 22.', 'At99-777777777-99999999');
INSERT INTO `customers` (`customer_id`, `user_name`, `first_name`, `last_name`, `email`, `registration`, `country`, `city`, `zip_code`, `address`, `account_number`) 
VALUES (NULL, 'Simon1', 'Simon', 'Nomis', 's.nomis@gmail.at', '2020-12-01', 'Austria', 'Vienna', '1080', 'Lederer str 28.', 'AT222-12345678-11111111-19876789');

INSERT INTO `category` (`cat_id`, `category_name`, `description`) VALUES ('C0001', 'coats', 'coats der firma Wolfskin');

INSERT INTO `products` (`prod_id`, `fk_category_cat_id`, `prod_name`, `description`, `price`, `picture_url`, `min_stock`, `stock`) 
VALUES (NULL, 'C0001', 'Coat women', 'winter coat black for woman', '99.00', NULL, '5', '20');

COMMIT;


