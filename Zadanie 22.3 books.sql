CREATE TABLE BOOKS_AUD (
	EVENT_ID INT(11) NOT NULL AUTO_INCREMENT,
    EVENT_DATE DATETIME NOT NULL,
    EVENT_TYPE VARCHAR(10) DEFAULT NULL,
    BOOK_ID INT(11) NOT NULL,
    NEW_TITLE VARCHAR(255),
    OLD_TITLE VARCHAR(255),
    NEW_PUBYEAR INT(4),
    OLD_PUBYEAR INT(4),
    NEW_BESTSELLER BOOLEAN,
    OLD_BESTSELLER BOOLEAN,
    PRIMARY KEY (EVENT_ID)
    );
       
  DELIMITER $$
  
  CREATE TRIGGER BOOKS_INSERT AFTER INSERT ON BOOKS
  FOR EACH ROW
  BEGIN
	INSERT INTO BOOKS_AUD (
		EVENT_DATE,
		EVENT_TYPE,
		BOOK_ID,
		NEW_TITLE,
		NEW_PUBYEAR,
		NEW_BESTSELLER
	)
	VALUES (
		CURTIME(),
        "INSERT",
        NEW.BOOK_ID,
        NEW.TITLE,
        NEW.PUBYEAR,
        NEW.BESTSELERS
	);
END $$

DELIMITER ;

DELIMITER $$

  CREATE TRIGGER BOOKS_DELETE AFTER DELETE ON BOOKS
  FOR EACH ROW
  BEGIN
	INSERT INTO BOOKS_AUD (
		EVENT_DATE,
		EVENT_TYPE,
		BOOK_ID,
		OLD_TITLE,
		OLD_PUBYEAR,
		OLD_BESTSELLER
	)
	VALUES (
		CURTIME(),
        "DELETE",
        OLD.BOOK_ID,
        OLD.TITLE,
        OLD.PUBYEAR,
        OLD.BESTSELERS
	);
END $$

DELIMITER ;

DELIMITER $$

  CREATE TRIGGER BOOKS_UPDATE AFTER UPDATE ON BOOKS
  FOR EACH ROW
  BEGIN
	INSERT INTO BOOKS_AUD (
		EVENT_DATE,
		EVENT_TYPE,
		BOOK_ID,
		NEW_TITLE,
		OLD_TITLE,
		NEW_PUBYEAR,
		OLD_PUBYEAR,
		NEW_BESTSELLER,
		OLD_BESTSELLER
	)
	VALUES (
		CURTIME(),
        "UPDATE",
		OLD.BOOK_ID,
        NEW.TITLE,
        OLD.TITLE,
        NEW.PUBYEAR,
        OLD.PUBYEAR,
        NEW.BESTSELERS,
        OLD.BESTSELERS
	);
END $$

DELIMITER ;    
    