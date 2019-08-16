--Zali Spurgeon
--102690319

--TASK 1
-- TOUR (TourName, Description)
-- Primary Key (TourName)

-- CLIENT (ClientID, Surname, GivenName, Gender)
-- Primary Key (ClientID)

-- EVENT (TourName, EventYear, EventMonth, EventDay, EventFee)
-- Primary Key (TourName, EventYear, EventMonth, EventDay)
-- Foreign Key (TourName) references TOUR

-- BOOKING (ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
-- Primary Key (ClientID, TourName, EventYear, EventMonth, EventDay)
-- Foreign Key (ClientID) references CLIENT
-- Foreign Key (TourName, EventYear, EventMonth, EventDay) references EVENT

--TASK 2
DROP TABLE IF EXISTS BOOKING;
DROP TABLE IF EXISTS EVENT;
DROP TABLE IF EXISTS CLIENT;
DROP TABLE IF EXISTS TOUR;

CREATE TABLE TOUR (
    TourName    NVARCHAR(100),
    Description NVARCHAR(500),
    PRIMARY KEY (TourName)
);

CREATE TABLE CLIENT (
    ClientID    INT IDENTITY(1, 1),
    Surname     NVARCHAR(100) NOT NULL,
    GivenName   NVARCHAR(100) NOT NULL,
    Gender      NVARCHAR(1),
    PRIMARY KEY (ClientID),
    CHECK       (Gender IN ('M', 'F', 'I'))
);

CREATE TABLE EVENT (
    TourName    NVARCHAR(100),
    EventMonth  NVARCHAR(3),
    EventDay    INT,
    EventYear   INT,
    EventFee    MONEY NOT NULL,
    PRIMARY KEY (TourName, EventMonth, EventDay, EventYear),
    FOREIGN KEY (TourName) references TOUR,
    CHECK       (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CHECK       (EventDay >= 1 AND EventDay <=31),
    CHECK       (EventYear BETWEEN 999 AND 9999),
    CHECK       (EventFee > 0)
);

CREATE TABLE BOOKING (
    ClientID    INT,
    TourName    NVARCHAR(100),
    EventMonth  NVARCHAR(3),
    EventDay    INT,
    EventYear   INT,
    Payment     MONEY,
    DateBooked  DATE NOT NULL,
    PRIMARY KEY (ClientID, TourName, EventMonth, EventDay, EventYear),
    FOREIGN KEY (ClientID) references CLIENT,
    FOREIGN KEY (TourName, EventMonth, EventDay, EventYear) references EVENT,
    CHECK       (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    CHECK       (EventDay >= 1 AND EventDay <=31),
    CHECK       (EventYear BETWEEN 1000 AND 9999),
    CHECK       (Payment > 0)
);

--TASK 3
INSERT INTO TOUR (TourName, Description)
VALUES  ('North', 'Tour of wineries and outlets of the Bendigo and Castlemaine region'),
        ('South', 'Tour of wineries in the coolest region');

INSERT INTO CLIENT (Surname, GivenName, Gender)
VALUES  ('Price', 'Taylor', 'M'),
        ('Spurgeon', 'Zali', 'F'),
        ('Harrison', 'Coffee', 'I');

INSERT INTO EVENT (TourName, EventMonth, EventDay, EventYear, EventFee)
VALUES  ('North', 'Jan', 9, 2016, 200),
        ('South', 'Sep', 18, 2019, 300);

INSERT INTO BOOKING (ClientID, TourName, EventMonth, EventDay, EventYear, DateBooked, Payment)
VALUES  (1, 'North', 'Jan', 9, 2016, '10 Dec 2015', 200),
        (2, 'South', 'Sep', 18, 2019, '16 Aug 2019', 300),
        (3, 'South', 'Sep', 18, 2019, '8 Aug 2019', 300);

--TASK 4
SELECT C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay, E.EventFee, B.DateBooked, B.Payment
FROM TOUR T
INNER JOIN EVENT E
ON T.TourName = E.TourName
INNER JOIN BOOKING B
ON E.TourName = B.TourName AND E.EventYear = B.EventYear AND E.EventMonth = B.EventMonth AND E.EventDay = B.EventDay
INNER JOIN CLIENT C
ON B.ClientID = C.ClientID;

SELECT EventMonth, TourName, Count(*) AS "Num Bookings"
FROM BOOKING
GROUP BY EventMonth, TourName;

SELECT *
FROM BOOKING
WHERE Payment > (SELECT AVG(Payment)
                FROM BOOKING);