--Zali Spurgeon
--102690319

-- TOUR (TourName, Description)
-- Primary Key (TourName)

-- CLIENT (CLientID, Surname, GivenName, Gender)
-- Primary Key (ClientID)

-- EVENT (TourName, EventYear, EventMonth, EventDay, Fee)
-- Primary Key (TourName, EventYear, EventMonth, EventDay)
-- Foreign Key (TourName) references TOUR

-- BOOKING (ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
-- Primary Key (ClientID, TourName, EventYear, EventMonth, EventDay)
-- Foreign Key (ClientID) references CLIENT
-- Foreign Key (TourName, EventYear, EventMonth, EventDay) references EVENT