USE xxx;

	
DELIMITER //

CREATE PROCEDURE insertKH(
	Ma_KH_n INT,
    CMND_n INT,
    Ten_n VARCHAR(255),
    Mail_n VARCHAR(255)
)
BEGIN
	IF Ma_KH_n IS NULL THEN 
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Mã khách hàng rỗng';
	END IF;
    IF CMND_n IS NULL THEN 
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'CMND rỗng';
	END IF;
    IF Ten_n IS NULL THEN 
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Tên khách hàng rỗng';
	END IF;
    IF Mail_n NOT LIKE "%@gmail.com" THEN  
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'Email không đúng mẫu @gmail.com';
    END IF;
    INSERT INTO khach_hang VALUE (Ma_KH_n, CMND_n, Ten_n, Mail_n);
END //


CREATE PROCEDURE updateKHfromMaKH(
	Ma_KH_update INT,
    updateCMND BOOLEAN,
    CMND_n INT,
    updateTen BOOLEAN,
    Ten_n VARCHAR(255),
    updateMail BOOLEAN,
    Mail_n VARCHAR(255)
)
BEGIN
	IF NOT EXISTS (SELECT Ma_KH FROM khach_hang WHERE Ma_KH = Ma_KH_update) THEN 
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Không tồn tại khách hàng theo mã khách hàng đã nhập';
    END IF;
    
	IF updateCMND THEN 
		IF CMND_n IS NULL THEN 
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'CMND rỗng';
		END IF;
        UPDATE khach_hang
		SET CMND = CMND_n
		WHERE Ma_KH = Ma_KH_update;
    END IF;
    
    IF updateTen THEN 
		IF Ten_n IS NULL THEN 
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'Tên khách hàng rỗng';
		END IF;
        UPDATE khach_hang
		SET Ten = Ten_n
		WHERE Ma_KH = Ma_KH_update;
    END IF;
    
    IF updateMail THEN 
		IF Mail_n NOT LIKE "%@gmail.com" THEN  
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'Email không đúng mẫu @gmail.com';
		END IF;
        UPDATE khach_hang
		SET Mail = Mail_n
		WHERE Ma_KH = Ma_KH_update;
    END IF;
	
END //

CREATE PROCEDURE updateKHfromCMND(
	CMND_update INT,
    updateMa_KH BOOLEAN,
    Ma_KH_n INT,
    updateTen BOOLEAN,
    Ten_n VARCHAR(255),
    updateMail BOOLEAN,
    Mail_n VARCHAR(255)
)
BEGIN
	IF NOT EXISTS (SELECT CMND FROM khach_hang WHERE CMND = CMND_update) THEN 
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Không tồn tại khách hàng theo CMND đã nhập';
    END IF;
    
	IF updateMa_KH THEN 
		IF Ma_KH_n IS NULL THEN 
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'Mã khách hàng rỗng';
		END IF;
        UPDATE khach_hang
		SET Ma_KH = Ma_KH_n
		WHERE CMND = CMND_update;
    END IF;
    
    IF updateTen THEN 
		IF Ten_n IS NULL THEN 
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'Tên khách hàng rỗng';
		END IF;
        UPDATE khach_hang
		SET Ten = Ten_n
		WHERE CMND = CMND_update;
    END IF;
    
    IF updateMail THEN 
		IF Mail_n NOT LIKE "%@gmail.com" THEN  
			SIGNAL SQLSTATE '45000' 
				SET MESSAGE_TEXT = 'Email không đúng mẫu @gmail.com';
		END IF;
        UPDATE khach_hang
		SET Mail = Mail_n
		WHERE CMND = CMND_update;
    END IF;
	
END //

CREATE PROCEDURE deleteKHfromMaKH(
	Ma_KH_delete INT
)
BEGIN
	IF NOT EXISTS (SELECT Ma_KH FROM khach_hang WHERE Ma_KH = Ma_KH_delete) THEN 
		SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Không tồn tại khách hàng theo mã khách hàng đã nhập';
    END IF;
	DELETE FROM khach_hang WHERE Ma_KH = Ma_KH_delete;
END //
DELIMITER ;