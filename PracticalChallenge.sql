--Zali Spurgeon
--102690319

-- TOUR (TourName, Description)
-- Primary Key (TourName)

-- CLIENT (CLientID, Surname, GivenName, Gender)
-- Primary Key (ClientID)

-- EVENT (TourName, EventYear, EventMonth, EventDay, EventFee)
-- Primary Key (TourName, EventYear, EventMonth, EventDay)
-- Foreign Key (TourName) references TOUR

-- BOOKING (ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
-- Primary Key (ClientID, TourName, EventYear, EventMonth, EventDay)
-- Foreign Key (ClientID) references CLIENT
-- Foreign Key (TourName, EventYear, EventMonth, EventDay) references EVENT

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
)