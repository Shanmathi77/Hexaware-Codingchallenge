CREATE database PET
USE PET

-- Create the Pets table
CREATE TABLE Pets (
    PetID INT PRIMARY KEY, 
    Pet_Name VARCHAR(20) NOT NULL, 
    Pet_Age INT,
    Pet_Breed VARCHAR(20),
    Pet_Type VARCHAR(20),
    AvailableForAdoption BIT, -
    OwnerID INT,
	ShelterID INT, -- Foreign key reference to Shelters table
    CONSTRAINT FK_Pets_Shelters FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID))
	
	
    

-- Create the Shelters table
CREATE TABLE Shelters (
    ShelterID INT PRIMARY KEY, 
    Shelter_Name VARCHAR(20) NOT NULL, 
    Shelter_Location VARCHAR(20)
);

-- Create the Donations table
CREATE TABLE Donations (
    DonationID INT PRIMARY KEY, 
    Donor_Name VARCHAR(20) NOT NULL,
    DonationType VARCHAR(20), 
    Donation_Item VARCHAR(20), 
    DonationDate DATETIME,
    DonationAmount DECIMAL(10, 2)
);

-- Create the Adoption_Events table
CREATE TABLE Adoption_Events (
    EventID INT PRIMARY KEY, 
    EventName VARCHAR(20) NOT NULL,
    EventDate DATETIME, 
    Event_Location VARCHAR(20),
    ShelterID INT, -- Foreign key reference to Shelters table
    CONSTRAINT FK_Adoption_Events_Shelters FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
);

-- Create the Participants table
CREATE TABLE Participants (
    ParticipantID INT PRIMARY KEY, 
    ParticipantName VARCHAR(20) NOT NULL, 
    ParticipantType VARCHAR(20),  
    EventID INT,
    CONSTRAINT FK_Participants_Events FOREIGN KEY (EventID) REFERENCES Adoption_Events(EventID)
);

-- Insert sample data into Shelters table
INSERT INTO Shelters (ShelterID, Shelter_Name, Shelter_Location) 
VALUES 
(11, 'AAA Shelter', 'Chennai'),
(21, 'Animal Home', 'Mayiladuthurai'),
(31, 'Friends Shelter', 'Kolkata'),
(41, 'BBB Shelter', 'Trichy');

-- Insert sample data into Pets table
INSERT INTO Pets (PetID, Pet_Name, Pet_Age, Pet_Breed, Pet_Type, AvailableForAdoption, OwnerID, ShelterID)
VALUES 
(1, 'Chiyan', 2, 'Bomerian', 'Dog', 1, 1, 11),
(2, 'Rosy', 3, 'Breed01', 'Cat', 1, 2, 21),
(3, 'Jacky', 1, 'Labrador', 'Dog', 0, 3, 31),
(4, 'Rocky', 5, 'Persian', 'Cat', 1, 4, 41);

-- Insert sample data into Donations table
INSERT INTO Donations (DonationID, Donor_Name, DonationType, Donation_Item, DonationDate, DonationAmount)
VALUES 
(1, 'Shanmathi', 'Cash', 'Dairy Pro', '2024-05-10', 500.00),
(2, 'Sherin', 'Item', 'Pet Food', '2024-06-15', 200.00),
(3, 'Subha', 'Cash', NULL, '2024-07-01', 300.00),
(4, 'Fathima', 'Item', 'Toys', '2024-08-25', 150.00);

-- Insert sample data into Adoption_Events table
INSERT INTO Adoption_Events (EventID, EventName, EventDate, Event_Location, ShelterID)
VALUES 
(1, 'Adoption Day9', '2024-05-20', 'Chennai', 11),
(2, 'Adoption Drive', '2024-06-10', 'Bangalore', 21),
(3, 'Adoption Event2', '2024-07-15', 'Kochi', 31),
(4, 'Pet Adoption1', '2024-08-01', 'Velleri', 41);

-- Insert sample data into Participants table
INSERT INTO Participants (ParticipantID, ParticipantName, ParticipantType, EventID)
VALUES 
(1, 'Kiruthika', 'Shelter', 1),
(2, 'John', 'Shelter', 2),
(3, 'Varsha', 'Adopter', 1),
(4, 'Julieee', 'Adopter', 2);


--1: Retrieve a list of available pets for adoption
SELECT Pet_Name, Pet_Age, Pet_Breed, Pet_Type
FROM Pets
WHERE AvailableForAdoption = 1;

 --2.Retrieve the names of participants for a specific adoption event


SELECT ParticipantName, ParticipantType
FROM Participants
WHERE EventID = 1;

 --4: Calculate and retrieve total donation amount for each shelter

 SELECT 
    Shelters.Shelter_Name,
    COALESCE(SUM(Donations.DonationAmount), 0) AS TotalDonationAmount
FROM Shelters
LEFT JOIN Donations ON Shelters.ShelterID = Donations.ShelterID
GROUP BY Shelters.Shelter_Name;

