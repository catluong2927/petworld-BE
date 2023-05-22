drop database `petworld-v1`;
create database `petworld-v1`;

use `petworld-v1`;

create table product
(
    `id`            bigint primary key auto_increment,
    `name`          varchar(100)  not null,
    `description`   longtext      not null,
    `image`         varchar(255)  not null,
    `price`         double(16, 2) not null,
    `product_code`  varchar(20)   not null unique,
    `protein`       varchar(200)  not null,
    `fats`          varchar(200)  not null,
    `carbohydrates` varchar(200)  not null,
    `minerals`      varchar(200)  not null,
    `vitamins`      varchar(200)  not null,
    `animal`        varchar(200)  not null,
    `sale`          int default 0 check (`sale` >= 0 and `sale` <= 100),
    `status`        bit           not null check (`status` = 0 or `status` = 1),
    `mark_id`       bigint        not null,
    `category_id`   bigint
);

create table image_detail
(
    `id`         bigint primary key auto_increment,
    `url`        varchar(255) not null,
    `product_id` bigint
);

create table category
(
    `id`   bigint primary key auto_increment,
    `name` varchar(40) not null unique
);

create table mark
(
    `id`        bigint primary key auto_increment,
    `tag`       varchar(10) unique,
    `tag_badge` varchar(10)
);

create table cart
(
    `id`            bigint primary key auto_increment,
    `amount_item`   int           default 0,
    `total_payment` double(16, 4) default 0.0000,
    `cart_date`     date          default (CURRENT_DATE),
    `user_id`       bigint not null unique
);

create table cart_detail
(
    `id`          bigint primary key auto_increment,
    `type`        bit    not null check (`type` = 0 or `type` = 1),
    `cart_id`     bigint not null,
    `type_id`     bigint not null,
    `total_price` double not null,
    `amount`      int    not null,
    `status`      bit check (`status` = 0 or `status` = 1)
);

create table `user`
(
    `id`             bigint       not null auto_increment,
    `full_name`      varchar(255) not null,
    `username`       varchar(255) not null,
    `password`       varchar(255) not null,
    `email`          varchar(255),
    `address`        varchar(255),
    `phone`          varchar(10),
    `avatar`         varchar(255),
    `is_status`      varchar(255),
    `remember_token` varchar(255),
    `role_id`        bigint       not null,
    PRIMARY KEY (id)
);
create table `role`
(
    `id`   bigint       not null auto_increment,
    `name` varchar(255) not null,
    `desc` varchar(255) not null,
    PRIMARY KEY (id)
);

create table `user_role`
(
    `id`      bigint primary key auto_increment,
    `user_id` bigint not null,
    `role_id` bigint not null
);

-- Khóa ngoại
ALTER TABLE product
    ADD CONSTRAINT fk_product_category
        FOREIGN KEY (`category_id`)
            REFERENCES category (`id`);

ALTER TABLE product
    ADD CONSTRAINT fk_product_mark
        FOREIGN KEY (`mark_id`)
            REFERENCES mark (`id`);

ALTER TABLE image_detail
    ADD CONSTRAINT fk_image_detail_product
        FOREIGN KEY (`product_id`)
            REFERENCES product (`id`);


ALTER TABLE cart_detail
    ADD CONSTRAINT fk_cart_detail_cart
        FOREIGN KEY (`cart_id`)
            REFERENCES cart (`id`);

ALTER TABLE cart
    ADD CONSTRAINT fk_user_cart
        FOREIGN KEY (`user_id`)
            REFERENCES `user` (`id`);

/*Customer - Role*/
ALTER TABLE `user_role`
    ADD CONSTRAINT fk_user_role_user
        FOREIGN KEY (`user_id`)
            REFERENCES `user` (`id`);

ALTER TABLE `user_role`
    ADD CONSTRAINT fk_user_role_role
        FOREIGN KEY (`role_id`)
            REFERENCES role (`id`);

------------------------------------
/*Customer - Role*/
INSERT INTO `role`(`name`, `Desc`)
VALUES ('ROLE_ADMIN', 'Quản trị viên'),
       ('ROLE_CUSTOMER', 'Khách hàng');



