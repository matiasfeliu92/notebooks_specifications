-- Active: 1713402156237@@postgresql-matiasmazparrotefeliu.alwaysdata.net@5432@matiasmazparrotefeliu_etl_data_practise@public

--ANALIZAMOS LOS PRIMEROS 15 REGISTROS DE LOS DATOS, CON SUS COLUMNAS Y TIPO DE DATO
SELECT * FROM notebooks LIMIT 10

--¿CON CUANTOS REGISTROS CONTAMOS PARA EL ANALISIS?
SELECT COUNT(*) FROM notebooks

--¿QUE TIPO DE DATO POSEEN LAS COLUMNAS DE LA TABLA?
SELECT
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'notebooks'
    AND table_schema = 'public'; 

--AGREGAMOS UNA COLUMNA BRAND, PARA LISTAR LAS MARCAS DE LAS NOTEBOOKS QUE ESTAN EN LOS DATOS
ALTER TABLE notebooks ADD COLUMN brand VARCHAR;

--ACTUALIZAMOS LA COLUMNA NUEVA DE BRAND, TOMANDO DEL NOMBRE DE CADA UNA, EL PRIMER SUBSTRING QUE SE CORRESPONDE CON LA MARCA DE CADA NOTEBOOK
UPDATE notebooks
SET brand = split_part(name, ' ', 1);

--SEGUN LAS MARCAS QUE TENEMOS EN LA COLUMNA BRAND, ANALIZAMOS EL CONTEO DE NOTEBOOKS POR CADA UNA DE LAS MARCAS
SELECT brand, COUNT(name) from notebooks GROUP BY brand ORDER BY COUNT(name) DESC

--ANALIZAMOS EL CONTEO DE NOTEBOOKS POR CADA UNA DE LAS MARCAS, TOMANDO LOS VALORES DE CONTEO MAYORES QUE 100 EN ESTE CASO
SELECT brand, COUNT(name) from notebooks GROUP BY brand HAVING COUNT(name) > 100 ORDER BY COUNT(name) DESC

--ANALIZAMOS LOS VALORES UNICOS DE LAS COLUMNAS DE cpu_processor Y gpu_integrated
SELECT DISTINCT(cpu_processor) FROM notebooks

SELECT DISTINCT(gpu_integrated) FROM notebooks

--¿CUAL ES LA CPU QUE MAS PREDOMINA EN LAS NOTEBOOKS?
SELECT
    CASE
        WHEN name ILIKE '%intel%' OR name ILIKE '%Intel%' OR gpu_integrated ILIKE '%intel%' OR gpu_integrated ILIKE '%Intel%' THEN 'Intel'
        WHEN name ILIKE '%amd%' OR name ILIKE '%AMD%' OR name ILIKE '%Amd%' OR gpu_integrated ILIKE '%amd%' OR gpu_integrated ILIKE '%AMD%' OR gpu_integrated ILIKE '%Amd%' THEN 'AMD'
        WHEN name ILIKE '%apple%' OR name ILIKE '%Apple%' OR gpu_integrated ILIKE '%apple%' OR gpu_integrated ILIKE '%Apple%' THEN 'Apple'
        ELSE 'Other'
    END AS cpu_brand,
    COUNT(*) AS brand_count
FROM notebooks
GROUP BY
    CASE
        WHEN name ILIKE '%intel%' OR name ILIKE '%Intel%' OR gpu_integrated ILIKE '%intel%' OR gpu_integrated ILIKE '%Intel%' THEN 'Intel'
        WHEN name ILIKE '%amd%' OR name ILIKE '%AMD%' OR name ILIKE '%Amd%' OR gpu_integrated ILIKE '%amd%' OR gpu_integrated ILIKE '%AMD%' OR gpu_integrated ILIKE '%Amd%' THEN 'AMD'
        WHEN name ILIKE '%apple%' OR name ILIKE '%Apple%' OR gpu_integrated ILIKE '%apple%' OR gpu_integrated ILIKE '%Apple%' THEN 'Apple'
        ELSE 'Other'
    END
ORDER BY brand_count DESC;


SELECT DISTINCT(operating_system) FROM notebooks
--¿CUAL ES EL SISTEMA OPERATIVO QUE MAS PREDOMINA EN LAS NOTEBOOKS?
SELECT
    CASE
        WHEN operating_system ILIKE '%Windows 11%' THEN 'Windows 11'
        WHEN operating_system ILIKE '%Windows 10%' THEN 'Windows 10'
        WHEN operating_system ILIKE '%macOS%' THEN 'macOS'
        WHEN operating_system ILIKE '%FreeDOS%' THEN 'FreeDOS'
        WHEN operating_system ILIKE '%Chrome OS%' THEN 'Chrome OS'
        WHEN operating_system ILIKE '%Linux%' THEN 'Linux'
        ELSE 'Other'
    END AS OS,
    COUNT(*) AS OS_count
FROM notebooks
GROUP BY
    CASE
        WHEN operating_system ILIKE '%Windows 11%' THEN 'Windows 11'
        WHEN operating_system ILIKE '%Windows 10%' THEN 'Windows 10'
        WHEN operating_system ILIKE '%macOS%' THEN 'macOS'
        WHEN operating_system ILIKE '%FreeDOS%' THEN 'FreeDOS'
        WHEN operating_system ILIKE '%Chrome OS%' THEN 'Chrome OS'
        WHEN operating_system ILIKE '%Linux%' THEN 'Linux'
        ELSE 'Other'
    END
ORDER BY OS_count DESC;

-- ¿Que tamaños de pantalla posee las notebooks de nuestros datos?
SELECT "display_inch", COUNT("display_inch") as "display_types_counts" FROM notebooks WHERE "display_inch" IS NOT NULL GROUP BY "display_inch" ORDER BY COUNT("display_inch") DESC;

SELECT DISTINCT(gpu_extra) FROM notebooks
-- ¿Que tipos de GPU son mas usadas en las notebooks de nuestros datos?
SELECT
    CASE
        WHEN gpu_extra ILIKE '%NVIDIA%' THEN 'Nvidia'
        WHEN gpu_extra ILIKE '%AMD%' THEN 'AMD'
        ELSE 'Other'
    END AS gpus,
    COUNT(*) AS gpus_count
FROM notebooks
GROUP BY
    CASE
        WHEN gpu_extra ILIKE '%NVIDIA%' THEN 'Nvidia'
        WHEN gpu_extra ILIKE '%AMD%' THEN 'AMD'
        ELSE 'Other'
    END
ORDER BY gpus_count DESC;