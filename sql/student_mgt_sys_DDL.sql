-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS student_management_system;
USE student_management_system;

-- Step 2: Create Tables

-- Create departments table
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

-- Create students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create instructors table
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create courses table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    department_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create enrollments table
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


-- STEP 3: Insert Sample Data

-- Departments
INSERT INTO departments (department_name) VALUES
('Computer Science'),
('Biological Sciences'),
('Business Administration'),
('Mathematics');

-- Students
INSERT INTO students (name, gender, dob, department_id) VALUES
('Faith Mbonu', 'Female', '1999-08-12', 1),
('John Doe', 'Male', '2000-02-20', 2),
('Jane Smith', 'Female', '2001-07-11', 1),
('Michael Lee', 'Male', '1998-05-15', 3),
('Ada Nnaji', 'Female', '2002-03-30', 4),
('Chinedu Okafor', 'Male', '2000-11-10', 1);

-- Instructors
INSERT INTO instructors (name, gender, department_id) VALUES
('Dr. Susan Eze', 'Female', 1),
('Mr. Paul Anya', 'Male', 2),
('Dr. Amina Yusuf', 'Female', 3),
('Prof. James Okoro', 'Male', 4);

-- Courses
INSERT INTO courses (course_name, instructor_id, department_id) VALUES
('Database Systems', 1, 1),
('Molecular Biology', 2, 2),
('Marketing Principles', 3, 3),
('Linear Algebra', 4, 4),
('Web Development', 1, 1),
('Business Ethics', 3, 3);

-- Enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-01'),
(1, 5, '2024-09-02'),
(2, 2, '2024-09-03'),
(3, 1, '2024-09-01'),
(3, 5, '2024-09-02'),
(4, 3, '2024-09-04'),
(4, 6, '2024-09-05'),
(5, 4, '2024-09-06'),
(6, 1, '2024-09-07'),
(6, 5, '2024-09-08');


SELECT COUNT(*)
FROM enrollments;

