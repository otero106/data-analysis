/*
Luis Otero
BSAN 6060
March 16, 2024
*/

/*
Database Connection
Host: lotero1.lmu.build
Username: loterolm_admin
Password: #JanesAddiction88
*/

USE loterolm_linkedin;

SET default_storage_engine=InnoDB;

/*
3.	Create the database and the tables that you have designed for the above relational database in 3rd Normal Form 
in your LMU Build account. You have to make sure that the tables are created using InnoDB engine and all the FKs 
have referential integrity with their corresponding PKs.
*/

CREATE TABLE Users(
	User_ID INT NOT NULL PRIMARY KEY,
	First_Name VARCHAR(255),
	Last_Name VARCHAR(255),
	Email VARCHAR(255),
    Password VARCHAR(255),
    Phone_No VARCHAR(255),
    DOB DATE,
    Location VARCHAR(255),
    Postal_Code INT
);

CREATE TABLE Postal_Codes(
	Postal_Code INT NOT NULL PRIMARY KEY,
    City VARCHAR(255),
    State VARCHAR(2)
);

#Adding Foreign Key to Users
ALTER TABLE Users
ADD CONSTRAINT user_fk FOREIGN KEY(Postal_Code) REFERENCES Postal_Codes(Postal_Code);

CREATE TABLE Profiles(
	Profile_URL VARCHAR(255) NOT NULL PRIMARY KEY,
	User_ID INT,
	Headline VARCHAR(255),
	Current_Industry VARCHAR(255),
    Website_URL TEXT,
    Language VARCHAR(255),
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE Account_Type(
	Account_Type_ID INT NOT NULL PRIMARY KEY,
    Description ENUM('Free', 'Premium'),
    Monthly_Cost DECIMAL(10,2)
);

CREATE TABLE Accounts(
	Seq_No INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Account_ID INT,
	User_ID INT,
	Account_Type_ID INT,
    Create_Timestamp TIMESTAMP,
    Expiration_Date DATE,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY(Account_Type_ID) REFERENCES Account_Type(Account_Type_ID)
);

CREATE TABLE Connections(
	Connection_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Request_Sent_By INT,
    Request_Sent_To INT,
    Connection_Date DATE,
    Status ENUM('Connected', 'Pending'),
    FOREIGN KEY(Request_Sent_By) REFERENCES Users(User_ID),
    FOREIGN KEY(Request_Sent_To) REFERENCES Users(User_ID)
);

CREATE TABLE Education(
	Educ_ID INT NOT NULL PRIMARY KEY,
	User_ID INT,
	School_Name VARCHAR(255),
	Degree VARCHAR(255),
    Field_of_Study VARCHAR(255),
    Grade VARCHAR(255),
    Start_Date DATE,
    End_Date DATE,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE Companies(
	Org_ID INT NOT NULL PRIMARY KEY,
    Company_Name VARCHAR(255),
    Company_Industry VARCHAR(255),
    Company_Location VARCHAR(255)
);

CREATE TABLE Work_Experience(
	Experience_ID INT NOT NULL PRIMARY KEY,
	User_ID INT,
	Org_ID INT,
	Employment_Type ENUM('Full-Time', 'Part-Time', 'Self-Employed', 'Freelance', 'Contract',
    'Internship', 'Apprenticeship', 'Seasonal'),
    Position_Title VARCHAR(255),
    Location_Type ENUM('On-site', 'Hybrid', 'Remote'),
    Description TEXT,
    Current_Role TINYINT,
    Start_Date DATE,
    End_Date DATE,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY(Org_ID) REFERENCES Companies(Org_ID)
);

CREATE TABLE Posts(
	Post_ID INT NOT NULL PRIMARY KEY,
	User_ID INT,
	Content TEXT,
	Post_Date DATE,
    Impressions INT,
    Tagged_User_ID INT,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY(Tagged_User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE Comments(
	Comment_ID INT NOT NULL PRIMARY KEY,
	Post_ID INT,
	Content TEXT,
	Comment_Date DATE,
    User_ID INT,
    FOREIGN KEY(Post_ID) REFERENCES Posts(Post_ID),
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID)
);

CREATE TABLE Skills(
	Skill_ID INT NOT NULL PRIMARY KEY,
    Skill_Name VARCHAR(255)
);

CREATE TABLE User_Skills(
	User_ID INT NOT NULL,
    Skill_ID INT NOT NULL,
    FOREIGN KEY(User_ID) REFERENCES Users(User_ID),
    FOREIGN KEY(Skill_ID) REFERENCES Skills(Skill_ID),
    PRIMARY KEY (User_ID, Skill_ID)
);

CREATE TABLE Post_Reactions(
	Reaction_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Reaction ENUM('Like', 'Celebrate', 'Support', 'Love', 'Insightful', 'Funny'),
    Post_ID INT,
    FOREIGN KEY(Post_ID) REFERENCES Posts(Post_ID)
);

/*
4. INSERT a few records (minimum of 5) in each of the tables. Make sure to enter the data carefully so that 
there are PK and FK connections. You can generate the records in Excel and then use csv file to upload the 
data. 
*/

#Inserting into Users
INSERT INTO Users(User_ID, First_Name, Last_Name, Email, Password, Phone_No, DOB, Location, Postal_Code)
VALUES
(1, 'John', 'Doe', 'john@example.com', 'password123', '123-456-7890', '1988-12-23', 'United States', 60007),
(2, 'Jane', 'Doe', 'jane@example.com', 'pass1234', '987-654-3210', '1973-03-10', 'United States', 59501),
(3, 'Eddie', 'Smith', 'eddie@example.com', '123password', '345-678-9012', '1966-07-20', 'United States', 98101),
(4, 'Mike', 'Cameron', 'mike@example.com', '789password', '789-012-3456', '1955-04-05', 'United States', 33101),
(5, 'Matt', 'Ament', 'matt@example.com', 'password321', '234-567-8901', '1990-11-28', 'United States', 91911),
(6, 'Jimmy', 'Lang', 'jimmy@example.com', '#LedZeppelin', '+44 20 7123 4567.', '1984-01-09', 'United Kingdom', NULL),
(7, 'Carlos', 'Dominic', 'carlos@example.com', '#oyecomova', '+52 21 0783-1957', '2000-05-30', 'Mexico', NULL),
(8, 'Paul', 'Farrell', 'paul@example.com', '#bonoU2', '+33 5 12 34 56 78', '1996-10-22', 'France', NULL);

#Inserting into Postal_Codes
INSERT INTO Postal_Codes(Postal_Code, City, State)
VALUES
(60007, 'Chicago', 'IL'),
(59501, 'Havre', 'MT'),
(98101, 'Seattle', 'WA'),
(33101, 'Miami', 'FL'),
(91911, 'San Diego', 'CA');

#Inserting into Account_Type
INSERT INTO Account_Type(Account_Type_ID, Description, Monthly_Cost)
VALUES
(1, 'Free', 0),
(2, 'Premium', 14.99);

#Inserting into Connections
INSERT INTO Connections (Request_Sent_By, Request_Sent_To, Connection_Date, Status)
VALUES
(1, 2, '2023-01-01', 'Connected'),
(1, 3, '2023-02-01', 'Connected'),
(1, 4, '2023-03-01', 'Pending'),
(2, 1, '2023-01-01', 'Connected'),
(3, 1, '2023-02-01', 'Connected'),
(4, 1, '2023-03-01', 'Pending'),
(2, 3, '2023-04-01', 'Connected'),
(3, 2, '2023-05-01', 'Connected'),
(5, 1, '2023-05-01', 'Connected'),
(8, 2, '2023-05-01', 'Pending'),
(7, 8, '2023-05-01', 'Connected'),
(4, 3, '2023-05-01', 'Connected'),
(6, 7, '2023-05-01', 'Connected'),
(7, 2, '2023-05-01', 'Connected');

#Inserting into Profiles
INSERT INTO Profiles(Profile_URL, User_ID, Headline, Current_Industry, Website_URL, Language)
VALUES
('https://example.com/profile/john', 1, 'Community-led Growth | Angel Investor', 'Finance', 'https://something.com', 'English'),
('https://example.com/profile/jane', 2, 'LinkedIn Top Voice. Keynote Speaker.', 'Professional Training & Coaching', 'https://example.com', 'English'),
('https://example.com/profile/eddie', 3, 'Social Entrepreneur | Change Maker', 'Non-Profit Organization Management', 'https://hello.com', 'English'),
('https://example.com/profile/mike', 4, 'Humanitarian | Philanthropist', 'Philanthropy', NULL, 'English'),
('https://example.com/profile/matt', 5, 'Bookworm | Literary Enthusiast', 'Libraries', 'https://bookworm.com', 'English'),
('https://example.com/profile/jimmy', 6, 'Researcher | Scholar', 'Research', NULL, 'English'),
('https://example.com/profile/carlos', 7, 'Educator | Math Instructor', 'Higher Education', 'https://hola.com', 'Spanish'),
('https://example.com/profile/paul', 8, 'Leadership Coach | Mentor', 'Professional Training & Coaching', NULL, 'French');

#Inserting into Accounts
INSERT INTO Accounts(Account_ID, User_ID, Account_Type_ID, Create_Timestamp, Expiration_Date)
VALUES
(1, 1, 1, '2008-04-15 12:30:00', '9999-12-31'),
(2, 2, 1, '2009-09-20 08:45:00', '9999-12-31'),
(3, 3, 2, '2010-07-05 15:20:00', '2013-08-12'),
(4, 4, 1, '2011-11-10 10:00:00', '9999-12-31'),
(5, 5, 2, '2012-03-25 14:00:00', '2013-03-25'),
(3, 3, 1, '2013-08-12 00:00:00', '9999-12-31'),
(5, 5, 1, '2013-03-25 13:05:00', '9999-12-31'),
(6, 6, 1, '2015-09-13 13:05:00', '9999-12-31'),
(7, 7, 2, '2018-01-10 17:20:00', '2022-11-10'),
(8, 8, 1, '2021-02-28 09:30:00', '2023-06-24'),
(7, 7, 1, '2022-11-10 00:00:00', '9999-12-31'),
(8, 8, 2, '2023-06-24 12:45:00', '9999-12-31'),
(1, 1, 2, '2023-07-15 12:30:00', '9999-12-31'),
(4, 4, 2, '2024-01-10 10:00:00', '9999-12-31');

#Inserting into Education
INSERT INTO Education(Educ_ID, User_ID, School_Name, Degree, Field_of_Study, Grade, Start_Date, End_Date)
VALUES
(1, 1, 'University of Chicago', 'Bachelor of Science', 'Finance', 'A', '2006-09-01', '2010-05-30'),
(2, 1, 'Harvard University', 'Bachelor of Science in Business Administration', 'Management', 'A-', '1991-08-19', '1995-05-12'),
(3, 2, 'Harvard University', 'Master of Business Administration', 'Business Administration', 'A-', '1995-08-15', '1997-05-20'),
(4, 3, 'Stanford University', 'Bachelor of Arts', 'Sociology', 'B', '1984-09-01', '1988-05-30'),
(5, 4, 'University of Miami', 'Bachelor of Science', 'Psychology', 'B+', '1975-08-15', '1979-05-20'),
(6, 5, 'San Diego State University', 'Bachelor of Arts', 'Creative Writing', 'A', '2008-09-01', '2012-05-30'),
(7, 5, 'San Diego State University', 'Master of Library and Information Science', 'Library and Information Science', 'A', '2012-09-01', '2014-05-30'),
(8, 6, 'Oxford University', 'Bachelor of Philosophy', 'Social Sciences', 'B', '2002-09-02', '2006-05-19'),
(9, 6, 'City, University of London', 'Master of Arts in Philosophy', 'Social Sciences', 'A-', '2007-08-27', '2009-05-15'),
(10, 6, 'University College London', 'Doctor of Philosophy', 'Social Sciences', 'A', '2011-08-29', '2015-05-22'),
(11, 7, 'Universidad Nacional Autónoma de México', 'Bachelor of Education', 'Mathematics', 'B', '2018-08-15', '2022-05-20'),
(12, 8, 'Université Paris-Saclay', 'Bachelor of Business Administration', 'Business Administration', 'A', '2015-09-01', '2017-05-30');

#Inserting into Companies
INSERT INTO Companies(Org_ID, Company_Name, Company_Industry, Company_Location)
VALUES 
(1, 'Goldman Sachs', 'Financial Services', 'New York'),
(2, 'Google', 'Technology', 'Mountain View'),
(3, 'Gates Foundation', 'Philanthropy', 'Seattle'),
(4, 'Nike', 'Apparel', 'Beaverton'),
(5, 'The J. Paul Getty Trust', 'Libraries', 'Los Angeles'),
(6, 'Oxford University', 'Education', 'Oxford'),
(7, 'BBVA', 'Banking', 'Mexico City'),
(8, 'Airbus', 'Aerospace', 'Toulouse'),
(9, 'Library of Congress', 'Libraries', 'Washington D.C.');

#Inserting into Work_Experience
INSERT INTO Work_Experience(Experience_ID, User_ID, Org_ID, Employment_Type, Position_Title, Location_Type, Description, Current_Role, Start_Date, End_Date)
VALUES
(1, 1, 1, 1, 'Financial Analyst', 'On-site', 'Responsible for analyzing financial data and creating reports.', 0, '2010-06-01', '2015-07-30'),
(2, 2, 2, 1, 'Product Manager', 'On-site', 'Led product development and strategy for various Google products.', 0, '1997-06-01', '2005-08-30'),
(3, 3, 3, 1, 'CEO', 'On-site', 'Led the foundations initiatives to combat poverty and improve global healthcare.', 1, '1988-06-01', '2010-08-30'),
(4, 4, 4, 1, 'Marketing Director', 'On-site', 'Developed marketing campaigns and strategies for Nike products.', 1, '1979-06-01', '1990-08-30'),
(5, 5, 5, 7, 'Library Assistant', 'On-site', 'Was responsible for a variety of activities in support of collections inventory control and tracking,.', 
1, '2010-10-01', '2012-05-30'),
(6, 5, 9, 1, 'Reference and Special Collections Librarian', 'On-site', 'Assisted patrons with research and managed library resources.', 1, '2012-08-01', '2018-01-30'),
(7, 5, 9, 1, 'Chief, Researcher Engagement and General Collections Division', 'Hybrid', 'In charge of the general and International Collections Directorate.', 
1, '2012-08-01', '2018-01-30'),
(8, 6, 6, 1, 'Research Fellow', 'Hybrid', 'Conducted research on social behavior and published multiple papers.', 1, '2006-10-01', NULL),
(9, 7, 7, 1, 'Math Teacher', 'Hybrid', 'Teach mathematics to high school students including Geometry and Calculus.', 1, '2022-01-01', NULL),
(10, 8, 8, 1, 'Project Manager', 'Hybrid', 'Managed projects and coordinated with international teams.', 1, '2018-09-01', NULL);

#Inserting into Posts
INSERT INTO Posts(Post_ID, User_ID, Content, Post_Date, Impressions, Tagged_User_ID)
VALUES
(1, 1, 'Excited to announce our new investment initiative!', '2024-03-15', 150, NULL),
(2, 2, 'Just finished speaking at the TEDx conference. What an inspiring experience!', '2024-03-14', 300, NULL),
(3, 3, 'Grateful for the opportunity to serve the community through our foundation.', '2024-03-12', 250, NULL),
(4, 4, 'Remembering the journey that led me to where I am today. Never forget your roots.', '2024-03-10', 200, NULL),
(5, 5, 'Just started reading a new book. Cannot wait to dive into it!', '2024-03-08', 180, NULL),
(6, 6, 'Exciting findings from our latest research project!', '2024-03-06', 220, NULL),
(7, 7, 'Today''s lesson: the beauty of mathematics!', '2024-03-04', 170, NULL),
(8, 8, 'Leading by example: How mentorship can shape future leaders.', '2024-03-02', 190, NULL);

#Inserting into Comments
INSERT INTO Comments(Comment_ID, Post_ID, Content, Comment_Date, User_ID)
VALUES
(1, 1, 'Can''t wait to see the impact!', '2024-03-16', 2),
(2, 2, 'Your talk was incredible! Truly inspiring.', '2024-03-15', 6),
(3, 3, 'Thank you for all that you do for our community!', '2024-03-14', 2),
(4, 4, 'Your story is so motivating!', '2024-03-13', 3),
(5, 5, 'Let me know how it is. I might pick it up too!', '2024-03-12', 1),
(6, 6, 'Can''t wait to read the paper!', '2024-03-11', 7),
(7, 7, 'Math is indeed beautiful!', '2024-03-10', 1),
(8, 8, 'What an amazing read!', '2024-03-09', 5);

#Inserting into Skills
INSERT INTO Skills(Skill_ID, Skill_Name)
VALUES
(1, 'Financial Analysis'),
(2, 'Microsoft Excel'),
(3, 'Leadership'),
(4, 'Marketing'),
(5, 'Library Science'),
(6, 'Research'),
(7, 'Teaching'),
(8, 'Project Management'),
(9, 'Microsoft PowerPoint'),
(10, 'Calculus');

#Inserting into User_Skills
INSERT IGNORE INTO User_Skills(User_ID, Skill_ID)
VALUES
(1, 1),
(1, 2),
(1, 10),
(2, 2),
(2, 4),
(3, 3),
(3, 6),
(3, 8),
(4, 4),
(5, 2),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

#Inserting into Post_Reactions
INSERT INTO Post_Reactions (Reaction_ID, Reaction, Post_ID)
VALUES
(1, 'Like', 1),
(2, 'Celebrate', 2),
(3, 'Support', 3),
(4, 'Love', 4),
(5, 'Insightful', 5),
(6, 'Funny', 6),
(7, 'Like', 7),
(8, 'Celebrate', 8);

/*
5. List the name and e-mail address along with the names and e-mail addresses of the 1st level connections for each user. Note that you 
may have to use SUBQUERIES along with JOIN to get this information.
*/

SELECT CONCAT(u1.First_Name, ' ', u1.Last_Name) AS Name, u1.Email,
CONCAT(u2.First_Name, ' ', u2.Last_Name) AS Connection_Name, u2.Email AS Connection_Email
FROM Users u1
INNER JOIN Connections con 
ON u1.User_ID = con.Request_Sent_By
INNER JOIN Users u2
ON con.Request_Sent_To = u2.User_ID
ORDER BY u1.User_ID;

/*
6. Create 2 queries that you think will be useful for the organization. Briefly justify your choice with comments above the queries.
*/

#Query 1: Find users with active premium accounts, and display their account details.
#This query helps identify users who have premium accounts, which could be valuable for targeted communication, special offers, 
#or analysis of premium users' behavior.
SELECT us.User_ID, CONCAT(us.First_Name, ' ',us.Last_Name) AS Name, us.Email,
act.Description AS Account_Type, act.Monthly_Cost
FROM Users us
INNER JOIN Accounts ac 
ON us.User_ID = ac.User_ID
INNER JOIN Account_Type act 
ON ac.Account_Type_ID = act.Account_Type_ID
WHERE act.Description = 'Premium' AND ac.Expiration_Date = '9999-12-31';

#Query 2: Identify users who have only have one connection.
#It could be useful for targeted outreach or for understanding user behavior and engagement levels
SELECT us.User_ID, us.First_Name, us.Last_Name, us.Email,
COUNT(con.Connection_ID) AS Total_Connections
FROM Users us
LEFT JOIN Connections con 
ON us.User_ID = con.Request_Sent_By
GROUP BY us.User_ID
HAVING Total_Connections = 1;