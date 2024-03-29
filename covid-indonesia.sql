-- Jumlah total kasus Covid-19 aktif yang baru di setiap provinsi berdasarkan jumlah kasus yang paling besar
SELECT
  Province,
  SUM(New_Active_Cases) AS total_kasus_aktif_baru
FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
WHERE 
  Province IS NOT NULL
GROUP BY 
  Province
ORDER BY 
  total_kasus_aktif_baru DESC;

-- 2 (dua) location iso code yang memiliki jumlah total kematian karena Covid-19 paling sedikit
SELECT 
  Location_ISO_Code, 
  SUM(Total_Deaths) AS total_kematian
FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
GROUP BY 
  Location_ISO_Code
ORDER BY 
  total_kematian
LIMIT 2;

-- Data tentang tanggal-tanggal ketika rate kasus recovered di Indonesia paling tinggi beserta jumlah ratenya
SELECT 
  Date, 
  Case_Recovered_Rate AS total_pulih
FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
WHERE 
  Location = 'Indonesia'
AND 
  Case_Recovered_Rate = (
    SELECT 
      MAX(Case_Recovered_Rate) 
    FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
    WHERE 
      Location = 'Indonesia');

-- Total case fatality rate dan case recovered rate dari masing-masing location iso code dari data yang paling rendah
SELECT
  Location_ISO_Code,
  AVG(CAST(Case_Fatality_Rate AS FLOAT64)) AS avg_case_fatality_rate,
  AVG(CAST(Case_Recovered_Rate AS FLOAT64)) AS avg_case_recovered_rate
FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
GROUP BY
  Location_ISO_Code
ORDER BY
  avg_case_fatality_rate, avg_case_recovered_rate;

-- Data tentang tanggal-tanggal saat total kasus Covid-19 mulai menyentuh angka 30.000-an
SELECT 
  Date,
  SUM(Total_Cases) AS total_kasus
FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
GROUP BY 
  Date
HAVING 
  total_kasus >= 30000;

-- Jumlah data yang tercatat ketika kasus Covid-19 lebih dari atau sama dengan 30.000
SELECT 
  COUNT(1) as total
FROM `trim-airfoil-353314.demo.kasus_covid19_indonesia`
HAVING 
  total >= 30000;