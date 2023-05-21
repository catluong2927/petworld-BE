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
                           name varchar(20) not null,
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

alter table `packages` add constraint `FK_center_package` foreign key(center_id) references centers(`id`);
alter table `services` add constraint `FK_service_package` foreign key(package_id) references packages(`id`);
alter table	`service_images` add constraint `FK_service_service_image` foreign key(service_id) references services(`id`);
alter table `sellers` add constraint `FK_seller_center` foreign key (center_id) references centers(`id`);
alter table `package_reviews` add constraint `FK_package_review_package` foreign key(package_id) references packages(`id`);
alter table `package_reviews` add constraint `FK_package_review_user` foreign key(user_id) references user(`id`);

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


INSERT INTO `centers` (name, phone, email, address, active) VALUES
                                                                ('Center A', '1234567890', 'centerA@example.com', '123 Main St, City A', 1),
                                                                ('Center B', '2345678901', 'centerB@example.com', '456 Broad St, City B', 1),
                                                                ('Center C', '3456789012', 'centerC@example.com', '789 Oak St, City C', 0);

INSERT INTO packages (name, description, image, min_price, max_price, status,active,center_id)
VALUES ('Package 1', 'Description 1', 'https://loremflickr.com/640/480/nature', 10.50, 30.25, 'Best Seller',1,1),
       ('Package 1', 'Description 2', 'https://loremflickr.com/641/480/nature', 12.50, 35.50, 'Discount',1,2),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,3),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,3),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,1),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,2),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,1),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,3),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,2),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,3),
       ('Package 1', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,3),
       ('Package 3', 'Description 3', 'https://loremflickr.com/640/481/nature', 15.75, 28.25, 'Normal',0,3);

INSERT INTO services (name, price, description,package_id)
VALUES ('Service 1', 10.50, 'Description 1',1),
       ('Service 2', 20.00, 'Description 2',1),
       ('Service 3', 15.75, 'Description 3',2),
       ('Service 4', 30.25, 'Description 4',3);

INSERT INTO service_images (url,service_id)
VALUES ('https://loremflickr.com/640/481/food',1),
       ('https://loremflickr.com/640/482/food',1),
       ('https://loremflickr.com/640/483/food',2),
       ('https://loremflickr.com/640/484/food',2),
       ('https://loremflickr.com/640/485/food',3),
       ('https://loremflickr.com/640/486/food',3),
       ('https://loremflickr.com/640/487/food',4),
       ('https://loremflickr.com/640/488/food',4),
       ('https://loremflickr.com/640/489/food',1),
       ('https://loremflickr.com/640/489/food',2),
       ('https://loremflickr.com/641/480/food',3),
       ('https://loremflickr.com/642/480/food',4),
       ('https://loremflickr.com/643/480/food',1),
       ('https://loremflickr.com/644/480/food',2),
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
       ('The service package was excellent, highly recommended!', 5, '2022-09-01 18:00:00',2,3),
       ('I had a good experience with the service package, but it was a bit too expensive.', 3, '2022-10-01 19:00:00',2,1),
       ('The service package was good, but I expected more.', 4, '2022-11-01 20:00:00',3,2),
       ('I was satisfied with the service package, but there is room for improvement.', 4, '2022-12-01 21:00:00',1,3);

INSERT INTO `sellers` (name, phone, email, address, center_id, active) VALUES
                                                                           ('Seller A', '1234567890', 'sellerA@example.com', '123 Main St, City A', 1, 1),
                                                                           ('Seller B', '2345678901', 'sellerB@example.com', '456 Broad St, City B', 2, 1),
                                                                           ('Seller C', '3456789012', 'sellerC@example.com', '789 Oak St, City C', 3, 0),
                                                                           ('Seller D', '4567890123', 'sellerD@example.com', '321 Maple St, City D', 1, 1),
                                                                           ('Seller E', '5678901234', 'sellerE@example.com', '654 Pine St, City E', 2, 1),
                                                                           ('Seller F', '6789012345', 'sellerF@example.com', '987 Cedar St, City F', 3, 0);


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


select *
from product p
         inner join category c on p.category_id = c.id
where c.id in (2, 3, 4, 5);

select p.*
from product p
         inner join category c on p.category_id = c.id
-- where c.id = 1 or c.id = 2 or c.id = 3 or c.id = 4;
where c.id in (1,2);
