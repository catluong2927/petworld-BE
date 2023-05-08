use `petworld-v1`;
create table users(
`id` int not null auto_increment,
`fullName` varchar(255) not null,
`username` varchar(255) not null,
`password` varchar(255) not null,
`email` varchar(255),
`address` varchar(255),
`phone` varchar(255),
`avatar` varchar(255),
`isStatus` bit not null,
`rememberToken` varchar(255),
PRIMARY KEY (`id`));
create table roles(
`id` int not null auto_increment,
`Name` varchar(255) not null,
`Desc` varchar(255) not null,
PRIMARY KEY (`id`));
create table Customers_Roles(
`customer_id` int not null,
`role_id` int not null);
ALTER TABLE Customers_Roles ADD CONSTRAINT FK_Customers_Role_Customers FOREIGN KEY(`customer_id`) REFERENCES users(`id`);
ALTER TABLE Customers_Roles ADD CONSTRAINT FK_Customers_Role_Roles FOREIGN KEY(`role_id`) REFERENCES roles(`id`);
INSERT INTO users (fullname,username,`password`,email,isStatus)
 values
 ('Lượng','kakashi','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','luong@codegym.com',1),
 ('Hiếu','hieuthuhai','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','hieu@codegym.com',1);
 INSERT INTO roles(`name`,`Desc`) values
 ('ROLE_ADMIN','Quản trị viên'),
 ('ROLE_CUSTOMER','Khách hàng');
