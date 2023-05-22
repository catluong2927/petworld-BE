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
                            `type`  		bit not null check(`type` = 0 or `type` = 1),
                            `cart_id`		bigint not null,
                            `type_id`		bigint not null,
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

INSERT INTO cart_detail(`type`, `cart_id`,`type_id`,`amount`, `status`,`total_price`)
VALUES
    (1, 1, 2, 3, 0, 75000.00),
    (0, 1, 2, 1, 0, 15000.00);

-- Phong Minh Section -------------------------
create table `centers` (
                           id int primary key auto_increment,
                           name varchar(30) not null,
                           phone varchar(10) not null,
                           email varchar(100) not null,
                           address varchar(200) not null,
                           active bit default(1)
);

create table `packages`(
                           id int primary key auto_increment,
                           name  varchar(20) not null,
                           description varchar(250) not null,
                           image varchar(255) not null,
                           min_price float not null,
                           max_price float not null,
                           status varchar(50),
                           active bit default(1),
                           center_id int not null);

create table `services`(
                           id int primary key auto_increment,
                           name varchar(200) not null,
                           price float not null,
                           description varchar(250) not null,
                           active bit default(1),
                           package_id int not null);

create table `service_images` (
                                  id int primary key auto_increment,
                                  url varchar(255) not null,
                                  service_id int not null
);

create table `package_reviews` (
                                   id int primary key auto_increment,
                                   review varchar(255) not null,
                                   star int,
                                   date datetime,
                                   active bit default(1),
                                   package_id int not null,
                                   user_id bigint not null
);

create table `sellers` (
                           id int primary key auto_increment,
                           name varchar(30) not null,
                           phone varchar(10) not null,
                           email varchar(100) not null,
                           address varchar(200) not null,
                           active bit default(1),
                           center_id int not null
);

alter table `packages` add constraint `FK_center_package` foreign key(center_id) references centers(`id`);

alter table `services` add constraint `FK_service_package` foreign key(package_id) references packages(`id`);

alter table	`service_images` add constraint `FK_service_service_image` foreign key(service_id) references services(`id`);

alter table `sellers` add constraint `FK_seller_center` foreign key (center_id) references centers(`id`);

alter table `package_reviews` add constraint `FK_package_review_package` foreign key(package_id) references packages(`id`);
alter table `package_reviews` add constraint `FK_package_review_user` foreign key(user_id) references user(`id`);


INSERT INTO centers (name, phone, email, address) VALUES
                                                      ('Pet Care Center', '1234567890', 'petcarecente@gmail.com.com', '123 Main St'),
                                                      ('Animal Hospital', '9876543210', 'animalhospital@gmail.com', '456 Elm St'),
                                                      ('Paws and Claws Clinic', '5551234567', 'appointments@gmail.com', '789 Oak Ave'),
                                                      ('Pet Lovers Vet', '9998887777', 'competloversvet@gmail.com', '321 Pine Rd'),
                                                      ('Happy Pets Clinic', '5551112222', 'happypetsclinic@gmail.com', '789 Maple Ave'),
                                                      ('Cat Lovers Veterinary', '4445556666', 'appointments@gmail.com', '456 Oak St'),
                                                      ('Doggy Daycare Center', '7778889999', 'doggydaycarecenter@gmail.com', '123 Pine Rd'),
                                                      ('Exotic Animal Hospital', '2223334444', 'comexoticanimalhospital@gmail.com', '789 Elm St'),
                                                      ('Birds and Beyond Clinic', '8889990000', 'beyondclinic@gmail.com', '456 Maple Ave'),
                                                      ('Rabbit and Rodent Clinic', '8889990000', 'infocomrabbitandrodentclinic12@gmail.com', '456 Maple Ave');


