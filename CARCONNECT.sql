CREATE database CarConnect

--CREATING CUSTOMER TABLE  

CREATE table Customer(CustomerID int Primary key, FirstName varchar(20),LastName varchar(20), Email  varchar(20) unique,
PhoneNumber varchar(10),CustomerAddress varchar(20), UserName  varchar(20) Unique, Password varchar(10), RegistrationDate Date ) 

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber,CustomerAddress, Username, Password, RegistrationDate)
VALUES
(21, 'shan', 'mathi', 'shan@gmail.com', '9876543210', 'Chennai', 'shanmathi77', 'dhoni77', '2024-10-27'),
(27, 'Kavi', 'nila', 'kavi@gmail.com', '9876443399', 'Trichy', 'kavinila66', 'nature', '2024-10-02'),
(7, 'Ayisha', 'afrin', 'ayisha@gmail.com', '8877665544', 'Bangalore', 'ayisha786', '1234a', '2024-10-11')

select* from Customer

--CREATING VEHICLE TABLE

CREATE table Vehicle(VehicleID int Primary key, Model varchar(20),Make varchar(20), Manu_Year int,
Color_Vehi varchar(10),RegistrationNumber int, Availability varchar(20), DailyRate  varchar(20)) 

INSERT INTO Vehicle (VehicleID, Model, Make, Manu_Year, Color_Vehi, RegistrationNumber, Availability, DailyRate)
VALUES 
(7, 'Corolla', 'Toyota', 2020, 'White', 111223, 'Available', '300'),
(8, 'Fiesta', 'Ford', 2018, 'Red', 223344, 'Not Available', '250'),
(9, 'Civic', 'Honda', 2021, 'Black', 334455, 'Available', '350');

select* from Vehicle


----CREATING RESERVATION TABLE

CREATE table Reservation(ReservationID int Primary key,StartDate date,EndDate date,TotalCost decimal not null,Reserve_Status varchar(20), CustomerID int
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ,VehicleID int
FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID))

INSERT INTO Reservation(ReservationID ,StartDate,EndDate,TotalCost ,Reserve_Status , CustomerID ,VehicleID)
VALUES 
 
(101, '2024-11-01', '2024-11-05', 250.00, 'Confirmed', 21, 7),
(102, '2024-11-06', '2024-11-10', 300.00, 'Pending',27, 8),
(103, '2024-11-11', '2024-11-15', 275.00, 'Cancelled', 7, 9)

select * from Reservation 

--CREATING ADMIN TABLE 

CREATE table Admin(CustomerID int Primary key, FirstName varchar(20),LastName varchar(20), Email  varchar(20) unique,
PhoneNumber varchar(10), UserName  varchar(20) Unique, Admin_Password varchar(10),Admin_Role varchar(20), JoinDate Date ) 

EXEC sp_rename 'Admin.CustomerID','AdminID','column'

INSERT into Admin(CustomerID , FirstName ,LastName, Email ,
PhoneNumber , UserName  , Admin_Password ,Admin_Role , JoinDate)
VALUES 

(1, 'Kayal', 'Vizhi', 'kayal@example.com', '9876543210', 'kayalvizhi', 'Admin@123', 'SuperAdmin', '2024-11-01'),
(2, 'Albert', 'Smith', 'smith@example.com', '9988776655', 'Albertsmith', 'Admin@456', 'Manager', '2024-10-15'),
(3, 'Sophia', 'John', 'sophia@example.com', '7766554433', 'sophiajohn', 'Admin@789', 'Assistant', '2024-09-20')

Select * from Customer
Select * from Vehicle 
Select * from Reservation
Select * from Admin

 