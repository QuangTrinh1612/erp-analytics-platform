SELECT 
    -- Purchase Order Header Information
    poh.po_header_id AS po_header_id,
    poh.segment1 AS po_number, -- Purchase Order Number
    poh.vendor_id AS supplier_id,
    poh.vendor_site_id AS supplier_site_id,
    poh.agent_id AS buyer_id,
    
    -- TO CHECK
    -- poh.order_date AS order_date,
    -- poh.closed_code AS po_status,
    -- poh.org_id AS organization_id,

    -- Purchase Order Line Information
    pol.po_line_id AS po_line_id,
    pol.line_num AS line_number,
    pol.item_id AS item_id,
    pol.item_description AS item_description,
    pol.unit_price AS unit_price,
    pol.quantity AS quantity,
    pol.uom_code AS uom_code, -- Unit of Measure
    pol.line_type_id AS line_type_id,

    -- Calculated Fields
    pol.quantity * pol.unit_price AS line_total_amount,

    -- Date Fields
    pol.creation_date AS line_creation_date,
    pol.last_update_date AS last_update_date

FROM {{ ref("purchase_order_header") }} poh
JOIN {{ ref("purchase_order_line") }} pol
    ON poh.po_header_id = pol.po_header_id;