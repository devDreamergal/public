CREATE TABLE Guests (
    GuestID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomNumber VARCHAR(10) UNIQUE NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL,
    PricePerNight DECIMAL(10, 2) NOT NULL,
    Status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    GuestID INT,
    RoomID INT,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    BookingStatus ENUM('Confirmed', 'Cancelled', 'CheckedIn', 'CheckedOut') DEFAULT 'Confirmed',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (GuestID) REFERENCES Guests(GuestID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('CreditCard', 'DebitCard', 'Cash', 'Online') NOT NULL,
    PaymentStatus ENUM('Completed', 'Pending', 'Failed') DEFAULT 'Completed',
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Position VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    HireDate DATE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE RoomServices (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    RoomID INT,
    ServiceDescription TEXT NOT NULL,
    ServiceDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);
-- Insert sample guests
INSERT INTO Guests (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Anytown, USA'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Elm St, Othertown, USA');

-- Insert sample rooms
INSERT INTO Rooms (RoomNumber, RoomType, Capacity, PricePerNight, Status) VALUES
('101', 'Single', 1, 100.00, 'Available'),
('102', 'Double', 2, 150.00, 'Available'),
('103', 'Suite', 4, 300.00, 'Available'),
('104', 'Single', 1, 100.00, 'Occupied'),
('105', 'Double', 2, 150.00, 'Maintenance');
-- Insert sample bookings
INSERT INTO Bookings (GuestID, RoomID, CheckInDate, CheckOutDate, TotalAmount, BookingStatus) VALUES
(1, 1, '2024-07-01', '2024-07-05', 400.00, 'Confirmed'),
(2, 2, '2024-07-10', '2024-07-15', 750.00, 'Confirmed'),
(1, 3, '2024-07-20', '2024-07-25', 1500.00, 'Confirmed');

-- Insert sample payments
INSERT INTO Payments (BookingID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES
(1, '2024-06-01 10:00:00', 400.00, 'CreditCard', 'Completed'),
(2, '2024-06-15 15:00:00', 750.00, 'DebitCard', 'Completed'),
(3, '2024-07-10 09:00:00', 1500.00, 'Cash', 'Completed');

