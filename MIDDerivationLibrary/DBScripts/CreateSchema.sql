IF NOT EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA
WHERE   SCHEMA_NAME = 'Master' )
BEGIN
    EXEC sp_executesql N'CREATE SCHEMA Master'
END