ALTER TABLE Depot ALTER COLUMN PhoneNumber INT;

ALTER TABLE Depot 
ADD AddressID VARCHAR(255);

INSERT INTO Depot(DepotID, DepotNumber, DepotName, PhoneNumber, AddressID)
VALUES(304, 23, 'Kumasi', 0596038258, 203);

UPDATE Depot
SET DepotAddress = 'Sunyani- Fiapre'
WHERE DepotID = 304;

SELECT DepotID, DepotName FROM Depot
WHERE DepotID > 200;

SELECT * FROM Bus;

TRUNCATE TABLE Depot;

CREATE TABLE Bus(
ID INT PRIMARY KEY,
BusNumber INT,
BusName VARCHAR(200),
BusTypeID INT,
TrainDate DATE,
FOREIGN KEY (BusTypeID) REFERENCES Bus
);