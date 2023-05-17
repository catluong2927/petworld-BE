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

create table image_detail(
	`id`           bigint primary key auto_increment,
    `url` 		   varchar(255) not null,
    `product_id`   bigint
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

-- Khóa ngoại 
ALTER TABLE product
ADD CONSTRAINT fk_product_category
	FOREIGN KEY (`category_id`)
	REFERENCES category(`id`);
    
ALTER TABLE product
ADD CONSTRAINT fk_product_mark
	FOREIGN KEY (`mark_id`)
	REFERENCES mark(`id`);
 
ALTER TABLE image_detail
ADD CONSTRAINT fk_image_detail_product
	FOREIGN KEY (`product_id`)
    REFERENCES product(`id`);
  
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
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3pyl7Oei9BjUXDBHNpbAwcV2gAdvG2_a8bSh2Gd6473AK_rPL0yloJx8jbxRWKuTck9I&usqp=CAU', 55000, 'PATE011', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Beef pate for dogs', 'One care beef', 'https://www.petmart.vn/wp-content/uploads/2019/04/pate-cho-cho-vi-thit-bo-iris-one-care-beef100g-768x768.jpg', 35000, 'PATE01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 1, 2,0),
	('Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://bizweb.dktcdn.net/100/458/454/products/petag-kmr-sua-bot-thay-the-danh-cho-meo-so-sinh-340g-1673494505588.png?v=1673494516117', 5000, 'MILK01', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,10),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi1O11-lKyc1Bu5JUBsps0Ck0DJrptR9RMXw&usqp=CAU', 25000, 'SEED03', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
    ('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgGLI32CNvJQz4NdV6Xl6808OoVtVezzOcJKg5mFmL7Ix1VMnTgT0yxtvH3NwlourMZ_M&usqp=CAU', 55000, 'PATE012', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-hat-kitcat-cho-meo-chicken-cuisine-goi-1-2kg.jpg?v=1669097725000', 25000, 'KITKAT01', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-dong-hop-kitcat-complete-cho-meo-12-vi.png?v=1669015221000', 55000, 'PATE02', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Cabbage', 'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000, 'RAU01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 3, 4,10),
	('Pate for dogs', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Z3oqhYUuRGrGPekuWwgjyFe1fOKT3W7qRA&usqp=CAU', 55000, 'PATE010', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
    ('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRf2R4hT8A0AL7OYH_ydiB4vvDmnxUhN9D7g&usqp=CAU', 25000, 'GRASS01', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass03', 1, 4, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnSm4NZ-mhf8M4t2bqUYMC89lxBEz21bYEqQ&usqp=CAU', 55000, 'PATE09', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Hay for rabbits', 'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000, 'HAY01', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 5, 4,30),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToGsTVVGmvh715WPWGaG5Nh9Qj4MqZvAO_ow&usqp=CAU', 5000, 'MILK02', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Coriander', 'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000, 'Coriander01', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 1, 4,10),
	('Sugar beet', 'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU', 35000, 'SUGERBEET01', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 2, 4,0),
    ('Pate for cat', 'One care beef', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSotOxcypXkSkcb3TOTVC5sNZi2l3Vd3rbydg&usqp=CAU', 35000, 'PATE04', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 3, 2,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWarBrQ3-FK3ayX3QkOHARbsF1zP2tERSSag&usqp=CAU', 5000, 'MILK03', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 5, 1,10),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7PREwOPsySq4hSWOibEQCNUKN_tQfWVifdA&usqp=CAU', 25000, 'GRASS04', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCegJXpRx0B3CYATMVJNdRvm_aIcFT4R2vxQ&usqp=CAU', 55000, 'PATE08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6zVhvgeRe-oOxdf4fNj_odclRSdhajOQNg&usqp=CAU', 25000, 'GRASS05', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwvsbJrHp9daEJhSBt_TSjuoMjjHikJ-PRVw&usqp=CAU', 25000, 'KITKAT04', '1g', '2g', '20g', '50mg', '', '', 1, 2, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQwHkksi0p04qJXMX1nCFPjifYUSo03wspqg&usqp=CAU', 55000, 'PATE07', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000, 'MILK04', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8KHG1MmyokfGq0nGzp01aXClQs5AXDUKUVg&usqp=CAU', 55000, 'PATE03', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 4, 2,10),
	('Cabbage', 'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000, 'RAU08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 5, 4,0),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST0iPUMOSmEEOGByl7TO0pYO4m9L2uS3-skQ&usqp=CAU', 25000, 'SEED02', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
	('Dog and Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW6Pk20H9wK_qDYr7sqxkvWNacLfeUXCPRuw&usqp=CAU', 5000, 'MILK05', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,20),
    ('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSZWTPPnsP4BLbQ-afBI1C_NGKyCVdcQ2G8w&usqp=CAU', 25000, 'GRASS03', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6zVhvgeRe-oOxdf4fNj_odclRSdhajOQNg&usqp=CAU', 25000, 'GRASS02', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Hay for rabbits', 'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000, 'HAY04', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 2, 4,0),
	('Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuht6t7E2HWryG0jPfbnVjhQ8gyJ6Wl5JRVw&usqp=CAU', 5000, 'MILK06', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSKjcSHu4te5W0E5mRU5RzAh5gwPzxu7wzEQ&usqp=CAU', 55000, 'PATE06', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Coriander', 'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000, 'Coriander06', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 3, 4,10),
	('Sugar beet', 'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU', 35000, 'SUGERBEET10', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 4, 4,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxzeTy1-U5R5G6qFBpdOtNpagd3cdgxyp8-8OGsenXQXc7VLQpKWSb0deTQnPQvIYdUY&usqp=CAU', 5000, 'MILK07', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 4, 1,0),
    ('Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrsEVF8cN8_ZmkjIabtALUULFDAux2CUSMWg&usqp=CAU', 5000, 'MILK08', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 1, 1,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY5vgcgrMM1LOHuCrtS6k7CH-ploNgAsBct7K4kKL9kZhKjJHhAjve-DuBCccRPdc1htY&usqp=CAU ', 55000, 'PATE015', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs_PPUIjnt6HPYgHZ2uB26unbqO1FJbDHZZQ&usqp=CAU', 25000, 'GRASS06', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzeDA7w_rOUT6LmGJjQSKdXmxCDqH5jbMvTg&usqp=CAU', 25000, 'SEED04', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0);
	

INSERT INTO `image_detail`(`url`, `product_id`)
VALUES  ('hhttps://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',1),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',1 ),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',1),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',1),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',1),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',2), 
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',2),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',2),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',2),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',2),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',3),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',3),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',3),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',3),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',3),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',4),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',4),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',4),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',4),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',4),
		('hhttps://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',5),
		('hhttps://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',5),
		('hhttps://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',5),
		('hhttps://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',5),
		('hhttps://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',5),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',6),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',6),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',6),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',6),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',6),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',7),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',7),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',7),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',7),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',7),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',8),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',8),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',8),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',8),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',8),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',9),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',9),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',9),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',9),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',9),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',10),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',10),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',10),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',10),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',10),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',11),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',11),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',11),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',11),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',11),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',12),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',12),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',12),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',12),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',12),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',13),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',13),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',13),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',13),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',13),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',14),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',14),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',14),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',14),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',14),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',15),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',15),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',15),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',15),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',15),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',16),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',16),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',16),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',16),
		('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',16),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',17),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',17),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',17),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',17),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',17),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',18),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',18),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',18),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',18),
		('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',18),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',19),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',19),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',19),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',19),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',19),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',20),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',20),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',20),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',20),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',20),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',21),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',21),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',21),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',21),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',21),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',22),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',22),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',22),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',22),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',22),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',23),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',23),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',23),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',23),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',23),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',24),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',24),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',24),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',24),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',24),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',25),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',25),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',25),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',25),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',25),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',26),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',26),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',26),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',26),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',26),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',27),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',27),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',27),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',27),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',27),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',28),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',28),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',28),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',28),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',28),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',29),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',29),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',29),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',29),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',29),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',30),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',30),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',30),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',30),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',30),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',31),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',31),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',31),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',31),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',31),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',32),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',32),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',32),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',32),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',32),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',33),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',33),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',33),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',33),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',33),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',34),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',34),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',34),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',34),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8Gle_xDKBYCeFR01lgPgcEOl2DGV3M0Hm3A&usqp=CAU',34),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',35),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',35),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',35),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',35),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',35),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',36),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',36),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',36),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',36),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkVR4aC8uZeqKBYttGlUJYPCkx-AYaiDD0rw&usqp=CAU',36),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',37),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',37),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',37),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',37),
	    ('https://beptruong.edu.vn/wp-content/uploads/2020/06/pate-gan-ga.jpg',37),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',38),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',38),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',38),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',38),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',38),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',39),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',39),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',39),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',39),
	    ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbvr25lkbDerWxW_Ujjip4dmlxbNe8ww--WQ&usqp=CAU',39);



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





-- ----test : 
select * from category;
select * from image_detail;
-- use `petworld-v1`;
 select * from product; 
-- select * from Product  where `status` = 1;

-- select * 
-- from product p
-- 	inner join category c on p.category_id = c.id
-- where c.id in (2, 3, 4, 5);

-- select p.* 
-- from product p
-- 	inner join category c on p.category_id = c.id
-- -- where c.id = 1 or c.id = 2 or c.id = 3 or c.id = 4;
-- where c.id in (1,2,3);
