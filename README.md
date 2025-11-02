# 🚲 SQL Analysis of Bike Sales

## 📚 Table of Contents
- **Project Overview**
- **Data Overview**
- **Structure Explanation**
- **How to Run**
- **Sample Queries**
- **Technical Details**
- **Author**

## 🔎 Project Overview

<p style="text-align:justify;">
The goal of this project is to analyze bike sales across different countries. The project focuses on sales revenue in every country, customer age distribution and product performance. 

The project is centred around [SQL_Analysis_of_bike_sales.ipynb](SQL_Analysis_of_bike_sales.ipynb) file, which can be run using Google Colab, Jupyter Notebook or VS Code (with the required extensions). It includes everything you need — from importing the **SQLite** database to running SQL analysis scripts.

Either way, you can view the project here (*note: you can't make any changes to the code before downloading it to your own Google Drive*) ⟶ [GDrive](https://colab.research.google.com/drive/1-lBUfiiWdffZX2V6LjN0bZKobtMGEEUZ?usp=sharing)
</p>

## 📂 Data Overview

The dataset consists **one CSV file**:

- `Sales.csv` – contains order date, customer age, gender, country, product type, price etc.


**Data source:** [Kaggle Bike Sales Dataset](https://www.kaggle.com/datasets/sadiqshah/bike-sales-in-europe)



## 🧱 Structure Explanation

| Folder / File | Description |
|----------------|-------------|
| **Sales.csv** | Contains original data file |
| **SQL_Analysis_of_bike_sales.ipynb** | .ipynb file used for analysis |
| **Visualization/** | Excel file (downloaded from Google Sheets) used to visualize analysis |
| **README.md** | Project overview 

---

## ⚙️ How to Run

1. Download the entire folder
2. Install Jupyter Notebook, VS Code (with the required extensions) or upload the folder to your Google Drive
3. Run first cell in **SQL_Analysis_of_bike_sales.ipynb** file❗

In the **Google Colab** case, make sure to change this part of the code located in the first cell (if your path of the folder is different):

 `path = '/content/drive/MyDrive/Colab Notebooks/SQL Analysis of bike sales/Sales.csv'`




## 📈 Sample Queries

### Number of Orders - age distribution by gender

**Query:** *1.1. Number of Orders (including quantity of each order) - age distribution by gender*

**Visualization:**

![Top Scorers by Decade](Visualization/images/Number_of_Orders_-_age_distribution_by_gender.png)

**Insights:**

<p style="text-align:justify;">
    Two major age groups take a clear lead in ordering the most bikes and other related products - Young Professionals (age between 25-34) and Early Adults (age between 35-44). Cycling is most popular among these 2 groups, likely because people around that age are reaching the peak of their careers (followed by financial stability), while still being young and physically active. 

In almost all groups men tend to order more than women. 
</p>

### Number of orders for every country for each season

**Query:** *2.1 Number of orders for every country for each season*

**Visualization:**

![Number of orders](Visualization/images/Number_of_Orders_country_distribution.png)

**Insights:**

<p style="text-align:justify;">

All six countries show a similar order distribution across the seasons. Most sales occur in spring and winter, while the least take place in summer and autumn. The majority of sales were made in the USA (34.68%), then in Australia (21.18%). Canada and the UK have almost the same percantage of total orderds 
(around 12%), as do France and Germany (around 10%).
</p>


## 🖥️ Technical Details

- **Database:** SQLite
- **Environment:** Google Colab
- **Visualization:** Google Sheets
- **Data source:** [Kaggle Bike Sales Dataset](https://www.kaggle.com/datasets/sadiqshah/bike-sales-in-europe)


## ✒️ Author

- **Author:** Mateusz Bochenek
- **Mail:** matbochenek42@gmail.com
- **GitHub link:** https://github.com/matbochenek42
- **LeetCode link:** https://leetcode.com/u/SmO7BWmsiz/