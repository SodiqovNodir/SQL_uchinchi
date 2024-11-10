-- O'chirish
DROP IF EXISTS attendance;
DROP IF EXISTS grade;
DROP IF EXISTS enrollment;
DROP IF EXISTS subject;
DROP IF EXISTS s_class;
DROP IF EXISTS student;
DROP IF EXISTS teacher;
DROP IF EXISTS school;

-- -----------------------------------------------------------------
-- Yaratish
CREATE TABLE IF NOT EXISTS school(
	s_id SERIAl PRIMARY KEY,
	s_name TEXT,
	address TEXT,
	phone_number CHAR(13),
	davlat_maktabi BOOL
);

CREATE TABLE IF NOT EXISTS teacher(
	t_id SERIAL PRIMARY KEY,
	t_name TEXT
	t_last_name TEXT,
	t_email TEXT
	phone_number CHAR(13),
	s_id INTEGER REFERENCES school(s_id)
);

CREATE TABLE IF NOT EXISTS student(
	stu_id SERIAL PRIMARY KEY,
	stu_name TEXT,
	stu_last_name TEXT,
	date_of_birth DATE,
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
	enrollment_date CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS grade(
	grade_id SERIAl PRIMARY KEY,
	stu_id INTEGER REFERENCES student(stu_id),
	sub_id INTEGER REFERENCES subject(sub_id),
	grade_value TEXT,
	date_given CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS attendance(
	att_id SERIAl PRIMARY KEY,
	stu_id INTEGER REFERENCES student(stu_id),
	c_id INTEGER REFERENCES s_class(c_id),
	att_date CURRENT_DATE
);

-- -------------------------------------------------------
-- Qiymat briktirish





