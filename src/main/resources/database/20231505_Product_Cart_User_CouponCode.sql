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
    `sale`          int default 0 check(`sale` >= 0 and `sale` <= 100),
	`status` 		bit not null check(`status` = 0 or `status` = 1),
    `mark_id`		bigint not null,
    `category_id` 	bigint
);
create table category(
	`id`			bigint primary key auto_increment,
    `name`			varchar(40) not null unique
);
create table mark(
	`id`			bigint primary key auto_increment,
    `tag`			varchar(10) unique,
    `tag_badge`		varchar(10)
);
create table cart(
	`id`			bigint primary key auto_increment,
    `amount_item`	int default 0,
    `total_payment`	double(16,4) default 0.0000,
    `cart_date`		date default(CURRENT_DATE),
	`user_id`		bigint not null unique
);
create table cart_detail(
	`id`			bigint primary key auto_increment,
    `cart_id`		bigint not null,
    `product_id`	bigint not null,
    `total_price`	double(16,4) default 0.0000,
    `amount`		int not null,
    `status`		bit check(`status` = 0 or `status` = 1)
);
create table `user`(
	`id`				bigint not null auto_increment,
	`full_name`			varchar(255) not null,
	`username`			varchar(255) not null,
	`password`			varchar(255) not null,
	`email`				varchar(255),
	`address`			varchar(255),
	`phone`				varchar(10),
	`avatar`			varchar(255),
	`is_status`			varchar(255),
	`remember_token`	varchar(255),
	`role_id`			bigint not null,
	PRIMARY KEY (id)
);
create table `role`(
	`id`		bigint not null auto_increment,
	`name`		varchar(255) not null,
	`desc`		varchar(255) not null,
	PRIMARY KEY (id)
);
create table `user_role`(
	 `id`		bigint primary key auto_increment,
	 `user_id`	bigint not null,
	 `role_id`	bigint not null
);

CREATE TABLE `coupon_code` (
    `id`					bigint primary key auto_increment,
    `code`					VARCHAR(20) not null unique,
    `discount`				int NOT NULL check(`discount` > 0 and `discount` <= 100),
    `begin_date`			date not null,
    `expiration_date`		date not null,
    `total_pay_condition`	double(16,4) not null
);


-- Khóa ngoại
ALTER TABLE product
ADD CONSTRAINT fk_product_category
	FOREIGN KEY (`category_id`)
	REFERENCES category(`id`);
ALTER TABLE product
ADD CONSTRAINT fk_product_mark
	FOREIGN KEY (`mark_id`)
	REFERENCES mark(`id`);
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
ADD CONSTRAINT fk_user_cart
	FOREIGN KEY (`user_id`)
	REFERENCES `user`(`id`);
/*Customer - Role*/
ALTER TABLE `user_role`
ADD CONSTRAINT fk_user_role_user
    FOREIGN KEY(`user_id`)
    REFERENCES `user`(`id`);
ALTER TABLE `user_role`
ADD CONSTRAINT fk_user_role_role
	FOREIGN KEY(`role_id`)
    REFERENCES role(`id`);
------------------------------------
/*Customer - Role*/
INSERT INTO `role`(`name`,`Desc`)
VALUES
	('ROLE_ADMIN','Quản trị viên'),
	('ROLE_CUSTOMER','Khách hàng');
INSERT INTO `user`(`full_name`,`username`,`password`,`email`,`is_status`, `role_id`)
VALUES
	('Lượng','kakashi','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','luong@codegym.com',1,1),
	('Hiếu','hieuthuhai','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','hieu@codegym.com',1,2),
	('Phong','phongxoan','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','xoan@codegym.com',1,3);
INSERT INTO `user_role`(`user_id`, `role_id`)
VALUES
	(1,1),
	(1,2),
	(2,2),
    (3,2);
/*Product - Cart*/
INSERT INTO category(`name`)
VALUES
	('Milk'),
	('Pate'),
	('Seed'),
	('Vegetable');
INSERT INTO mark(`tag`,`tag_badge`)
VALUES
	('',''),
	('offer',''),
	('hot',''),
	('Hot Sale','sale'),
	('Sold Out','sold-out');

