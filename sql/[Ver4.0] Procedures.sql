
########################
########################
#                                            
# 		Transactions PART A
#                                           
########################
########################
SET SQL_SAFE_UPDATES = 0;
DROP PROCEDURE IF EXISTS `CreateAccount`;

DELIMITER $$
	CREATE PROCEDURE CreateAccount 
    (IN 	Id		 		VARCHAR(24)		,
	 IN 	Passwd	VARCHAR(24)		,
	 IN 	Last 		VARCHAR(20)		,
	 IN	First			VARCHAR(20)		,		-- First Name
	 IN 	Addr		VARCHAR(50)		,
     IN 	City			VARCHAR(20)		,
     IN 	State		VARCHAR(20)		,
     IN	Zip			VARCHAR(5)			,
     IN	Tele			BIGINT					,
     IN	Email		VARCHAR(50)		,
     IN	CCN		BIGINT UNSIGNED,		-- Credit Card Number
     IN	PPP			VARCHAR(1)			,
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateId 	INTEGER DEFAULT 1;
        DECLARE InvalidState 	INTEGER DEFAULT 2;
        DECLARE InvalidZip		INTEGER DEFAULT 3;
        DECLARE InvalidTele 	INTEGER DEFAULT 4;
        DECLARE InvalidCCN 	INTEGER DEFAULT 5;
        DECLARE InvalidPPP 	INTEGER DEFAULT 6;
        
        -- NULL Id
        IF (0 <> (SELECT COUNT(*) FROM Customer C WHERE C.ID = ID))
			THEN
				SET Status = DuplicateId;
		-- Invalid Zip
		ELSEIF (Zip NOT REGEXP '^[0-9]+$')
			THEN
				SET Status = InvalidZip;
		-- Invalid Tele
		ELSEIF (Tele <= 999999999 OR Tele > 9999999999)
			THEN
				SET Status = InvalidTele;
		-- Invalid Credit Card Number
		ELSEIF (CCN <= 999999999999999 OR CCN > 9999999999999999)
			THEN
				SET Status = InvalidCCN;
		-- Invalid Profile Placement Priority
		ELSEIF (NOT(PPP = 'A' OR PPP = 'B'  OR PPP = 'C'))
			THEN
				SET Status = InvalidPPP;
		-- Valid Input
        ELSE
			INSERT INTO Customer (Id, Password, Last, First, Addr, City, State, Zip, Tele, Email, ACD, CCN, PPP)
					VALUES(Id,Passwd, Last, First, Addr, City, State, Zip, Tele, Email, CURRENT_TIMESTAMP, CCN, PPP);
			SET Status = Success;
		END IF;
            
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DeleteAccount`;

DELIMITER $$
	CREATE PROCEDURE DeleteAccount 
    (
		IN 		AccId		 	VARCHAR(24)		,
		OUT 	Status			INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 	INTEGER DEFAULT 0;
        DECLARE Failure	 	INTEGER DEFAULT 1;
        DECLARE InvalidId	 	INTEGER DEFAULT 2;
        
        -- NULL Id
        IF AccId IS NULL
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = AccId))
			THEN
				SET Status = Failure;
		-- Valid Input
        ELSE
			DELETE FROM CUSTOMER WHERE Id = AccId;

            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateAccountId`;

DELIMITER $$
	CREATE PROCEDURE UpdateAccountId 
    (IN 	OldId		 	VARCHAR(24)		,
	 IN 	NewId			VARCHAR(24)		,
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE NoChange	 	INTEGER DEFAULT 1;
        DECLARE DuplicateId 	INTEGER DEFAULT 2;
        DECLARE NoSuchId	 	INTEGER DEFAULT 3;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = OldId))
			THEN
				SET Status = NoSuchId;
		-- Same Id
        ELSEIF (OldId = NewId)
			THEN
				SET Status = NoChange;
		-- Duplicate Id
        ELSEIF (0 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = NewId))
			THEN
				SET Status = DuplicateId;
		-- Valid Input
        ELSE
			UPDATE Customer SET Id = NewId WHERE Id = OldId;
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateAccountCCN`;

DELIMITER $$
	CREATE PROCEDURE UpdateAccountCCN
    (IN 	UId		 		VARCHAR(24)			,
	 IN 	NewCCN		BIGINT UNSIGNED	,
     OUT Status		INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE Failure		 	INTEGER DEFAULT 1;
        DECLARE NoSuchId	 	INTEGER DEFAULT 2;
        
       -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = UId))
			THEN
				SET Status = NoSuchId;
		-- Invalid Credit Card Number
		ELSEIF (NewCCN <= 999999999999999 OR NewCCN > 9999999999999999)
			THEN
				SET Status = Failure;
		-- Valid Input
        ELSE
			UPDATE Customer SET CCN = NewCCN WHERE Id = UId;
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateAccountAddress`;

DELIMITER $$
	CREATE PROCEDURE UpdateAccountAddress
    (IN 	UId		 			VARCHAR(24)		,
	 IN 	NewAddr			VARCHAR(50)		,
     IN 	NewCity			VARCHAR(20)		,
     IN 	NewState		VARCHAR(20)		,
     IN	NewZip			VARCHAR(5)			,	
     OUT Status			INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE Failure		 	INTEGER DEFAULT 1;
        DECLARE NoSuchId	 	INTEGER DEFAULT 2;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = UId))
			THEN
				SET Status = NoSuchId;
		-- Invalid Zip
		ELSEIF (NewZip NOT REGEXP '^[0-9]+$')
			THEN
				SET Status = Failure;
		-- Valid Input
        ELSE
			UPDATE Customer SET Addr = NewAddr, City = NewCity, 
					State = NewState, Zip = NewZip WHERE Id = UId;
			SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateAccountInfo`;

DELIMITER $$
	CREATE PROCEDURE UpdateAccountInfo
    (IN 	UId		 			VARCHAR(24)		,
	 IN 	NewFirst			VARCHAR(20)		,
     IN 	NewLast			VARCHAR(20)		,
     IN 	NewTele			BIGINT					,
     IN	NewEmail		VARCHAR(50)		,	
     OUT Status			INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE Failure		 	INTEGER DEFAULT 1;
        DECLARE NoSuchId	 	INTEGER DEFAULT 2;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = UId))
			THEN
				SET Status = NoSuchId;
		-- Invalid Tele
		ELSEIF (NewTele <= 999999999 OR NewTele > 9999999999)
			THEN
				SET Status = Failure;
		-- Valid Input
        ELSE
			UPDATE Customer SET First = NewFirst, Last = NewLast, 
					Tele = NewTele, Email = NewEmail WHERE Id = UId;
			SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateAccountPPP`;

DELIMITER $$
	CREATE PROCEDURE UpdateAccountPPP
    (IN 	UId		 		VARCHAR(24)		,	-- Customer Account Number
	 IN 	NewPPP		VARCHAR(1)			, 	-- New PPP
     OUT Status		INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE Failure		 	INTEGER DEFAULT 1;
        DECLARE NoSuchId	 	INTEGER DEFAULT 2;
        
       -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM Customer C WHERE C.Id = UId))
			THEN
				SET Status = NoSuchId;
		-- Invalid PPP
		ELSEIF (NOT(NewPPP = 'A' OR NewPPP = 'B'  OR NewPPP = 'C'))
			THEN
				SET Status = Failure;
		-- Valid Input
        ELSE
			UPDATE Customer SET PPP = NewPPP WHERE Id = UId;
            UPDATE PROFILE	SET PPP = NewPPP	WHERE Cid = UId;
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `CreateDate`;

