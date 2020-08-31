CREATE TABLE INSTRUCTOR (

	ins_id INTEGER NOT NULL,
	lastname CHAR NOT NULL,
	firstname CHAR NOT NULL,
	city CHAR,
	country CHAR,
	PRIMARY KEY (ins_id) 
	
	);
	
	
INSERT INTO INSTRUCTOR
	(ins_id, lastname, firstname, city, country)
VALUES
	(1, 'Ahuja', 'Rav', 'Toronto', 'CA');
	

INSERT INTO INSTRUCTOR
	(ins_id, lastname, firstname, city, country)
VALUES
	(2, 'Chong', 'Raul', 'Toronto', 'CA'),
	(3, 'Vasudevan', 'Hima', 'Chicago', 'US');