INSERT INTO `user`(`full_name`, `username`, `password`, `email`, `is_status`, `role_id`)
VALUES ('Lượng', 'kakashi', '$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq', 'luong@codegym.com', 1, 1),
       ('Hiếu', 'hieuthuhai', '$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq', 'hieu@codegym.com', 1, 2),
       ('Phong', 'phongxoan', '$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq', 'xoan@codegym.com', 1, 3);

INSERT INTO `user_role`(`user_id`, `role_id`)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (3, 2);

/*Product - Cart*/
INSERT INTO category(`name`)
VALUES ('Milk'),
       ('Pate'),
       ('Seed'),
       ('Vegetable');

INSERT INTO mark(`tag`, `tag_badge`)
VALUES ('', ''),
       ('offer', ''),
       ('hot', ''),
       ('Hot Sale', 'sale'),
       ('Sold Out', 'sold-out');

INSERT INTO product (`name`, `description`, image, price, product_code, protein, fats, carbohydrates, minerals,
                     vitamins, animal, `status`, mark_id, category_id, sale)
VALUES ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3pyl7Oei9BjUXDBHNpbAwcV2gAdvG2_a8bSh2Gd6473AK_rPL0yloJx8jbxRWKuTck9I&usqp=CAU',
        55000, 'PATE011', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Beef pate for dogs', 'One care beef',
        'https://www.petmart.vn/wp-content/uploads/2019/04/pate-cho-cho-vi-thit-bo-iris-one-care-beef100g-768x768.jpg',
        35000, 'PATE01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 1, 2, 0),
       ('Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://bizweb.dktcdn.net/100/458/454/products/petag-kmr-sua-bot-thay-the-danh-cho-meo-so-sinh-340g-1673494505588.png?v=1673494516117',
        5000, 'MILK01', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 10),
       ('Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi1O11-lKyc1Bu5JUBsps0Ck0DJrptR9RMXw&usqp=CAU', 25000,
        'SEED03', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgGLI32CNvJQz4NdV6Xl6808OoVtVezzOcJKg5mFmL7Ix1VMnTgT0yxtvH3NwlourMZ_M&usqp=CAU',
        55000, 'PATE012', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-hat-kitcat-cho-meo-chicken-cuisine-goi-1-2kg.jpg?v=1669097725000',
        25000, 'KITKAT01', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-dong-hop-kitcat-complete-cho-meo-12-vi.png?v=1669015221000',
        55000, 'PATE02', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Cabbage',
        'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000,
        'RAU01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 3, 4, 10),
       ('Pate for dogs',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Z3oqhYUuRGrGPekuWwgjyFe1fOKT3W7qRA&usqp=CAU', 55000,
        'PATE010', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRf2R4hT8A0AL7OYH_ydiB4vvDmnxUhN9D7g&usqp=CAU', 25000,
        'GRASS01', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass03', 1, 4, 3, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnSm4NZ-mhf8M4t2bqUYMC89lxBEz21bYEqQ&usqp=CAU', 55000,
        'PATE09', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Hay for rabbits',
        'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000,
        'HAY01', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 5, 4, 30),
       ('Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToGsTVVGmvh715WPWGaG5Nh9Qj4MqZvAO_ow&usqp=CAU', 5000,
        'MILK02', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 0),
       ('Coriander',
        'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000,
        'Coriander01', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 1, 4, 10),
       ('Sugar beet',
        'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU',
        35000, 'SUGERBEET01', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 2, 4, 0),
       ('Pate for cat', 'One care beef',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSotOxcypXkSkcb3TOTVC5sNZi2l3Vd3rbydg&usqp=CAU', 35000,
        'PATE04', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 3, 2, 0),
       ('Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWarBrQ3-FK3ayX3QkOHARbsF1zP2tERSSag&usqp=CAU', 5000,
        'MILK03', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 5, 1, 10),
       ('Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7PREwOPsySq4hSWOibEQCNUKN_tQfWVifdA&usqp=CAU', 25000,
        'GRASS04', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCegJXpRx0B3CYATMVJNdRvm_aIcFT4R2vxQ&usqp=CAU', 55000,
        'PATE08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6zVhvgeRe-oOxdf4fNj_odclRSdhajOQNg&usqp=CAU', 25000,
        'GRASS05', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       ('Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwvsbJrHp9daEJhSBt_TSjuoMjjHikJ-PRVw&usqp=CAU', 25000,
        'KITKAT04', '1g', '2g', '20g', '50mg', '', '', 1, 2, 3, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQwHkksi0p04qJXMX1nCFPjifYUSo03wspqg&usqp=CAU', 55000,
        'PATE07', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000,
        'MILK04', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8KHG1MmyokfGq0nGzp01aXClQs5AXDUKUVg&usqp=CAU', 55000,
        'PATE03', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 4, 2, 10),
       ('Cabbage',
        'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000,
        'RAU08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 5, 4, 0),
       ('Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST0iPUMOSmEEOGByl7TO0pYO4m9L2uS3-skQ&usqp=CAU', 25000,
        'SEED02', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0),
       ('Dog and Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW6Pk20H9wK_qDYr7sqxkvWNacLfeUXCPRuw&usqp=CAU', 5000,
        'MILK05', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 20),
       ('Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSZWTPPnsP4BLbQ-afBI1C_NGKyCVdcQ2G8w&usqp=CAU', 25000,
        'GRASS03', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       ('Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6zVhvgeRe-oOxdf4fNj_odclRSdhajOQNg&usqp=CAU', 25000,
        'GRASS02', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       ('Hay for rabbits',
        'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000,
        'HAY04', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 2, 4, 0),
       ('Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuht6t7E2HWryG0jPfbnVjhQ8gyJ6Wl5JRVw&usqp=CAU', 5000,
        'MILK06', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSKjcSHu4te5W0E5mRU5RzAh5gwPzxu7wzEQ&usqp=CAU', 55000,
        'PATE06', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Coriander',
        'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000,
        'Coriander06', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 3, 4, 10),
       ('Sugar beet',
        'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU',
        35000, 'SUGERBEET10', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 4, 4, 0),
       ('Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxzeTy1-U5R5G6qFBpdOtNpagd3cdgxyp8-8OGsenXQXc7VLQpKWSb0deTQnPQvIYdUY&usqp=CAU',
        5000, 'MILK07', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 4, 1, 0),
       ('Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrsEVF8cN8_ZmkjIabtALUULFDAux2CUSMWg&usqp=CAU', 5000,
        'MILK08', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 1, 1, 0),
       ('Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY5vgcgrMM1LOHuCrtS6k7CH-ploNgAsBct7K4kKL9kZhKjJHhAjve-DuBCccRPdc1htY&usqp=CAU ',
        55000, 'PATE015', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       ('Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs_PPUIjnt6HPYgHZ2uB26unbqO1FJbDHZZQ&usqp=CAU', 25000,
        'GRASS06', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       ('Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzeDA7w_rOUT6LmGJjQSKdXmxCDqH5jbMvTg&usqp=CAU', 25000,
        'SEED04', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0);


INSERT INTO `image_detail`(`url`, `product_id`)
VALUES ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 1),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8YqqS2PVX_hhWJBrxTTuFlAo7OWD1W3jyoQ&usqp=CAU', 1),
       ('https://media.istockphoto.com/id/1326701268/photo/kibble-and-canned-dog-food-in-bowls-two-types-of-dog-food.jpg?b=1&s=170667a&w=0&k=20&c=GHHLtQPDq2dZEUTR-N8ECZUdeYnASDgwhp_jN8br8u8=',
        1),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLiG7n-qIt2T9zM8XnqNYMfQoy7ifoSNGV5g&usqp=CAU', 1),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw1sqY_ercoHYbPZIfm2y2iwB-bzYTAXls8Q&usqp=CAU', 1),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 2),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgO_Cez7kPjpb5O_39hUk1vZmVBMhs3lNotA&usqp=CAU', 2),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh3_NMnt-k78pW9B8c5jjC7sBhEug9kHSbBA&usqp=CAU', 2),
       ('https://freshpet.com/wp-content/uploads/2020/01/FP_DogPage_Puppy_2020_v2.jpg', 2),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFN2jUeLRupXQf8isZjC0nDxFGBy5ylHIhA3Sc_mEG0oDpV-eyYJ4i5-jhnSyRYvQejyU&usqp=CAU',
        2),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 3),
       ('https://youdidwhatwithyourweiner.com/wp-content/uploads/2023/01/Water-Added-to-Dry-Dog-Food-800x600.jpg', 3),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiIQ1qWNJcPya9yEc6ditzalfPVAuM-FQgnzorhsCg9Vd95cuR_MpM8Rxb2mze9aHiTX8&usqp=CAU',
        3),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbbAiS_TnXDGzNYLtAB8EaFDjzixTYOo_3nTQGsMtVPNm22sOtcVnRXHezl2__1dB7ZaA&usqp=CAU',
        3),
       ('https://thumbs.dreamstime.com/b/puppy-bowl-dry-dog-food-isolated-white-background-70006967.jpg', 3),
       ('https://e3.365dm.com/23/05/2048x1152/skynews-dog-dog-food-study-finds_6141795.jpg', 4),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 4),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZIBQIUTpxtnXdIrMQ1384pVwtBkjc54yw5Q&usqp=CAU', 4),
       ('https://static.wixstatic.com/media/3e3a39_1f4234364d544e449969759ccc9427d1~mv2.jpg/v1/fill/w_680,h_680,al_c,lg_1,q_85/3e3a39_1f4234364d544e449969759ccc9427d1~mv2.jpg',
        4),
       ('https://img.freepik.com/free-photo/domestic-pet-food-assortment_23-2148982332.jpg', 4),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq1xPCFwR6Kxq2WFPxysF6cR8ZdIdjHO4sFA&usqp=CAU', 5),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 24),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 24),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 24),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 24),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 24),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       ('ttps://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39);



