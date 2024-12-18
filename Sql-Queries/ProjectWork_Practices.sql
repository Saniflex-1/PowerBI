USE ParliamentDB;

--order by
SELECT mp_name FROM MPs ORDER BY Mp_id DESC;
--offset
SELECT mp_name FROM MPs ORDER BY Mp_id DESC OFFSET 5 rows;
SELECT * FROM MPs;

--subquery confused
SELECT * FROM MPs as mp
CROSS APPLY (SELECT Constituency_name
from Constituencies c where mp.Constituency_id = c.Constituency_id) as p;

SELECT Constituency_name,count(*), MAX(region_id) as maxs 
FROM Constituencies GROUP BY Constituency_name order by maxs desc 
SELECT Party_name FROM PoliticalParties GROUP BY Party_id as partyname

SELECT * FROM Constituencies AS C
 cross JOIN MPs as mp --on c.Constituency_name = mp.Mp_code;
