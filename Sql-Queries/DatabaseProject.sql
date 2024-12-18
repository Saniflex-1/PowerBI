-- Create table for regions
CREATE TABLE Regions (
    Region_id INT IDENTITY(1,1) PRIMARY KEY,
    Region_name VARCHAR(100) NOT NULL
);

-- Create table for constituencies
CREATE TABLE Constituencies (
    Constituency_id INT IDENTITY(1,1) PRIMARY KEY,
    Constituency_name VARCHAR(100) NOT NULL,
    Region_id INT,
    FOREIGN KEY (region_id) REFERENCES Regions(region_id) ON DELETE CASCADE
);

-- Create table for political parties
CREATE TABLE PoliticalParties (
    Party_id INT IDENTITY(1,1) PRIMARY KEY,
    Party_name VARCHAR(100) NOT NULL
);

-- Create table for MPs
CREATE TABLE MPs (
    Mp_id INT IDENTITY(1,1) PRIMARY KEY,
    Mp_code VARCHAR(20) UNIQUE NOT NULL,
    Mp_name VARCHAR(100) NOT NULL,
    Date_elected DATE,
    Constituency_id INT,
    Party_id INT,
    FOREIGN KEY (constituency_id) REFERENCES Constituencies(constituency_id)
	ON DELETE CASCADE,
    FOREIGN KEY (party_id) REFERENCES PoliticalParties(party_id) 
	ON DELETE CASCADE
);

-- Create table for bills
CREATE TABLE Bills (
    Bill_id INT IDENTITY(1,1) PRIMARY KEY,
    Bill_name VARCHAR(100) NOT NULL,
    Bill_date DATE NOT NULL,
    Bill_status VARCHAR(3) 
	CHECK (Bill_status IN ('yes', 'no')) DEFAULT 'no',
    Sponsor VARCHAR(100)
);



-- Create table for votes
CREATE TABLE Votes (
    Vote_id INT IDENTITY(1,1) PRIMARY KEY,
    Mp_id INT,
    Bill_id INT,
    Vote VARCHAR(10)
	CHECK (Vote IN ('Yes', 'No', 'abstain', 'absent')),
    FOREIGN KEY (Mp_id) REFERENCES MPs(mp_id) ON DELETE CASCADE,
    FOREIGN KEY (bill_id) REFERENCES Bills(bill_id) ON DELETE CASCADE
);
--TABLE CREATION ENDING



--INSERTING INTO TABLES

--INSERTING INTO REGIONS
INSERT INTO Regions (region_name) VALUES
('Greater Accra'),
('Ashanti'),
('Western'),
('Eastern'),
('Volta'),
('Central'),
('Northern'),
('Bono'),
('Upper East'),
('Upper West');

--Insert 10 Records into the Constituencies Table
INSERT INTO Constituencies (constituency_name, region_id) VALUES
('Ayawaso West', 1),      -- Greater Accra
('Manhyia South', 2),     -- Ashanti
('Sekondi', 3),           -- Western
('New Juaben South', 4),  -- Eastern
('Ho Central', 5),        -- Volta
('Cape Coast South', 6),  -- Central
('Tamale Central', 7),    -- Northern
('Sunyani West', 8),      -- Bono
('Bolgatanga Central', 9),-- Upper East
('Wa Central', 10);       -- Upper West

--Insert 10 Records into the PoliticalParties Table
INSERT INTO PoliticalParties (party_name) VALUES
('NPP'),
('NDC'),
('CPP'),
('PNC'),
('PPP'),
('GCPP'),
('APC'),
('LPG'),
('PNP'),
('Independents');

--Query to update Party name
SELECT * FROM PoliticalParties
UPDATE PoliticalParties
SET Party_name = 'NDC'
where Party_id = 6



--Insert 10 Records into the MPs Table
INSERT INTO MPs (mp_code, mp_name, constituency_id, date_elected, party_id)
VALUES
('MP001', 'Rene Kofi Annan', 1, '2024-12-07', 1),   -- NPP
('MP002', 'Michael Barcelona', 2, '2024-12-07', 2), -- NDC
('MP003', 'Mark Kofi Annan', 3, '2024-12-07', 3),-- CPP
('MP004', 'Bright Aryee', 4, '2024-12-07', 4),-- PNC
('MP005', 'Felix Owusu', 5, '2024-12-07', 5), -- PPP
('MP006', 'Owusu William', 6, '2024-12-07', 6),  -- GCPP
('MP007', 'Eliza Badu', 7, '2024-12-07', 7), -- APC
('MP008', 'Alhaji Forge', 8, '2024-12-07', 8),   -- LPG
('MP009', 'Rachael Reps', 9, '2024-12-07', 9),-- PNP
('MP010', 'Manubea Admin', 10, '2024-12-07', NULL);-- Independent