INSERT INTO product (`name`, `description`, image, price, product_code, protein, fats, carbohydrates, minerals, vitamins, animal, `status`, mark_id, category_id,sale)
VALUES
	('Beef pate for dogs', 'One care beef', 'https://www.petmart.vn/wp-content/uploads/2019/04/pate-cho-cho-vi-thit-bo-iris-one-care-beef100g-768x768.jpg', 35000, 'PATE01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 1, 2,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK01', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,10),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-hat-kitcat-cho-meo-chicken-cuisine-goi-1-2kg.jpg?v=1669097725000', 25000, 'KITKAT01', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-dong-hop-kitcat-complete-cho-meo-12-vi.png?v=1669015221000', 55000, 'PATE02', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Cabbage', 'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000, 'RAU01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 3, 4,10),
	('Grass seed', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRf2R4hT8A0AL7OYH_ydiB4vvDmnxUhN9D7g&usqp=CAU', 25000, 'GRASS01', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass03', 1, 4, 3,0),
	('Hay for rabbits', 'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000, 'HAY01', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 5, 4,30),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK02', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Coriander', 'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000, 'Coriander01', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 1, 4,10),
	('Sugar beet', 'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU', 35000, 'SUGERBEET01', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 2, 4,0),
    ('Beef pate for dogs', 'One care beef', 'https://www.petmart.vn/wp-content/uploads/2019/04/pate-cho-cho-vi-thit-bo-iris-one-care-beef100g-768x768.jpg', 35000, 'PATE04', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 3, 2,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK03', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 5, 1,10),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-hat-kitcat-cho-meo-chicken-cuisine-goi-1-2kg.jpg?v=1669097725000', 25000, 'KITKAT04', '1g', '2g', '20g', '50mg', '', '', 1, 2, 3,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK04', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-dong-hop-kitcat-complete-cho-meo-12-vi.png?v=1669015221000', 55000, 'PATE03', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 4, 2,10),
	('Cabbage', 'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000, 'RAU08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 5, 4,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK05', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,20),
    ('Grass seed', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRf2R4hT8A0AL7OYH_ydiB4vvDmnxUhN9D7g&usqp=CAU', 25000, 'GRASS02', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Hay for rabbits', 'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000, 'HAY04', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 2, 4,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK06', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Coriander', 'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000, 'Coriander06', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 3, 4,10),
	('Sugar beet', 'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU', 35000, 'SUGERBEET10', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 4, 4,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK07', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 4, 1,0),
    ('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK08', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 1, 1,0);
INSERT INTO cart(`user_id`)
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
    
INSERT INTO `coupon_code` (`code`, `discount`, `begin_date`, `expiration_date`, `total_pay_condition`)
VALUES
    ('SUMMER2023', 20, '2023-05-12', '2023-05-14', 100000.0000),
    ('FALLSALE', 15, '2023-05-15', '2023-05-16', 150000.0000),
    ('WINTER2024', 25, '2023-12-01', '2024-02-29', 200000.0000),
    ('CODE1', 10, '2023-05-16', '2023-05-18', 50000.0000),
    ('CODE2', 30, '2023-06-01', '2023-06-30', 100000.0000),
    ('CODE3', 20, '2023-07-01', '2023-07-31', 150000.0000),
    ('CODE4', 15, '2023-05-16', '2023-08-31', 100000.0000),
    ('CODE5', 25, '2023-09-01', '2023-09-30', 200000.0000),
    ('CODE6', 30, '2023-10-01', '2023-10-31', 300000.0000),
    ('CODE7', 20, '2023-11-01', '2023-11-30', 150000.0000);


    
select *
from product p
	inner join category c on p.category_id = c.id
where c.id in (2, 3, 4, 5);
select p.*
from product p
	inner join category c on p.category_id = c.id
-- where c.id = 1 or c.id = 2 or c.id = 3 or c.id = 4;
where c.id in (1,2,3);

select * from cart;

select cd.*
from product p
join cart_detail cd on p.id = cd.`product_id`
join cart c on cd.cart_id = c.id
join `user` u on c.user_id = u.id
where u.email = 'hieu@codegym.com';
