-- =====================================================
-- AML Credit Card Fraud Detection Project
-- SQL Analysis File
-- Author: Your Name
-- =====================================================

-- =====================================================
-- 1. View First 10 Records
-- =====================================================

SELECT *
FROM creditcard
LIMIT 10;

-- =====================================================
-- 2. Total Number of Transactions
-- =====================================================

SELECT COUNT(*) AS total_transactions
FROM creditcard;

-- =====================================================
-- 3. Total Fraud Transactions
-- =====================================================

SELECT COUNT(*) AS fraud_transactions
FROM creditcard
WHERE Class = 1;

-- =====================================================
-- 4. Total Genuine Transactions
-- =====================================================

SELECT COUNT(*) AS genuine_transactions
FROM creditcard
WHERE Class = 0;

-- =====================================================
-- 5. Fraud Percentage
-- =====================================================

SELECT
COUNT(CASE WHEN Class = 1 THEN 1 END) * 100.0 / COUNT(*)
AS fraud_percentage
FROM creditcard;

-- =====================================================
-- 6. Total Fraud Amount
-- =====================================================

SELECT
SUM(Amount) AS total_fraud_amount
FROM creditcard
WHERE Class = 1;

-- =====================================================
-- 7. Average Fraud Transaction Amount
-- =====================================================

SELECT
AVG(Amount) AS avg_fraud_amount
FROM creditcard
WHERE Class = 1;

-- =====================================================
-- 8. Top 10 Highest Fraud Transactions
-- =====================================================

SELECT *
FROM creditcard
WHERE Class = 1
ORDER BY Amount DESC
LIMIT 10;

-- =====================================================
-- 9. High Risk Transactions (Amount > 2000)
-- =====================================================

SELECT *
FROM creditcard
WHERE Amount > 2000
ORDER BY Amount DESC;

-- =====================================================
-- 10. Create Risk Level Column
-- =====================================================

SELECT *,
CASE
WHEN Class = 1 THEN 'High Risk'
WHEN Amount > 2000 THEN 'Medium Risk'
ELSE 'Low Risk'
END AS risk_level
FROM creditcard;

-- =====================================================
-- 11. Count Transactions by Risk Level
-- =====================================================

SELECT
CASE
WHEN Class = 1 THEN 'High Risk'
WHEN Amount > 2000 THEN 'Medium Risk'
ELSE 'Low Risk'
END AS risk_level,
COUNT(*) AS total_count
FROM creditcard
GROUP BY risk_level
ORDER BY total_count DESC;

-- =====================================================
-- 12. Fraud Transactions Above Average Fraud Amount
-- =====================================================

SELECT *
FROM creditcard
WHERE Class = 1
AND Amount > (
SELECT AVG(Amount)
FROM creditcard
WHERE Class = 1
);

-- =====================================================
-- 13. Fraud Trend by Hour
-- =====================================================

SELECT
FLOOR(Time / 3600) AS hour,
COUNT(*) AS fraud_count
FROM creditcard
WHERE Class = 1
GROUP BY hour
ORDER BY hour;

-- =====================================================
-- 14. Create View for Fraud Monitoring
-- =====================================================

CREATE VIEW fraud_monitoring AS

SELECT
Time,
Amount,
Class,

CASE
WHEN Class = 1 THEN 'Fraud'
ELSE 'Genuine'
END AS transaction_type,

CASE
WHEN Class = 1 THEN 'High Risk'
WHEN Amount > 2000 THEN 'Medium Risk'
ELSE 'Low Risk'
END AS risk_level

FROM creditcard;

-- =====================================================
-- 15. View Fraud Monitoring Table
-- =====================================================

SELECT *
FROM fraud_monitoring;

-- =====================================================
-- END OF FILE
-- =====================================================