-- Insert 10 Records into the Bills Table
INSERT INTO Bills (bill_name, bill_date, bill_status, sponsor) VALUES
('24hour Economy', '2024-05-01', 'Yes', 'Ministry of Youth and Economy'),
('Health Insurance Bill', '2024-06-15', 'yes', 'Ministry of Health'),
('Bet Reform Bill', '2024-07-10', 'no', 'Ministry of Finance'),
('1D1F', '2024-08-20', 'no', 'Ministry of Agriculture'),
('E-Levy Reform Bill', '2024-09-05', 'no', 'Ministry of Finance'),
('Public Safety Bill', '2024-09-18', 'no', 'Ministry of Interior'),
('Housing Policy Bill', '2024-09-28', 'yes', 'Ministry of Works and Housing'),
('Youth Employment Bill', '2024-10-05', 'no', 'Ministry of Youth and Sports'),
('Infrastructure Bill', '2024-10-15', 'yes', 'Ministry of Roads and Highways'),
('Tourism Development Bill', '2024-10-20', 'no', 'Ministry of Tourism');


--Insert 10 Records into the Votes Table
--Making sure that the mp_id and bill_id values 
--match those in the MPs and Bills tables.
-- Votes for Education Reform Bill
INSERT INTO Votes (mp_id, bill_id, vote) VALUES
(1, 1, 'yes'),
(2, 1, 'no'),
(3, 1, 'abstain'),
(4, 1, 'yes'),
(5, 1, 'no'),
(6, 1, 'abstain'),
(7, 1, 'yes'),
(8, 1, 'yes'),
(9, 1, 'no'),
(10, 1, 'absent');

-- Votes for Health Insurance Bill
INSERT INTO Votes (mp_id, bill_id, vote) VALUES
(1, 8, 'yes'),
(2, 8, 'yes'),
(3, 8, 'no'),
(4, 8, 'abstain'),
(5, 8, 'yes'),
(6, 8, 'yes'),
(7, 8, 'no'),
(8, 8, 'yes'),
(9, 8, 'abstain'),
(10, 8, 'absent');
--TABLE INSERTING ENDING



--CREATION OF SUBPROGRAMS

--CREATING PROCEDURE TO STORE VOTES
CREATE PROCEDURE dbo.getvotes (@votes VARCHAR(10) = null)
AS
IF @votes IS NULL 
	SELECT * FROM Votes;
ELSE 
	SELECT * FROM Votes
	WHERE Vote = @votes;
EXEcute dbo.getvotes 'yes';

--CHECKING MAJORITY VOTE
 CREATE FUNCTION fn_checkbillstatus(@Bill_ID INT)
 RETURNS VARCHAR(20)
 AS
 BEGIN 
	DECLARE @YesVote INT;
	DECLARE @TotalVote INT;
	DECLARE @Status VARCHAR(20)

	--let us count the vote that is yes
	SELECT @YesVote = COUNT(*)
	FROM Votes where Bill_id = @Bill_ID AND vote = 'yes';

	--let select total vote
	SELECT @TotalVote = COUNT(*)
	FROM Votes WHERE Bill_id = @Bill_ID and vote in ('yes', 'no')

	--checking
	if @YesVote > (@TotalVote/2)
		SET @Status = 'YES, Bill Passed';
	ELSE
		SET @Status = 'Bill Failled';
	return @status;
END;

SELECT dbo.fn_checkbillstatus(9) Bill_Status;


--PROCEDURE TO ADD NEW BILL
CREATE PROCEDURE AddNewbill
    @Bill_name VARCHAR(255), 
    @Bill_date DATE, 
    @Sponsor VARCHAR(200),
	@Bill_status varchar(200)
AS
BEGIN
    -- Check if status is allowed
    IF @Bill_status NOT IN ('approved', 'rejected', 'pending') 
    BEGIN
        PRINT 'Error: Status must be one of ''approved'', ''rejected'', or ''pending''.';
        RETURN;
    END

    -- Inserting new bill
    INSERT INTO Bills (Bill_name, Bill_date, Bill_status, Sponsor)
    VALUES (@Bill_name, @Bill_date, 'pending', @Sponsor);
END;

-- Execute the procedure with example values
EXEC dbo.AddNewbill
    @Bill_name = 'Digitalization Bill', 
    @Bill_date = '2024-10-12', 
	@Bill_status = 'pending',
    @Sponsor = 'Ministry of Communication';