INSERT INTO cart(`user_id`)
VALUES (1),
       (2),
       (3);

INSERT INTO cart_detail(`type`, `cart_id`, `type_id`, `amount`, `status`, `total_price`)
VALUES (1, 1, 2, 3, 0, 75000.00),
       (0, 1, 2, 1, 0, 15000.00);

-- Phong Minh Section -------------------------
create table `centers`
(
    id      int primary key auto_increment,
    name    varchar(30)  not null,
    phone   varchar(10)  not null,
    email   varchar(100) not null,
    address varchar(200) not null,
    active  bit default (1)
);

create table `packages`
(
    id          int primary key auto_increment,
    name        varchar(20)  not null,
    description varchar(250) not null,
    image       varchar(255) not null,
    min_price   float        not null,
    max_price   float        not null,
    status      varchar(50),
    active      bit default (1),
    center_id   int          not null
);

create table `services`
(
    id          int primary key auto_increment,
    name        varchar(200) not null,
    price       float        not null,
    description varchar(250) not null,
    active      bit default (1),
    package_id  int          not null
);

create table `service_images`
(
    id         int primary key auto_increment,
    url        varchar(255) not null,
    service_id int          not null
);

create table `package_reviews`
(
    id         int primary key auto_increment,
    review     varchar(255) not null,
    star       int,
    date       datetime,
    active     bit default (1),
    package_id int          not null,
    user_id    bigint       not null
);