DELIMITER $$
	CREATE PROCEDURE CreateDate
    (IN 	PIdA		 	VARCHAR(24)				, -- UserA Id 
	 IN 	PIdB			VARCHAR(24)				, -- UserB Id 
     IN 	DTime			TIMESTAMP					, -- Date Time
     IN	DLocation	VARCHAR(100)				, -- Geo Location (Null if no)
     IN	DZip			VARCHAR(5)					, -- ZIP
     IN	DFee			DOUBLE UNSIGNED		, -- Date Fee
     IN 	DRepId		VARCHAR(9)					, -- Customer Representative
     OUT Status		INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE Failure		 	INTEGER DEFAULT 1;
        DECLARE NoSuchId	 	INTEGER DEFAULT 2;
        DECLARE SameUser		INTEGER DEFAULT 3;
        DECLARE NoSuchRep	INTEGER DEFAULT 4;
        
       -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PIdA))
			THEN
				SET Status = NoSuchId;
		ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PIdB))
			THEN
				SET Status = NoSuchId;
		-- Same User 
        ELSEIF (PIdA = PIdB)
			THEN
				SET Status = SameUser;
		ELSEIF ((SELECT CId FROM PROFILE WHERE Id = PIdA) = (SELECT CId FROM PROFILE WHERE Id = PIdB))
			THEN
				SET Status = Failure;
		-- Invalid Representative
		ELSEIF (1 <> (SELECT COUNT(*) FROM EMPLOYEE E WHERE E.SSN = DRepId))
			THEN
				SET Status = NoSuchRep;
		ELSEIF (DZip NOT REGEXP '^[0-9]+$')
			THEN 
				SET Status = Failure;
		-- Invalid Time
		ELSEIF (DTime < CURRENT_TIMESTAMP)
			THEN
				SET Status = Failure;		
		-- Valid Input
        ELSE
			INSERT INTO DATEDATA (UserAId, UserBId, DateTime, GeoLoc, ZipCode, Fee, RepId)
					VALUES(PIdA, PIDB, DTime, DLocation, DZip, DFee, DRepId);
                    
			UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + DFee WHERE Id = PIdA;
            UPDATE PROFILE SET NumPDate = NumPDate + 1, TotalFee = TotalFee + DFee WHERE Id = PIdB;
            
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `CancelDate`;

