# Retail & Warehouse Sales Analysis (Liquor, Beer, Wine)
## SQL Engineering • Data Cleaning • Sales Analysis • PowerPoint Visual Summary
# 1. Overview
This project walks through a full SQL‑driven workflow for cleaning, engineering, and analyzing retail and warehouse sales data across three major alcohol categories: Liquor, Beer, and Wine. The goal of this analysis was to determine which category sold the most across both retail and warehouse channels, and then break that down further by each category’s performance within each channel. The results were surprisingly insightful.

If you run this dataset through a programming language like R or Python, you won’t need as many preprocessing steps — you can clean and analyze almost immediately. But if you choose to work in SQL, as I did, you’ll want to follow the load_wh_rt_sales.sql file to properly load and prepare the data.
Everything in this repository is designed to be transparent, reproducible, and easy for others to follow.

# 2. Tools Used
- MySQL or a similar database application
- Excel
- PowerPoint


# 3. Data Cleaning & Engineering
The raw sales data needed several fixes before it could be analyzed — mainly because the dataset came from Kaggle, where most users cleaned it using Python (pandas). Since I’m not fully comfortable with Python yet, and I currently use R only for NFL analytics, I chose to tackle this project entirely in SQL to sharpen my engineering skills. I didn’t realize how many challenges I’d run into, but honestly, working through them taught me a lot and made the project even more rewarding.
Because SQL doesn’t automatically handle messy CSVs the way Python or R does, the cleaning and loading process became a crucial part of the workflow. If you’re following along, make sure to use the files in this repository exactly as written.

## Key Cleaning Steps
### Handled inconsistent delimiters
- Some rows used commas, others used tabs, and a few had mixed delimiters. These had to be standardized before loading.
### Removed BOM and encoding artifacts
- The raw file included hidden characters that prevented SQL from reading the data cleanly.
### Standardized column names and data types
- Ensured all numeric fields were actually numeric, and all text fields were consistent and readable.
### Validated and corrected malformed values
- A few rows contained unexpected characters or formatting issues that needed to be fixed before analysis.
### Created the final clean table
- wh_and_rt_sales_clean.sql
- This table is the foundation for all analysis in the project.
## Reproducibility
All cleaning logic is stored in load_wh_rt_sales.sql, which walks through the entire process step‑by‑step. Anyone using SQL can follow the same workflow and recreate the exact dataset I used for analysis.

# 4. Analysis
Once the dataset was fully cleaned and loaded into SQL, I moved into the analysis phase. The goal was straightforward: identify which category (Liquor, Beer, or Wine) sold the most across both retail and warehouse channels. From there, I decided to break the results down even further by analyzing each category within each individual channel.
Because everything was done in SQL, the analysis is intentionally clear, readable, and easy for anyone to rerun. My focus was on writing simple, reproducible queries that anyone could follow — especially after the amount of work it took just to get the dataset loaded properly.

## Core Questions Answered
### 1. Which category sold the most overall?
- I aggregated total sales across both retail and warehouse channels to determine the top‑performing category.
### 2. How do retail and warehouse sales compare?
- Retail and warehouse behave very differently in this dataset, so I broke out each category by channel to see where the volume was coming from.
### 3. Which category dominates each channel?
- Instead of just looking at totals, I analyzed:
• 	Liquor retail vs. liquor warehouse
• 	Beer retail vs. beer warehouse
• 	Wine retail vs. wine warehouse
This made it easy to see which categories rely more heavily on warehouse distribution versus retail storefronts.

## SQL‑Driven Approach
All analysis was performed using straightforward SQL patterns such as:
- SUM() for total sales
- GROUP BY() for category and channel comparisons
- ORDER BY to rank performance
- WHERE to filter to categories or channels
- Once the data was cleaned, the analysis became simple and straightforward.

## High‑Level Findings
The SQL analysis revealed several clear patterns in how Liquor, Beer, and Wine perform across retail and warehouse channels:
- Beer was the top‑selling category overall, consistently outperforming Liquor and Wine when retail and warehouse sales were combined.
- Warehouse sales drive the majority of total volume, with Beer leading the way — but retail still shows meaningful differences between categories that aren’t obvious until you break the data apart.
- Each category behaves differently across channels, creating distinct performance profiles that become much clearer once retail and warehouse sales are separated.
Together, these findings set up the visual summary in the next section, where the patterns become even easier to interpret.

