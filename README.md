# Enterprise Data Warehouse (EDW)

Enterprise Data Warehouses (EDWs) and Data Marts are foundational components of modern data management and analytics, and their implementation for a book store or any business is indeed a complex and strategic undertaking. This section will provide some context about why building an EDW and Data Mart for a book store is a significant endeavor that requires meticulous planning and design.

**Enterprise Data Warehouse (EDW) - Star Schema (Tested in Lab):**
In this section, we delve into the concept of an Enterprise Data Warehouse (EDW) designed using a star schema, a well-established and tested approach for organizing data in a data warehouse. The star schema consists of a central fact table surrounded by dimension tables, offering simplicity, query performance, and ease of use. This section provides insights into the benefits, practical implementation, and use cases of a star schema within an EDW, backed by actual testing and experimentation.

**Data Mart - Cube Data Mart:**
A Data Mart is a specialized subset of an Enterprise Data Warehouse (EDW) that focuses on a specific business area or department's data needs. In the context of a book store, a Cube Data Mart is a type of Data Mart that is particularly useful for multidimensional analysis and reporting. This section provides an overview of the Cube Data Mart concept, its design considerations, and its applications in the book store context.

**Enterprise Data Warehouse (EDW) - Snowflake Schema (Untested in Lab):**
In this section, we explore the concept of an Enterprise Data Warehouse (EDW) designed using a snowflake schema, although it has not yet undergone testing by the author. The snowflake schema is characterized by its more normalized structure, potentially reducing data redundancy and offering advantages in terms of data integrity and adaptability to changes. This section examines the theoretical benefits and considerations of using a snowflake schema within an EDW, while acknowledging that practical testing results are pending.


## Enterprise Data Warehouse (EDW) - Star Schema (Tested in Lab)

Creating a full-fledged Enterprise Data Warehouse (EDW) and Data Mart for a book store is a complex task that typically involves a significant amount of planning and design. In this text-based format, I can provide you with a simplified example of an Entity-Relationship Diagram (ERD) for a Data Warehouse and Data Mart in a book store scenario, along with SQL code and sample data for one fact table and three dimension tables.

Using a star schema instead of a snowflake schema for a data warehouse in a book store context can be a more suitable choice for several reasons:

1. **Simplicity and Ease of Use**: Star schemas are simpler and easier to understand for business users, analysts, and report developers. They involve fewer tables and joins, making it more straightforward to write and maintain SQL queries. This simplicity can lead to increased productivity among users who need to access and analyze data.

2. **Query Performance**: Star schemas generally offer better query performance compared to snowflake schemas. With fewer joins involved, queries can be executed more quickly, which is crucial for analytical and reporting purposes. This faster query performance allows for quicker access to insights and reports.

3. **Agility and Flexibility**: Star schemas are more agile and flexible when it comes to adapting to changing business needs. If you need to add new dimensions or modify existing ones, changes can be made to the schema with minimal impact on other parts of the system. This agility is beneficial in a dynamic business environment.

4. **Tool Compatibility**: Many Business Intelligence (BI) and reporting tools are optimized for star schemas. Using a star schema can lead to better compatibility with these tools, streamlining the reporting and analytics process. It can also reduce the complexity of setting up connections between tools and the data warehouse.

5. **Performance Optimization**: Star schemas allow for easier implementation of performance optimization techniques, such as indexing and materialized views. These optimizations can further enhance query performance and responsiveness.

6. **User Adoption**: Star schemas are generally more intuitive for end-users, resulting in quicker user adoption. When users find it easier to access and work with data, they are more likely to embrace data-driven decision-making practices.

7. **Scalability**: Star schemas are often more scalable as data volumes grow. They can handle large amounts of data without significant degradation in query performance, making them suitable for a growing book store's data needs.

8. **Reduced Complexity**: Snowflake schemas can introduce unnecessary complexity by normalizing data into multiple related tables. While normalization has its benefits in transactional databases, it can add complexity and potentially hinder performance in a data warehousing context.

