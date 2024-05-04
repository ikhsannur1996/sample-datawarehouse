-- Create Dimension Tables
CREATE TABLE BookDim (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(255),
    publication_year INT,
    publisher VARCHAR(255)
);

CREATE TABLE CustomerDim (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE DateDim (
    date_id INT PRIMARY KEY,
    date DATE,
    day_of_week VARCHAR(10),
    month VARCHAR(10),
    quarter VARCHAR(10),
    year INT
);

-- Create Fact Table
CREATE TABLE SalesFact (
    sales_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    date_id INT,
    quantity_sold INT,
    total_sales_amount DECIMAL(10, 2),
    FOREIGN KEY (book_id) REFERENCES BookDim(book_id),
    FOREIGN KEY (customer_id) REFERENCES CustomerDim(customer_id),
    FOREIGN KEY (date_id) REFERENCES DateDim(date_id)
);

-- Insert sample data into BookDim table
INSERT INTO BookDim (book_id, book_title, author, genre, publication_year, publisher)
VALUES
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 'Scribner'),
    (2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 'HarperCollins'),
    (3, '1984', 'George Orwell', 'Fiction', 1949, 'Penguin Books');

-- Insert sample data into CustomerDim table
INSERT INTO CustomerDim (customer_id, customer_name, email, phone, address)
VALUES
    (101, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA'),
    (102, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St, Othertown, USA'),
    (103, 'Bob Johnson', 'bob.j@example.com', '555-123-4567', '789 Oak St, Anothercity, USA');

-- Insert sample data into DateDim table
INSERT INTO DateDim (date_id, date, day_of_week, month, quarter, year)
VALUES
    (1, '2023-09-01', 'Thursday', 'September', 'Q3', 2023),
    (2, '2023-09-02', 'Friday', 'September', 'Q3', 2023),
    (3, '2023-09-03', 'Saturday', 'September', 'Q3', 2023);

-- Insert sample data into SalesFact table
INSERT INTO SalesFact (sales_id, book_id, customer_id, date_id, quantity_sold, total_sales_amount)
VALUES
    (1, 1, 101, 1, 2, 24.99),
    (2, 2, 102, 2, 3, 34.99),
    (3, 3, 103, 3, 1, 14.99),
    (4, 1, 102, 1, 2, 24.99),
    (5, 2, 101, 2, 4, 49.99),
    (6, 3, 103, 3, 3, 34.99),
    (7, 1, 103, 1, 2, 24.99),
    (8, 2, 102, 2, 3, 34.99),
    (9, 3, 101, 3, 1, 14.99),
    (10, 1, 102, 1, 2, 24.99),
    (11, 2, 101, 2, 4, 49.99),
    (12, 3, 102, 3, 3, 34.99),
    (13, 1, 103, 1, 2, 24.99),
    (14, 2, 102, 2, 3, 34.99),
    (15, 3, 101, 3, 1, 14.99),
    (16, 1, 102, 1, 2, 24.99),
    (17, 2, 103, 2, 4, 49.99),
    (18, 3, 102, 3, 3, 34.99),
    (19, 1, 101, 1, 2, 24.99),
    (20, 2, 101, 2, 3, 34.99);

-- Create a view to analyze monthly sales trends
CREATE VIEW MonthlySalesTrends AS
SELECT
    D.year,
    D.month,
    SUM(S.quantity_sold) AS total_quantity_sold,
    SUM(S.total_sales_amount) AS total_sales_amount
FROM
    SalesFact S
JOIN
    DateDim D ON S.date_id = D.date_id
GROUP BY
    D.year, D.month
ORDER BY
    D.year, D.month;

-- Create a view to analyze top selling books
CREATE VIEW TopSellingBooks AS
SELECT
    B.book_title,
    SUM(S.quantity_sold) AS total_quantity_sold,
    SUM(S.total_sales_amount) AS total_sales_amount
FROM
    SalesFact S
JOIN
    BookDim B ON S.book_id = B.book_id
GROUP BY
    B.book_title
ORDER BY
    total_quantity_sold DESC;

-- Create a view to calculate Customer Lifetime Value (CLV)
CREATE VIEW CustomerLifetimeValue AS
SELECT
    C.customer_id,
    C.customer_name,
    SUM(S.total_sales_amount) AS total_sales_amount
FROM
    SalesFact S
JOIN
    CustomerDim C ON S.customer_id = C.customer_id
GROUP BY
    C.customer_id, C.customer_name
ORDER BY
    total_sales_amount DESC;

-- Create a view to analyze purchase patterns
CREATE VIEW PurchasePatterns AS
SELECT
    C.customer_id,
    C.customer_name,
    COUNT(S.sales_id) AS total_purchases,
    MAX(D.date) AS last_purchase_date
FROM
    SalesFact S
JOIN
    CustomerDim C ON S.customer_id = C.customer_id
JOIN
    DateDim D ON S.date_id = D.date_id
GROUP BY
    C.customer_id, C.customer_name
ORDER BY
    total_purchases DESC;

-- Create a Data Mart Cube View
CREATE VIEW DataMartCube AS
SELECT
    S.sales_id,
    B.book_title,
    C.customer_name,
    D.year,
    D.month,
    S.quantity_sold,
    S.total_sales_amount
FROM
    SalesFact S
JOIN
    BookDim B ON S.book_id = B.book_id
JOIN
    CustomerDim C ON S.customer_id = C.customer_id
JOIN
    DateDim D ON S.date_id = D.date_id;

-- Slicing by year
SELECT *
FROM DataMartCube
WHERE year = 2023;

-- Dicing by year and genre
SELECT *
FROM DataMartCube
WHERE year = 2023 AND month = 'September';

-- Drilling up from month to year
SELECT year, SUM(total_sales_amount)
FROM DataMartCube
GROUP BY year;

-- Drilling down from year to month
SELECT year, month, SUM(total_sales_amount)
FROM DataMartCube
GROUP BY year, month;

-- Pivoting by month and sum of sales
SELECT month,
       SUM(CASE WHEN year = 2022 THEN total_sales_amount ELSE 0 END) AS "2022_Sales",
       SUM(CASE WHEN year = 2023 THEN total_sales_amount ELSE 0 END) AS "2023_Sales"
FROM DataMartCube
GROUP BY month;

-- Rolling up from day to month
SELECT year, month, SUM(total_sales_amount)
FROM DataMartCube
GROUP BY year, month;