create table `sellers`
(
    id        int primary key auto_increment,
    name      varchar(30)  not null,
    phone     varchar(10)  not null,
    email     varchar(100) not null,
    address   varchar(200) not null,
    active    bit default (1),
    center_id int          not null
);

alter table `packages`
    add constraint `FK_center_package` foreign key (center_id) references centers (`id`);

alter table `services`
    add constraint `FK_service_package` foreign key (package_id) references packages (`id`);

alter table `service_images`
    add constraint `FK_service_service_image` foreign key (service_id) references services (`id`);

alter table `sellers`
    add constraint `FK_seller_center` foreign key (center_id) references centers (`id`);

alter table `package_reviews`
    add constraint `FK_package_review_package` foreign key (package_id) references packages (`id`);
alter table `package_reviews`
    add constraint `FK_package_review_user` foreign key (user_id) references user (`id`);


INSERT INTO centers (name, phone, email, address)
VALUES ('Pet Care Center', '1234567890', 'petcarecente@gmail.com.com', '123 Main St'),
       ('Animal Hospital', '9876543210', 'animalhospital@gmail.com', '456 Elm St'),
       ('Paws and Claws Clinic', '5551234567', 'appointments@gmail.com', '789 Oak Ave'),
       ('Pet Lovers Vet', '9998887777', 'competloversvet@gmail.com', '321 Pine Rd'),
       ('Happy Pets Clinic', '5551112222', 'happypetsclinic@gmail.com', '789 Maple Ave'),
       ('Cat Lovers Veterinary', '4445556666', 'appointments@gmail.com', '456 Oak St'),
       ('Doggy Daycare Center', '7778889999', 'doggydaycarecenter@gmail.com', '123 Pine Rd'),
       ('Exotic Animal Hospital', '2223334444', 'comexoticanimalhospital@gmail.com', '789 Elm St'),
       ('Birds and Beyond Clinic', '8889990000', 'beyondclinic@gmail.com', '456 Maple Ave'),
       ('Feline Friends Veterinary', '6667778888', 'appointments@gmail.com', '123 Oak St'),
       ('Happy Tails Boarding', '3334445555', 'comhappytailsboarding@gmail.com', '789 Pine Rd'),
       ('Reptile Care Center', '9990001111', 'contact@gmail.comreptilecarecenter.com', '456 Elm St'),
       ('Pawsome Pet Resort', '7778889999', 'pawsomepetresort@gmail.com', '123 Maple Ave'),
       ('Small Animal Clinic', '2223334444', 'appointments@gmail.com', '789 Oak St'),
       ('Avian Veterinary Services', '8889990000', 'comavianvetservices@gmail.com', '456 Pine Rd'),
       ('Whiskers and Paws Clinic', '6667778888', 'comwhiskersandpawsclinic@gmail.com', '123 Elm St'),
       ('Critter Care Center', '3334445555', 'infocomcrittercarecenter@gmail.com', '789 Maple Ave'),
       ('Equine Veterinary Clinic', '9990001111', 'appointmentscomequinevetclinic@gmail.com', '456 Oak St'),
       ('Purrfect Pet Grooming', '7778889999', 'infocompurrfectpetgrooming@gmail.com', '123 Pine Rd'),
       ('Aquatic Animal Hospital', '2223334444', 'comaquaticanimalhospitalcontact@gmail.com', '789 Elm St'),
       ('Rabbit and Rodent Clinic', '8889990000', 'infocomrabbitandrodentclinic12@gmail.com', '456 Maple Ave');

