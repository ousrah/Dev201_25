DROP DATABASE IF EXISTS library;
-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS library;
USE library;

-- Create the authors table
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT
) ENGINE=InnoDB;

-- Create the books table
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category VARCHAR(100),
    published_year INT,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Create the members table
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Create the loans table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    return_date TIMESTAMP,
    status ENUM('emprunté', 'retourné', 'overdue') DEFAULT 'emprunté',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insert authors
INSERT INTO authors (name, bio) VALUES
    ('George Orwell', 'English novelist and essayist, journalist and critic.'),
    ('J.K. Rowling', 'British author, best known for the Harry Potter series.'),
    ('J.R.R. Tolkien', 'English writer, poet, philologist, and academic.'),
    ('Mark Twain', 'American writer, humorist, entrepreneur, and publisher.'),
    ('Agatha Christie', 'English writer known for her detective novels.');

-- Insert books
INSERT INTO books (title, author_id, category, published_year, stock) VALUES
    ('1984', 1, 'Dystopian', 1949, 10),
    ('Harry Potter and the Philosopher\'s Stone', 2, 'Fantasy', 1997, 5),
    ('The Hobbit', 3, 'Fantasy', 1937, 7),
    ('The Adventures of Tom Sawyer', 4, 'Classic', 1876, 3),
    ('Murder on the Orient Express', 5, 'Mystery', 1934, 4);

-- Insert members
INSERT INTO members (name, email, phone, address) VALUES
    ('Alice Johnson', 'alice@example.com', '1234567890', '123 Main St'),
    ('Bob Smith', 'bob@example.com', '0987654321', '456 Oak St'),
    ('Charlie Brown', 'charlie@example.com', '1231231234', '789 Pine St'),
    ('Diana Prince', 'diana@example.com', '2342342345', '321 Maple St'),
    ('Evan Davis', 'evan@example.com', '3453453456', '654 Elm St');

INSERT INTO loans (book_id, member_id, loan_date, return_date, status)
VALUES 
    (1, 1, '2024-11-01', '2024-11-15', 'emprunté'),
    (2, 1, '2024-11-02', '2024-11-16', 'emprunté'),
    (3, 2, '2024-11-03', '2024-11-17', 'emprunté'),
    (4, 2, '2024-11-04', '2024-11-18', 'retourné'),
    (5, 3, '2024-11-05', '2024-11-19', 'emprunté'),
    (1, 3, '2024-11-06', '2024-11-20', 'retourné'),
    (2, 4, '2024-11-07', '2024-11-21', 'emprunté'),
    (3, 4, '2024-11-08', '2024-11-22', 'retourné'),
    (4, 5, '2024-11-09', '2024-11-23', 'emprunté'),
    (5, 5, '2024-11-10', '2024-11-24', 'emprunté'),
    (1, 1, '2024-11-11', '2024-11-25', 'emprunté'),
    (2, 2, '2024-11-12', '2024-11-26', 'retourné'),
    (3, 3, '2024-11-13', '2024-11-27', 'emprunté'),
    (4, 4, '2024-11-14', '2024-11-28', 'emprunté'),
    (5, 1, '2024-11-15', '2024-11-29', 'retourné'),
    (1, 2, '2024-11-16', '2024-11-30', 'emprunté'),
    (2, 3, '2024-11-17', '2024-12-01', 'emprunté'),
    (3, 4, '2024-11-18', '2024-12-02', 'retourné'),
    (4, 5, '2024-11-19', '2024-12-03', 'emprunté'),
    (5, 2, '2024-11-20', '2024-12-04', 'retourné');




