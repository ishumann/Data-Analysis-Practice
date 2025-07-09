SELECT TOP 1 * FROM product_category_name_translation;

EXEC sp_rename 'product_category_name_translation.product_category_name_english', 'product_category_name', 'COLUMN';
EXEC sp_rename 'product_category_name_translation.column2', 'product_category_name_english', 'COLUMN';

delete FROM product_category_name_translation WHERE product_category_name = 'product_category_name';