INSERT INTO packages (name, description, image, min_price, max_price, status, center_id)
VALUES ('DayCare', 'A routine health check-up for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376776/Packages/scottsdale-daycare-image-1-a_qszly6.jpg',
        50.0, 100.0, 'Active', 1),
       ("'Pet's Sapa'", 'Essential vaccinations for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376796/Packages/dog-massage-therapy-picture-id909810936_gtpm6j.jpg',
        80.0, 150.0, 'Active', 2),
       ('DayCare', 'Pamper your pet with a grooming session',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg',
        60.0, 120.0, 'Active', 3),
       ('Training Program', 'Professional training for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376948/Packages/jrmrtpfwcgk92c3iefen.jpg', 100.0, 200.0,
        'Active', 10),
       ("'Pet's Sapa'", 'Safe and comfortable boarding for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376983/Packages/caninemassagefeat-1080x675_hvebpl.jpg',
        40.0, 80.0, 'Active', 4),
       ('DayCare', 'Professional dental cleaning for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377007/Packages/oakland-and-east-bay-dog-daycare-1024x683_csvb5i.jpg',
        80.0, 150.0, 'Active', 5),
       ('Walking Service', 'Expert consultation for pet behavior issues',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377039/Packages/images_otmqqy.jpg', 120.0, 200.0,
        'Active', 1),
       ('DayCare', 'Training package specifically designed for puppies',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377079/Packages/images_l2npht.jpg', 150.0, 250.0,
        'Active', 2),
       ("'Pet's Sapa'", 'Specialized wellness package for senior pets',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377116/Packages/images_y4dyct.jpg', 90.0, 160.0,
        'Active', 3),
       ('DayCare', 'Consultation to ensure proper nutrition for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377150/Packages/rs_h_1000_cg_true_m_eqc1z7.jpg', 70.0,
        120.0, 'Active', 5),
       ("'Pet's Sapa'", 'Microchipping service for identification and tracking',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377180/Packages/images_sfguki.jpg', 50.0, 100.0,
        'Active', 4),
       ('DayCare', 'Preventive treatment for fleas and ticks',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377227/Packages/images_es7beo.jpg', 30.0, 70.0,
        'Active', 1),
       ('Walking Service', 'Relaxing massage therapy for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377252/Packages/images_tqmpxw.jpg', 60.0, 100.0,
        'Active', 6),
       ('DayCare', 'Testing to identify pet allergies',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377276/Packages/images_xhk5e2.jpg', 100.0, 200.0,
        'Active', 7),
       ("'Pet's Sapa'", 'Acupuncture treatment for your pet',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377360/Packages/images_fz4ihk.jpg', 80.0, 150.0,
        'Active', 3),
       ('DayCare', 'Rehabilitation therapy for pets recovering from injuries',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377427/Packages/images_ithwde.jpg', 120.0, 200.0,
        'Active', 2),
       ('Walking Service', 'Boarding services exclusively for cats',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377461/Packages/images_womxnd.jpg', 40.0, 80.0,
        'Active', 3),
       ('DayCare', 'Package for deworming and parasite control',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377504/Packages/images_vjgni4.jpg', 50.0, 100.0,
        'Active', 4),
       ("'Pet's Sapa'", 'Grooming services for pet birds',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377526/Packages/images_fbqldb.jpg', 60.0, 120.0,
        'Active', 5),
       ('DayCare', 'Specialized care for exotic pets',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377550/Packages/images_ww33bd.jpg', 100.0, 200.0,
        'Active', 6),
       ('Walking Service', 'Professional dog walking service',
        'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377584/Packages/images_awbr7q.jpg', 30.0, 60.0,
        'Active', 7);