--This function return mp's details and the bill they voted on
drop function fn_BillVotingResultwithmpname
CREATE FUNCTION fn_BillVotingResultwithmpname (@Bill_ID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT mps.Mp_code, mps.Mp_name, B.Bill_ID, B.Bill_Name, R.Region_name,
           SUM(CASE WHEN V.Vote = 'yes' THEN 1 ELSE 0 END) AS YesVotes,
           SUM(CASE WHEN V.Vote = 'no' THEN 1 ELSE 0 END) AS NoVotes
    FROM Bills B
    JOIN Votes V ON B.Bill_ID = V.Bill_ID
    JOIN MPs ON V.Mp_id = MPs.Mp_id
    JOIN Constituencies C ON MPs.Constituency_ID = C.Constituency_ID
    JOIN Regions R ON C.Region_ID = R.Region_ID
    WHERE B.Bill_ID = 2
    GROUP BY mps.Mp_code, mps.Mp_name, B.Bill_ID, B.Bill_Name, R.Region_name
);


 SELECT * FROM View_MP_BillVotes where Mp_code = 'mp001';
 
 
	select * from Bills;
--CREATING OF VIEWS FOR ALL PM's WITH POLITICAL PARTY
CREATE VIEW vgetMpPartyDetails AS
SELECT Mp_id, Mp_code, Mp_name, Party_name, Constituency_name 
FROM MPs as MP
JOIN PoliticalParties AS PP ON mp.Party_id = pp.Party_id
JOIN Constituencies AS CC on mp.Constituency_id = cc.Constituency_id;

SELECT * FROM vgetMpPartyDetails --WHERE Party_name = ('PNP');



--CREATING VIEW TO GET ALL DETAILS FROM THE MP WITH A PARTY OR WITHOUR PARTY
CREATE VIEW vGetAllMpsDetail AS
SELECT * FROM MPs as mp
CROSS APPLY (SELECT Constituency_name, Region_name
from Constituencies c 
JOIN Regions as R on c.Region_id = r.Region_id 
where mp.Constituency_id = c.Constituency_id) as p;

SELECT * FROM vGetAllMpsDetail



--This view joins MPVote, MP, Bill, Constituency, and PoliticalParty 
--to show each MP's vote on each bill. It includes details like constituency 
--and party for context.
CREATE VIEW View_MP_BillVotes AS
SELECT V.Bill_id, B.Bill_name, B.Bill_date, MPs.Mp_code, Mps.Mp_name, 
       C.Constituency_name, PP.Party_name, V.Vote
FROM Votes V
JOIN MPs ON V.Mp_id = MPs.Mp_id
JOIN Bills B ON V.Bill_id = B.Bill_id
JOIN Constituencies C ON MPs.Constituency_id = C.Constituency_id
LEFT JOIN PoliticalParties PP ON MPs.Party_id = PP.Party_id;

SELECT * FROM View_MP_BillVotes where vote = 'yes';



--This view groups MPVote data by BillID and RegionName, 
--showing the count of "yes" and "no" votes per region for each bill
CREATE VIEW vView_Bill_VotingResults_ByRegion AS
SELECT B.Bill_ID, B.Bill_Name, mps.Mp_name, r.Region_name,
       SUM(CASE WHEN V.Vote = 'yes' THEN 1 ELSE 0 END) AS YesVotes,
       SUM(CASE WHEN V.Vote = 'no' THEN 1 ELSE 0 END) AS NoVotes
FROM Bills B
JOIN Votes V ON B.Bill_ID = V.Bill_ID
JOIN MPs ON V.Mp_id = MPs.Mp_id
JOIN Constituencies C ON MPs.Constituency_ID = C.Constituency_ID
JOIN Regions R ON C.Region_ID = R.Region_ID
GROUP BY B.Bill_ID, B.Bill_Name, R.Region_id, R.Region_name, mps.Mp_name;

SELECT * FROM vView_Bill_VotingResults_ByRegion



--function to handle the above view
CREATE FUNCTION fn_BillVotingResultsByRegion (@Bill_ID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT B.Bill_ID, B.Bill_Name, R.Region_name,
           SUM(CASE WHEN V.Vote = 'yes' THEN 1 ELSE 0 END) AS YesVotes,
           SUM(CASE WHEN V.Vote = 'no' THEN 1 ELSE 0 END) AS NoVotes
    FROM Bills B
    JOIN Votes V ON B.Bill_ID = V.Bill_ID
    JOIN MPs ON V.Mp_id = MPs.Mp_id
    JOIN Constituencies C ON MPs.Constituency_ID = C.Constituency_ID
    JOIN Regions R ON C.Region_ID = R.Region_ID
    WHERE B.Bill_ID = @Bill_ID
    GROUP BY B.Bill_ID, B.Bill_Name, R.Region_name
);
 SELECT * FROM fn_BillVotingResultsByRegion(1)


 
 --FUNCTION TO HANDLE bill vote with detail
SELECT count(Vote), Bill_name NumberOfVote  
FROM fn_BillVotesWithDetails(2) where vote = 'yes';


---check for billsdeatails
CREATE PROCEDURE dbo.getbillsdetails (@bills VARCHAR(255) = null)
AS
IF @bills IS NULL 
	SELECT * FROM Bills;
ELSE 
	SELECT * FROM Bills
	WHERE Bill_status = @bills;
EXEcute dbo.getbillsdetails 'no';