DELIMITER $$
	CREATE PROCEDURE CancelDate 
    (IN 	DId		 	BIGINT UNSIGNED		, -- DateId
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 	INTEGER DEFAULT 0;
        DECLARE Failure	 	INTEGER DEFAULT 1;
        DECLARE InvalidId	 	INTEGER DEFAULT 2;
        
        -- NULL Id
        IF NULL = DId
			THEN
				SET Status = InvalidId;
		-- No Such Date
        ELSEIF (1 <> (SELECT COUNT(*) FROM DATEDATA D WHERE D.DateId = DId AND D.DateTime > CURRENT_TIMESTAMP))
			THEN
				SET Status = Failure;
		-- Valid Input
        ELSE
            
            UPDATE PROFILE SET NumPDate = NumPDate - 1 WHERE Id = (SELECT UserAId FROM DATEDATA WHERE DateId = DId);
            UPDATE PROFILE SET NumPDate = NumPDate - 1 WHERE Id = (SELECT UserBId FROM DATEDATA WHERE DateId = DId);
            
			DELETE FROM DATEDATA WHERE DateId = DId;
            
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `CommentAndRateDate`;

DELIMITER $$
	CREATE PROCEDURE CommentAndRateDate 
    (IN 	DId		 			BIGINT UNSIGNED		, -- DateId
     IN	PIdA				VARCHAR(24)				, -- User Id
     IN	DRate				DOUBLE									, -- Rate
     IN	DComment		VARCHAR(250)				, -- Comment
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE Failure	 		INTEGER DEFAULT 1;
        DECLARE InvalidId	 		INTEGER DEFAULT 2;
        DECLARE InvalidRate	INTEGER DEFAULT 3;
        
        -- NULL Id
        IF DId IS NULL
			THEN
				SET Status = InvalidId;
		-- No Such Date
        ELSEIF (1 <> (SELECT COUNT(*) FROM DATEDATA D WHERE D.DateId = DId))
			THEN
				SET Status = InvalidId;
		-- Invalid Rate
		ELSEIF (DRate < 1 OR DRate > 5)
			THEN
				SET Status = InvalidRate;
                
		-- Case 1: User A
        ELSEIF (1 = (SELECT COUNT(*) FROM DATEDATA D WHERE (D.DateId = DId AND D.UserAId = PIdA AND D.DateTime < CURRENT_TIMESTAMP AND D.RateA = 0)))
			THEN
				UPDATE DATEDATA SET CommentA = DComment, RateA = DRate WHERE (DateId = DId AND UserAId = PIdA);
                -- Update UserB's Profile Num of Date
                UPDATE PROFILE 
                SET NumPDate = NumPDate  - 1, NumCDate = NumCDate + 1 
				WHERE Id = (SELECT UserBId FROM DATEDATA WHERE DateId = DId);
                -- Update UserB's Profile AVG Rate
                UPDATE PROFILE 
                SET TotalRate =  ((TotalRate * (NumCDate - 1) + DRate) / NumCDate)
				WHERE Id = (SELECT UserBId FROM DATEDATA WHERE DateId =  DId);
				SET Status = Success;
                
		-- Case 2: User B
        ELSEIF (1 = (SELECT COUNT(*) FROM DATEDATA D WHERE (D.DateId = DId AND D.UserBId = PIdA AND D.DateTime < CURRENT_TIMESTAMP AND D.RateB = 0)))
			THEN
				UPDATE DATEDATA SET CommentB = DComment, RateB = DRate WHERE (DateId = DId AND UserBId = PIdA);
                -- Update UserA's Profile Num of Date
                UPDATE PROFILE 
                SET NumPDate = NumPDate  - 1, NumCDate = NumCDate + 1 
				WHERE Id = (SELECT UserAId FROM DATEDATA WHERE DateId =  DId);
                -- Update UserA's Profile AVG Rate
                UPDATE PROFILE 
                SET TotalRate = ((TotalRate * (NumCDate - 1) + DRate) / NumCDate)
				WHERE Id = (SELECT UserAId FROM DATEDATA WHERE DateId =  DId);
				SET Status = Success;
                
		-- Inalid Input
        ELSE
            SET Status = Failure;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `LikeAProfile`;

DELIMITER $$
	CREATE PROCEDURE LikeAProfile 
    (IN 	PLikerId		 		VARCHAR(24)		, -- LikerId
     IN	PLikeeId				VARCHAR(24)		, -- LikeeId 
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 			INTEGER DEFAULT 0;
        DECLARE Failure	 			INTEGER DEFAULT 1;
        DECLARE InvalidId	 			INTEGER DEFAULT 2;
        DECLARE DuplicateLike	INTEGER DEFAULT 3;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PLikerId))
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PLikeeId))
			THEN
				SET Status = InvalidId;
		-- Duplicate Like
        ELSEIF (0 <> (SELECT COUNT(*) FROM LIKES L WHERE L.LikeeId = PLikeeId AND L.LikerId = PLikerId))
			THEN
				SET Status = DuplicateLike;
		-- Valid Input
        ELSE
			INSERT INTO LIKES(LikerId, LikeeId, DateTime) VALUES (PLikerId, PLikeeId, CURRENT_TIMESTAMP);
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UnlikeAProfile`;

DELIMITER $$
	CREATE PROCEDURE UnlikeAProfile 
    (IN 	PLikerId		 		VARCHAR(24)		, -- LikerId
     IN	PLikeeId				VARCHAR(24)		, -- LikeeId 
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 			INTEGER DEFAULT 0;
        DECLARE Failure	 			INTEGER DEFAULT 1;
        DECLARE InvalidId	 			INTEGER DEFAULT 2;
        DECLARE NoSuchLike		INTEGER DEFAULT 3;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PLikerId))
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PLikeeId))
			THEN
				SET Status = InvalidId;
		-- Duplicate Like
        ELSEIF (1 <> (SELECT COUNT(*) FROM LIKES L WHERE L.LikeeId = PLikeeId AND L.LikerId = PLikerId))
			THEN
				SET Status = NoSuchLike;
		-- Valid Input
        ELSE
			DELETE FROM LIKES WHERE (LikerId = PLikerId AND LikeeId = PLikeeId);
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `ReferAProfile`;

DELIMITER $$
	CREATE PROCEDURE ReferAProfile 
    (IN 	PUserA		 		VARCHAR(24)		, -- UserA
     IN	PUserB				VARCHAR(24)		, -- UserB 
     IN	PUserC				VARCHAR(24)		, -- UserC 
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 			INTEGER DEFAULT 0;
        DECLARE Failure	 			INTEGER DEFAULT 1;
        DECLARE InvalidId	 			INTEGER DEFAULT 2;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PUserA))
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PUserB))
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PUserC))
			THEN
				SET Status = InvalidId;
		-- Same Profile
        ELSEIF (PUserA = PUserB OR PUserB = PUserC OR PUserA = PUserC)
			THEN
				SET Status = Failure;
		-- Same Customer
        ELSEIF ((SELECT CId FROM PROFILE WHERE Id = PUserA) = (SELECT CId FROM PROFILE WHERE Id = PUserB))
			THEN
				SET Status = Failure;
		ELSEIF ((SELECT CId FROM PROFILE WHERE Id = PUserA) = (SELECT CId FROM PROFILE WHERE Id = PUserC))
			THEN
				SET Status = Failure;
        ELSEIF ((SELECT CId FROM PROFILE WHERE Id = PUserB) = (SELECT CId FROM PROFILE WHERE Id = PUserC))
			THEN
				SET Status = Failure;
        -- Valid Input
        ELSE
			INSERT INTO REFERAL(UserA, UserB, UserC, DateTime) VALUES (PUserA, PUserB, PUserC, CURRENT_TIMESTAMP);
            SET Status = Success;
		END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `SuggestAProfile`;

DELIMITER $$
	CREATE PROCEDURE SuggestAProfile 
    (IN 	RepSSN		 		VARCHAR(9)			, -- UserA
     IN	PUserB				VARCHAR(24)		, -- UserB 
     IN	PUserC				VARCHAR(24)		, -- UserC 
     OUT Status	INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 			INTEGER DEFAULT 0;
        DECLARE Failure	 			INTEGER DEFAULT 1;
        DECLARE InvalidId	 			INTEGER DEFAULT 2;
        
        -- No Such Id
        IF (1 <> (SELECT COUNT(*) FROM EMPLOYEE P WHERE P.SSN = RepSSN))
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PUserB))
			THEN
				SET Status = InvalidId;
		-- No Such Id
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = PUserC))
			THEN
				SET Status = InvalidId;
		-- Same Profile
        ELSEIF (PUserB = PUserC)
			THEN
				SET Status = Failure;
		-- Same Customer
        ELSEIF ((SELECT CId FROM PROFILE WHERE Id = PUserB) = (SELECT CId FROM PROFILE WHERE Id = PUserC))
			THEN
				SET Status = Failure;
        -- Valid Input
        ELSE
			INSERT INTO SUGGESTBY(RepId, UserB, UserC, DateTime) VALUES (RepSSN, PUserB, PUserC, CURRENT_TIMESTAMP);
            SET Status = Success;
		END IF;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `GetPendingDates`;

DELIMITER $$
	CREATE PROCEDURE GetPendingDates 
    (
		IN PId 		VARCHAR(24)	-- Profile ID
    )
    
    BEGIN
			SELECT DISTINCT DateId, UserAId, UserBId, DateTime, GeoLoc, Fee
            FROM DATEDATA 
            WHERE DateTime >= CURRENT_TIMESTAMP AND (UserAId = PId OR UserBId = PId);
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `GetPastDates`;

DELIMITER $$
	CREATE PROCEDURE GetPastDates 
    (
		IN PId 		VARCHAR(24) 	-- Profile ID
    )
    
    BEGIN
			SELECT DISTINCT DateId, UserAId, UserBId, DateTime, GeoLoc, Fee 
            FROM DATEDATA 
            WHERE DateTime < CURRENT_TIMESTAMP AND (UserAId = PId OR UserBId = PId);
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `GetLikeList`;

DELIMITER $$
	CREATE PROCEDURE GetLikeList
    (
		IN PId 	VARCHAR(24)	-- Profile ID
    )
    
    BEGIN
			SELECT DISTINCT LikeeID
            FROM LIKES 
            WHERE LikerId = PId;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `GetBeLikedList`;

DELIMITER $$
	CREATE PROCEDURE GetBeLikedList
    (
		IN PId 	VARCHAR(24)	-- Profile ID
    )
    
    BEGIN
			SELECT DISTINCT LikerID
            FROM LIKES 
            WHERE LikeeId = PId;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `SearchBaseOnAge`;

DELIMITER $$
	CREATE PROCEDURE SearchBaseOnAge
    (
    	IN ProfId 	VARCHAR(24)		,	-- Exclude Searcher
		IN SAgeMin 	INT UNSIGNED	, 
        IN SAgeMax 	INT UNSIGNED 	
    )
    
    BEGIN
			SELECT DISTINCT Id, Age, TotalRate AS Rate
            FROM PROFILE 
            WHERE Age >= SAgeMin AND Age <= SAgeMax 
							AND Id <> ProfId AND CId <> (SELECT CId FROM PROFILE WHERE Id = ProfId)
                            -- AND Gender <> (SELECT Gender FROM PROFILE WHERE Id = ProfId)
            ORDER BY AGE ASC, TotalRate DESC;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `SearchBaseOnCityNState`;

DELIMITER $$
	CREATE PROCEDURE SearchBaseOnCityNState
    (
		IN ProfId 			VARCHAR(24)		,	-- Exclude Searcher
		IN SCity     		VARCHAR(20)	, 
        IN SState   		VARCHAR(20) 	
    )
    
    BEGIN
			SELECT Id, TotalRate AS Rate
            FROM PROFILE 
            WHERE City = SCity AND State = SState 
							AND Id <> ProfId AND CId <> (SELECT CId FROM PROFILE WHERE Id = ProfId)
                            -- AND Gender <> (SELECT Gender FROM PROFILE WHERE Id = ProfId)
			ORDER BY TotalRate DESC;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `SearchBaseOnState`;

DELIMITER $$
	CREATE PROCEDURE SearchBaseOnState
    (
        IN ProfId 			VARCHAR(24)		,	-- Exclude Searcher
        IN SState   		VARCHAR(20) 	
    )
    
    BEGIN
			SELECT Id, TotalRate AS Rate
            FROM PROFILE 
            WHERE State = SState 
							AND Id <> ProfId AND CId <> (SELECT CId FROM PROFILE WHERE Id = ProfId)
                            -- AND Gender <> (SELECT Gender FROM PROFILE WHERE Id = ProfId)
			ORDER BY TotalRate DESC;
            
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `SearchBaseOnPhyCharHW`;

DELIMITER $$
	CREATE PROCEDURE SearchBaseOnPhyCharHW
    (
    	IN ProfId 			VARCHAR(24)		,	-- Exclude Searcher
        IN SHeightMin   		DOUBLE,
        IN SHeightMax		DOUBLE,
		IN SWeightMin   		DOUBLE,
        IN SWeightMax		DOUBLE
    )
    
    BEGIN
			SELECT Id, TotalRate AS Rate
            FROM PROFILE 
            WHERE Height >= SHeightMin AND Height <= SHeightMax 
            		AND Weight >= SWeightMin AND Weight <= SWeightMax 
                    AND Id <> ProfId AND CId <> (SELECT CId FROM PROFILE WHERE Id = ProfId)
                    -- AND Gender <> (SELECT Gender FROM PROFILE WHERE Id = ProfId)
			ORDER BY TotalRate DESC;
            
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `SearchBaseOnPhyCharHWC`;

DELIMITER $$
	CREATE PROCEDURE SearchBaseOnPhyCharHWC
    (
    	IN ProfId 					VARCHAR(24)		,	-- Exclude Searcher
        IN SHeightMin   		DOUBLE,
        IN SHeightMax		DOUBLE,
		IN SWeightMin   		DOUBLE,
        IN SWeightMax		DOUBLE,
        IN SHairColor			VARCHAR(20)
    )
    
    BEGIN
			SELECT Id, TotalRate AS Rate
            FROM PROFILE 
            WHERE Height >= SHeightMin AND Height <= SHeightMax 
							AND Weight >= SWeightMin AND Weight <= SWeightMax 
							AND HColor = SHairColor 
                            AND Id <> ProfId AND CId <> (SELECT CId FROM PROFILE WHERE Id = ProfId)
                            -- AND Gender <> (SELECT Gender FROM PROFILE WHERE Id = ProfId)
			ORDER BY TotalRate DESC;
            
	END$$
DELIMITER ;

########################
########################
#                                            
# 		Transactions PART B
#                                           
########################
########################


DROP PROCEDURE IF EXISTS `CreateProfile`;

DELIMITER $$
	CREATE PROCEDURE CreateProfile
    (
		IN 	pCId 				VARCHAR(24), 
        IN 	pId 					VARCHAR(24), 
		IN 	pName 			VARCHAR(20),
		IN 	pAge  				INT UNSIGNED,
        IN 	pAddr     			VARCHAR(50),
        IN 	pCity     			VARCHAR(20),
        IN 	pState   			VARCHAR(20),
        IN 	pGender   		VARCHAR(6),
        IN 	pGeoRange 	DOUBLE UNSIGNED,
        IN 	pAgeMin   		INT UNSIGNED,
        IN 	pAgeMax   		INT UNSIGNED,
        OUT status 				INTEGER
    )
    
    BEGIN
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateId 	INTEGER DEFAULT 1;
        DECLARE InvalidGender	INTEGER DEFAULT 2;
        DECLARE InvalidRange		INTEGER DEFAULT 3;
        DECLARE Failure	 	INTEGER DEFAULT 4;
        
        
        IF pId IS NULL 
			THEN
				SET status = DuplicateId;
        ELSEIF (0 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = pId))
			THEN
				SET status = DuplicateId;
		-- Invalid Custumer Id
		ELSEIF (1 <> (SELECT COUNT(*) FROM CUSTOMER C WHERE C.Id = pCId))
			THEN
				SET status = Failure;
		-- Check Gender
		ELSEIF (pGender <> 'Female' AND pGender <> 'Male')
			THEN
				SET status = InvalidGender;
		-- Check Range
		ELSEIF (pAgeMin > pAgeMax)
			THEN
				SET status = InvalidRange;
		-- Valid
        ELSE
			INSERT INTO PROFILE (Id, Name, Age, Addr, City, State, Gender, GeoRange, AgeMin, AgeMax, CreateDate, CId, PPP)
					VALUES(pId, pName, pAge, pAddr, pCity, pState, pGender, pGeoRange, pAgeMin, pAgeMax, CURRENT_TIMESTAMP, pCId, (SELECT PPP FROM CUSTOMER WHERE Id = pCId));
                                        
			SET status = Success;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DeleteProfile`;

