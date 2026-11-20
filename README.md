# Online Store Data Analysis with SQL

[English](#english) | [فارسی](#فارسی)

---

## English

Hi, I'm Mohammadreza Aghebati, a marketing data analyst. This repo is a collection of SQL queries I wrote to practice SQL and to understand customer behavior. Each file answers one business question, like "Which age group spends the most?" or "Which customers might not come back?"

When the SQL part is done, I'll add Power BI dashboards and R analyses to this repo too.

### Important note about the data

The data in this repo is **fictional**. It was generated with the help of AI and is not taken from a real store or real customers. Any similarity to real people is a coincidence.

### Using the code

You are free to use these queries for learning and practice. If you have feedback, suggestions or a better way to write any query, I'd really like to hear it. Open an issue or message me on LinkedIn. It helps me improve and I'd be glad to know the work is useful to someone.

### Data

All queries run on one table called `customer_orders`. The table structure and the data are in `schema_00.sql`.

- 100 orders, from January to April 2025
- Order status: Completed, Returned or Cancelled
- Payment method: online gateway, wallet or card-to-card
- Amounts are in Iranian rial

### Files

All files are in the `01-sql-projects` folder.

| File | What it looks at |
|------|------------------|
| `schema_00.sql` | Creates the table and inserts the data |
| `demographic_segmentation_01.sql` | Groups customers by age and gender, then compares revenue, revenue share and discount use |
| `basket_segmentation_02.sql` | Groups orders by basket size (single item, regular, large) and shows each group's share of revenue |
| `customer_order_history_03.sql` | Purchase history per customer: lifetime value, days between orders, change in value on the second order, and customers at risk of leaving |
| `monthly_sales_summary_04.sql` | Number of orders, net revenue and average order value for each month |

### Results

Monthly sales summary (Completed orders only; net revenue = order amount minus discount):

| Month | Orders | Net revenue (rial) | Avg. order value (rial) |
|-------|--------|--------------------|-------------------------|
| January | 18 | 1,019,000,000 | 56,611,111 |
| February | 22 | 1,143,500,000 | 51,977,273 |
| March | 26 | 1,571,000,000 | 60,423,077 |
| April | 22 | 1,345,000,000 | 61,136,364 |

- March had the highest sales.
- April sales dropped compared to March, but April had the highest average order value.
- Out of 100 orders, 88 were Completed, 6 Returned and 6 Cancelled.
- Only 6 customers bought more than once, so a cohort (retention) analysis doesn't mean much on this data.

### How to run

1. Create a database in SQL Server.
2. Run `schema_00.sql` first to create the table and load the data.
3. Run the other files in any order. One note: `demographic_segmentation_01.sql` creates a new table called `customer_demographics`, so running it a second time gives an error unless you drop that table first.

### SQL techniques used

`CTE`, `CASE`, `JOIN`, `GROUP BY`, window functions (`ROW_NUMBER`, `LAG`, `DENSE_RANK`, `SUM() OVER`), `DATEDIFF`, `DATEFROMPARTS`, and `NULLIF` to avoid dividing by zero.

### What's next

- Month-over-month sales growth
- Payment method analysis and return/cancel rates
- RFM segmentation
- Power BI dashboard
- Analysis in R

### Tools

SQL Server (T-SQL), Power BI, R

### Contact

Mohammadreza Aghebati
[LinkedIn](https://www.linkedin.com/in/mohammadreza-aghebati/)

---

<div dir="rtl">

## فارسی

سلام، من محمدرضا عاقبتی هستم، تحلیلگر داده بازاریابی. این ریپو مجموعه کوئری‌هایی هست که برای تمرین SQL و تحلیل رفتار مشتری نوشتم. هر فایل یک سؤال تجاری مشخص رو جواب می‌ده، مثلاً «کدوم گروه سنی بیشترین خرید رو داره؟» یا «کدوم مشتری‌ها ممکنه دیگه برنگردن؟».

بعد از تموم شدن بخش SQL، داشبوردهای Power BI و تحلیل‌های R هم به همین ریپو اضافه می‌شن.

### نکته مهم درباره داده‌ها

داده‌های این ریپو **فرضی** هستن و با کمک هوش مصنوعی ساخته شدن. این داده‌ها از یک فروشگاه یا مشتری واقعی گرفته نشدن و هر شباهتی به افراد واقعی اتفاقی است.

### استفاده از کدها

استفاده از این کدها برای آموزش و تمرین آزاد و بلامانعه. اگه نظر، پیشنهاد یا روش بهتری برای نوشتن هر کوئری داری، خوشحال می‌شم بشنوم. می‌تونی یک Issue باز کنی یا توی لینکدین بهم پیام بدی. این کار به بهتر شدنم کمک می‌کنه و برام خوشاینده بدونم کارم برای کسی مفید بوده.

### داده

همه کوئری‌ها روی یک جدول به اسم `customer_orders` اجرا می‌شن. ساختار جدول و داده‌هاش توی فایل `schema_00.sql` هست.

- ۱۰۰ سفارش، از ژانویه تا آوریل ۲۰۲۵
- وضعیت سفارش: Completed، Returned یا Cancelled
- روش پرداخت: درگاه آنلاین، کیف پول یا کارت به کارت
- مبلغ‌ها به ریال هستن

### فایل‌ها

همه فایل‌ها توی پوشه `01-sql-projects` هستن.

| فایل | چی رو بررسی می‌کنه |
|------|--------------------|
| `schema_00.sql` | ساخت جدول و وارد کردن داده‌ها |
| `demographic_segmentation_01.sql` | دسته‌بندی مشتری‌ها بر اساس سن و جنسیت و مقایسه درآمد، سهم فروش و میزان استفاده از تخفیف |
| `basket_segmentation_02.sql` | دسته‌بندی سفارش‌ها بر اساس تعداد اقلام سبد (تک‌محصولی، متداول، حجیم) و سهم هر دسته از درآمد |
| `customer_order_history_03.sql` | تاریخچه خرید هر مشتری: ارزش کل، فاصله بین خریدها، تغییر مبلغ خرید دوم، و تشخیص مشتری‌های در خطر ریزش |
| `monthly_sales_summary_04.sql` | تعداد سفارش، درآمد خالص و میانگین ارزش سفارش در هر ماه |

### نتیجه‌ها

خلاصه فروش ماهانه (فقط سفارش‌های Completed، درآمد خالص یعنی مبلغ سفارش منهای تخفیف):

| ماه | تعداد سفارش | درآمد خالص (ریال) | میانگین هر سفارش (ریال) |
|-----|-------------|-------------------|-------------------------|
| ژانویه | ۱۸ | ۱٬۰۱۹٬۰۰۰٬۰۰۰ | ۵۶٬۶۱۱٬۱۱۱ |
| فوریه | ۲۲ | ۱٬۱۴۳٬۵۰۰٬۰۰۰ | ۵۱٬۹۷۷٬۲۷۳ |
| مارس | ۲۶ | ۱٬۵۷۱٬۰۰۰٬۰۰۰ | ۶۰٬۴۲۳٬۰۷۷ |
| آوریل | ۲۲ | ۱٬۳۴۵٬۰۰۰٬۰۰۰ | ۶۱٬۱۳۶٬۳۶۴ |

- بیشترین فروش مربوط به مارس بود.
- فروش آوریل کمتر از مارس شد، ولی میانگین ارزش هر سفارش در آوریل بالاترین بود.
- از ۱۰۰ سفارش، ۸۸ تا Completed بودن، ۶ تا Returned و ۶ تا Cancelled.
- فقط ۶ مشتری بیشتر از یک بار خرید کردن، برای همین تحلیل بازگشت مشتری (Cohort) روی این داده معنی‌دار نیست.

### نحوه اجرا

1. توی SQL Server یک دیتابیس بساز.
2. اول `schema_00.sql` رو اجرا کن تا جدول و داده‌ها ساخته بشن.
3. بقیه فایل‌ها رو به هر ترتیبی می‌تونی اجرا کنی. فقط `demographic_segmentation_01.sql` یک جدول جدید به اسم `customer_demographics` می‌سازه، پس اجرای دوبارش بدون پاک کردن اون جدول خطا می‌ده.

### تکنیک‌هایی که استفاده شده

`CTE`، `CASE`، `JOIN`، `GROUP BY`، توابع پنجره‌ای (`ROW_NUMBER`، `LAG`، `DENSE_RANK`، `SUM() OVER`)، `DATEDIFF`، `DATEFROMPARTS` و `NULLIF` برای جلوگیری از تقسیم بر صفر.

### قدم‌های بعدی

- رشد ماه به ماه فروش
- تحلیل روش‌های پرداخت و نرخ مرجوعی و لغو
- بخش‌بندی RFM
- داشبورد Power BI
- تحلیل با R

### ابزارها

SQL Server (T-SQL)، Power BI، R

### ارتباط با من

محمدرضا عاقبتی
[لینکدین](https://www.linkedin.com/in/mohammadreza-aghebati/)

</div>
