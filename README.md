# Fetch Rewards Coding Exercise - Analytics Engineer

## Project Overview:
This project contains the solution to the Fetch Rewards Coding Exercise. It includes SQL queries to answer business questions, data quality analysis, and a relational data model for better structuring the provided datasets.

## Project Structure:
- **/queries/**: Contains SQL queries to answer the business questions.
  - `query_1_top_5_brands.sql`: SQL query to find the top 5 brands by receipts scanned in the most recent month.
  - `query_2_top_spending_brand.sql`: SQL query to find the brand with the highest spend among users who joined in the last 6 months.
  - `query_3_top_transaction_brand.sql`: SQL query to find the brand with the most transactions among users who were created within the past 6 months.

- **/scripts/**: Contains the Python script for data quality checks.
  - `data_quality_checks.ipynb`: Jupyter notebook that checks for missing values, invalid data types, future dates, and duplicate records.

- **/documentation/**: Contains supporting documentation.
  - `data_model_diagram.pdf`: A relational data model diagram.
  - `data_quality_report.txt`: A summary of the data quality findings.
  - `communication_draft.txt`: A draft email communicating data quality issues.

- **/data/**: Sample data files used in this exercise.
  - `receipts_sample.json`: Sample receipts data.
  - `users_sample.json`: Sample users data.
  - `brands_sample.json`: Sample brands data.

## Instructions:

### 1. Running SQL Queries:
The SQL queries are provided in `/queries/`. You can run these queries using any MySQL-compatible database. Make sure to adjust table names if necessary.

### 2. Running Data Quality Checks:
To run the Python script for data quality checks:
```bash
python scripts/data_quality_checks.py