DELIMITER $$
CREATE PROCEDURE DeleteProfile 
    (
		IN 	pId		 	VARCHAR(24)		,
		OUT status		INTEGER			
	)
    
    BEGIN
		DECLARE Success 	INTEGER DEFAULT 0;
        DECLARE Failure	 	INTEGER DEFAULT 1;
        DECLARE InvalidId	 	INTEGER DEFAULT 2;
        
        IF pId IS NULL
			THEN
				SET status = InvalidId;
        ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.Id = pId))
			THEN
				SET status = Failure;
        ELSE
			DELETE FROM PROFILE WHERE Id = pId;
            SET status = Success;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateProfilePhyChar`;

DELIMITER $$
	CREATE PROCEDURE UpdateProfilePhyChar
    (
        IN	pId 				VARCHAR(24), 
        IN 	pGender		VARCHAR(6),
        IN	pHeight   		DOUBLE,
        IN	pWeight  		DOUBLE,
        IN	pHColor   	VARCHAR(20),
        IN	pHobby    	VARCHAR(100),
        OUT status 			INTEGER
    )
    
    BEGIN
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE InvalidId 	INTEGER DEFAULT 1;
        DECLARE InvalidGender	INTEGER DEFAULT 2;
        
        IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = pId))
			THEN
				SET status = InvalidId;
		ELSEIF (pGender <> 'Female' AND pGender <> 'Male')
			THEN
				SET status = InvalidGender;
        ELSE
			UPDATE PROFILE 
            SET Height = pHeight, Weight = pWeight, HColor = pHColor, Hobby = pHobby
            WHERE Id = pId;
	
			SET status = Success;
		END IF;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `UpdateProfileName`;

DELIMITER $$
	CREATE PROCEDURE UpdateProfileName
    (
        IN	ProfId				VARCHAR(24)	, 
		IN 	NewName		VARCHAR(20)			,
		OUT status	INTEGER			
    )
    
    BEGIN
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE NoSuchId	 	INTEGER DEFAULT 1;
        
		IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = ProfId))
			THEN
				SET status = NoSuchId;
        ELSE
			UPDATE PROFILE P SET P.Name = NewName WHERE P.Id = ProfId;
            SET status = Success;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateProfileSearchFilter`;

DELIMITER $$
	CREATE PROCEDURE UpdateProfileSearchFilter
    (
        IN	ProfId				VARCHAR(24)	, 
		IN  	pAge 				INT UNSIGNED,
        IN 	pGeoRange 	DOUBLE UNSIGNED,
        IN 	pAgeMin   		INT UNSIGNED,
        IN 	pAgeMax   		INT UNSIGNED,
		OUT status	INTEGER			
    )
    
    BEGIN
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateId 	INTEGER DEFAULT 1;
        DECLARE InvalidGender	INTEGER DEFAULT 2;
        
		IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = ProfId))
			THEN
				SET status = NoSuchId;
		-- Check Range
		ELSEIF (pAgeMin > pAgeMax)
			THEN
				SET status = InvalidRange;
		-- Valid
        ELSE
			UPDATE PROFILE P 
            SET P.Age = pAge, P.GeoRange = pGeoRange, P.AgeMin =  pAgeMin, P.AgeMax = pAgeMax 
            WHERE P.Id = ProfId;
            
            SET status = Success;
		END IF;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `CreatePhoto`;

DELIMITER $$
	CREATE PROCEDURE CreatePhoto
    (
		IN 		pId 		VARCHAR(24), 
		IN 		pURL 	VARCHAR(255),
		OUT	status 	INTEGER
	)
	BEGIN	
		DECLARE Success 	INTEGER DEFAULT 0;
        DECLARE Failure 		INTEGER DEFAULT 1;
        DECLARE Duplicate 	INTEGER DEFAULT 2;
        
        IF ((pURL IS NULL) OR pId IS NULL)
			THEN
				SET status = Failure;
		ELSEIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = pId))
			THEN
				SET status = Failure;
		ELSEIF (0 <> (SELECT COUNT(*) FROM PHOTOS P WHERE (P.Id = pId AND P.URL = pURL)))
			THEN
				SET status = Duplicate;
        ELSE
			INSERT INTO PHOTOS (Id, URL) VALUES(pId, pURL);
			SET status = Success;
            
		END IF;
    END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `DeletePhoto`;

