SELECT 
  COUNT(DISTINCT listing_id) as units,
  room_type,
  active,
  month_date,
  SUM(revenue) as revenue_by_type,
  SUM(unavailable_days) as nn,
  SUM(
    CASE WHEN active = TRUE
    THEN available_days
    ELSE 0
    END
  ) as free,
  (CASE WHEN active = TRUE THEN (SUM(unavailable_days)/(SUM(unavailable_days)+SUM(CASE WHEN active = TRUE THEN available_days ELSE 0 END)))ELSE 0 END) as occupancy_rate,
  ROUND (CASE WHEN active = TRUE THEN (SUM(revenue)* (SUM(unavailable_days)/(SUM(unavailable_days)+SUM(CASE WHEN active = TRUE THEN available_days ELSE 0 END))))ELSE 0 END) as revpar
FROM `airbnb-projects-502210.airbnb_projects.london_listings_monthly`
WHERE active = TRUE
GROUP BY room_type, month_date, active