INSERT INTO services (name, price, description, package_id)
VALUES ('Basic Check-up', 50.0, 'Routine health check-up for your pet', 1),
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

INSERT INTO service_images (url, service_id)
VALUES ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377733/Packages/ServiceImage/PEts-like-humans-article-COVER_yzla70.jpg',
        1),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377767/Packages/ServiceImage/images_kd4ium.jpg', 1),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377780/Packages/ServiceImage/home-2_eoovki.jpg', 2),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377805/Packages/ServiceImage/pet-care_cat-care_thumb_fgw2hf.jpg',
        2),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377816/Packages/ServiceImage/images_zansmg.jpg', 3),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377827/Packages/ServiceImage/jack-russell-terrier-dog-holding-260nw-2100518530_wojavq.jpg',
        3),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377935/Packages/ServiceImage/s3wf6poxajhl0fa0adbu.jpg',
        4),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377973/Packages/ServiceImage/images_jvdrwd.jpg', 4),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377994/Packages/ServiceImage/images_g9vmwq.jpg', 1),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378011/Packages/ServiceImage/images_una9lg.jpg', 2),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378061/Packages/ServiceImage/images_obdjp4.jpg', 3),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378127/Packages/ServiceImage/images_vz5c3h.jpg', 4),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378142/Packages/ServiceImage/images_rfh8op.jpg', 1),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378162/Packages/ServiceImage/images_leocve.jpg', 2),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378187/Packages/ServiceImage/images_sdyeow.jpg', 3),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378208/Packages/ServiceImage/images_pqgm2f.jpg', 4),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378230/Packages/ServiceImage/images_bxpyvu.jpg', 1),
       ('https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378251/Packages/ServiceImage/images_kmpwb2.jpg', 2);


INSERT INTO package_reviews (review, star, date, package_id, user_id)
VALUES ('Great service package, highly recommended!', 5, '2022-01-01 10:00:00', 1, 1),
       ('The service package was good, but could be better.', 4, '2022-02-01 11:00:00', 2, 2),
       ('I really enjoyed the service package, will come back again!', 5, '2022-03-01 12:00:00', 1, 3),
       ('Service package was okay, nothing special.', 3, '2022-04-01 13:00:00', 3, 1),
       ('Highly professional service package, exceeded my expectations!', 5, '2022-05-01 14:00:00', 3, 2),
       ('The service package was a bit pricey, but the quality was good.', 4, '2022-06-01 15:00:00', 2, 3),
       ('Great value for money, highly recommend this service package!', 5, '2022-07-01 16:00:00', 3, 1),
       ('Service package was good, but could be better.', 4, '2022-08-01 17:00:00', 1, 2),
