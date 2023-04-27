drop database demo;
create database demo;

use demo;

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
    `category_id` 	bigint not null
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
  
  
------------------------------------
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