However, it's important to note that the choice between a star schema and a snowflake schema should ultimately align with the specific business requirements, data modeling standards, and preferences of your organization. In some cases, a snowflake schema may be more appropriate, especially when dealing with highly normalized data or strict data integrity requirements.

Before making a decision, it's essential to carefully analyze your data and consider the reporting and analytical needs of your book store to determine the most suitable schema design for your data warehouse.

### Entity-Relationship Diagram (ERD):

![drawSQL-sql-export-2023-09-06](https://github.com/ikhsannur1996/sample-datawarehouse/assets/32507742/127cc5a5-f05e-4301-9996-e2f71e86952d)

Please note that in a real-world scenario, the design and structure of the data warehouse would be more comprehensive and tailored to the specific needs of the business.

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

### Sample Datamart:

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


## Cube Data Mart
To create a Data Mart Cube and perform cube operations (Slicing, Dicing, Drilling up and down, Pivoting, Rolling Up) using the tables you've provided, you would typically use a database management system that supports Online Analytical Processing (OLAP) operations. Below are SQL queries for each of these operations:

**Create Data Mart Cube:**

To create a Data Mart Cube, you can create a view that aggregates the data from the fact table (SalesFact) and join it with the dimension tables (BookDim, CustomerDim, DateDim) to create a multidimensional view of the data.

```sql
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
```

**Cube Operations:**

1. **Slicing:**
   - Slicing involves selecting a single value along one dimension while keeping all other dimensions intact.

   ```sql
   -- Slicing by year
   SELECT *
   FROM DataMartCube
   WHERE year = 2023;
   ```

2. **Dicing:**
   - Dicing involves selecting specific values along multiple dimensions.

   ```sql
   -- Dicing by year and genre
   SELECT *
   FROM DataMartCube
   WHERE year = 2023 AND month = 'September';
   ```

3. **Drilling Up and Down:**
   - Drilling up involves moving from a more detailed level to a higher level of aggregation.
   - Drilling down involves moving from a higher level of aggregation to a more detailed level.

   ```sql
   -- Drilling up from month to year
   SELECT year, SUM(total_sales_amount)
   FROM DataMartCube
   GROUP BY year;

   -- Drilling down from year to month
   SELECT year, month, SUM(total_sales_amount)
   FROM DataMartCube
   GROUP BY year, month;
   ```

4. **Pivoting:**
   - Pivoting involves changing the orientation of the data, typically converting rows into columns.

   ```sql
   -- Pivoting by month and sum of sales
   SELECT month,
          SUM(CASE WHEN year = 2022 THEN total_sales_amount ELSE 0 END) AS "2022_Sales",
          SUM(CASE WHEN year = 2023 THEN total_sales_amount ELSE 0 END) AS "2023_Sales"
   FROM DataMartCube
   GROUP BY month;
   ```

5. **Rolling Up:**
   - Rolling up involves aggregating data from a lower level to a higher level within a dimension.

   ```sql
   -- Rolling up from day to month
   SELECT year, month, SUM(total_sales_amount)
   FROM DataMartCube
   GROUP BY year, month;
   ```

These SQL queries demonstrate cube operations on the Data Mart Cube. Keep in mind that in a real-world scenario, you would typically use OLAP tools or OLAP functions provided by your database management system for more efficient and optimized cube operations.


## Enterprise Data Warehouse (EDW) - Snowflake Schema (Untested in Lab)

Creating a full-fledged Enterprise Data Warehouse (EDW) and Data Mart with a snowflake schema for a book store is a complex task that typically involves a significant amount of planning, design, and development. In this text-based format, I can provide a simplified example of an Entity-Relationship Diagram (ERD) for a Data Warehouse and Data Mart using a snowflake schema, along with sample SQL code for creating tables and some sample data for one fact table and three dimension tables.

Using a snowflake schema instead of a star schema for a data warehouse in a book store context might be a valid choice depending on certain factors and requirements. Here are some reasons why you might consider using a snowflake schema:

1. **Data Normalization**: Snowflake schemas are typically more normalized compared to star schemas. If your book store's data contains a lot of redundancy and you want to reduce data storage requirements, a snowflake schema can help by eliminating some duplicate data. This can be especially useful if you have limited storage resources.

2. **Data Integrity**: Snowflake schemas can provide better data integrity by reducing the chances of anomalies. With more normalized data, you can enforce data consistency rules more effectively. This is crucial if maintaining data accuracy is a top priority, such as for financial data or regulatory compliance.

3. **Data Changes and Updates**: If your data source systems frequently change or update their data structures, a snowflake schema can be more adaptable. Since it's normalized, changes in one dimension table are less likely to have a cascading effect on other parts of the schema, reducing the maintenance effort.

4. **Complex Hierarchies**: If your business processes involve complex hierarchies within dimension tables (e.g., hierarchical product categories or organizational structures), a snowflake schema may help represent these hierarchies more efficiently by breaking them into separate tables.

5. **Security and Access Control**: Snowflake schemas can provide finer-grained control over data access. You can grant different permissions on individual tables or views within the schema, which can be important for enforcing security policies and data privacy regulations.

6. **Resource Constraints**: If your data warehouse platform has resource constraints, such as limited memory or processing power, a snowflake schema may consume fewer resources during query execution due to its normalized structure. This can help with query performance on resource-constrained systems.

However, it's important to consider the trade-offs when using a snowflake schema:

1. **Query Performance**: Snowflake schemas typically involve more joins, which can lead to slower query performance compared to star schemas, especially for complex analytical queries. You may need to invest in query optimization techniques to mitigate this.

2. **Query Complexity**: Snowflake schemas can make SQL queries more complex due to the need for additional joins across multiple tables. This complexity can affect query development and maintenance.

3. **Tool Compatibility**: Some Business Intelligence (BI) tools and reporting tools are optimized for star schemas. Using a snowflake schema may require additional effort to integrate these tools effectively.

4. **End-User Understanding**: Snowflake schemas can be more challenging for end-users and business analysts to understand compared to star schemas, which are more intuitive and user-friendly.

In conclusion, the decision to use a snowflake schema or a star schema should be based on a careful analysis of your specific business requirements, data characteristics, and resource constraints. Both schema designs have their advantages and trade-offs, and the choice should align with your organization's goals for data warehousing and analytics.

**Entity-Relationship Diagram (ERD):**

![drawSQL-sql-export](https://github.com/ikhsannur1996/sample-datawarehouse/assets/32507742/3d951b0a-a228-477f-b2d4-f23c4884f094)


Here's a simplified ERD for the Data Warehouse and Data Mart using a snowflake schema:

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
     - author_id (Foreign Key)
     - genre_id (Foreign Key)
     - publication_year
     - publisher_id (Foreign Key)

   - `AuthorDim` (Dimension)
     - author_id (Primary Key)
     - author_name

   - `GenreDim` (Dimension)
     - genre_id (Primary Key)
     - genre_name

   - `PublisherDim` (Dimension)
     - publisher_id (Primary Key)
     - publisher_name

3. `CustomerDim` (Dimension)
     - customer_id (Primary Key)
     - customer_name
     - email
     - phone
     - address

4. `DateDim` (Dimension)
     - date_id (Primary Key)
     - date
     - day_of_week
     - month
     - quarter
     - year

**SQL Code:**

Below is sample SQL code to create the tables for the above snowflake schema:

```sql
-- Create Dimension Tables
CREATE TABLE AuthorDim (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255)
);

CREATE TABLE GenreDim (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(255)
);

CREATE TABLE PublisherDim (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(255)
);

-- Create BookDim table with foreign keys to AuthorDim, GenreDim, and PublisherDim
CREATE TABLE BookDim (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(255),
    author_id INT,
    genre_id INT,
    publication_year INT,
    publisher_id INT,
    FOREIGN KEY (author_id) REFERENCES AuthorDim(author_id),
    FOREIGN KEY (genre_id) REFERENCES GenreDim(genre_id),
    FOREIGN KEY (publisher_id) REFERENCES PublisherDim(publisher_id)
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

-- Create Fact Table with foreign keys to Dimension Tables
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

Below is some sample data for one fact table record and three dimension tables:

**AuthorDim Table Sample Data:**

| author_id | author_name       |
| --------- | ----------------- |
| 1         | F. Scott Fitzgerald |
| 2         | Harper Lee        |
| 3         | George Orwell     |

**GenreDim Table Sample Data:**

| genre_id | genre_name |
| -------- | ---------- |
| 1        | Fiction    |
| 2        | Mystery    |
| 3        | Science Fiction |

**PublisherDim Table Sample Data:**

| publisher_id | publisher_name |
| ----------- | -------------- |
| 1           | Scribner       |
| 2           | HarperCollins  |
| 3           | Penguin Books  |

**Sample Data for one BookDim Record:**

| book_id | book_title        | author_id | genre_id | publication_year | publisher_id |
| ------- | ----------------- | --------- | -------- | ----------------- | ------------ |
| 1       | The Great Gatsby  | 1         | 1        | 1925            | 1            |

**CustomerDim Table Sample Data:**

| customer_id | customer_name    | email                  | phone        | address                   |
| ----------- | ---------------- | ---------------------- | ------------ | -------------------------- |
| 101         | John Doe         | john.doe@example.com   | 123-456-7890 | 123 Main St, Anytown, USA |
| 102         | Jane Smith       | jane.smith@example.com | 987-654-3210 | 456 Elm St, Othertown, USA |
| 103         | Bob Johnson      | bob.j@example.com      | 555-123-4567 | 789 Oak St, Anothercity, USA |

**DateDim Table Sample Data:**

| date_id | date       | day_of_week | month      | quarter | year |
| ------- | ---------- | ----------- | ---------- | ------- | ---- |
| 1       | 2023-09-01 | Thursday    | September | Q3      | 2023 |
| 2       | 2023-09-02 | Friday      | September | Q3      | 2023 |
| 3       | 2023-09-03 | Saturday    | September | Q3      | 2023 |

**Sample Data for one SalesFact Record:**

| sales_id | book_id | customer_id | date_id | quantity_sold | total_sales_amount |
| -------- | ------- | ----------- | ------- | ------------- | ------------------ |
| 1        | 1       | 101         | 1       | 2             | 24.99              |

Please note that this is a simplified example with only a few records in each table. In a real-world scenario, you would populate these tables with a much larger dataset based on your actual business data.

**Sample Data for Dimension Tables:**

```sql
-- Insert data into AuthorDim
INSERT INTO AuthorDim (author_id, author_name)
VALUES
    (1, 'F. Scott Fitzgerald'),
    (2, 'Harper Lee'),
    (3, 'George Orwell');

-- Insert data into GenreDim
INSERT INTO GenreDim (genre_id, genre_name)
VALUES
    (1, 'Fiction'),
    (2, 'Mystery'),
    (3, 'Science Fiction');

-- Insert data into PublisherDim
INSERT INTO PublisherDim (publisher_id, publisher_name)
VALUES
    (1, 'Scribner'),
    (2, 'HarperCollins'),
    (3, 'Penguin Books');

-- Insert data into BookDim
INSERT INTO BookDim (book_id, book_title, author_id, genre_id, publication_year, publisher_id)
VALUES
    (1, 'The Great Gatsby', 1, 1, 1925, 1),
    (2, 'To Kill a Mockingbird', 2, 1, 1960, 2),
    (3, '1984', 3, 3, 1949, 3);

-- Insert data into CustomerDim
INSERT INTO CustomerDim (customer_id, customer_name, email, phone, address)
VALUES
    (101, 'John Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA'),
    (102, 'Jane Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St, Othertown, USA'),
    (103, 'Bob Johnson', 'bob.j@example.com', '555-123-4567', '789 Oak St, Anothercity, USA');

-- Insert data into DateDim
INSERT INTO DateDim (date_id, date, day_of_week, month, quarter, year)
VALUES
    (1, '2023-09-01', 'Thursday', 'September', 'Q3', 2023),
    (2, '2023-09-02', 'Friday', 'September', 'Q3', 2023),
    (3, '2023-09-03', 'Saturday', 'September', 'Q3', 2023);
```

**Sample Data for the Fact Table:**

```sql
-- Insert data into SalesFact
INSERT INTO SalesFact (sales_id, book_id, customer_id, date_id, quantity_sold, total_sales_amount)
VALUES
    (1, 1, 101, 1, 2, 24.99),
    (2, 2, 102, 2, 3, 34.99),
    (3, 3, 103, 3, 1, 14.99);
```

Please adjust the sample data according to your specific requirements and add more records as needed. In practice, you would typically load data from external sources, automate data integration, and handle larger datasets.

### Sample Datamart:

**Data Mart 1: Sales Analysis Data Mart**

*Business Case:*
The Sales Analysis Data Mart focuses on providing insights into the sales performance of books. It enables the sales and marketing teams to monitor sales trends, evaluate book performance, and make data-driven decisions to optimize sales strategies.

*Tables Included:*
1. `SalesFact`: Contains sales data, including the quantity sold and total sales amount.
2. `BookDim`: Provides details about books, including titles, authors, genres, and publishers.
3. `CustomerDim`: Contains customer information.
4. `DateDim`: Includes date-related information.

*Queries and Reports:*
- Monthly and quarterly sales reports.
- Bestselling books by month or quarter.
- Customer purchase history and segmentation.
- Sales performance by author, genre, or publisher.
- Trend analysis to identify seasonal variations in sales.

**Data Mart 2: Customer Insights Data Mart**

*Business Case:*
The Customer Insights Data Mart focuses on understanding customer behavior and preferences. It enables the marketing and customer service teams to tailor their strategies, improve customer satisfaction, and increase customer retention.

*Tables Included:*
1. `SalesFact`: Contains sales data, including the quantity sold and total sales amount.
2. `CustomerDim`: Contains customer information.
3. `BookDim`: Provides details about books, including titles, authors, genres, and publishers.
4. `DateDim`: Includes date-related information.

*Queries and Reports:*
- Customer segmentation based on purchase history.
- Customer lifetime value (CLV) analysis.
- Customer churn analysis to identify at-risk customers.
- Recommendations for books based on customer preferences.
- Personalized marketing campaigns targeting specific customer segments.

These Data Marts serve as focused subsets of the larger data warehouse, designed to meet the specific needs of different business units within the book store. They allow teams to extract meaningful insights and make informed decisions in their respective areas of operation.

Creating a Data Mart typically involves designing new tables, views, or indexes based on the specific business requirements of the mart. Below, I'll provide a simplified SQL code example for creating the two Data Marts mentioned earlier: the Sales Analysis Data Mart and the Customer Insights Data Mart. Please note that in a real-world scenario, Data Mart development would be more extensive and tailored to specific business needs.

**Sales Analysis Data Mart SQL Code:**

```sql
-- Create Sales Analysis Data Mart
-- This Data Mart focuses on sales analysis.

-- Create Sales Analysis Fact Table
CREATE TABLE SalesAnalysisFact AS
SELECT
    S.date_id,
    S.book_id,
    B.author_id,
    B.genre_id,
    B.publisher_id,
    D.year AS sale_year,
    D.month AS sale_month,
    SUM(S.quantity_sold) AS total_quantity_sold,
    SUM(S.total_sales_amount) AS total_sales_amount
FROM
    SalesFact S
JOIN
    BookDim B ON S.book_id = B.book_id
JOIN
    DateDim D ON S.date_id = D.date_id
GROUP BY
    S.date_id, S.book_id, B.author_id, B.genre_id, B.publisher_id, D.year, D.month;

-- Create views and indexes as needed for sales analysis queries.

-- Create Customer Segmentation Table (Sample)
CREATE TABLE CustomerSegmentation AS
SELECT
    C.customer_id,
    CASE
        WHEN CA.total_sales_amount >= 1000 THEN 'High Value'
        WHEN CA.total_sales_amount >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM
    CustomerDim C
JOIN
    (
        SELECT
            customer_id,
            SUM(total_sales_amount) AS total_sales_amount
        FROM
            SalesAnalysisFact
        GROUP BY
            customer_id
    ) CA ON C.customer_id = CA.customer_id;

-- Additional views and reports can be created as needed for sales analysis.

-- Create indexes for performance optimization.

-- Create stored procedures for generating reports.

```

**Customer Insights Data Mart SQL Code:**

```sql
-- Create Customer Insights Data Mart
-- This Data Mart focuses on customer insights.

-- Create Customer Behavior Fact Table
CREATE TABLE CustomerBehaviorFact AS
SELECT
    C.customer_id,
    B.genre_id,
    D.year AS sale_year,
    D.month AS sale_month,
    SUM(S.quantity_sold) AS total_quantity_sold,
    SUM(S.total_sales_amount) AS total_sales_amount
FROM
    SalesFact S
JOIN
    CustomerDim C ON S.customer_id = C.customer_id
JOIN
    BookDim B ON S.book_id = B.book_id
JOIN
    DateDim D ON S.date_id = D.date_id
GROUP BY
    C.customer_id, B.genre_id, D.year, D.month;

-- Create views and indexes as needed for customer insights queries.

-- Create Customer Segmentation Table (Sample)
CREATE TABLE CustomerSegmentation AS
SELECT
    customer_id,
    CASE
        WHEN total_quantity_sold >= 50 THEN 'Frequent Buyer'
        WHEN total_quantity_sold >= 20 THEN 'Regular Buyer'
        ELSE 'Occasional Buyer'
    END AS customer_segment
FROM
    CustomerBehaviorFact;

-- Additional views and reports can be created as needed for customer insights.

-- Create indexes for performance optimization.

-- Create stored procedures for generating reports.

```

These SQL code examples are simplified and serve as a starting point for creating Data Marts. In practice, you would tailor the Data Mart design and SQL code to match your specific business requirements, including the creation of appropriate views, indexes, and stored procedures for generating reports and insights.

## Additional - Create or Copy Table: DM_monthlysalestrends
This SQL operation focuses on the creation or duplication of a table named `DM_monthlysalestrends`. The objective is to either establish a new table with this name or replicate the data structure and content of an existing table known as `monthlysalestrends`. This process is designed to maintain data consistency and structure while offering flexibility in database management tasks.

**SQL Code:**

```sql
-- Create or Copy Table: DM_monthlysalestrends
-- Description: Create a new table or copy data into an existing table named DM_monthlysalestrends from the public.monthlysalestrends table.
-- This SQL statement ensures that the new table matches the structure and data of the source table.
CREATE TABLE IF NOT EXISTS public.DM_monthlysalestrends AS
SELECT * FROM public.monthlysalestrends;
```

**Usage Guidelines:**

- **Table Creation:** If the table `DM_monthlysalestrends` does not already exist, this SQL code will create it. It precisely mirrors the structure and content of the source table `public.monthlysalestrends`.

- **Table Duplication:** If the table `DM_monthlysalestrends` already exists, this SQL code will not recreate it. Instead, it will populate the existing table with data from `public.monthlysalestrends`. This is useful for maintaining backups or derived tables for analytical purposes.

- **Schema and Database:** The code assumes that both the source table `public.monthlysalestrends` and the destination table `DM_monthlysalestrends` reside in the same database and schema ("public"). Ensure that the appropriate database context is set before executing the code.

- **Data Consistency:** This operation preserves data integrity by copying all rows and columns from the source table. Any changes in the source table will be reflected in the destination table upon execution.

- **Error Handling:** The use of `CREATE TABLE IF NOT EXISTS` ensures that the code will not produce errors if the destination table already exists.

**Note:** Be cautious when using this code in production environments, as it can potentially overwrite or duplicate data. Always verify the database context and table names before executing the SQL statement.
