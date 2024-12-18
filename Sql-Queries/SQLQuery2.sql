--CREATING OF DEPOT TABLECREATE TABLE Depot (    DepotID INT IDENTITY(1,1) PRIMARY KEY,    DepotNumber INT,    DepotName VARCHAR(100),    DepotAddress VARCHAR(255));--CREATING OF BUS TABLECREATE TABLE Bus (    BusID INT IDENTITY(1,1) PRIMARY KEY,    BusRegNo VARCHAR(100),    ModelNo VARCHAR(100),    DepotID INT,	FOREIGN KEY (DepotID) REFERENCES Depot(DepotID) ON DELETE CASCADE);--INSERTING INTO DEPOTINSERT INTO Depot(DepotNumber, DepotName, DepotAddress)VALUES(2, 'Bantaman', 'AC-24'),	(3, 'Akweiman', 'AC-25')--INSERTING INTO BUS TABLEINSERT INTO Bus(BusRegNo, ModelNo, DepotID)VALUES('GN124', 'Benz124', 2),	  ('GN125', 'Volvo125', 3)--DELETING FROM TABLEDELETE FROM Depot WHERE DepotID = 1;--UPDATING TABLEUPDATE Depot SET DepotName = 'ADEISO' WHERE DepotID = 2;SELECT * FROM Depot;