--5. Retrieve pets without an owner (OwnerID is NULL)

SELECT Pet_Name, Pet_Age, Pet_Breed, Pet_Type
FROM Pets
WHERE OwnerID IS NULL;

--6: Retrieve total donation amount for each month and year

SELECT 
    FORMAT(DonationDate, 'yyyy-MM') AS MonthYear,
    SUM(DonationAmount) AS TotalDonationAmount
FROM Donations
GROUP BY FORMAT(DonationDate, 'yyyy-MM')
ORDER BY MonthYear;

--7.Retrieve distinct breeds for pets aged between 1-3 years or older than 5 years

SELECT DISTINCT Pet_Breed
FROM Pets
WHERE (Pet_Age BETWEEN 1 AND 3) OR Pet_Age > 5;

--8.Retrieve pets and their respective shelters available for adoption

SELECT 
    Pets.Pet_Name, 
    Shelters.Shelter_Name
FROM Pets
JOIN Shelters ON Pets.ShelterID = Shelters.ShelterID
WHERE Pets.AvailableForAdoption = 1;

--9.Find total number of participants in events organized by shelters in a specific city (e.g., Chennai)

SELECT 
    COUNT(Participants.ParticipantID) AS TotalParticipants
FROM Participants
JOIN Adoption_Events ON Participants.EventID = Adoption_Events.EventID
JOIN Shelters ON Adoption_Events.ShelterID = Shelters.ShelterID
WHERE Shelters.Shelter_Location = 'Chennai';


--10. Retrieve a list of unique breeds for pets aged between 1-5 years

SELECT DISTINCT Pet_Breed
FROM Pets
WHERE Pet_Age BETWEEN 1 AND 5;


--11: Find pets that have not been adopted (AvailableForAdoption = 0)

SELECT Pet_Name, Pet_Age, Pet_Breed, Pet_Type
FROM Pets
WHERE AvailableForAdoption = 0;


--12.Find all shelters with the count of pets available for adoption

SELECT 
    Shelters.Shelter_Name, 
    COUNT(Pets.PetID) AS PetsAvailableForAdoption
FROM Shelters
LEFT JOIN Pets ON Shelters.ShelterID = Pets.ShelterID AND Pets.AvailableForAdoption = 1
GROUP BY Shelters.Shelter_Name;


--13.Find pairs of pets from the same shelter that have the same breed


SELECT 
    P1.Pet_Name AS Pet1, 
    P2.Pet_Name AS Pet2, 
    P1.Pet_Breed
FROM Pets P1
JOIN Pets P2 ON P1.ShelterID = P2.ShelterID AND P1.Pet_Breed = P2.Pet_Breed
WHERE P1.PetID < P2.PetID;  -- To avoid pairing the same pet with itself



--14.  List all possible combinations of shelters and adoption events

SELECT 
    Shelters.Shelter_Name, 
    Adoption_Events.EventName
FROM Shelters
CROSS JOIN Adoption_Events;

--15. Find the pets that have not been adopted by selecting their information from the Pets table

SELECT Pet_Name, Pet_Age, Pet_Breed, Pet_Type
FROM Pets
WHERE AvailableForAdoption = 0;

--16. Retrieve the names of all adopted pets along with the adopter's name

SELECT 
    Pets.Pet_Name,
    Users.User_Name AS AdopterName
FROM Pets
JOIN Adoptions ON Pets.PetID = Adoptions.PetID
JOIN Users ON Adoptions.UserID = Users.UserID
WHERE Pets.AvailableForAdoption = 0;


--17.Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter

SELECT 
    Shelters.Shelter_Name, 
    COUNT(Pets.PetID) AS PetsAvailableForAdoption
FROM Shelters
LEFT JOIN Pets ON Shelters.ShelterID = Pets.ShelterID AND Pets.AvailableForAdoption = 1
GROUP BY Shelters.Shelter_Name;


--18.Find pairs of pets from the same shelter that have the same breed


SELECT 
    P1.Pet_Name AS Pet1, 
    P2.Pet_Name AS Pet2, 
    P1.Pet_Breed,
    P1.ShelterID
FROM Pets P1
JOIN Pets P2 ON P1.ShelterID = P2.ShelterID AND P1.Pet_Breed = P2.Pet_Breed
WHERE P1.PetID < P2.PetID;  -- Prevents duplicate pairs and self-pairs


--19. List all possible combinations of shelters and adoption events


SELECT 
    Shelters.Shelter_Name, 
    Adoption_Events.EventName
FROM Shelters
CROSS JOIN Adoption_Events;


--20.Determine the shelter that has the highest number of adopted pets

SELECT TOP 1 
    Shelters.Shelter_Name,
    COUNT(Pets.PetID) AS AdoptedPetsCount
FROM Shelters
JOIN Pets ON Shelters.ShelterID = Pets.ShelterID
WHERE Pets.AvailableForAdoption = 0
GROUP BY Shelters.Shelter_Name
ORDER BY AdoptedPetsCount DESC;


