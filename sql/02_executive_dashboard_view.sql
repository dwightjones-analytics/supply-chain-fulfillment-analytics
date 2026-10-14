-- View: public.vw_executive_dashboard

-- DROP VIEW public.vw_executive_dashboard;

CREATE OR REPLACE VIEW public.vw_executive_dashboard
 AS
 WITH order_financials AS (
         SELECT order_items.order_id,
            count(*) AS item_count,
            count(DISTINCT order_items.product_id) AS unique_products,
            count(DISTINCT order_items.seller_id) AS seller_count,
            sum(order_items.price) AS order_product_value,
            sum(order_items.freight_value) AS order_freight_value
           FROM order_items
          GROUP BY order_items.order_id
        )
 SELECT o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_purchase_timestamp::date AS purchase_date,
    o.delivery_performance,
    o.delivery_variance_days,
    o.approval_hours,
    o.approval_to_carrier_hours,
    o.carrier_to_customer_hours,
    c.customer_state,
    c.customer_city,
    COALESCE(f.item_count, 0::bigint) AS item_count,
    COALESCE(f.unique_products, 0::bigint) AS unique_products,
    COALESCE(f.seller_count, 0::bigint) AS seller_count,
    COALESCE(f.order_product_value, 0::numeric) AS order_product_value,
    COALESCE(f.order_freight_value, 0::numeric) AS order_freight_value
   FROM vw_order_performance o
     LEFT JOIN order_financials f ON o.order_id::text = f.order_id::text
     LEFT JOIN customers c ON o.customer_id::text = c.customer_id::text;

ALTER TABLE public.vw_executive_dashboard
    OWNER TO postgres;

