--1. What is the current average class duration for classes that started in 2014?

SELECT AVG(Duration), StartDate
FROM Classes
WHERE StartDate Like '2014%';

-- 2. How many classes are held in room 3346?

SELECT COUNT(ClassRoomID)
FROM Classes
WHERE ClassRoomID = '3346';

-- 3. Return the number of classes that occur on each day of the week.

SELECT SUM(MondaySchedule), SUM(TuesdaySchedule), SUM(WednesdaySchedule),
SUM(ThursdaySchedule), SUM(FridaySchedule), SUM(SaturdaySchedule)
FROM Classes;

-- 4. Display by category the category name and the count of classes offered

SELECT cat.CategoryID, count(class.ClassID) AS Times_Offered
FROM Categories cat
INNER JOIN Subjects subj
ON cat.CategoryID = subj.CategoryID
INNER JOIN Classes class
ON subj.SubjectID = class.SubjectID
GROUP BY cat.CategoryID;

-- 5. List each staff member and the count of classes each is scheduled to teach

SELECT st.StfFirstName, st.StfLastName, 
count(fac.ClassID) AS Count_of_Classes
FROM Staff st
INNER JOIN Faculty_Classes fac
ON st.StaffID = fac.StaffID
GROUP BY st.StfFirstName, St.StfLastName;

-- 6. Show me all the students enrolled in school and the subject name 
-- (if any) they are taking and the grade for each of those classes

SELECT stu.StudFirstName ||' '|| stu.StudLastName AS Name, sch.Grade,
sub.SubjectName
FROM Students stu
LEFT JOIN Student_Schedules sch
ON stu.StudentID = sch.StudentID
LEFT JOIN Classes class
ON sch.ClassID = class.ClassID
LEFT JOIN Subjects sub
ON class.SubjectID = sub.SubjectID;

-- 7. Give me the total classes taught by all staff members.

SELECT count(ClassID) FROM Faculty_Classes;

-- 8. Return a count per category id where the subject description contains econ. 
-- (Exam Question)

SELECT Count(CategoryID)
FROM Subjects
WHERE SubjectDescription LIKE '%econ%';
