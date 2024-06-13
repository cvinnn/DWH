CREATE VIEW Dim_Users AS
SELECT
    uuid AS user_id,
    name,
    email,
    role,
    status
FROM
    users;

CREATE VIEW Dim_Product AS
SELECT
    ItemID AS product_id,
    `Nama Product` AS name,
    Price AS price,
    CategoryID AS category_id,
    Description AS description,
    Stock AS stock
FROM
    Product;

CREATE VIEW Dim_Shipping AS
SELECT
    uuid AS shipping_id,
    user_id,
    alamat,
    kota,
    provinsi,
    negara,
    kode_pos,
    nomor_telepon
FROM
    Shipping;

CREATE VIEW Dim_Category AS
SELECT
    Category_id AS category_id,
    Category_Name AS category_name
FROM
    Category;

CREATE VIEW Fact_Transaction AS
SELECT
    t.uuid AS transaction_id,
    t.shipping_uuid AS shipping_id,
    s.user_id,
    t.total_amount,
    t.payment_type,
    t.transaction_date
FROM
    transaction t
JOIN
    Shipping s ON t.shipping_uuid = s.uuid;

CREATE VIEW Fact_Transaction_Detail AS
SELECT
    d.id AS detail_id,
    d.trxid AS transaction_id,
    d.item AS product_id,
    d.qty AS quantity,
    d.subtotal
FROM
    transaction_detail d;


CREATE VIEW Sales_DataMart AS
SELECT
    f.transaction_id,
    u.name AS user_name,
    u.email AS user_email,
    p.name AS product_name,
    p.price AS product_price,
    c.category_name,
    s.kota,
    s.provinsi,
    f.total_amount,
    f.payment_type,
    f.transaction_date,
    d.quantity,
    d.subtotal
FROM
    Fact_Transaction f
JOIN
    Dim_Users u ON f.user_id = u.user_id
JOIN
    Fact_Transaction_Detail d ON f.transaction_id = d.transaction_id
JOIN
    Dim_Product p ON d.product_id = p.product_id
JOIN
    Dim_Category c ON p.category_id = c.category_id
JOIN
    Dim_Shipping s ON f.shipping_id = s.shipping_id;
