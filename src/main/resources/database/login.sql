drop database `petworld-v1`;
create database `petworld-v1`;

use `petworld-v1`;
create table `user`(
                    `id` bigint not null auto_increment,
                    `full_name` varchar(255) not null,
                    `username` varchar(255) not null,
                    `password` varchar(255) not null,
                    `email` varchar(255) not null,
                    `address` varchar(255),
                    `phone` varchar(255),
                    `avatar` varchar(255),
                    `is_status` bit not null check(`is_status` = 0 or `is_status` = 1),
                    `remember_token` varchar(255),
                    PRIMARY KEY (`id`)
);
create table `role`(
                    `id` bigint not null auto_increment,
                    `name` varchar(255) not null,
                    `desc` varchar(255) not null,
                    PRIMARY KEY (`id`)
);
create table `user_role`(
                         `id` bigint primary key auto_increment,
                         `user_id` bigint not null,
                         `role_id` bigint not null
);
ALTER TABLE user_role ADD CONSTRAINT fk_user_role_customer FOREIGN KEY(`user_id`) REFERENCES `user`(`id`);
ALTER TABLE user_role ADD CONSTRAINT fk_user_role_role FOREIGN KEY(`role_id`) REFERENCES role(`id`);
INSERT INTO `user` (full_name, username, `password`, email, is_status)
values
 ('Lượng','kakashi','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','luong@codegym.com',1),
 ('Hiếu','hieuthuhai','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','hieu@codegym.com',1);
INSERT INTO `role`(`name`,`desc`) values
                                   ('ROLE_ADMIN','Quản trị viên'),
                                   ('ROLE_CUSTOMER','Khách hàng');

create table product(
                     `id`			bigint primary key auto_increment,
                     `name`			varchar(100) not null,
                     `description` 	longtext not null,
                     `image` 		varchar(255) not null,
                     `price` 		double(16,2) not null,
	`product_code` 	varchar(20) not null,
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

create table product_cart(
 `id` bigint primary key auto_increment
);

create table cart_detail(
                         `product_cart_id` bigint,
                         `product_id` bigint,
                         primary key(`product_cart_id`, `product_id`)
);

ALTER TABLE cart_detail
 ADD CONSTRAINT fk_cart_detail_product_cart
  FOREIGN KEY (`product_cart_id`)
   REFERENCES product_cart (`id`);

ALTER TABLE cart_detail
 ADD CONSTRAINT fk_cart_detail_product
  FOREIGN KEY (`product_id`)
   REFERENCES product (`id`);

ALTER TABLE product
 ADD CONSTRAINT fk_product_category
  FOREIGN KEY (`category_id`)
   REFERENCES category(`id`);


# ------------------------------------
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

Select * from product, category where product.category_id = category.id;
INSERT INTO `user_role`(`user_id`, `role_id`)
VALUES
 (1,1),
 (1,2),
 (2,2);
