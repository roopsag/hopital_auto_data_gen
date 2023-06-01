-------Diesease categories and docter assigned
-------female-Anti Immuno Defeciency Syndome,Polycystic Ovary Syndrome-----DR.haripriya
-------male-Anti Immuno Defeciency Syndome-----------------DR.Venkeshwar_reddy
--------male/female-Allergies,'Colds and Flu',Diarrhea--------DR.Hrish_varma
--------male/female-Infectious mononucleosis,fewer,Stomach Aches--  DR.Sreeshanth_singh
 ---  male/female-- Conjunctivitis ("pink eye“),Mononucleosis,Headaches---DR.Sree_Vidya


-----Bed allocation condition and medication categorised
------normal medication----Single day ----no bed allocated-----reconsult day after 3 days of discharge
------simple_medications---two  treatement----bed allocated--------reconsult day after 2 days of discharge
------critical_problem-----four days treatment----bed allocated------reconsult day after 7 daysof discharge
------emergency------------five days /more then five days---bed allocated-----reconsult day after 7 daysof discharge
  --------------------------------CODE------------------------------------------------------------------------
  create table sample4(token_id int primary key identity(1001,1),NAME VARCHAR(MAX),gender varchar(max),age int,disease varchar(max),
					 condition_level varchar(max),doctor_assign varchar(max),bed_number varchar(max),date_of_joining date,
					 date_of_dscharge date,re_consult_date date)

	     Declare @gen INT;
set @gen = ABS(Checksum(NewID()) % 2) + 1
--select @gen

declare @gender varchar(max);
set @gender=CHOOSE(@gen, 'MALE','FEMALE'); 
--SELECT @gender
	     Declare @age INT;
set @age = ABS(Checksum(NewID()) % 97) + 1

declare @dies INT;
set @dies =ABS(CHECKSUM(newid()) %10)+1
--select @dies

declare @dieseas varchar(max);
set @dieseas=CHOOSE(@dies,'Allergies',
'Colds and Flu',
'Conjunctivitis("pink eye“)',
'Diarrhea',
'Headaches',
'Mononucleosis',
'Stomach Aches',
'fewer',
'HIV/AIDS',
'Infectious mononucleosis')
--select @dieseas
declare @menid int;
set @menid=ABS(CHECKSUM(NEWID())%20)+1;
--select @menid

declare @mennames varchar(max);
set @mennames=CHOOSE(@menid,'hari','giri','suri','venkatesh','sreekanthu','harish','suresh','ramesh','veeranna','sai'
                             ,'sri_vastav','mahamood_ali','narendra_modi','rajanikanth','om_prakash','venkat_prabhu',
							 'Raajamouli','raama_krishna','roop_sagar','majestic_manjunath')
							--select @mennames
declare @femaleid int;
set @femaleid=ABS(CHECKSUM(newid())%20)+1;
--select @femaleid

declare @femalenames varchar(max);
set @femalenames=CHOOSE(@femaleid,'divya','vijaya_lakshmi','maha_lakshmi','surya_kumari','roopa','chaitra','sonali','megha','anu',
                       'sirisha','vedavathi','manjusha','hari priya','sarika','harika','''mallika','sreeja','keerthi','sai_pallavi','hansika')
--select @femalenames
declare @lev int;
set @lev =ABS(checksum(NEWID())%4)+1
--select @lev
declare @level varchar(max)
set @level=CHOOSE(@lev,'normal','simple_medications','critical_problem','emergency')
--select @level





DECLARE @StartDate  date;
DECLARE @EndDate  date;
DECLARE @DaysBetween  int;


Set @StartDate   = '01/01/2019';
 set @EndDate     = '12/31/2021';
 set @DaysBetween = (1+DATEDIFF(DAY, @StartDate, @EndDate));

declare @assigned_date date;
set @assigned_date=DATEADD(DAY, RAND(CHECKSUM(NEWID()))*@DaysBetween,@StartDate) ;
select @assigned_date

declare @bed_id int;
set @bed_id =ABS(checksum(NEWID())%100)+1


insert into sample4(NAME,gender,age,disease,
					 condition_level ,doctor_assign ,bed_number,date_of_joining,
					 date_of_dscharge ,re_consult_date ) values(case when @gender='MALE' THEN @mennames
                                else @femalenames
								end ,@gender,@age,
								@dieseas,@level,case 
								            when @age<18 AND @gender='FEMALE' THEN  'DR.Aishwarya_rajesh'
                                            when @gender='FEMALE' and @dies=9 then 'DR.haripriya'
											when @gender='MALE' AND @dies=9 THEN 'DR.Venkeshwar_reddy'
											when @dies in(1,4,2) then 'DR.Hrish_varma'
											when @dies in(10,8,7) then'DR.Sreeshanth_singh'
											
											else 'DR.Sree_Vidya'
											end, case when @lev>1 then CAST(@bed_id as varchar)
											          else 'no bed assigned'
													  end,
											@assigned_date,case
                                                   when @lev=1 then @assigned_date
												   when @lev=2 then DATEADD(dd,1,@assigned_date)
												   when @lev=3 then DATEADD(dd,3,@assigned_date)
												   else DATEADD(dd,5,@assigned_date)
												   end, case when @lev>2 then dateadd(dd,10,@assigned_date)
												         else dateadd(dd,4,@assigned_date)
														 end
														 ) ;
									go 100

select * from sample4
---truncate table sample4