--        ('The service package was excellent, highly recommended!', 5, '2022-09-01 18:00:00',2,3),
--        ('I had a good experience with the service package, but it was a bit too expensive.', 3, '2022-10-01 19:00:00',2,1),
--        ('The service package was good, but I expected more.', 4, '2022-11-01 20:00:00',3,2),
--        ('I was satisfied with the service package, but there is room for improvement.', 4, '2022-12-01 21:00:00',1,3),
--        ('The service package was great, exceeded my expectations!', 5, '2023-01-01 22:00:00',1,4),
--        ('I had a good experience with the service package, but it was a bit overpriced.', 4, '2023-02-01 23:00:00',2,3),
--        ('The service package was excellent, highly recommended!', 5, '2023-03-01 00:00:00',3,1),
--        ('The service package was good, but I expected more.', 4, '2023-04-01 01:00:00',6,1),
--        ('I enjoyed the service package, but the price was a bit high.', 4, '2023-05-01 02:00:00',1,2),
--        ('The service package was good, but it could be better.', 3, '2023-06-01 03:00:00',3,2),
--        ('Great service package, highly recommended!', 5, '2023-07-01 04:00:00',1,4),
       ('The service package was good, but the quality was inconsistent.', 3, '2023-08-01 05:00:00', 2, 1);

INSERT INTO `sellers` (name, phone, email, address, center_id, active)
VALUES ('Seller A', '1234567890', 'sellerA@gmail.comexample.com', '123 Main St, City A', 1, 1),
       ('Seller B', '2345678901', 'sellerB@gmail.comexample.com', '456 Broad St, City B', 2, 1),
       ('Seller C', '3456789012', 'sellerC@gmail.comexample.com', '789 Oak St, City C', 3, 0),
       ('Seller D', '4567890123', 'sellerD@gmail.comexample.com', '321 Maple St, City D', 1, 1),
       ('Seller E', '5678901234', 'sellerE@gmail.comexample.com', '654 Pine St, City E', 2, 1),
       ('Seller F', '6789012345', 'sellerF@example.com', '987 Cedar St, City F', 3, 0);

create table `orders`
(
    id           int primary key auto_increment,
    phone_number varchar(20)  not null,
    note         varchar(200),
    `date`       datetime     not null,
    address      varchar(200) not null,
    `status`     varchar(100) not null,
    total        double,
    user_id      bigint       not null
);

create table `order_detail`
(
    id        int primary key auto_increment,
    item_name varchar(200),
    image     varchar(300),
    quantity  int    not null,
    total     double not null,
    note      varchar(200),
    orders_id int    not null
);

alter table `orders`
    add constraint `FK_order_user` foreign key (user_id) references `user` (`id`);
alter table `order_detail`
    add constraint `FK_order_detail_order` foreign key (orders_id) references `orders` (`id`);

INSERT INTO `orders` (phone_number, note, `date`, address, `status`, total, user_id)
VALUES ('1234567890', 'Please deliver ASAP', '2023-05-19 10:00:00', '123 Main St, City, Country', 'Pending', 45.3, 1);

INSERT INTO `orders` (phone_number, note, `date`, address, `status`, total, user_id)
VALUES ('9876543210', 'Call before delivery', '2023-05-20 15:30:00', '456 Elm St, City, Country', 'Processing', 35.3,
        2);

INSERT INTO `orders` (phone_number, note, `date`, address, `status`, total, user_id)
VALUES ('5555555555', 'No onions, please', '2023-05-21 18:00:00', '789 Oak St, City, Country', 'Completed', 35.3, 3);

INSERT INTO `order_detail` (item_name, image, quantity, total, note, orders_id)
VALUES ('Item 1', 'https://loremflickr.com/641/480/food', 2, 10.99, 'No special instructions', 1);

INSERT INTO `order_detail` (item_name, image, quantity, total, note, orders_id)
VALUES ('Item 2', 'https://loremflickr.com/641/480/food', 1, 5.99, 'Extra cheese', 1);

INSERT INTO `order_detail` (item_name, image, quantity, total, note, orders_id)
VALUES ('Item 3', 'https://loremflickr.com/641/480/food', 3, 20.99, 'Gluten-free option', 2);

INSERT INTO `order_detail` (item_name, image, quantity, total, note, orders_id)
VALUES ('Item 4', 'https://loremflickr.com/641/480/food', 1, 7.99, 'Spicy', 3);

INSERT INTO `order_detail` (item_name, image, quantity, total, note, orders_id)
VALUES ('Item 5', 'https://loremflickr.com/641/480/food', 2, 15.99, 'No onions', 3);




