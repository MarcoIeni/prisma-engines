SELECT
	tc.table_schema AS namespace,
	tc.table_name AS table_name,
	tc.constraint_name AS constraint_name,
	CAST(LOWER(LEFT(tc.constraint_type, 1)) AS CHAR) AS constraint_type,
	cc.check_clause AS constraint_definition,
	CASE 
		WHEN tc.enforced = 'YES' THEN true
		ELSE false
	END AS is_enforced
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
LEFT JOIN INFORMATION_SCHEMA.CHECK_CONSTRAINTS cc
	ON cc.constraint_schema = tc.table_schema
	AND cc.constraint_name = tc.constraint_name
WHERE constraint_type IN ('CHECK')
ORDER BY namespace, table_name, constraint_type, constraint_name;
