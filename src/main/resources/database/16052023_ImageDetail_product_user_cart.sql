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
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294029/ImageProduct/images_bobdmm.jpg', 55000, 'PATE011', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Beef pate for dogs', 'One care beef', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294099/ImageProduct/pate-cho-cho-vi-thit-bo-iris-one-care-beef100g-768x768_oyugrc.jpg', 35000, 'PATE01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 1, 2,0),
	('Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294138/ImageProduct/petag-kmr-sua-bot-thay-the-danh-cho-meo-so-sinh-340g-1673494505588_i3fw2z.png', 5000, 'MILK01', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,10),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294172/ImageProduct/images_uywgb8.jpg', 25000, 'SEED03', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
    ('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294210/ImageProduct/images_xtqzc7.jpg', 55000, 'PATE012', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294302/ImageProduct/thuc-an-hat-kitcat-cho-meo-chicken-cuisine-goi-1-2kg_d2f3if.jpg', 25000, 'KITKAT01', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294365/ImageProduct/thuc-an-dong-hop-kitcat-complete-cho-meo-12-vi_abs0d9.png', 55000, 'PATE02', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Cabbage', 'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294385/ImageProduct/images_tspmxf.jpg', 85000, 'RAU01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 3, 4,10),
	('Pate for dogs', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294406/ImageProduct/images_oobkzx.jpg', 55000, 'PATE010', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
    ('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294424/ImageProduct/images_cyt8h1.jpg', 25000, 'GRASS01', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass03', 1, 4, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294440/ImageProduct/images_ztdab6.jpg', 55000, 'PATE09', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Hay for rabbits', 'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294460/ImageProduct/images_xueyl3.jpg', 65000, 'HAY01', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 5, 4,30),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294479/ImageProduct/images_kjdgyr.jpg', 5000, 'MILK02', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Coriander', 'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294517/ImageProduct/images_riiz4b.jpg', 45000, 'Coriander01', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 1, 4,10),
	('Sugar beet', 'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294554/ImageProduct/images_xnimba.jpg', 35000, 'SUGERBEET01', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 2, 4,0),
    ('Pate for cat', 'One care beef', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294575/ImageProduct/images_yl3cjn.jpg', 35000, 'PATE04', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 3, 2,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294590/ImageProduct/images_jnhdo7.jpg', 5000, 'MILK03', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 5, 1,10),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294610/ImageProduct/images_oeuipd.jpg', 25000, 'GRASS04', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294656/ImageProduct/images_t9ym3y.jpg', 55000, 'PATE08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294671/ImageProduct/images_jgzwpp.jpg', 25000, 'GRASS05', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294690/ImageProduct/images_cbbvdr.jpg', 25000, 'KITKAT04', '1g', '2g', '20g', '50mg', '', '', 1, 2, 3,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294706/ImageProduct/images_zqgnzb.jpg', 55000, 'PATE07', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294745/ImageProduct/sua-bot-cho-bbn-goats-milk-new-zealand-768x768_pmhuj8.jpg', 5000, 'MILK04', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
    ('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294766/ImageProduct/images_ggsaix.jpg', 55000, 'PATE03', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 4, 2,10),
	('Cabbage', 'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294782/ImageProduct/images_eck81j.jpg', 85000, 'RAU08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 5, 4,0),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294799/ImageProduct/images_sbzs3y.jpg', 25000, 'SEED02', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0),
	('Dog and Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294816/ImageProduct/images_iieaza.jpg', 5000, 'MILK05', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,20),
    ('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294834/ImageProduct/images_zvh6ys.jpg', 25000, 'GRASS03', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294846/ImageProduct/images_urtozj.jpg', 25000, 'GRASS02', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Hay for rabbits', 'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294860/ImageProduct/images_ar9wsb.jpg', 65000, 'HAY04', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 2, 4,0),
	('Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294878/ImageProduct/images_tmejza.jpg', 5000, 'MILK06', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294906/ImageProduct/images_dymlym.jpg', 55000, 'PATE06', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Coriander', 'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294922/ImageProduct/images_jbnrvg.jpg', 45000, 'Coriander06', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 3, 4,10),
	('Sugar beet', 'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294937/ImageProduct/images_qo66mv.jpg', 35000, 'SUGERBEET10', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 4, 4,0),
	('Dog milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294970/ImageProduct/images_bbahje.jpg', 5000, 'MILK07', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 4, 1,0),
    ('Cat milk powder', 'BBN Goat’s Milk New Zealand', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684294986/ImageProduct/images_npmt9q.jpg', 5000, 'MILK08', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 1, 1,0),
	('Pate for cats', 'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295006/ImageProduct/images_p6t6fq.jpg', 55000, 'PATE015', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2,20),
	('Grass seed for squirrel', 'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295022/ImageProduct/images_rpwcc0.jpg', 25000, 'GRASS06', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3,0),
	('Cat food', 'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295047/ImageProduct/images_pi06sh.jpg', 25000, 'SEED04', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3,0);
	

INSERT INTO `image_detail`(`url`, `product_id`)
VALUES  ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',1),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',1),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',1),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',1),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',1),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',2), 
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',2),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',2),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',2),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',2),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',3),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',3),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',3),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',3),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',3),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',4),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',4),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',4),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',4),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',4),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',5),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',5),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',5),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',5),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',5),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',6),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',6),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',6),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',6),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',6),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',7),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',7),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',7),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',7),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',7),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',8),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',8),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',8),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',8),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',8),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',9),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',9),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',9),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',9),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',9),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',10),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',10),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',10),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',10),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',10),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',11),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',11),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',11),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',11),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',11),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',12),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',12),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',12),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',12),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',12),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',13),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',13),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',13),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',13),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',13),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',14),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',14),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',14),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',14),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',14),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',15),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',15),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',15),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',15),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',15),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',16),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',16),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',16),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',16),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',16),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',17),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',17),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',17),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',17),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',17),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',18),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',18),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',18),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',18),
		('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',18),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',19),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',19),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',19),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',19),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',19),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',20),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',20),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',20),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',20),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',20),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',21),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',21),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',21),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',21),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',21),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',22),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',22),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',22),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',22),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',22),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',23),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',23),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',23),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',23),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',23),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',24),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',24),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',24),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',24),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',24),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',25),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',25),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',25),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',25),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',25),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',26),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',26),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',26),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',26),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',26),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',27),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',27),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',27),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',27),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',27),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',28),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',28),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',28),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',28),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',28),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',29),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',29),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',29),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',29),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',29),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',30),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',30),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',30),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',30),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',30),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',31),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',31),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',31),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',31),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',31),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',32),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',32),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',32),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',32),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',32),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',33),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',33),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',33),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',33),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',33),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',34),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',34),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',34),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',34),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg',34),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',35),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',35),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',35),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',35),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',35),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',36),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',36),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',36),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',36),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg',36),
	    ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',37),
	    ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',37),
	    ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',37),
	    ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',37),
	    ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg',37),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',38),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',38),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',38),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',38),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',38),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',39),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',39),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',39),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',39),
	    ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg',39);



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
