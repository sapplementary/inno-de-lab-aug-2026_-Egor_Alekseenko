--Скрипт для создания и заполнения значенями таблиц для hw5

-- Dim_Date
CREATE TABLE Dim_Date (
    date_key      INT           PRIMARY KEY,
    full_date     DATE          NOT NULL,
    day_of_week   VARCHAR(10)   NOT NULL,
    month         SMALLINT      NOT NULL CHECK (month BETWEEN 1 AND 12),
    quarter       SMALLINT      NOT NULL CHECK (quarter BETWEEN 1 AND 4),
    year          SMALLINT      NOT NULL,
    is_weekend    BOOLEAN       NOT NULL DEFAULT FALSE,
    is_holiday    BOOLEAN       NOT NULL DEFAULT FALSE
);

-- Dim_time
CREATE TABLE Dim_time (
    time_key            INT         PRIMARY KEY,
    hour                SMALLINT    NOT NULL CHECK (hour BETWEEN 0 AND 23),
    minute              SMALLINT    NOT NULL CHECK (minute BETWEEN 0 AND 59),
    time_of_day_segment VARCHAR(20) NOT NULL
);

-- Dim_customer
CREATE TABLE Dim_customer (
    customer_key      SERIAL      PRIMARY KEY,
    customer_id       VARCHAR(50) NOT NULL UNIQUE,
    full_name         VARCHAR(100),
    phone             VARCHAR(20),
    email             VARCHAR(100),
    registration_date DATE
);

-- Dim_Restaurant
CREATE TABLE Dim_Restaurant (
    restaurant_key  SERIAL       PRIMARY KEY,
    restaurant_id   VARCHAR(50)  NOT NULL UNIQUE,
    restaurant_name VARCHAR(100) NOT NULL,
    city            VARCHAR(100),
    address         VARCHAR(200),
    cuisine_type    VARCHAR(50)
);

-- Dim_Table
CREATE TABLE Dim_Table (
    table_key        SERIAL      PRIMARY KEY,
    table_number     VARCHAR(20) NOT NULL,
    seating_capacity SMALLINT    NOT NULL CHECK (seating_capacity > 0),
    table_location   VARCHAR(50)
);

-- Dim_Status
CREATE TABLE Dim_Status (
    status_key   SERIAL      PRIMARY KEY,
    status_name  VARCHAR(50) NOT NULL UNIQUE  -- 'Confirmed', 'Completed', 'Cancelled', 'No-Show'
);

-- Dim_Booking_Source
CREATE TABLE Dim_Booking_Source (
    source_key  SERIAL       PRIMARY KEY,
    channel     VARCHAR(50)  NOT NULL UNIQUE 
);


CREATE TABLE Fact_reservation (
    reservation_fact_key  SERIAL    PRIMARY KEY,
    booking_id            VARCHAR(50) NOT NULL UNIQUE,

    -- Foreign Keys
    date_key_created  INT       NOT NULL REFERENCES Dim_Date(date_key),
    date_key_visit    INT       NOT NULL REFERENCES Dim_Date(date_key),
    time_key_visit    INT       NOT NULL REFERENCES Dim_time(time_key),
    customer_key      INT       NOT NULL REFERENCES Dim_customer(customer_key),
    restaurant_key    INT       NOT NULL REFERENCES Dim_Restaurant(restaurant_key),
    table_key         INT       NOT NULL REFERENCES Dim_Table(table_key),
    status_key        INT       NOT NULL REFERENCES Dim_Status(status_key),
    source_key        INT       NOT NULL REFERENCES Dim_Booking_Source(source_key),

    -- Facts
    guests_count          SMALLINT NOT NULL CHECK (guests_count > 0),
    lead_time_days        SMALLINT NOT NULL CHECK (lead_time_days >= 0),  -- сколько дней заранее бронировали
    duration_minutes      SMALLINT CHECK (duration_minutes > 0),
    is_no_show            BOOLEAN  NOT NULL DEFAULT FALSE,
    is_cancelled          BOOLEAN  NOT NULL DEFAULT FALSE,
    waiting_time_minutes  SMALLINT DEFAULT 0 CHECK (waiting_time_minutes >= 0)
);


