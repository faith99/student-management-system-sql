USE student_management_system;

-- Student and Enrollment reports
-- Q1 How many students are currently enrolled in each course?
SELECT c.course_name AS course, COUNT(e.student_id) AS no_of_students
FROM enrollments AS e
JOIN courses AS c
ON e.course_id = c.course_id
GROUP BY course;

-- Q2 Which students are enrolled in multiple courses, and which courses are they taking?
SELECT s.`name` AS students, COUNT(e.course_id) AS no_of_enrolled_courses, c.course_name AS courses
FROM students AS s
JOIN courses AS c
ON s.department_id = c.department_id
JOIN enrollments AS e
ON s.student_id = e.student_id
GROUP BY students, courses
HAVING COUNT(e.course_id) > 1;

-- Q3 What is the total number of students per department across all courses?
SELECT department_name AS department , COUNT(DISTINCT e.student_id) AS no_of_students
FROM courses AS c
JOIN departments AS d
ON c.department_id = d.department_id
JOIN enrollments AS e
ON c.course_id = e.course_id
GROUP BY department;

-- Course & Instructor Analysis
-- Q1 Which courses have the highest number of enrollments?
SELECT course_name AS courses, COUNT(DISTINCT e.student_id) AS no_of_enrollment
FROM courses AS c
JOIN enrollments AS e
ON c.course_id = e.course_id
GROUP BY courses
ORDER BY no_of_enrollment DESC
LIMIT 2;

-- Q2 Which department has the least number of students?
SELECT department_name AS departments, COUNT(s.department_id) AS no_of_students
FROM departments AS d
JOIN students AS s
ON d.department_id = s.department_id
GROUP BY departments
ORDER BY no_of_students
LIMIT 1;

-- Data Integrity & Operational Insights
-- Q1 Are there any students not enrolled in any course?
SELECT s.student_id, s.`name` AS not_enrolled_student
FROM students AS s
LEFT JOIN enrollments AS e
ON s.student_id = e.student_id
WHERE enrollment_id IS NULL;

-- Q2 How many courses does each student take on average?
SELECT ROUND((COUNT(*)/COUNT(DISTINCT student_id)), 1) AS ave_course_per_student
FROM enrollments;
    
-- Q3 What is the gender distribution of students across courses and instructors?
SELECT c.course_name AS course, i.name as instructors,
 SUM(CASE WHEN s.gender = 'Male' THEN 1 ELSE 0 END) AS Male_students,
 SUM(CASE WHEN s.gender = 'Female' THEN 1 ELSE 0 END) AS Female_students
FROM courses AS c
JOIN students AS s
ON c.department_id = s.department_id
JOIN instructors AS i
ON c.instructor_id = i.instructor_id
GROUP BY c.course_name, i.name;

-- Q4 Which course has the highest number of male or female students enrolled?
SELECT c.course_name AS course,
 SUM(CASE WHEN s.gender = 'Male' THEN 1 ELSE 0 END) AS Male_students,
 SUM(CASE WHEN s.gender = 'Female' THEN 1 ELSE 0 END) AS Female_students
FROM courses AS c
JOIN students AS s
ON c.department_id = s.department_id
GROUP BY c.course_name
ORDER BY Male_students DESC, Female_students DESC
LIMIT 2;


