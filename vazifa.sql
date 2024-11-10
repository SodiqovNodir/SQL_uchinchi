-- ----------------------O'CHIRISH----------------------------------

DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS grade;
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS subject;
DROP TABLE IF EXISTS s_class;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS school;

-- -------------------------------YARATISH----------------------------------

CREATE TABLE IF NOT EXISTS school(
	s_id SERIAl PRIMARY KEY,
	s_name TEXT,
	address TEXT,
	s_phone_number CHAR(17),
	davlat_maktabi BOOL DEFAULT True
);

CREATE TABLE IF NOT EXISTS teacher(
	t_id SERIAL PRIMARY KEY,
	t_name TEXT,
	t_last_name TEXT,
	t_email TEXT,
	t_phone_number CHAR(17),
	s_id INTEGER REFERENCES school(s_id)
);

CREATE TABLE IF NOT EXISTS student(
	stu_id SERIAL PRIMARY KEY,
	stu_name TEXT,
	stu_last_name TEXT,
	birth_day DATE,
	gender TEXT,
	s_id INTEGER REFERENCES school(s_id)
);

CREATE TABLE IF NOT EXISTS s_class(
	c_id SERIAl PRIMARY KEY,
	c_name TEXT,
	t_id INTEGER REFERENCES teacher(t_id),
	s_id INTEGER REFERENCES school(s_id)
);

CREATE TABLE IF NOT EXISTS subject(
	sub_id SERIAl PRIMARY KEY,
	sub_name TEXT,
	c_id INTEGER REFERENCES s_class(c_id),
	t_id INTEGER REFERENCES teacher(t_id)
);

CREATE TABLE IF NOT EXISTS enrollment(
	e_id SERIAl PRIMARY KEY,
	stu_id INTEGER REFERENCES student(stu_id),
	c_id INTEGER REFERENCES s_class(c_id),
	enrollment_date DATE
);

CREATE TABLE IF NOT EXISTS grade(
	grade_id SERIAl PRIMARY KEY,
	stu_id INTEGER REFERENCES student(stu_id),
	sub_id INTEGER REFERENCES subject(sub_id),
	grade_value TEXT,
	date_given DATE
);

CREATE TABLE IF NOT EXISTS attendance(
	att_id SERIAl PRIMARY KEY,
	stu_id INTEGER REFERENCES student(stu_id),
	c_id INTEGER REFERENCES s_class(c_id),
	att_date DATE
);

-- --------------------------------QIYMAT BERISH-------------------------------------

INSERT INTO school(s_name, address, s_phone_number) VALUES
('12-maktab', 'Fargona', '+998 91 234 56 87'),
('32-maktab', 'Joydam', '+998 98 984 02 32'),
('21-maktab', 'Kirgili', '+998 93 562 45 87'),
('16-maktab', 'Kirgili', '+998 50 034 45 23'),
('40-maktab', 'Margilon', '+998 93 435 67 23');

INSERT INTO teacher(t_name, t_last_name, t_email, t_phone_number, s_id) VALUES
('Ali', 'Aliyev', 'AliAliyev@gmail.com', '+998 93 342 56 32', 3),
('Bakir', 'Bakiriv', 'Bakirov@gmail.com', '+998 98 483 34 82', 1),
('Qodir', 'Qodirov', 'QQodirov@gmail.com', '+998 50 733 83 42', 5),
('Aziz', 'Azizov', 'AzizovAziz@gmail.com', '+998 33 985 23 90', 2),
('Holmat', 'Holmativ', 'HolHolmativ@gmail.com', '+998 91 231 83 22', 4);


INSERT INTO student(stu_name, stu_last_name, birth_day, gender, s_id) VALUES
('Doston', 'Dostonov', '2009-01-11', 'Erkak', 5),
('Maftuna', 'Ergashova', '2007-10-29', 'Ayol', 3),
('Olim', 'Olimov', '2008-03-24', 'Erkak', 1),
('Muhlisa', 'Salimova', '2010-08-25', 'Ayol', 4),
('Sardor', 'Sardorov', '2013-05-22', 'Erkak', 2);

INSERT INTO s_class(c_name, t_id, s_id) VALUES
('Kimyo', 2, 5),
('Biologiya', 4, 3),
('Fizika', 1, 1),
('Matematika', 5, 4),
('Ona tili', 3, 2);

