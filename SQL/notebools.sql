SELECT * FROM notebooks

-- ¿Cuales son los tipos de CPU que tenemos en nuestros datos?
-- SELECT "cpu_processor", COUNT("cpu_processor") AS "cpus_counts" FROM notebooks GROUP BY "cpu_processor" HAVING COUNT("cpu_processor") > 9 ORDER BY COUNT("cpu_processor") DESC;
-- SELECT "cpu_processor", COUNT("cpu_processor") AS "cpus_counts" FROM notebooks WHERE "cpu_processor" IS NOT NULL GROUP BY "cpu_processor" ORDER BY COUNT("cpu_processor") DESC;
SELECT 
    CASE 
        WHEN cpu_processor LIKE '%i3%' THEN 'i3'
        WHEN cpu_processor LIKE '%i5%' THEN 'i5'
        WHEN cpu_processor LIKE '%i7%' THEN 'i7'
        WHEN cpu_processor LIKE '%i9%' THEN 'i9'
        ELSE 'Other'
    END AS cpu_category,
    COUNT(*) AS count
FROM notebooks
GROUP BY cpu_category;

-- Cuales son los sistemas operativos mas usados en las notebooks de nuestros datos?
SELECT "operating_system", COUNT("operating_system") as "OS_counts" FROM notebooks WHERE "operating_system" IS NOT NULL GROUP BY "operating_system" ORDER BY COUNT("operating_system") DESC;

-- ¿Que tamaños de pantalla posee las notebooks de nuestros datos?
SELECT "display_inch", COUNT("display_inch") as "display_types_counts" FROM notebooks WHERE "display_inch" IS NOT NULL GROUP BY "display_inch" ORDER BY COUNT("display_inch") DESC;

-- ¿Que tipos de GPU son mas usadas en las notebooks de nuestros datos?
SELECT "gpu_extra", COUNT("gpu_extra") as "gpus_count" FROM notebooks WHERE "gpu_extra" IS NOT NULL GROUP BY "gpu_extra" HAVING COUNT("gpu_extra") > 2 ORDER BY COUNT("gpu_extra") DESC;