DELIMITER $$
	CREATE PROCEDURE DeletePhoto 
    (
		IN 	pId		 	VARCHAR(24)		,
		IN	pURL 		VARCHAR(255)		,
		OUT status		INTEGER			
	)
    
    BEGIN
		DECLARE Success 	INTEGER DEFAULT 0;
        DECLARE Failure	 	INTEGER DEFAULT 1;
        DECLARE InvalidId	 	INTEGER DEFAULT 2;
        
        IF (pURL IS NULL OR pId IS NULL)
			THEN
				SET status = InvalidId;
        ELSEIF (0 = (SELECT COUNT(*) FROM PHOTOS P WHERE P.Id = pId AND P.URL = pURL))
			THEN
				SET status = Failure;
        ELSE
			DELETE FROM PHOTOS WHERE Id = pId AND URL = pURL;
            SET status = Success;
		END IF;
	END$$
    
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdatePhoto`;

DELIMITER $$
	CREATE PROCEDURE UpdatePhoto
    (
		IN 	pId		 		VARCHAR(24),
		IN 	OldURL 		VARCHAR(255),
		IN 	NewURL 		VARCHAR(255),
		OUT status			INTEGER			
	)
    
    BEGIN
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE NoChange	 	INTEGER DEFAULT 1;
        DECLARE NoSuchPhoto	 	INTEGER DEFAULT 2;
        
        IF (1 <> (SELECT COUNT(*) FROM PHOTOS P WHERE P.Id = pId AND P.URL = OldURL))
			THEN
				SET status = NoSuchPhoto;
        ELSEIF (OldURL = NewURL)
			THEN
				SET status = NoChange;
        ELSE
			UPDATE PHOTOS P SET  P.URL= NewURL WHERE P.Id = pId AND P.URL = OldURL;
            SET status = Success;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `ProduceListDatesCalendar`;

DELIMITER $$
	CREATE PROCEDURE ProduceListDatesCalendar -- List of Dates At Specific Time Period
    (	
		IN time1 TIMESTAMP,
		IN time2 TIMESTAMP
	)
    
    BEGIN
		SELECT 	DISTINCT *
        FROM 	DATEDATA D
        WHERE 	D.DateTime BETWEEN time1 AND time2
        ORDER BY DATETIME;
        
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `ProduceListDatesCustomer`;

DELIMITER $$
	CREATE PROCEDURE ProduceListDatesCustomer -- List of ALL Dates Of a Specific Customer
    (	
		IN cAccID  VARCHAR(24)
	)
    
    BEGIN
		SELECT DISTINCT *
        FROM DATEDATA D
        WHERE D.UserAId IN (SELECT Id FROM PROFILE WHERE CId = cAccID) 
						OR D.UserBId IN (SELECT Id FROM PROFILE WHERE CId = cAccID)
        ORDER BY DateTime
        ;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `ProduceSummaryRevenueCalendar`;

DELIMITER $$
	CREATE PROCEDURE ProduceSummaryRevenueCalendar
    (	
		IN time1 TIMESTAMP,
		IN time2 TIMESTAMP
	)
    
    BEGIN
		SELECT SUM(D.Fee) AS SummaryRevenue
        FROM DATEDATA D
        WHERE D.DateTime BETWEEN time1 AND time2;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `ProduceSummaryRevenueCustomer`;

DELIMITER $$
	CREATE PROCEDURE ProduceSummaryRevenueCustomer
    (	
		IN cAccID  VARCHAR(24)
	)
    
    BEGIN
		SELECT SUM(P.TotalFee) AS SummaryRevenue
        FROM PROFILE P
        WHERE P.CId = cAccID
		;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `CustRepMostRevenue`;

DELIMITER $$
	CREATE PROCEDURE CustRepMostRevenue
    (	
    
	)
	BEGIN
		DROP VIEW IF EXISTS TotalRevenue;
        
		CREATE VIEW TotalRevenue(RepId,TotalFee) AS
        SELECT D.RepId, SUM(D.Fee)
        FROM DATEDATA D
        WHERE D.RepId IS NOT NULL
        GROUP BY D.RepId;
            
        SELECT DISTINCT E.SSN AS SSN, E.FIRST AS First, E.LAST AS Last, MAX(R.TotalFee) AS TotalFee
        FROM EMPLOYEE E, TotalRevenue R
        WHERE E.SSN IN 
			(
				SELECT RepId
                FROM TotalRevenue T
                WHERE T.TotalFee = 
					(
						SELECT MAX(TotalFee)
                        FROM TotalRevenue
					)
            )
        GROUP BY E.SSN;
		
        DROP VIEW IF EXISTS TotalRevenue;
        
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `CustomerMostRevenue`;

DELIMITER $$
    CREATE PROCEDURE CustomerMostRevenue
    (   
    
    )
    BEGIN
    	DROP VIEW IF EXISTS TotalRevenue;
        
        CREATE VIEW TotalRevenue(CId, TotalFee) AS
        (
            SELECT P.CId, SUM(P.TotalFee) AS TotalFee
            FROM PROFILE P
			GROUP BY CId
        );

        SELECT DISTINCT C.ID AS ID, C.FIRST AS First, C.LAST AS Last, C.PPP AS PPP, MAX(R.TotalFee) AS TotalFee
		FROM CUSTOMER C, TotalRevenue R
		WHERE R.TotalFee = (SELECT MAX(TotalFee) FROM TotalRevenue) AND R.CId = C.Id
        GROUP BY C.Id;
            
        DROP VIEW IF EXISTS TotalRevenue;
        
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `MostActiveCustomers`;

DELIMITER $$
	CREATE PROCEDURE MostActiveCustomers
    (
		IN	MAXIMUM 	INT UNSIGNED	-- Maximum number of entries
    )
    
    BEGIN
    	DROP VIEW IF EXISTS TotalDates;
        
		CREATE VIEW TotalDates(Id, TotaDates) AS
		(
            SELECT T.CId AS Id, (SUM(T.NumCDate) + SUM(T.NumPDate)) AS TotaDates
            FROM PROFILE T
			GROUP BY T.CId
        );

        SELECT DISTINCT *
		FROM CUSTOMER C
		WHERE C.Id IN 
			(
				SELECT Id
				FROM TotalDates T
                WHERE T.TotaDates = (SELECT MAX(TotaDates) FROM TotalDates) AND T.TotaDates <> 0
            )
        ORDER BY PPP
        LIMIT MAXIMUM;
        
        DROP VIEW IF EXISTS TotalDates;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `HighRatedCalendarDates`;

DELIMITER $$
	CREATE PROCEDURE HighRatedCalendarDates
    (
		
    )
    
    BEGIN
    	DROP VIEW IF EXISTS DatesAsOfCalendar;
		CREATE VIEW DatesAsOfCalendar(Id, Date, Rate) AS
        (
			SELECT D.DateId, CAST(D.DateTime AS DATE), D.RateA
            FROM	DATEDATA D
            WHERE D.DateTime < CURRENT_TIMESTAMP AND D.RateA > 0 AND D.RateB = 0
		)
		UNION
		(	SELECT D.DateId, CAST(D.DateTime AS DATE), ((D.RateA + D.RateB) / 2.0)
            FROM	DATEDATA D
            WHERE D.DateTime < CURRENT_TIMESTAMP AND D.RateA > 0 AND D.RateB > 0
		)
        UNION
		(	SELECT D.DateId, CAST(D.DateTime AS DATE), D.RateB
            FROM	DATEDATA D
            WHERE D.DateTime < CURRENT_TIMESTAMP AND D.RateA = 0 AND D.RateB > 0
		);
        
        DROP VIEW IF EXISTS MergedCalendar;
        CREATE VIEW MergedCalendar(Date, AvgRate) AS
        (
			SELECT D.Date, AVG(D.Rate)
            FROM	DatesAsOfCalendar D
            GROUP BY D.Date
        );
        
        SELECT DATE
        FROM MergedCalendar M
        WHERE M.AvgRate = 
			(
				SELECT MAX(AvgRate)
                FROM MergedCalendar
            )
        ;
        
		DROP VIEW IF EXISTS DatesAsOfCalendar;
        DROP VIEW IF EXISTS MergedCalendar;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `ParticularCustDateList`;

DELIMITER $$
	CREATE PROCEDURE ParticularCustDateList -- Produce a list of all customers who have dated a particular customer
    (	
		IN 	cAccId 	VARCHAR(24)
	)
	BEGIN
        SELECT *
        FROM CUSTOMER C
        WHERE C.Id IN
			(
				SELECT P.CId
				FROM PROFILE P
				WHERE P.Id IN
					(
						SELECT Da.UserAId
						FROM DATEDATA Da
						WHERE Da.UserBId IN
							(
								SELECT T.Id
								FROM PROFILE T
								WHERE T.CId = cAccId
							)
					)
					OR
					P.Id IN (
						SELECT Db.UserBId
						FROM DATEDATA Db
						WHERE Db.UserAId IN
							(
								SELECT T.Id
								FROM PROFILE T
								WHERE T.CId = cAccId
							)
					)
			)
				;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `HighestRatedCustomer`;

DELIMITER $$
	CREATE PROCEDURE HighestRatedCustomer
    (	
		IN	MAXIMUM	INT UNSIGNED
	)
	BEGIN
		DROP VIEW IF EXISTS CustRate;
        
		CREATE VIEW CustRate (CustNum, Rating) AS 
        (
			SELECT P.CId AS CustNum, AVG(P.TotalRate) AS Rating
            FROM PROFILE P
			WHERE P.TotalRate > 0.0
			GROUP BY P.CId
        );
        
        SELECT DISTINCT *
		FROM CUSTOMER C
        WHERE C.Id IN 
			(
				SELECT CustNum
                FROM CustRate R
                WHERE R.Rating =  (SELECT MAX(Rating) FROM CustRate)
            )
        LIMIT MAXIMUM;

		DROP VIEW IF EXISTS CustRate;
        
	END$$
DELIMITER ;


########################
########################
#                                            
# 		Transactions PART C
#                                           
########################
########################

DROP PROCEDURE IF EXISTS `CreateEmployee`;

DELIMITER $$

	CREATE PROCEDURE CreateEmployee 
    (
		IN 		ESSN		 	VARCHAR(9)				,
        IN 		EPasswd		VARCHAR(24)			,
		IN 		ELast 			VARCHAR(20)			,
		IN	    EFirst			VARCHAR(20)			,		#First Name
		IN 		EAddr			VARCHAR(50)			,
		IN 		ECity			VARCHAR(20)			,
		IN 		EState			VARCHAR(20)			,
		IN	    EZip				VARCHAR(5)				,
		IN	    ETele			BIGINT UNSIGNED	,
        IN 		EEmail			VARCHAR(50)			,
		IN     	EHRate		DOUBLE UNSIGNED	,
		OUT 	Status			INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateSSN 	INTEGER DEFAULT 1;
        DECLARE InvalidSSN		INTEGER DEFAULT 2;
        DECLARE InvalidState 	INTEGER DEFAULT 3;
        DECLARE InvalidZip		INTEGER DEFAULT 4;
        DECLARE InvalidTele 	INTEGER DEFAULT 5;
        
        -- NULL SSN
        IF ESSN IS NULL
			THEN
				SET Status = InvalidSSN;
        ELSEIF (ESSN NOT REGEXP '^[0-9]+$')
			THEN
				SET Status = InvalidSSN;
		-- Duplicate SSN
        ELSEIF (0 <> (SELECT COUNT(*) FROM Employee E WHERE E.SSN = ESSN))
			THEN
				SET Status = DuplicateSSN;
		-- Invalid Zip
		ELSEIF (EZip NOT REGEXP '^[0-9]+$')
			THEN
				SET Status = InvalidZip;
		-- Invalid Tele
		ELSEIF (ETele <= 999999999 OR ETele > 9999999999)
			THEN
				SET Status = InvalidTele;
		-- Valid Input
        ELSE
			INSERT INTO Employee (SSN, Password, Last, First, Addr, City, State, Zip, Tele, Email, Start, HRate)
					VALUES(ESSN, EPasswd, ELast, EFirst, EAddr, ECity, EState, EZip, ETele, EEmail, CURRENT_TIMESTAMP, EHRate);
			SET Status = Success;
		END IF;
            
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateEmployee`;

