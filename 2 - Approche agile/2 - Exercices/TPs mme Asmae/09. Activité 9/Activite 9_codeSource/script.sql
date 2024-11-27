Create database address_book;

create table
    customers (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name varchar(40),
        email varchar(80),
        mobile varchar(40)
    );