-- Dim_Date
INSERT INTO Dim_Date VALUES
(20240101, '2024-01-01', 'Monday',    1, 1, 2024, FALSE, TRUE),
(20240115, '2024-01-15', 'Monday',    1, 1, 2024, FALSE, FALSE),
(20240120, '2024-01-20', 'Saturday',  1, 1, 2024, TRUE,  FALSE),
(20240315, '2024-03-15', 'Friday',    3, 1, 2024, FALSE, FALSE),
(20240316, '2024-03-16', 'Saturday',  3, 1, 2024, TRUE,  FALSE),
(20240614, '2024-06-14', 'Friday',    6, 2, 2024, FALSE, FALSE),
(20240812, '2024-08-12', 'Monday',    8, 3, 2024, FALSE, FALSE),
(20241225, '2024-12-25', 'Wednesday',12, 4, 2024, FALSE, TRUE);

-- Dim_time
INSERT INTO Dim_time VALUES
(1200, 12, 0,  'Afternoon'),
(1300, 13, 0,  'Afternoon'),
(1330, 13, 30, 'Afternoon'),
(1800, 18, 0,  'Evening'),
(1900, 19, 0,  'Evening'),
(1930, 19, 30, 'Evening'),
(2000, 20, 0,  'Evening'),
(2100, 21, 0,  'Evening');

-- Dim_customer
INSERT INTO Dim_customer (customer_id, full_name, phone, email, registration_date) VALUES
('C001', 'Anna Kowalski',   '+37061234567', 'anna@email.com',  '2023-05-10'),
('C002', 'Bob Petrov',      '+37069876543', 'bob@email.com',   '2022-11-20'),
('C003', 'Carl Novak',      '+37061112233', 'carl@email.com',  '2024-01-05'),
('C004', 'Diana Smirnova',  '+37068887766', 'diana@email.com', '2023-08-14'),
('C005', 'Egor Alekseenko', '+37062345678', 'egor@email.com',  '2024-02-20');

-- Dim_Restaurant
INSERT INTO Dim_Restaurant (restaurant_id, restaurant_name, city, address, cuisine_type) VALUES
('R001', 'La Bella Italia', 'Vilnius', 'Gedimino 15',    'Italian'),
('R002', 'Tokyo Garden',    'Vilnius', 'Pilies 8',        'Japanese'),
('R003', 'Burger Palace',   'Kaunas',  'Laisves al. 55',  'American');

-- Dim_Table
INSERT INTO Dim_Table (table_number, seating_capacity, table_location) VALUES
('T01', 2,  'Window'),
('T02', 4,  'Center'),
('T03', 6,  'Terrace'),
('T04', 8,  'VIP'),
('T05', 2,  'Center');

-- Dim_Status
INSERT INTO Dim_Status (status_name) VALUES
('Confirmed'),
('Completed'),
('Cancelled'),
('No-Show');

-- Dim_Booking_Source
INSERT INTO Dim_Booking_Source (channel) VALUES
('App'),
('Website'),
('Phone'),
('Walk-in');

-- Fact_reservation
INSERT INTO Fact_reservation
    (booking_id, date_key_created, date_key_visit, time_key_visit,
     customer_key, restaurant_key, table_key, status_key, source_key,
     guests_count, lead_time_days, duration_minutes, is_no_show, is_cancelled, waiting_time_minutes)
VALUES
('BK001', 20240101, 20240115, 1900, 1, 1, 2, 2, 1, 2, 14,  90,  FALSE, FALSE, 0),
('BK002', 20240101, 20240120, 2000, 2, 1, 4, 2, 2, 4,  5, 120,  FALSE, FALSE, 5),
('BK003', 20240115, 20240315, 1300, 3, 2, 1, 2, 1, 2, 59,  75,  FALSE, FALSE, 10),
('BK004', 20240115, 20240316, 1800, 4, 2, 3, 3, 3, 6,  1, NULL, FALSE, TRUE,  0),
('BK005', 20240315, 20240614, 2100, 5, 3, 2, 4, 1, 2, 91, NULL, TRUE,  FALSE, 0),
('BK006', 20240316, 20240614, 1200, 1, 3, 5, 2, 4, 2, 90,  60,  FALSE, FALSE, 15),
('BK007', 20240614, 20240812, 1930, 2, 1, 4, 2, 2, 8, 59, 150,  FALSE, FALSE, 0),
('BK008', 20240812, 20241225, 1330, 3, 2, 2, 2, 1, 3, 135, 90,  FALSE, FALSE, 20);