DELIMITER $$
	CREATE PROCEDURE UpdateEmployee
	(
		IN 	ESSN 		VARCHAR(9)				, 
		IN 	NLast 		VARCHAR(20)			, 
		IN 	NFirst 		VARCHAR(20)			, 
		IN 	NAddr 		VARCHAR(50)			, 
		IN 	NCity 		VARCHAR(20)			, 
		IN 	NState 	VARCHAR(20)			, 
		IN 	NZip 		VARCHAR(5)				, 
		IN 	NTele 		BIGINT UNSIGNED	, 
        IN 	NEmail	VARCHAR(50)			,
		IN 	NHRate 	DOUBLE UNSIGNED	, 
		OUT output 	INT
	)
    
	BEGIN 
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateSSN 	INTEGER DEFAULT 1;
        DECLARE InvalidSSN		INTEGER DEFAULT 2;
        DECLARE InvalidState 	INTEGER DEFAULT 3;
        DECLARE InvalidZip		INTEGER DEFAULT 4;
        DECLARE InvalidTele 	INTEGER DEFAULT 5;
        
        -- INVALID SSN
		IF (1 <> (SELECT COUNT(*) FROM Employee E WHERE E.SSN = ESSN))
			THEN SET output = InvalidSSN ;
        -- INVALID NEW ZIP
		ELSEIF(NZip NOT REGEXP '^[0-9]+$')
			THEN SET output =  InvalidZip;
        -- INVALID NEW PHONE
		ELSEIF(NTele<= 999999999 or NTele > 9999999999)
			Then SET output = InvalidTele;
		-- VALID & UPDATE
		ELSE
			UPDATE EMPLOYEE SET Last = NLast WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET First = NFirst WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET Tele = NTele WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET Addr = NAddr WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET City = NCity WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET State = NState WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET Zip = NZip WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET Tele = NTele WHERE SSN = ESSN;
            UPDATE EMPLOYEE SET Email = NEmail WHERE SSN = ESSN;
			UPDATE EMPLOYEE SET HRate = NHRate WHERE SSN = ESSN;
			SET output = Success;
        END IF;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DeleteEmployee`;

DELIMITER $$
	CREATE PROCEDURE DeleteEmployee
		(
			IN		DSSN		VARCHAR(9), 
            OUT 	Status 		INTEGER
		)
	BEGIN
		DECLARE success			INT DEFAULT 0;
		DECLARE invalidSSN	INT DEFAULT 1;
		-- no such ssn
		IF(1 <> (SELECT COUNT(*) FROM Employee E WHERE E.SSN = DSSN))
			THEN SET Status = invalidSSN;
		ELSE 
			DELETE FROM Employee WHERE SSN = DSSN;
			SET Status = success;
		END IF;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `CreateManager`;

DELIMITER $$

	CREATE PROCEDURE CreateManager 
    (
		IN 		ESSN		 	VARCHAR(9)				,
        IN 		EPasswd		VARCHAR(24)			,
		IN 		ELast 			VARCHAR(20)			,
		IN	    EFirst			VARCHAR(20)			,		#First Name
		IN 		EAddr			VARCHAR(50)			,
		IN 		ECity			VARCHAR(20)			,
		IN 		EState			VARCHAR(20)			,
		IN	    EZip				VARCHAR(5)				,
		IN	    ETele			BIGINT UNSIGNED	,
        IN 		EEmail			VARCHAR(50)			,
		IN     	EHRate		DOUBLE UNSIGNED	,
		OUT 	Status			INTEGER			
	)
    
    BEGIN
		-- Status
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateSSN 	INTEGER DEFAULT 1;
        DECLARE InvalidSSN		INTEGER DEFAULT 2;
        DECLARE InvalidState 	INTEGER DEFAULT 3;
        DECLARE InvalidZip		INTEGER DEFAULT 4;
        DECLARE InvalidTele 	INTEGER DEFAULT 5;
        
        -- NULL SSN
        IF ESSN IS NULL
			THEN
				SET Status = InvalidSSN;
        ELSEIF (ESSN NOT REGEXP '^[0-9]+$')
			THEN
				SET Status = InvalidSSN;
		-- Duplicate SSN
        ELSEIF (0 <> (SELECT COUNT(*) FROM MANAGER E WHERE E.SSN = ESSN))
			THEN
				SET Status = DuplicateSSN;
		-- Invalid Zip
		ELSEIF (EZip NOT REGEXP '^[0-9]+$')
			THEN
				SET Status = InvalidZip;
		-- Invalid Tele
		ELSEIF (ETele <= 999999999 OR ETele > 9999999999)
			THEN
				SET Status = InvalidTele;
		-- Valid Input
        ELSE
			INSERT INTO Manager (SSN, Password, Last, First, Addr, City, State, Zip, Tele, Email, Start, HRate)
					VALUES(ESSN, EPasswd, ELast, EFirst, EAddr, ECity, EState, EZip, ETele, EEmail, CURRENT_TIMESTAMP, EHRate);
			SET Status = Success;
		END IF;
            
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateManager`;

