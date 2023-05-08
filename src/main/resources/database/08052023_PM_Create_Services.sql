create database `petworld-v1`;
use `petworld-v1`;
create table `services`(
                           id int primary key auto_increment,
                           name varchar(20) not null,
                           price float not null,
                           description varchar(250) not null,
                           active bit default(1));

create table `service_packages`(
                                   id int primary key auto_increment,
                                   name  varchar(20) not null,
                                   description varchar(250) not null,
                                   image varchar(255) not null,
                                   min_price float not null,
                                   max_price float not null,
                                   status varchar(50),
                                   active bit default(1));


create table `service_package_details`(
                                          service_package_id int not null,
                                          service_id int not null
);

create table `service_images`(
                                 id int primary key auto_increment,
                                 url varchar(255) not null
);

create table `service_image_details`(
                                        service_id int not null,
                                        service_images_id int not null
);

create table `service_package_reviews` (
                                           id int primary key auto_increment,
                                           review text,
                                           start int,
                                           date datetime
);

create table `service_package_review_details`(
                                                 service_package_id int not null ,
                                                 service_package_review_id int not null
);

-- service_package-details --
alter table `service_package_details` add constraint `FK_service_package_detail_service_packages` foreign key(service_package_id) references service_packages(`id`);
alter table `service_package_details` add constraint `FK_service_package_detail_services` foreign key(service_id) references services(`id`);

-- service_image_detail --
alter table `service_image_details` add constraint `FK_service_image_detail_services` foreign key(service_id) references services(`id`);
alter table `service_image_details` add constraint `FK_service_image_detail_service_images` foreign key(service_images_id) references service_images(`id`);

-- service_package_review --
alter table `service_package_review_details` add constraint `FK_service_package_review_detail_service_package` foreign key(service_package_id) references service_packages(`id`);
alter table `service_package_review_details` add constraint `FK_service_package_review_detail_service_package_review` foreign key(service_package_review_id) references service_package_reviews(`id`);

