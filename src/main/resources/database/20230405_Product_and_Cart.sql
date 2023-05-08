drop database `petworld-v1`;
create database `petworld-v1`;

use `petworld-v1`;

create table product(
	`id`			bigint primary key auto_increment,
	`name`			varchar(100) not null,
	`description` 	longtext not null,
	`image` 		varchar(255) not null,
	`price` 		double(16,2) not null,
	`product_code` 	varchar(20) not null unique,
	`protein` 		varchar(200) not null,
	`fats` 			varchar(200) not null,
	`carbohydrates` varchar(200) not null,
	`minerals` 		varchar(200) not null,
	`vitamins` 		varchar(200) not null,
	`animal` 		varchar(200) not null,
	`status` 		bit not null check(`status` = 0 or `status` = 1),
    `category_id` 	bigint
);

create table category(
	`id`			bigint primary key auto_increment,
    `name`			varchar(40) not null unique
);

create table cart(
	`id`			bigint primary key auto_increment,
    `amount_item`	int default 0,
    `total_payment`	double(16,4) default 0.0000,
    `cart_date`	date default(CURRENT_DATE),
 --    `current_date`	date default(CURRENT_DATE),
	`customer_id`	int not null unique
);

create table cart_detail(
	`id`			bigint primary key auto_increment,
    `cart_id`		bigint not null,
    `product_id`	bigint not null,
    `total_price`	double(16,4) default 0.0000,
    `amount`		int not null,
    `status`		bit check(`status` = 0 or `status` = 1)
);

create table customer(
	`id`				int not null auto_increment,
	`full_name`			varchar(255) not null,
	`username`			varchar(255) not null,
	`password`			varchar(255) not null,
	`email`				varchar(255),
	`address`			varchar(255),
	`phone`				varchar(10),
	`avatar`			varchar(255),
	`is_status`			varchar(255),
	`remember_token`	varchar(255),
	`role_id`			int not null,
	PRIMARY KEY (id)
);
create table `role`(
	`id`		int not null auto_increment,
	`name`		varchar(255) not null,
	`desc`		varchar(255) not null,
	PRIMARY KEY (id)
);

create table `customer_role`(
	`customer_id`	int not null,
	`role_id`		int not null
);

-- Khóa ngoại 
ALTER TABLE product
ADD CONSTRAINT fk_product_category
	FOREIGN KEY (`category_id`)
	REFERENCES category(`id`);
  
/*Cart - CartDetail*/
ALTER TABLE cart_detail
ADD CONSTRAINT fk_cart_detail_product
	FOREIGN KEY (`product_id`)
	REFERENCES product(`id`);
  
ALTER TABLE cart_detail
ADD CONSTRAINT fk_cart_detail_cart
	FOREIGN KEY (`cart_id`)
	REFERENCES cart(`id`);

ALTER TABLE cart
ADD CONSTRAINT fk_customers_cart
	FOREIGN KEY (`customer_id`)
	REFERENCES customer(`id`);
  
/*Customer - Role*/
ALTER TABLE customer_role 
ADD CONSTRAINT fk_customer_role_customer 
	FOREIGN KEY(customer_id) 
	REFERENCES customer(id);
    
ALTER TABLE customer_role 
ADD CONSTRAINT fk_customer_role_role 
	FOREIGN KEY(role_id) 
	REFERENCES role(id);
  
------------------------------------
/*Customer - Role*/
INSERT INTO role(`name`,`Desc`) 
VALUES
	('ROLE_ADMIN','Quản trị viên'),
	('ROLE_CUSTOMER','Khách hàng');
   
INSERT INTO customer (`full_name`,`username`,`password`,`email`,`is_status`, `role_id`)
VALUES
	('Lượng','kakashi','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','luong@codegym.com',1,1),
	('Hiếu','hieuthuhai','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','hieu@codegym.com',1,2),
	('Phong','phongxoan','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','xoan@codegym.com',1,3);
 
INSERT INTO customer_role
VALUES
	(1,1),
	(2,2),
    (3,1);
 
/*Product - Cart*/
INSERT INTO category(`name`)
VALUES
	('Food Toppers'),
	('Milk Replacers'),
	('Canned Food'),
	('Veterinary Authorized Diets'),
	('Bones & Rawhide');


INSERT INTO product (name, description, image, price, product_code, protein, fats, carbohydrates, minerals, vitamins, animal, status, category_id)
VALUES
('Sữa tươi Vinamilk', 'Sản phẩm sữa tươi đến từ thương hiệu Vinamilk nổi tiếng tại Việt Nam', 'vinamilk.jpg', 25000, 'VINMILK01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Sữa bò', 1, 1),
('Bánh mì trứng', 'Bánh mì ăn sáng được làm từ bột mì, trứng và gia vị tạo nên hương vị thơm ngon đặc trưng', 'banhmi.jpg', 15000, 'BMTR01', '5g', '2g', '25g', '50mg', 'vitamin B1, B2, B3, B6', 'Trứng gà', 1, 2),
('Chuối hột', 'Chuối hột là loại trái cây giàu dinh dưỡng và cung cấp nhiều chất xơ cho cơ thể', 'chuoi.jpg', 5000, 'CHUOI01', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3),
('Thịt heo quay', 'Món ăn truyền thống Việt Nam được làm từ thịt heo, gia vị và nước tương, được nướng đến khi thơm ngon và giòn tan', 'thitheoquay.jpg', 75000, 'THQ01', '20g', '15g', '5g', '50mg', 'vitamin B3, B6', 'Heo', 1, 4),
('Cà phê sữa đá', 'Đồ uống phổ biến tại Việt Nam, được làm từ cà phê rang xay và sữa đặc, thêm đá để giảm nhiệt độ', 'cafesuada.jpg', 25000, 'CAFESUADA01', '1g', '2g', '20g', '50mg', '', '', 1, 2),
('Sườn heo chiên giòn', 'Món ăn chính được làm từ sườn heo, được chiên giòn và thêm gia vị tạo nên hương vị thơm ngon đặc trưng', 'suonheochiengion.jpg', 65000, 'SHCG01', '15g', '10g', '5g', '50mg', 'vitamin B3', 'Heo', 1, 4);


INSERT INTO cart(`customer_id`)
VALUES
	(1),(2),(3);
    
INSERT INTO cart_detail(`cart_id`,`product_id`,`amount`, `status`,`total_price`)
VALUES
	(1, 1, 3, 0, 75000.00),
	(1, 2, 1, 0, 15000.00),
	(1, 3, 3, 0, 15000.00),
    (2, 1, 3, 0, 75000.00),
	(2, 2, 1, 0, 15000.00),
	(3, 3, 3, 0, 15000.00);

--------------------------- 
/*Query*/
Select * from cart_detail where cart_detail.cart_id = 2;

-- get cart list
Select *
from cart
join cart_detail on cart.id = cart_detail.cart_id
join product on cart_detail.product_id = product.id
where cart.id = 1;

-- total payment
Select cart.id, product.`name`, product.price, cart_detail.amount, (product.price * cart_detail.amount) as total_price
from cart
join cart_detail on cart.id = cart_detail.cart_id
join product on cart_detail.product_id = product.id
where cart.id = 1;

-- Customer
Select *
from customer
join cart on customer.id = cart.customer_id 
join cart_detail on cart.id = cart_detail.cart_id
join product on cart_detail.product_id = product.id
where customer.id = 1 and cart.id = 1;

SELECT * FROM `petworld-v1`.customer;