# 5. Visual Summary
After completing the SQL analysis, I created a short PowerPoint visual summary to highlight the key findings in a clean, business‑friendly format. I didn’t want to overwhelm the viewer with a wall of charts, so each slide focuses on one category at a time, pairing the numbers with a simple visual and the exact SQL query used to generate it. This makes the patterns in the data — especially the differences between retail and warehouse sales across Liquor, Beer, and Wine — easy to see and easy to trust.
The visuals translate the SQL results into something that can be understood at a glance, whether you’re a hiring manager, an analyst, or someone casually exploring the dataset.

## What the Visuals Include
### Category Comparison Chart
- A simple bar chart showing total sales for Liquor, Beer, and Wine combined across both channels.
- This makes it immediately clear which category leads overall.
### Retail vs. Warehouse Breakdown
- Side‑by‑side visuals comparing each category’s performance in retail vs. warehouse.
- This highlights how differently each category behaves depending on the channel.
### Key Takeaways Slide
- A concise summary of the most important insights from the analysis.
- Designed to stand on its own for quick review.

## Purpose of the Deck
The slide deck serves as a quick, polished way to communicate the results without requiring someone to read through SQL queries or raw tables.

# 6. Conclusion
This project was a great blend of SQL engineering, data cleaning, and sales analysis and it pushed me to solve problems I didn’t expect when I first downloaded the dataset. Working with messy CSVs in SQL forced me to slow down, troubleshoot, and really understand the structure of the data before I could analyze anything. It ended up being one of the most valuable parts of the entire workflow.
Once the data was cleaned, the analysis became straightforward and revealed clear patterns in how Liquor, Beer, and Wine perform across retail and warehouse channels. Beer emerged as the top‑selling category overall, and the channel‑level breakdowns showed just how differently each category behaves depending on where it’s sold.

The final PowerPoint visuals helped translate those findings into a clean, business‑friendly format that mirrors how analysts present insights in real‑world settings.
Overall, this project strengthened my SQL skills, improved my ability to work with imperfect data, and gave me a chance to communicate insights in a way that’s both technical and accessible. Everything in this repository is built to be reproducible, transparent, and easy for others to follow — whether you’re learning SQL, exploring the dataset, or reviewing this as part of my portfolio.

# 7. Repository Structure

| Folder / File | Purpose | Key Contents |
|---------------|---------|--------------|
| `data/` | Raw dataset that must be loaded properly before cleaning | `Warehouse_and_Retail_Sales.csv` |
| `excel/` | Final Excel workbook containing 10 analysis tabs (retail, warehouse, totals, supporting tables) | `Retail, Warehouse, and Total Sales of WBL.xlsx` |
| `sql/` | Full SQL pipeline: loading, cleaning, and analysis queries | `load_wh_rt_sales.sql`, `cleaning_wh_rt_sales.sql`, `questions_wh_rt_sales.sql` |
| `visuals/` | All project visuals, organized into subfolders | — |
|   `visuals/powerpoint/` | Full PowerPoint case study summarizing workflow, analysis, and insights | `Sales Analysis of WBL.pptx` |
|   `visuals/chartvisuals/` | All PNG chart exports used in the PowerPoint deck | `Retail_Beer_Sales.png`, `Retail_Liquor_Sales.png`, `Retail_Wine_Sales.png`, `Retail_Sales_by_Item_Type.png`, `Total_Sales_by_Category.png`, `Beer_Warehouse_Sales.png`, `Liquor_Warehouse_Sales.png`, `Warehouse_Sales_by_Item_Type.png`, `Warehouse_Sales_by_Item_Type_v2.png` |
|   `visuals/excelvisuals/` | Excel‑exported tables used for analysis | `beer_rt_sales_table.png`, `beer_wh_sales_table.png`, `liquor_rt_sales_table.png`, `liquor_wh_sales_table.png`, `wine_rt_sales_table.png`, `wine_wh_sales_table.png`, `retail_sales_table.png`, `total_sales_table.png`, `warehouse_sales_table.png` |
| `README.md` | Full project documentation & overview | — |

# 8. Data Source

This project uses a publicly available dataset originally shared on Kaggle by **[Sahir Maharaj]**.  
All cleaning, transformation, validation, and pipeline engineering were performed by me.
The dataset was used solely for educational and portfolio purposes.  
No modifications were made to the original raw files beyond cleaning and preprocessing steps documented in this repository.
