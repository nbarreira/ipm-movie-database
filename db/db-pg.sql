DROP TABLE users;

CREATE TABLE users (
	id SERIAL NOT NULL,
	username VARCHAR(80) NOT NULL,
	email VARCHAR(120)  NOT NULL,
	passwd VARCHAR(80) NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY(id)
);

DROP TABLE movies;
CREATE TABLE movies (
	id SERIAL NOT NULL,
	title VARCHAR(255) NOT NULL,
	synopsis TEXT,
	cover VARCHAR(500),
	editor INTEGER NOT NULL,
	year INTEGER NOT NULL,
	category VARCHAR(100),
	CONSTRAINT movies_pk PRIMARY KEY(id),
	CONSTRAINT movies_fk FOREIGN KEY(author) REFERENCES users(id)
);
	
	
DROP TABLE comments;
CREATE TABLE comments (
	id SERIAL NOT NULL,
	content TEXT NOT NULL,
	author INTEGER NOT NULL,
	comment_date DATE NOT NULL,
	movie INTEGER NOT NULL,
	CONSTRAINT comments_pk PRIMARY KEY(id),
	CONSTRAINT comments_fk1 FOREIGN KEY(movie) REFERENCES movies(id),
	CONSTRAINT comments_fk2 FOREIGN KEY(author) REFERENCES users(id)
);

DROP TABLE favs;
CREATE TABLE favs (
	id SERIAL NOT NULL,
	movie INTEGER NOT NULL,
	user_id  INTEGER NOT NULL,
	CONSTRAINT favs_pk PRIMARY KEY(id),
	CONSTRAINT favs_fk1 FOREIGN KEY(movie) REFERENCES movies(id),
	CONSTRAINT favs_fk2 FOREIGN KEY(user_id) REFERENCES users(id)
);	

INSERT INTO users(name, email, passwd) VALUES('noelia', 'noelia.barreira@udc.es', 'noelia.1');
INSERT INTO users(name, email, passwd) VALUES('marcos', 'marcos.ortega@udc.es', 'marcos.1');
INSERT INTO users(name, email, passwd) VALUES('david', 'cabrero@udc.es', 'david.1');

