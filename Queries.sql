---Query to return the count of incidents and total victims grouped by the type of weapon, sorted by the number of incidents in descending order:
SELECT 
  CASE 
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%semiautomatic%' THEN 'Semiautomatic'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%handgun%' THEN 'Handgun'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%rifle%' THEN 'Rifle'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%shotgun%' THEN 'Shotgun'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%revolver%' THEN 'Revolver'
    ELSE w.WEAPON_TYPE
  END AS WEAPON_TYPE,
  COUNT(*) as INCIDENTS,
  SUM(e.TOTAL_VICTIMS) as TOTAL_VICTIMS
FROM WEAPON w
JOIN EVENT e ON w.CASE_ID = e.CASE_ID
GROUP BY 
  CASE 
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%semiautomatic%' THEN 'Semiautomatic'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%handgun%' THEN 'Handgun'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%rifle%' THEN 'Rifle'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%shotgun%' THEN 'Shotgun'
    WHEN LOWER(w.WEAPON_TYPE) LIKE '%revolver%' THEN 'Revolver'
    ELSE w.WEAPON_TYPE
  END
ORDER BY INCIDENTS DESC;

---Query to return the case name, date, age at shooting, legality of the weapon, and state for each incident where the target was a school, sorted by age at shooting:
SELECT e.CASE_NAME, e.CASE_DATE, p.AGE_AT_SHOOTING, w.LEGALLY_OBTAINED, l.STATE
FROM EVENT e
JOIN PERSON p ON e.CASE_ID = p.CASE_ID
JOIN WEAPON w ON e.CASE_ID = w.CASE_ID
JOIN LOCATION l ON e.CASE_ID = l.CASE_ID
WHERE e.TARGET LIKE '%school%' OR e.TARGET LIKE '%School%'
ORDER BY p.AGE_AT_SHOOTING;

---Query to examine the relationship between the shooter's mental health and the percentage of incidents where the weapon was obtained legally:
SELECT 
  COUNT(*) AS Total_Shootings,
  SUM(CASE WHEN p."PRIOR_MENTAL_HEALTH_COMPLICATIONS" = 'Yes' AND w.LEGALLY_OBTAINED = 'Yes' THEN 1 ELSE 0 END) AS Legal_Gun_Mental_Health_Issues,
  ROUND((SUM(CASE WHEN p."PRIOR_MENTAL_HEALTH_COMPLICATIONS" = 'Yes' AND w.LEGALLY_OBTAINED = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS Percentage
FROM EVENT e
JOIN PERSON p ON e.Case_Id = p.Case_Id
JOIN WEAPON w ON e.Case_Id = w.Case_Id;

---Query to return the number of shootings by gender of the shooter:
SELECT p.GENDER, COUNT(*) as num_shootings
FROM PERSON p
JOIN EVENT e ON p.CASE_ID = e.CASE_ID
GROUP BY p.GENDER
ORDER BY num_shootings DESC;

---Query to return the average age of the shooter grouped by gender:
SELECT p.GENDER, AVG(p.AGE_AT_SHOOTING) as avg_age
FROM PERSON p
JOIN EVENT e ON p.CASE_ID = e.CASE_ID
GROUP BY p.GENDER
ORDER BY avg_age DESC;
