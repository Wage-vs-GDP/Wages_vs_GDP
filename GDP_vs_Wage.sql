--drop table avg_wage;
--drop table gdp;
--drop table country_code;

CREATE TABLE country_code (
    c_id INT   NOT NULL,
    code varchar(3)   NOT NULL,
    country varchar(100)   NOT NULL,
    CONSTRAINT pk_country_code PRIMARY KEY (
        c_id
     )
);
CREATE TABLE avg_wage (
    id serial   NOT NULL,
    c_id INT   NOT NULL,
    year INT   NOT NULL,
    avg_wage float,
    CONSTRAINT pk_avg_wage PRIMARY KEY (
        id
     )
);
CREATE TABLE gdp (
    id serial   NOT NULL,
    c_id INT   NOT NULL,
    year INT   NOT NULL,
    gdp float,
    CONSTRAINT pk_gdp PRIMARY KEY (
        id
     )
);

ALTER TABLE avg_wage ADD CONSTRAINT fk_avg_wage_c_id FOREIGN KEY(c_id)
REFERENCES country_code (c_id);
ALTER TABLE gdp ADD CONSTRAINT fk_gdp_c_id FOREIGN KEY(c_id)
REFERENCES country_code (c_id);


--test query
SELECT country_code.country, country_code.code, avg_wage.year, gdp, avg_wage, ((avg_wage/gdp)*100) AS div
FROM country_code
JOIN avg_wage ON country_code.c_id = avg_wage.c_id
JOIN gdp ON country_code.c_id = gdp.c_id
WHERE
gdp.year = avg_wage.year
and
gdp IS NOT NULL
and
avg_wage <= 45000
and
gdp.year = 1990
ORDER BY div desc;