DELIMITER $$
	CREATE PROCEDURE UpdateManager
	(
		IN 	ESSN 		VARCHAR(9)				, 
		IN 	NLast 		VARCHAR(20)			, 
		IN 	NFirst 		VARCHAR(20)			, 
		IN 	NAddr 		VARCHAR(50)			, 
		IN 	NCity 		VARCHAR(20)			, 
		IN 	NState 	VARCHAR(20)			, 
		IN 	NZip 		VARCHAR(5)				, 
		IN 	NTele 		BIGINT UNSIGNED	, 
        IN 	NEmail	VARCHAR(50)			,
		IN 	NHRate 	DOUBLE UNSIGNED	, 
		OUT output 	INT
	)
    
	BEGIN 
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE DuplicateSSN 	INTEGER DEFAULT 1;
        DECLARE InvalidSSN		INTEGER DEFAULT 2;
        DECLARE InvalidState 	INTEGER DEFAULT 3;
        DECLARE InvalidZip		INTEGER DEFAULT 4;
        DECLARE InvalidTele 	INTEGER DEFAULT 5;
        
        -- INVALID SSN
		IF (1 <> (SELECT COUNT(*) FROM MANAGER E WHERE E.SSN = ESSN))
			THEN SET output = InvalidSSN ;
        -- INVALID NEW ZIP
		ELSEIF(NZip NOT REGEXP '^[0-9]+$')
			THEN SET output =  InvalidZip;
        -- INVALID NEW PHONE
		ELSEIF(NTele<= 999999999 or NTele > 9999999999)
			Then SET output = InvalidTele;
		-- VALID & UPDATE
		ELSE
			UPDATE MANAGER SET Last = NLast WHERE SSN = ESSN;
			UPDATE MANAGER SET First = NFirst WHERE SSN = ESSN;
			UPDATE MANAGER SET Tele = NTele WHERE SSN = ESSN;
			UPDATE MANAGER SET Addr = NAddr WHERE SSN = ESSN;
			UPDATE MANAGER SET City = NCity WHERE SSN = ESSN;
			UPDATE MANAGER SET State = NState WHERE SSN = ESSN;
			UPDATE MANAGER SET Zip = NZip WHERE SSN = ESSN;
			UPDATE MANAGER SET Tele = NTele WHERE SSN = ESSN;
            UPDATE MANAGER SET Email = NEmail WHERE SSN = ESSN;
			UPDATE MANAGER SET HRate = NHRate WHERE SSN = ESSN;
			SET output = Success;
        END IF;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DeleteManager`;

DELIMITER $$
	CREATE PROCEDURE DeleteManager
		(
			IN		DSSN		INT UNSIGNED, 
            OUT 	Status 		INTEGER
		)
	BEGIN
		DECLARE success			INT DEFAULT 0;
		DECLARE invalidSSN	INT DEFAULT 1;
		-- no such ssn
		IF(1 <> (SELECT COUNT(*) FROM MANAGER E WHERE E.SSN = DSSN))
			THEN SET Status = invalidSSN;
		ELSE 
			DELETE FROM MANAGER WHERE SSN = DSSN;
			SET Status = success;
		END IF;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `ProduceCustomerEmailList`;

DELIMITER $$
	CREATE PROCEDURE ProduceCustomerEmailList
		(
		)
	BEGIN
		SELECT DISTINCT Email FROM CUSTOMER;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `MostHighRateProiles`;

DELIMITER $$
	CREATE PROCEDURE MostHighRateProiles
		(
			IN IAccNum 	VARCHAR(24),
            IN MAXIMUM 	INT UNSIGNED
		)
	BEGIN
		SELECT DISTINCT 	p.Id AS ID, 
											p.TotalRate AS TotalRate, 
                                            p.NumPDate AS Pending, 
                                            p.NumCDate AS Completed, 
                                            p.TotalFee AS TotalFee
		FROM PROFILE p
		WHERE p.CId = IAccNum
		ORDER BY TotalRate DESC
		LIMIT MAXIMUM
		;
	END $$ 
DELIMITER ;

DROP PROCEDURE IF EXISTS `MostActiveProfile`;

DELIMITER $$
	CREATE PROCEDURE MostActiveProfile
		(	
			IN IAccNum 	VARCHAR(24),
            IN MAXIMUM 	INT UNSIGNED
		)
	BEGIN

		SELECT P.Id AS ProfId, ((SELECT (SUM(T.NumPDate) + SUM(T.NumCDate)) FROM PROFILE T WHERE T.CId = IAccNum)) AS Times
		FROM PROFILE P
		WHERE P.CId = IAccNum
        ORDER BY Times DESC
        LIMIT MAXIMUM
		;

	END $$ 
DELIMITER ;

DROP PROCEDURE IF EXISTS `MostActiveZip`;

DELIMITER $$
	CREATE PROCEDURE MostActiveZip
	(
			IN IAccNum 	VARCHAR(24),
            IN MAXIMUM 	INT UNSIGNED
	)
	BEGIN
		SELECT ddc.ZipCode, COUNT(ZipCode)
		FROM DateData ddc
		WHERE ddc.UserAId IN 
			(
				SELECT h.Id FROM PROFILE h WHERE h.CId = IAccNum
			)
			OR
            ddc.UserBId IN
			(
				SELECT h.Id FROM PROFILE h WHERE h.CId = IAccNum
			)
		GROUP BY ddc.ZipCode
		ORDER BY COUNT(ZipCode) DESC
		LIMIT 5
		;
	END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS `SaleReportMonth`;

DELIMITER $$
	CREATE PROCEDURE SaleReportMonth
	(
			IN 	SMonth		INT UNSIGNED
	)
	BEGIN
		        
        SELECT SUM(Fee) AS Revenue, 
						(SELECT COUNT(*) 
							FROM DATEDATA 
                            WHERE SMonth = MONTH(DateTime) AND YEAR(NOW()) = YEAR(DateTime)) AS NumOfDate, 
						(SELECT ((SELECT SUM(Fee) FROM DATEDATA WHERE SMonth = MONTH(DateTime) AND YEAR(NOW()) = YEAR(DateTime)) / SUM(Fee))
							FROM DATEDATA 
                            WHERE SMonth = MONTH(DateTime) AND (YEAR(NOW()) - 1) = YEAR(DateTime)) AS CompToLastYear
                        
        FROM DATEDATA
        WHERE SMonth = MONTH(DateTime) AND YEAR(NOW()) = YEAR(DateTime)
        ;
        
	END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS `SaleReportYearMonth`;

DELIMITER $$
	CREATE PROCEDURE SaleReportYearMonth
	(
			IN 	SYear			INT UNSIGNED,
            IN 	SMonth		INT UNSIGNED
	)
	BEGIN
		
        SELECT SUM(Fee) AS Revenue, 
						(SELECT COUNT(*) FROM DATEDATA WHERE SMonth = MONTH(DateTime) AND SYear = YEAR(DateTime)) AS NumOfDate,
                        (SELECT ((SELECT SUM(Fee) FROM DATEDATA WHERE SMonth = MONTH(DateTime) AND SYear = YEAR(DateTime)) / SUM(Fee))
							FROM DATEDATA 
                            WHERE SMonth = MONTH(DateTime) AND SYear = (YEAR(DateTime) + 1)) AS CompToLastYear
        FROM DATEDATA
        WHERE SMonth = MONTH(DateTime) AND SYear = YEAR(DateTime)
        ;
        
	END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS `SuggestDate`;
DELIMITER $$
CREATE PROCEDURE SuggestDate 
	( 
		IN IProId VARCHAR(24)  
	)
	BEGIN
		IF ( 3 > ( 	SELECT  COUNT( DISTINCT p.Id) 
						FROM PROFILE p, PROFILE p2
						WHERE p2.Id = IProId 
									AND p.Age >= (	SELECT (Sum(Age)/count(Id) - 2) 
																FROM profile 
																WHERE Id IN  (	SELECT DISTINCT UserBId 
																							FROM DATEDATA dd  
																							WHERE UserAId = IProId )
																				OR Id IN (SELECT DISTINCT UserAId 
																								FROM DATEDATA dd  
																								WHERE UserBId=IProId )) 
									AND p.Age <= (	SELECT  Sum(Age)/count(Id) + 2 
																FROM profile 
																WHERE Id IN (	SELECT DISTINCT UserBId 
																							FROM DATEDATA dd  
																							WHERE UserAId = IProId ) 
																			OR Id IN (	SELECT DISTINCT UserAId 
																								FROM DATEDATA dd  
																								WHERE UserBId = IProId ))
									AND p.Age <= p2.AgeMax 
                                    AND p.Age >=p2.AgeMin 
                                    AND p.Gender <> p2.Gender
									AND p.CId <> p2.CId 
						ORDER BY p.TotalRate DESC))
				THEN  
							SELECT DISTINCT 	p.Id AS SuggestedId, 
																p.Age AS Age, 
																p.City AS City, 
																p.State AS State, 
                                                                p.TotalRate AS Rate 
							FROM PROFILE p, PROFILE p2
							WHERE 	p2.Id = IProId 
											AND p.Age >= p2.AgeMin 
											AND p.Age <= p2.AgeMax  
                                            AND p.Gender <> p2.Gender 
											AND p.CId <> p2.CId 
							ORDER BY p.TotalRate DESC ;

		ELSE  SELECT DISTINCT p.Id AS SuggestedId, 
													p.Age AS Age, 
													p.City AS City, 
                                                    p.State AS State, 
													p.TotalRate AS Rate 
					FROM PROFILE p, PROFILE p2 
					WHERE p2.Id = IProId 
									AND p.Age >= (	SELECT (Sum(Age) / count(Id) - 2 )
																FROM profile  
																WHERE Id IN  (	SELECT DISTINCT UserBId 
																							FROM DATEDATA dd  
																							WHERE UserAId = IProId)
																			OR Id IN( SELECT DISTINCT UserAId 
																							FROM DATEDATA dd  
																							WHERE UserBId=IProId)) 
									AND p.Age <= (	SELECT  Sum(Age) / count(Id) + 2 
																FROM profile 
                                                                WHERE Id IN (	SELECT DISTINCT UserBId 
																							FROM DATEDATA dd  
																							WHERE UserAId = IProId )
																			OR Id IN( SELECT DISTINCT UserAId 
																							FROM DATEDATA dd 
																							WHERE UserBId=IProId ))
									AND p.Age <= p2.AgeMax 
                                    AND p.Age >=p2.AgeMin 
                                    AND p.Gender <> p2.Gender
									AND p.CId <> p2.CId
					ORDER BY p.TotalRate DESC;
		END IF;
	END $$ 
DELIMITER ;

DROP PROCEDURE IF EXISTS `ComprehensiveList`;

DELIMITER $$
CREATE PROCEDURE ComprehensiveList()
	BEGIN
		DROP VIEW IF EXISTS `cl`;
		CREATE VIEW cl(TotalCustomer) AS 
				SELECT COUNT(*) 
                FROM CUSTOMER c;
        
		DROP VIEW IF EXISTS `cl2`;
		CREATE VIEW cl2(TotalProfile) AS 
				SELECT COUNT(*) 
                FROM PROFILE;
        
		DROP VIEW IF EXISTS `cl3`;
		CREATE VIEW cl3(AvgAge) AS 
				SELECT AVG(Age) 
                FROM PROFILE;
        
		DROP VIEW IF EXISTS `cl4`;
		CREATE VIEW cl4(AvgHeight) AS 
				SELECT AVG(Height) 
                FROM PROFILE;
        
		DROP VIEW IF EXISTS `c15`;
		CREATE VIEW c15(MostActiveState) AS 
				SELECT State 
                FROM CUSTOMER 
                GROUP BY State
				ORDER BY COUNT(*) DESC 
                LIMIT 1;
                
		DROP VIEW IF EXISTS `c16`;
		CREATE VIEW c16(UserPaid) AS 
					SELECT COUNT(*) 
                    FROM CUSTOMER 
                    WHERE PPP="A";
                    
		SELECT * FROM cl,cl2,cl3,cl4,c15,c16;
		DROP VIEW IF EXISTS `cl`;
        
		DROP VIEW IF EXISTS `cl2`;
		DROP VIEW IF EXISTS `cl3`;
		DROP VIEW IF EXISTS `cl4`;
		DROP VIEW IF EXISTS `c15`;
		DROP VIEW IF EXISTS `c16`;
  END $$ 
DELIMITER ;

DROP PROCEDURE IF EXISTS `CreateMessage`;

DELIMITER $$
	CREATE PROCEDURE CreateMessage
	(
			IN 	Sinvitee			VARCHAR(24),
            IN 	Sinviter		VARCHAR(24),
            IN  SAddr			VARCHAR(50),
			IN  SCity				VARCHAR(20)	,			
			IN  SState			VARCHAR(20)		,			
			IN  Stime TIMESTAMP ,
            OUT status 			INTEGER
	)
	BEGIN	
			DECLARE Success 		INTEGER DEFAULT 0;
			DECLARE Invalidinvitee 	INTEGER DEFAULT 1;
            DECLARE Invalidinviter 	INTEGER DEFAULT 2;
            DECLARE DuplicateEntry 	INTEGER DEFAULT 3;
            
			IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = Sinvitee))
			THEN 
				SET status = Invalidinvitee;
			elseIF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = Sinviter))
			THEN 
				SET status = Invalidinviter;
			elseIF (0 <> (SELECT COUNT(*) FROM MESSAGE M WHERE M.invitee=Sinvitee and M.inviter = Sinviter))
            THEN 
				SET status = DuplicateEntry;
            else 
			INSERT INTO message (invitee, inviter, addr, City, State)
					VALUES(Sinvitee, Sinviter , SAddr, SCity, SState);
			end if;
    END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `UpdateProfileIP`;

DELIMITER $$
	CREATE PROCEDURE UpdateProfileIP
    (
        IN	pId 				VARCHAR(24), 
        IN  IIP					VARCHAR(15),
        IN 	Ilatitude 			double,
        IN  Ilongitude 		    double,
        OUT status 			INTEGER
    )
    
    BEGIN
		DECLARE Success 		INTEGER DEFAULT 0;
        DECLARE InvalidId 	INTEGER DEFAULT 1;
        
        IF (1 <> (SELECT COUNT(*) FROM PROFILE P WHERE P.ID = pId))
			THEN
				SET status = InvalidId;
                
        ELSE
			UPDATE PROFILE 
            SET IP=IIP ,
				latitude=Ilatitude ,
                longitude=Ilongitude
            WHERE Id = pId;
	
			SET status = Success;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DELETEALLMESSAGESENT`;

DELIMITER $$
	CREATE PROCEDURE DELETEALLMESSAGESENT
    (
        IN	Id 				VARCHAR(24)
    )
    
    BEGIN
        
        IF ((SELECT COUNT(*) FROM PROFILE P WHERE P.ID = Id) = 1)
			THEN
				DELETE FROM MESSAGE WHERE inviter=Id;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DELETEALLMESSAGERECEIVED`;

DELIMITER $$
	CREATE PROCEDURE DELETEALLMESSAGERECEIVED
    (
        IN	Id 				VARCHAR(24)
    )
    
    BEGIN
        
        IF ((SELECT COUNT(*) FROM PROFILE P WHERE P.ID = Id) = 1)
			THEN
				DELETE FROM MESSAGE WHERE invitee=Id;
		END IF;
	END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `DELETETHISMESSAGERECEIVED`;

DELIMITER $$
	CREATE PROCEDURE DELETETHISMESSAGERECEIVED
    (
        IN	Sinvitee 				VARCHAR(24),
        IN  Sinviter					VARCHAR(24)
    )
    
    BEGIN
		DELETE FROM MESSAGE WHERE invitee=Sinvitee and inviter=Sinviter;
	END$$
DELIMITER ;