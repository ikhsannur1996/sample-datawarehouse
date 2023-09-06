## Enterprise Data Warehouse (EDW)

Creating a full-fledged Enterprise Data Warehouse (EDW) and Data Mart for a book store is a complex task that typically involves a significant amount of planning and design. In this text-based format, I can provide you with a simplified example of an Entity-Relationship Diagram (ERD) for a Data Warehouse and Data Mart in a book store scenario, along with SQL code and sample data for one fact table and three dimension tables.

Please note that in a real-world scenario, the design and structure of the data warehouse would be more comprehensive and tailored to the specific needs of the business.

### Entity-Relationship Diagram (ERD):

![drawSQL-sql-export-2023-09-06](https://github.com/ikhsannur1996/sample-datawarehouse/assets/32507742/127cc5a5-f05e-4301-9996-e2f71e86952d)

Here's a simplified ERD for the Data Warehouse and Data Mart:

1. Fact Table:
   - `SalesFact` (Fact)
     - sales_id (Primary Key)
     - book_id (Foreign Key)
     - customer_id (Foreign Key)
     - date_id (Foreign Key)
     - quantity_sold
     - total_sales_amount

2. Dimension Tables:
   - `BookDim` (Dimension)
     - book_id (Primary Key)
     - book_title
     - author
     - genre
     - publication_year
     - publisher

   - `CustomerDim` (Dimension)
     - customer_id (Primary Key)
     - customer_name
     - email
     - phone
     - address

   - `DateDim` (Dimension)
     - date_id (Primary Key)
     - date
     - day_of_week
     - month
     - quarter
     - year

### SQL Code:

Here's an example of SQL code to create the above tables:

```sql
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
```

### Sample Data:

Here's some sample data for one fact table record and three dimension tables:

**BookDim Table Sample Data:**

| book_id | book_title        | author         | genre     | publication_year | publisher         |
| ------- | ----------------- | -------------- | --------- | ----------------- | ------------------ |
| 1       | The Great Gatsby  | F. Scott Fit.. | Fiction   | 1925            | Scribner           |
| 2       | To Kill a Mock..  | Harper Lee     | Fiction   | 1960            | HarperCollins     |
| 3       | 1984              | George Orwell  | Fiction   | 1949            | Penguin Books     |

**CustomerDim Table Sample Data:**

| customer_id | customer_name    | email                  | phone        | address                   |
| ----------- | ---------------- | ---------------------- | ------------ | -------------------------- |
| 101         | John Doe         | john.doe@example.com   | 123-456-7890 | 123 Main St, Anytown, USA |
| 102         | Jane Smith       | jane.smith@example.com | 987-654-3210 | 456 Elm St, Othertown, USA |
| 103         | Bob Johnson      | bob.j@example.com      | 555-123-4567 | 789 Oak St, Anothercity, USA |

**DateDim Table Sample Data:**

| date_id | date       | day_of_week | month    | quarter | year |
| ------- | ---------- | ----------- | -------- | ------- | ---- |
| 1       | 2023-09-01 | Thursday    | September| Q3      | 2023 |
| 2       | 2023-09-02 | Friday      | September| Q3      | 2023 |
| 3       | 2023-09-03 | Saturday    | September| Q3      | 2023 |

**SalesFact Table Sample Data:**

| sales_id | book_id | customer_id | date_id | quantity_sold | total_sales_amount |
| -------- | ------- | ----------- | ------- | ------------- | ------------------- |
| 1        | 1       | 101         | 1       | 2             | 24.99               |

Please note that in a real-world scenario, these tables would be populated with a significant amount of data, and you would need to design a comprehensive ETL (Extract, Transform, Load) process to keep the data warehouse up to date. Additionally, you would create more dimensions and facts to support various analytical queries and reporting needs.

Sure, here's sample SQL INSERT statements to populate the previously defined tables with data:

**BookDim Table Sample Data:**

```sql
-- Insert sample data into BookDim table
INSERT INTO BookDim (book_id, book_title, author, genre, publication_year, publisher)
VALUES
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 'Scribner'),
    (2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 'HarperCollins'),
    (3, '1984', 'George Orwell', 'Fiction', 1949, 'Penguin Books');
```

**CustomerDim Table Sample Data:**

```sql
-- Insert sample data into CustomerDim table
INSERT INTO CustomerDim (customer_id, customer_name, email, phone, address)
VALUES
    (101, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA'),
    (102, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St, Othertown, USA'),
    (103, 'Bob Johnson', 'bob.j@example.com', '555-123-4567', '789 Oak St, Anothercity, USA');
```

**DateDim Table Sample Data:**

```sql
-- Insert sample data into DateDim table
INSERT INTO DateDim (date_id, date, day_of_week, month, quarter, year)
VALUES
    (1, '2023-09-01', 'Thursday', 'September', 'Q3', 2023),
    (2, '2023-09-02', 'Friday', 'September', 'Q3', 2023),
    (3, '2023-09-03', 'Saturday', 'September', 'Q3', 2023);
```

**SalesFact Table Sample Data:**

```sql
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

-- Insert additional data into dimension tables if needed
-- For example, add more books, customers, and dates to the dimension tables

```

These INSERT statements will populate the tables with the sample data provided earlier. You can continue to add more records to these tables as needed for your testing or development purposes.

Certainly! Here are two sample Data Marts that can be created from the Data Warehouse described above, along with their respective business cases:

**Data Mart 1: Sales Analysis Data Mart**

*Business Case:*
This Data Mart is designed to provide in-depth sales analysis for the book store. It enables the business to gain insights into their sales performance, track trends, and make informed decisions.

**Dimension Tables:**
1. `BookDim`: Contains book-related information.
2. `DateDim`: Provides date-related details.
3. `CustomerDim`: Stores customer information.

**Fact Table:**
1. `SalesFact`: Contains sales data such as quantity sold and total sales amount.

**Key Metrics and Reports:**
1. **Monthly Sales Trends:** Analyze monthly sales data to identify peak sales months, seasonal patterns, and sales trends over time.
2. **Top Selling Books:** Determine which books are top sellers in terms of quantity sold and revenue generated.
3. **Customer Segmentation:** Segment customers based on their purchase behavior and demographics to target marketing efforts effectively.
4. **Sales by Genre:** Analyze which book genres are performing the best and adjust inventory accordingly.
5. **Sales by Publisher:** Evaluate the performance of different publishers in terms of sales.
6. **Customer Loyalty:** Track repeat customers and analyze their contribution to sales.
7. **Inventory Management:** Monitor stock levels and make informed decisions about reordering books.

**Data Mart 2: Customer Insights Data Mart**

*Business Case:*
This Data Mart focuses on providing deep insights into customer behavior and preferences. It helps the business understand its customers better and tailor marketing strategies accordingly.

**Dimension Tables:**
1. `CustomerDim`: Contains customer information.
2. `DateDim`: Provides date-related details.
3. `BookDim`: Stores book-related information.

**Fact Table:**
1. `SalesFact`: Contains sales data, including quantity sold and total sales amount.

**Key Metrics and Reports:**
1. **Customer Lifetime Value (CLV):** Calculate CLV for different customer segments to identify high-value customers and tailor marketing efforts.
2. **Purchase Patterns:** Analyze customer purchase patterns, such as frequency and recency of purchases.
3. **Customer Segmentation:** Segment customers based on demographics, preferences, and buying behavior.
4. **Product Affinity:** Identify which books are often purchased together and use this information for product recommendations.
5. **Customer Churn Analysis:** Determine factors leading to customer churn and develop strategies to retain customers.
6. **Marketing Campaign Effectiveness:** Evaluate the success of marketing campaigns and promotions by tracking sales before and after campaigns.
7. **Customer Feedback Analysis:** Incorporate customer feedback data to improve products and services.

These Data Marts serve as specialized subsets of the Data Warehouse, tailored to specific business needs. They allow stakeholders to access relevant data quickly and make data-driven decisions to improve sales, customer relationships, and overall business performance.

Creating SQL code for Data Marts typically involves designing specific queries and views based on the requirements of the Data Mart. Below, I'll provide sample SQL code for creating views within the Data Mart context for the two Data Marts described earlier. Please note that these are simplified examples, and in practice, you may need more complex SQL queries and data transformation depending on your actual business requirements.

**Data Mart 1: Sales Analysis Data Mart**

*Views:*

```sql
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

-- Create other views for additional metrics and reports as needed
```

**Data Mart 2: Customer Insights Data Mart**

*Views:*

```sql
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

-- Create other views for customer segmentation, product affinity, churn analysis, etc., as needed
```

These SQL views are just starting points for your Data Marts. Depending on your specific business requirements, you may need to create additional views or customize the existing ones to provide the necessary data for your reports and analyses. Additionally, you can use these views as data sources for your BI tools or reporting applications to visualize and interact with the data.