INSERT INTO subject(sub_name, c_id, t_id) VALUES
('Fizika', 3, 5),
('Matimatika', 4, 2),
('Kimyo', 1, 4),
('Ona-tili', 5, 1),
('Biologiya', 2, 3);

INSERT INTO enrollment(stu_id, c_id, enrollment_date) VALUES
( 3, 4, '2014-09-05'),
( 1, 2, '2015-09-05'),
( 4, 5, '2012-09-05'),
( 2, 3, '2016-09-05'),
( 5, 1, '2017-09-05');

INSERT INTO grade(stu_id, sub_id, grade_value, date_given) VALUES
( 2, 3, '100/89', '2024-11-10'),
( 5, 1, '100/72', '2024-11-10'),
( 3, 4, '100/98', '2024-11-10'),
( 1, 2, '100/66', '2024-11-10'),
( 4, 5, '100/94', '2024-11-10');

INSERT INTO attendance(stu_id, c_id, att_date) VALUES
( 5, 3, '2024-11-10'),
( 2, 1, '2024-11-10'),
( 4, 4, '2024-11-10'),
( 1, 2, '2024-11-10'),
( 3, 5, '2024-11-10');

-- -----------------------------CHIQARISH----------------------------------

SELECT * FROM school;

SELECT t_name, t_last_name, t_email, t_phone_number, s_name, davlat_maktabi FROM teacher 
JOIN school ON teacher.s_id = school.s_id;

SELECT stu_id, stu_last_name, TO_CHAR(birth_day, 'dd.mm.yyyy'), gender, s_name, address FROM student 
JOIN school ON student.s_id = school.s_id;

SELECT c_name, t_name, t_email, t_phone_number, s_name, address FROM s_class
JOIN teacher ON s_class.t_id = teacher.t_id
JOIN school ON s_class.s_id = school.s_id;

SELECT sub_name, c_name, t_name, t_phone_number FROM subject 
JOIN s_class ON subject.c_id = s_class.c_id
JOIN teacher ON subject.t_id = teacher.t_id;

SELECT TO_CHAR(enrollment_date, 'dd.mm.yyyy'), stu_name, stu_last_name, TO_CHAR(birth_day, 'dd.mm.yyyy'), gender FROM enrollment 
JOIN student ON enrollment.stu_id = student.stu_id
JOIN s_class ON enrollment.c_id = s_class.c_id;

SELECT stu_name, sub_name, grade_value, date_given FROM grade 
JOIN student ON grade.stu_id = student.stu_id
JOIN subject ON grade.sub_id = subject.sub_id;

SELECT c_name, stu_name, TO_CHAR(att_date, 'dd.mm.yyyy') FROM attendance 
JOIN student ON attendance.stu_id = student.stu_id
JOIN s_class ON attendance.c_id = s_class.c_id;

-- ----------------------------------O'ZGARTIRISH-------------------------------

ALTER TABLE school
RENAME TO maktab;

ALTER TABLE student
RENAME TO oquvchi;

ALTER TABLE teacher
RENAME COLUMN t_phone_number TO tel_raqam;

ALTER TABLE s_class
RENAME COLUMN c_name TO xona_nomi;

ALTER TABLE oquvchi
RENAME COLUMN stu_name TO oquvchi_ismi;

ALTER TABLE grade
ADD COLUMN umumiy_bahosi TEXT;

ALTER TABLE attendance
ADD COLUMN umumiy_davomat TEXT;

ALTER TABLE grade
DROP COLUMN date_given;

UPDATE oquvchi SET oquvchi_ismi = 'Ali' WHERE stu_id = 4;
UPDATE oquvchi SET oquvchi_ismi = 'Salima' WHERE stu_id = 1;
UPDATE oquvchi SET oquvchi_ismi = 'Javohir' WHERE stu_id = 3;
UPDATE oquvchi SET oquvchi_ismi = 'Ozod' WHERE stu_id = 5;

DELETE FROM teacher WHERE t_id = 3;
DELETE FROM teacher WHERE t_id = 1;
DELETE FROM teacher WHERE t_id = 5;
DELETE FROM teacher WHERE t_id = 2;


















