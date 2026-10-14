-- View: public.vw_order_performance

-- DROP VIEW public.vw_order_performance;

CREATE OR REPLACE VIEW public.vw_order_performance
 AS
 SELECT order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
        CASE
            WHEN order_status::text = 'delivered'::text AND order_delivered_customer_date IS NOT NULL AND order_estimated_delivery_date IS NOT NULL AND order_delivered_customer_date::date <= order_estimated_delivery_date::date THEN 'On Time'::text
            WHEN order_status::text = 'delivered'::text AND order_delivered_customer_date IS NOT NULL AND order_estimated_delivery_date IS NOT NULL AND order_delivered_customer_date::date > order_estimated_delivery_date::date THEN 'Late'::text
            ELSE 'Not Evaluated'::text
        END AS delivery_performance,
        CASE
            WHEN order_status::text = 'delivered'::text AND order_delivered_customer_date IS NOT NULL AND order_estimated_delivery_date IS NOT NULL THEN order_delivered_customer_date::date - order_estimated_delivery_date::date
            ELSE NULL::integer
        END AS delivery_variance_days,
    round(EXTRACT(epoch FROM order_approved_at - order_purchase_timestamp) / 3600::numeric, 2) AS approval_hours,
    round(EXTRACT(epoch FROM order_delivered_carrier_date - order_approved_at) / 3600::numeric, 2) AS approval_to_carrier_hours,
    round(EXTRACT(epoch FROM order_delivered_customer_date - order_delivered_carrier_date) / 3600::numeric, 2) AS carrier_to_customer_hours
   FROM orders;

ALTER TABLE public.vw_order_performance
    OWNER TO postgres;

