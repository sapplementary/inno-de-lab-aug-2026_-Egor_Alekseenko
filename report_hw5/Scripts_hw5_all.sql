-- action 1
--Загруженность по дню недели и части времени (утро, день, вечер)
SELECT
    d.day_of_week,
    t.time_of_day_segment,
    COUNT(*)                     AS total_reservations,
    SUM(f.guests_count)          AS total_guests,
    ROUND(AVG(f.guests_count), 1) AS avg_guests_per_booking
FROM Fact_reservation f
JOIN Dim_Date         d ON f.date_key_visit = d.date_key
JOIN Dim_time         t ON f.time_key_visit = t.time_key
WHERE f.is_cancelled = FALSE
GROUP BY d.day_of_week, t.time_of_day_segment
ORDER BY total_reservations DESC;


--action 2
--Топ клиентов по количеству завершённых визитов
SELECT
    c.full_name,
    c.email,
    COUNT(*)                            AS completed_visits,
    SUM(f.guests_count)                 AS total_guests_brought,
    ROUND(AVG(f.duration_minutes), 0)   AS avg_visit_duration_min
FROM Fact_reservation f
JOIN Dim_customer     c ON f.customer_key = c.customer_key
JOIN Dim_Status       s ON f.status_key   = s.status_key
WHERE s.status_name = 'Completed'
GROUP BY c.customer_key, c.full_name, c.email
ORDER BY completed_visits DESC
LIMIT 10;


-- action 3
-- Ежемесячная динамика бронирований (по году визита)
SELECT
    d.year,
    d.month,
    COUNT(*)                     AS total_reservations,
    SUM(f.guests_count)          AS total_guests,
    SUM(CASE WHEN f.is_cancelled THEN 1 ELSE 0 END) AS cancelled,
    SUM(COUNT(*)) OVER (
        PARTITION BY d.year
        ORDER BY d.month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    )                            AS running_total_year
FROM Fact_reservation f
JOIN Dim_Date         d ON f.date_key_visit = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- action 4
-- Разница в трафике в не праздники и праздники
SELECT
    CASE
        WHEN d.is_holiday THEN 'Holiday'
        WHEN d.is_weekend THEN 'Weekend'
        ELSE 'Weekday'
    END                              AS day_type,
    COUNT(*)                         AS total_reservations,
    SUM(f.guests_count)              AS total_guests,
    ROUND(AVG(f.guests_count), 1)    AS avg_guests_per_booking,
    ROUND(AVG(f.waiting_time_minutes), 1) AS avg_wait_min
FROM Fact_reservation f
JOIN Dim_Date         d ON f.date_key_visit = d.date_key
WHERE f.is_cancelled = FALSE
GROUP BY day_type
ORDER BY total_reservations DESC;



