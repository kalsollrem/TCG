create database tcgdb;

use tcgdb;

create table info
(
	mnum 	 INT  PRIMARY KEY auto_increment 	, 
	mid 	 VARCHAR(100) 						, 
	mpw 	 VARCHAR(100) 						, 
	mname 	 VARCHAR(50) 						, 
	mphone 	 VARCHAR(100) 						, 
	mmail 	 VARCHAR(150) 						, 
	msex 	 VARCHAR(2) 						, 
	mnick 	 VARCHAR(100) 						, 
	maddr_a	 VARCHAR(255) 						, 
	maddr_b	 VARCHAR(255) 						, 
	mmyself  text 								, 
	mrank 	 FLOAT default '5'					, 
	mdelnum  INT default '0'					, 
	mjoindate DATETIME default now() 			,  
	mlive 	 VARCHAR(2) default 'N'				,
	mpic 	 VARCHAR(255) 						    
	
);



CREATE TABLE product 
(
	gnum    INT  PRIMARY KEY auto_increment       				, 
	mnum    INT													, 
	gname   VARCHAR(255)										, 
	gdate   DATETIME default now()    			 				, 
	gdir    VARCHAR(10) default 'No'	 			 				, 
	gmail   VARCHAR(10) default 'N'	 			 				,  
	gmyself TEXT        			 							,  
	gvalue  INT         			 							, 
	gpic    VARCHAR(255)			 							,  
	gqty    INT 	        			 						,  
	gstate  VARCHAR(4) default 'A'	  							, 
	gdelsc  FLOAT       			 							, 
	gbuysc  FLOAT      			  								
);

//gstate = A -> E -> D -> O순으로 이행
//A 생존  E평가  D다른사람 O아웃
select*from product where mnum =1;

//물건추가
insert into product(mnum, gname, gmyself, gvalue, gqty)
values(1, '물건입니다', '싸죠?', 100, 1);


CREATE TABLE propic 
(
	mnum   int	                            					, 
	gnum   int 													, 
	gpname VARCHAR(255) NULL									,     
	gfname VARCHAR(255) NULL									,     
	gno    INT PRIMARY KEY auto_increment									 	 
);


CREATE TABLE buylist 
(
	mnum   INT													,
	gnum   INT													,
	blnum   INT PRIMARY KEY auto_increment	
);
alter table buylist add tnum INT;		


CREATE TABLE sellist 
(
	mnum   INT 													,
	gnum   INT													,
	tnum   INT													,
	slnum   INT PRIMARY KEY auto_increment			
);


CREATE TABLE poketlist 
(
	mnum   INT													,
	gnum   INT													,
	plnum  INT PRIMARY KEY auto_increment
);
alter table poketlist add tnum INT;		



CREATE TABLE telroom 
(
	mnum   INT													,		
	gmnum  INT													,
	gnum   int													,
	tnum   INT PRIMARY KEY auto_increment
);


CREATE TABLE reply 
(
	mnum   INT,
	tnum   INT     					,				
	rdate  DATETIME default now() ,  
	rnote  TEXT				,
	rnum   INT PRIMARY KEY auto_increment

);