INSERT INTO packages (name, description, image, min_price, max_price, status, center_id) VALUES
                                                                                             ('DayCare', 'A routine health check-up for your pet', 'https://www.pawcommons.com/wp-content/uploads/2022/02/scottsdale-daycare-image-1-a.jpg', 50.0, 100.0, 'Active', 1),
                                                                                             ("'Pet's Sapa'", 'Essential vaccinations for your pet', 'https://image.petmd.com/files/styles/863x625/public/dog-massage-therapy-picture-id909810936.jpg', 80.0, 150.0, 'Active', 2),
                                                                                             ('DayCare', 'Pamper your pet with a grooming session', 'grooming_spa.jpg', 60.0, 120.0, 'Active', 3),
                                                                                             ('Training Program', 'Professional training for your pet', 'training_program.jpg', 100.0, 200.0, 'Active', 10),
                                                                                             ("'Pet's Sapa'", 'Safe and comfortable boarding for your pet', 'https://pawstucson.com/wp-content/uploads/2020/02/caninemassagefeat-1080x675.jpg', 40.0, 80.0, 'Active', 4),
                                                                                             ('DayCare', 'Professional dental cleaning for your pet', 'https://happyhound.com/wp-content/uploads/2014/02/oakland-and-east-bay-dog-daycare-1024x683.jpg', 80.0, 150.0, 'Active', 5),
                                                                                             ('Walking Service', 'Expert consultation for pet behavior issues', 'behavioral_consultation.jpg', 120.0, 200.0, 'Active', 1),
                                                                                             ('DayCare', 'Training package specifically designed for puppies', 'puppy_training_package.jpg', 150.0, 250.0, 'Active', 2),
                                                                                             ("'Pet's Sapa'", 'Specialized wellness package for senior pets', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCcB5IC3OaKB4KiG0tqnsEpQzHkiSEXkSkkg&usqp=CAU', 90.0, 160.0, 'Active', 3),
                                                                                             ('DayCare', 'Consultation to ensure proper nutrition for your pet', 'https://img1.wsimg.com/isteam/ip/c74c0bf8-4a50-4e28-9cb4-28c10c5a27e9/_e_34i8ah_j_g8iUd018svc1lz14zggqfbxr_rwq903.jpg/:/rs=h:1000,cg:true,m', 70.0, 120.0, 'Active', 5),
                                                                                             ("'Pet's Sapa'", 'Microchipping service for identification and tracking', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDsUK22AmwhD1TUuLGYSO55S64Y6cW9NCfVg&usqp=CAU', 50.0, 100.0, 'Active', 4),
                                                                                             ('DayCare', 'Preventive treatment for fleas and ticks', 'flea_tick_prevention.jpg', 30.0, 70.0, 'Active', 1),
                                                                                             ('Walking Service', 'Relaxing massage therapy for your pet', 'pet_massage_therapy.jpg', 60.0, 100.0, 'Active', 6),
                                                                                             ('DayCare', 'Testing to identify pet allergies', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTftsISFVfSTtTfDlSO2FExqVyEyVe_I_WxTg&usqp=CAU', 100.0, 200.0, 'Active', 7),
                                                                                             ("'Pet's Sapa'", 'Acupuncture treatment for your pet', 'https://cdn.shopify.com/s/files/1/0720/8340/7127/products/Sc066ec96de9d4dca865e63824c7e434aa_600x.jpg?v=1678652124', 80.0, 150.0, 'Active', 3),
                                                                                             ('DayCare', 'Rehabilitation therapy for pets recovering from injuries', 'rehabilitation_services.jpg', 120.0, 200.0, 'Active', 2),
                                                                                             ('Walking Service', 'Boarding services exclusively for cats', 'cat_boarding.jpg', 40.0, 80.0, 'Active', 3),
                                                                                             ('DayCare', 'Package for deworming and parasite control', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnFuSxfSt5KiQcec6BCSQ0AVjOYLd7RePBOg&usqp=CAU', 50.0, 100.0, 'Active', 4),
                                                                                             ("'Pet's Sapa'", 'Grooming services for pet birds', 'bird_grooming.jpg', 60.0, 120.0, 'Active', 5),
                                                                                             ('DayCare', 'Specialized care for exotic pets', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCZ3vEUIKlSLTbfacdnfZDp0K47coR6d8dTg&usqp=CAU', 100.0, 200.0, 'Active', 6),
                                                                                             ('Walking Service', 'Professional dog walking service', 'dog_walking_service.jpg', 30.0, 60.0, 'Active', 7);

INSERT INTO services (name, price, description, package_id) VALUES
                                                                ('Basic Check-up', 50.0, 'Routine health check-up for your pet', 1),
                                                                ('Vaccination', 30.0, 'Essential vaccinations for your pet', 2),
                                                                ('Grooming', 40.0, 'Grooming session for your pet', 3),
                                                                ('Dental Cleaning', 70.0, 'Professional dental cleaning for your pet', 1),
                                                                ('Training Session', 80.0, 'Training session for your pet', 2),
                                                                ('Nutrition Consultation', 60.0, 'Consultation for your pet''s nutrition', 3),
                                                                ('Microchipping', 50.0, 'Microchipping service for identification', 4),
                                                                ('Bathing', 20.0, 'Bathing service for your pet', 5),
                                                                ('Behavioral Training', 100.0, 'Training to address behavioral issues', 6),
                                                                ('Flea and Tick Treatment', 35.0, 'Treatment for fleas and ticks', 16),
                                                                ('Cat Boarding', 40.0, 'Boarding services for cats', 17),
                                                                ('Deworming', 25.0, 'Deworming treatment for your pet', 18),
                                                                ('Bird Grooming', 30.0, 'Grooming services for pet birds', 19),
                                                                ('Exotic Pet Care', 90.0, 'Specialized care for exotic pets', 20),
                                                                ('Dog Walking', 25.0, 'Professional dog walking service', 2),
                                                                ('Dental Surgery', 150.0, 'Surgical procedures for pet dental issues', 4),
                                                                ('Pet Massage', 50.0, 'Relaxing massage therapy for your pet', 3),
                                                                ('Allergy Testing', 120.0, 'Testing to identify pet allergies', 6),
                                                                ('Rehabilitation Therapy', 150.0, 'Therapy for pets recovering from injuries', 1),
                                                                ('Pet Bathing', 25.0, 'Bathing service for your pet', 2),
                                                                ('Eye and Ear Care', 70.0, 'Specialized care for pet eye and ear issues', 3),
                                                                ('Pet Dental Care', 80.0, 'Professional dental care for your pet', 5),
                                                                ('Tick Removal', 15.0, 'Removal of ticks from your pet', 7),
                                                                ('Pet Sitting', 40.0, 'Professional pet sitting service', 1),
                                                                ('Nail Trimming', 15.0, 'Trimming your pet''s nails', 8),
                                                                ('Wound Care', 60.0, 'Care for pet wounds and injuries', 9),
                                                                ('Pet Dental Scaling', 100.0, 'Scaling and cleaning for pet teeth', 9),
                                                                ('Pet CPR Training', 80.0, 'Training on pet CPR techniques', 10),
                                                                ('Pet Photography', 80.0, 'Professional pet photography service', 1),
                                                                ('Dog Training', 120.0, 'Training to teach basic commands and obedience', 2),
                                                                ('Pet Transportation', 50.0, 'Transportation service for your pet', 3),
                                                                ('Pet Nail Trimming', 15.0, 'Professional nail trimming for your pet', 4),
                                                                ('Pet Dental Cleaning', 100.0, 'Deep cleaning for your pet''s teeth', 5),
                                                                ('Pet Behavioral Training', 80.0, 'Training to modify pet behavior', 6),
                                                                ('Pet Eye Care', 70.0, 'Specialized care for pet eye conditions', 7),
                                                                ('Pet Bath and Brush', 35.0, 'Bathing and brushing service for your pet', 8),
                                                                ('Pet Health Check-up', 50.0, 'Comprehensive health check-up for your pet', 9),
                                                                ('Pet Dental Examination', 60.0, 'Thorough examination of your pet''s dental health', 11),
                                                                ('Pet Tick Treatment', 40.0, 'Treatment for ticks infestation on your pet', 14),
                                                                ('Overnight Pet Care', 60.0, 'Care for your pet overnight', 12),
                                                                ('Pet Microchip Installation', 50.0, 'Installation of microchip for pet identification', 5),
                                                                ('Pet First Aid Training', 90.0, 'Training on administering first aid to your pet', 6),
                                                                ('Pet Massage Therapy', 70.0, 'Relaxing massage therapy for your pet', 7),
                                                                ('Pet Allergy Treatment', 120.0, 'Treatment for pet allergies', 8),
                                                                ('Pet Rehabilitation Exercises', 80.0, 'Exercises to aid pet rehabilitation', 9),
                                                                ('Pet Ear Cleaning', 30.0, 'Cleaning your pet''s ears', 10);

INSERT INTO service_images (url,service_id)
VALUES ('https://images.ctfassets.net/f7tuyt85vtoa/aLpA08MU0o95DOwirZoOc/41f82697e0dde05e54d7dd9b095e5f63/PEts-like-humans-article-COVER.jpg',1),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJWzIo7jX8WFN5HmguC-wFNL_dhc2HgHhKK2UzZbuqk-zlZTbEjk0kXEa3XN9tBPmLRZU&usqp=CAU',1),
       ('https://caseyspetsitting4u.com/wp-content/themes/pet3/images/home-2.jpg',2),
       ('hhttps://www.aspca.org/sites/default/files/pet-care_cat-care_thumb.jpg',2),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNmiiD1NPMuwXI-rJeAhS2welwFhFYMTtRvQ&usqp=CAU',3),
       ('https://www.shutterstock.com/image-photo/jack-russell-terrier-dog-holding-260nw-2100518530.jpg',3),
       ('https://loremflickr.com/640/487/food',4),
       ('https://loremflickr.com/640/488/food',4),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxpjRGCH9vZ8pjjjEbz2u-9T2bnX70UXsIsA&usqp=CAU',1),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-mg_o6Xmn9QY1TnkxJTBTt-Ba6rXTtlw9PYeTYoBG6fBjdgozKj7MBUzYEAFQy7Vtjt4&usqp=CAU',2),
       ('https://loremflickr.com/641/480/food',3),
       ('https://loremflickr.com/642/480/food',4),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTRmn3oJ02gYlGzhujR67tlp4K6LlF5VmpCMiBFw-3OTbYNt-HRiF5XI0HmdPaZJH8qP8&usqp=CAU',1),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShdlNbfgywdGXSo1RYao3YaBNbDBNpNUmPCJHz40TUFpWOGPLwCFCKzLnyWHhr8tQbvR0&usqp=CAU',2),
       ('https://loremflickr.com/645/480/food',3),
       ('https://loremflickr.com/646/480/food',4),
       ('https://loremflickr.com/647/480/food',1),
       ('https://loremflickr.com/648/480/food',2);

INSERT INTO package_reviews (review, star, date, package_id,user_id)
VALUES ('Great service package, highly recommended!', 5, '2022-01-01 10:00:00',1,1),
       ('The service package was good, but could be better.', 4, '2022-02-01 11:00:00',2,2),
       ('I really enjoyed the service package, will come back again!', 5, '2022-03-01 12:00:00',1,3),
       ('Service package was okay, nothing special.', 3, '2022-04-01 13:00:00',3,1),
       ('Highly professional service package, exceeded my expectations!', 5, '2022-05-01 14:00:00',3,2),
       ('The service package was a bit pricey, but the quality was good.', 4, '2022-06-01 15:00:00',2,3),
       ('Great value for money, highly recommend this service package!', 5, '2022-07-01 16:00:00',3,1),
       ('Service package was good, but could be better.', 4, '2022-08-01 17:00:00',1,2),
       ('The service package was good, but the quality was inconsistent.', 3, '2023-08-01 05:00:00',2,1);

INSERT INTO `sellers` (name, phone, email, address, center_id, active) VALUES
                                                                           ('Seller A', '1234567890', 'sellerA@gmail.comexample.com', '123 Main St, City A', 1, 1),
                                                                           ('Seller B', '2345678901', 'sellerB@gmail.comexample.com', '456 Broad St, City B', 2, 1),
                                                                           ('Seller C', '3456789012', 'sellerC@gmail.comexample.com', '789 Oak St, City C', 3, 0),
                                                                           ('Seller D', '4567890123', 'sellerD@gmail.comexample.com', '321 Maple St, City D', 1, 1),
                                                                           ('Seller E', '5678901234', 'sellerE@gmail.comexample.com', '654 Pine St, City E', 2, 1),
                                                                           ('Seller F', '6789012345', 'sellerF@example.com', '987 Cedar St, City F', 3, 0);

create table `orders` (
                          id int primary key auto_increment,
                          phone_number varchar(20) not null,
                          note varchar (200),
                          `date` datetime not null ,
                          address varchar(200) not null,
                          `status` varchar(100) not null,
                          user_id bigint not null
);

create table `order_detail` (
                                id int primary key auto_increment,
                                item_name varchar(200) not null,
                                quantity int not null,
                                total double not null,
                                note varchar(200),
                                orders_id int not null
);

alter table `orders` add constraint `FK_order_user` foreign key(user_id) references `user`(`id`);
alter table `order_detail` add constraint `FK_order_detail_order` foreign key(orders_id) references `orders`(`id`);

INSERT INTO `orders` (phone_number, note, `date`, address, `status`, user_id)
VALUES ('1234567890', 'Please deliver ASAP', '2023-05-19 10:00:00', '123 Main St, City, Country', 'Pending', 1);

INSERT INTO `orders` (phone_number, note, `date`, address, `status`, user_id)
VALUES ('9876543210', 'Call before delivery', '2023-05-20 15:30:00', '456 Elm St, City, Country', 'Processing', 2);

INSERT INTO `orders` (phone_number, note, `date`, address, `status`, user_id)
VALUES ('5555555555', 'No onions, please', '2023-05-21 18:00:00', '789 Oak St, City, Country', 'Completed', 3);

INSERT INTO `order_detail` (item_name, quantity, total, note, orders_id)
VALUES ('Item 1', 2, 10.99, 'No special instructions', 1);

INSERT INTO `order_detail` (item_name, quantity, total, note, orders_id)
VALUES ('Item 2', 1, 5.99, 'Extra cheese', 1);

INSERT INTO `order_detail` (item_name, quantity, total, note, orders_id)
VALUES ('Item 3', 3, 20.99, 'Gluten-free option', 2);

INSERT INTO `order_detail` (item_name, quantity, total, note, orders_id)
VALUES ('Item 4', 1, 7.99, 'Spicy', 3);

INSERT INTO `order_detail` (item_name, quantity, total, note, orders_id)
VALUES ('Item 5', 2, 15.99, 'No onions', 3);




