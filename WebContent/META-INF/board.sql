create database boarddb;
use boarddb;

create table user
(
	uno int primary key auto_increment comment 'ȸ����ȣ',
	uid varchar(100) comment '���̵�',
	upw varchar(100) comment '��й�ȣ',
	uname varchar(50) comment '�̸�',
	ugender varchar(2) comment '����',
	uhabby varchar(4) comment '���',
	uretire varchar(2) default 'N' comment 'Ż�𿩺�',
	ujoindate datetime default now() comment '��������'
);

create table fav
(
	uno int comment 'ȸ����ȣ',
	fkind varchar(4) comment '�о��ڵ�',
	fname varchar(50)  comment '�о߸�'
);

create table board
(
	bno int primary key auto_increment comment '�Խù���ȣ',
	uno int comment 'ȸ����ȣ',
	btitle varchar(250) comment '����',
	bkind varchar(2) comment '����',
	bnote text comment '����',
	bwdate datetime default now() comment '�ۼ�����',
	bhit int default 0 comment '��ȸ��'
);

create table attach
(
	ano int primary key auto_increment comment '÷�ι�ȣ',
	bno int comment '�Խù���ȣ',
	uno int comment 'ȸ����ȣ',
	pname varchar(255) comment '�������ϸ�',
	fname varchar(255) comment '�����ϸ�'
);

create table recommand
(
	rno int primary key auto_increment comment '��õ��ȣ',
	bno int comment '�Խù���ȣ',
	runo int comment '��õ�ι�ȣ',
	rdate datetime default now() comment '��õ����',
	rflag varchar(2) comment '��õ����'	
);

create table reply
(
	rpno int primary key auto_increment comment '��۹�ȣ',
	bno int comment '�Խù���ȣ',
	rpuno int comment '����ۼ��ڹ�ȣ',
	rpnote text comment '��۳���',
	rpdate datetime default now() comment '�ۼ�����'
);

