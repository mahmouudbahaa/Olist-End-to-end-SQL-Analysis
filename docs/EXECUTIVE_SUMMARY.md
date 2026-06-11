# 📈 Executive Results Report

Data-driven findings extracted directly from advanced T-SQL analytics executed against the warehouse layer.

---

## 🌐 High-Level Commercial KPIs

The marketplace demonstrates substantial operational scale across both revenue generation and transaction volume.

| KPI | Value |
|------|------:|
| Total Revenue Generated | $14.80M |
| Total Customer Orders | 102K |
| Products Sold | 112.6K |
| Average Revenue per Order | $142.17 |
| Average Items per Order | 1.14 |

### Key Insight

The platform successfully processed over **102,000 customer orders**, generating nearly **$15 million in total revenue** while maintaining a relatively stable basket size.

---

## 📦 Strategic Price Distribution Analysis

Advanced percentile analysis reveals a marketplace dominated by affordable retail products with a smaller segment of premium inventory.

| Statistical Metric | Value |
|-------------------|-------:|
| Minimum Price | $0.85 |
| Maximum Price | $6,735.00 |
| Average Price | $120.65 |
| Median Price | $74.99 |

### Key Insight

The large gap between the **average price ($120.65)** and the **median price ($74.99)** indicates a heavily right-skewed distribution.

Most transactions occur within low-to-mid price ranges, while a limited number of luxury purchases significantly increase the overall average.

---

## 🚚 Logistics Performance & Supply Chain Analysis

### Delivery Performance Metrics

| Metric | Value |
|----------|------:|
| Average Delivery Time | 12.5 Days |
| Delayed Delivery Rate | 6.5% |
| Average Delay Duration | 11.5 Days |

### Key Insight

While the majority of deliveries meet customer expectations, delayed shipments experience significant overruns that negatively affect customer satisfaction.

---

## ⭐ Customer Satisfaction vs Delivery Delays

Cross-analysis between review scores and delivery performance reveals a direct operational impact on customer experience.

| Review Score | Average Delivery Delay |
|-------------|-----------------------:|
| ⭐ 1 Star | 3.88 Days |
| ⭐⭐ 2 Stars | 1.83 Days |
| ⭐⭐⭐ 3 Stars | 0.95 Days |
| ⭐⭐⭐⭐ 4 Stars | 0.38 Days |
| ⭐⭐⭐⭐⭐ 5 Stars | 0.13 Days |

### Strategic Insight

Customers leaving **1-star reviews experience delays nearly 30 times greater** than customers providing **5-star reviews**.

Delivery performance emerges as one of the strongest drivers of customer satisfaction and retention.

---

## 🗺️ Highest Delay Shipping Routes

The most severe fulfillment bottlenecks are concentrated across long-distance routes originating from major southeastern logistics hubs.

| Origin State | Destination State | Average Delay |
|-------------|-------------------|--------------:|
| SP | AP | 14.5 Days |
| RJ | AM | 11.2 Days |
| SP | RR | 10.8 Days |

### Key Insight

Remote northern regions consistently experience the highest delivery latency, highlighting opportunities for logistics network optimization.

---

## 📅 Revenue Growth & Seasonality Trends

Historical Month-over-Month (MoM) analysis using SQL window functions (`LAG()` and `LEAD()`) reveals strong marketplace growth.

### Growth Highlights

- Marketplace operations began with approximately **$49.5K** monthly revenue in October 2016.
- Monthly revenue exceeded **$1.1M** during late 2017 and early 2018.
- Seasonal demand spikes were heavily influenced by year-end shopping behavior.
- Post-holiday sales stabilized at levels approximately **23% higher year-over-year**.

### Key Insight

The platform achieved rapid growth while maintaining healthy post-seasonal revenue retention.

---

## 💳 Payment Method Utilization

Consumer purchasing behavior demonstrates a strong reliance on installment-based financing options.

| Payment Method | Share of Orders |
|---------------|----------------:|
| Credit Card | 75.4% |
| Boleto | 19.4% |
| Voucher & Debit Card | 5.2% |

### Key Insight

Credit cards dominate the marketplace payment ecosystem, accounting for more than three-quarters of all transactions, while Boleto remains an important option for cash-oriented customer segments.

---

## 🎯 Executive Conclusions

### Revenue & Growth
- Generated approximately **$14.8M** in total revenue.
- Sustained strong year-over-year growth.
- Successfully scaled beyond **$1M monthly revenue**.

### Customer Experience
- Delivery speed strongly influences review scores.
- Logistics delays are a leading indicator of customer dissatisfaction.

### Supply Chain
- Northern shipping routes experience the largest delays.
- Significant opportunity exists for regional fulfillment optimization.

### Commercial Operations
- Revenue is primarily driven by affordable products sold at scale.
- Consumer purchasing behavior is heavily dependent on credit card financing.

