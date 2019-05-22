
/*
 * Создание всех таблиц, согласно предложенной диаграмме, и
 * описание всех необходимых отношений между таблицами.
 */

create table UserInfo
(
    id int primary key,
    name varchar(255),
    surname varchar(255)
);

create table Roles
(
    id int unique generated always as identity(start with 1, increment by 1),
    name varchar(255) primary key
);

create table  Users
(
    id int unique generated always as identity(start with 1, increment by 1),
    email varchar(255) primary key,
    password varchar(255) not null,
    info int unique not null references UserInfo(id),
    role_id int not null references Roles(id)
);

create table Orders
(
    id int primary key generated always as identity(start with 1, increment by 1),
    user_id int not null references Users(id),
    created timestamp not null
);

create table Supplier
(
    id int unique generated always as identity(start with 1, increment by 1),
    name varchar(255) primary key,
    address varchar(255),
    phone varchar(255) not null,
    representative varchar(255)
);

create table Product
(
    id int unique generated always as identity(start with 1, increment by 1),
    code varchar(255) primary key,
    title varchar(255) not null,
    supplier int not null references supplier(id),
    initial_price double not null,
    retail_value double not null
);

create table Order2Product
(
    order_id int not null references Orders(id),
    product int not null references Product(id),
    constraint pk_order_2_product primary key(order_id, product)
);

/*
 * Добавление в каждую таблицу минимум трех записей.
 */

insert into UserInfo(id, name, surname)
values  (1, 'John', 'Doe'),
        (2, 'Jane', 'Doe'),
        (3, 'Ivan', 'Ivanov');

insert into Roles(name)
values  ('Admin'),
        ('User'),
        ('Editor');

insert into Users(email, password, info, role_id)
values  ('John@gmail.com', 'Doe', 1, 1),
        ('Jane@gmail.com', 'Doe', 2, 1),
        ('Ivan@gmail.com', 'Ivanov',3, 2);

insert into Orders(user_id, created)
values  (1, '2015-12-31 06:30:00'),
        (2, '2015-12-31 06:30:00'),
        (3, '2015-12-31 06:30:00');

insert into Supplier(name, address, phone, representative)
values  ('Interplay', null, '455-78-95', null),
        ('CD Project RED', null, '455-78-96', null),
        ('Konami', null, '455-78-97', null);

insert into Product(code, title, supplier, initial_price, retail_value)
values  ('34567832', 'fallout', 1, 12300, 13300),
        ('89766754', 'witcher', 2, 3400, 4900),
        ('90893648', 'pes2019', 3, 9800, 12800);

insert into Order2Product(order_id, product)
values  (1, 3),
        (2, 2),
        (3, 1);
