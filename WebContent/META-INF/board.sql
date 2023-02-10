create database boarddb;
use boarddb;

create table user
(
	uno int primary key auto_increment comment '회원번호',
	uid varchar(100) comment '아이디',
	upw varchar(100) comment '비밀번호',
	uname varchar(50) comment '이름',
	ugender varchar(2) comment '성별',
	uhabby varchar(4) comment '취미',
	uretire varchar(2) default 'N' comment '탈퇴여부',
	ujoindate datetime default now() comment '가입일자'
);

create table fav
(
	uno int comment '회원번호',
	fkind varchar(4) comment '분야코드',
	fname varchar(50)  comment '분야명'
);

create table board
(
	bno int primary key auto_increment comment '게시물번호',
	uno int comment '회원번호',
	btitle varchar(250) comment '제목',
	bkind varchar(2) comment '구분',
	bnote text comment '내용',
	bwdate datetime default now() comment '작성일자',
	bhit int default 0 comment '조회수'
);

create table attach
(
	ano int primary key auto_increment comment '첨부번호',
	bno int comment '게시물번호',
	uno int comment '회원번호',
	pname varchar(255) comment '물리파일명',
	fname varchar(255) comment '논리파일명'
);

create table recommand
(
	rno int primary key auto_increment comment '추천번호',
	bno int comment '게시물번호',
	runo int comment '추천인번호',
	rdate datetime default now() comment '추천일자',
	rflag varchar(2) comment '추천여부'	
);

create table reply
(
	rpno int primary key auto_increment comment '댓글번호',
	bno int comment '게시물번호',
	rpuno int comment '댓글작성자번호',
	rpnote text comment '댓글내용',
	rpdate datetime default now() comment '작성일자'
);

