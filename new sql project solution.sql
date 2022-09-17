use shopkeeper;
show databases;
show tables;

-- Q1) Select count of customers based on customer type
select * from customer;
select c_name,C_type, count(*) from customer group by C_type;
-- Q2) Select branch wise count of emp in descending order of count
select * from employee_details;
select E_name,E_branch,count(*) from employee_details group by E_branch order by  E_branch desc;

-- Q3) Select designation wise count of emp ID in descending order of count
select * from employee_details;
select e_id,e_designation,count(*) from employee_details group by E_designation order by e_id desc;
-- Q4) Select Count of customer based on payment status in descending order of count
select * from payment_details;
select c_id,payment_status, count(*) from payment_details group by payment_status order by c_id;

-- Q5) Select Count of customer based on payment mode in descending order of count
select * from payment_details;
select c_id,payment_mode ,count(*) from payment_details group by payment_mode
 order by count(*) desc;
 -- Q6) Select Count of customer based on shipment_domain in descending order of count
 select * from shipment_details;
 select c_id,sh_domain,count(*) from shipment_details group by sh_domain
  order by count(*) desc;
-- Q7) Select Count of customer based on ser_type in descending order of count
select * from shipment_details; 
select c_id,ser_type ,count(*) from shipment_details group by ser_type
order by count(*) desc;

 

-- Q8) Find average payment amount based on Customer Type where payment mode as COD
select * from customer inner join payment_details;
select * from payment_details;

select * from customer;
select c.c_id,c.c_type,p.amount,avg(p.amount) from customer as c inner join 
payment_details as p on c.c_id=p.c_id where p.payment_mode="cod"   ;

-- Q9) Find avg payment amount based on payment mode where payment date is not null
select * from payment_details;
select payment_mode,amount,avg(amount) ,payment_date from payment_details
where payment_date in ('2014-12-18','1997-07-10','1971-11-01');

-- Q10) Find sum of shipment charges based on payment_mode where service type is not regular

select * from shipment_details;
select * from payment_details;
select p.c_id,p.payment_mode,s.sh_charges,s.ser_type,sum(s.sh_charges) from payment_details as p
inner join shipment_details as s on p.c_id=s.c_id where s.ser_type!="Regular" group by ser_type ;

-- Q11) Find avg shipment weight based on payment_status where shipment content does not start with H
select * from shipment_details;
select * from payment_details;
select s.sh_weight,avg(s.sh_weight),s.sh_content,p.payment_status from shipment_details as s
inner join payment_details as p on s.c_id=p.c_id where sh_content not like "H%" group by sh_content ;

-- Q12) Find mean of payment amount based on shipping domain where service type 
-- is Express and payment status is paid
select * from shipment_details;
select * from payment_details;
select s.sh_domain,s.ser_type,p.amount,avg(p.amount) from shipment_details as s
inner join payment_details as p on s.C_ID=p.C_id where ser_type="Express" and payment_status="paid";

-- Q12) Find avg of shipment weight and shipment charges based on paymnet status
select * from shipment_details;
select s.sh_weight,s.sh_charges,avg(s.sh_weight),avg(s.sh_charges),p.payment_status
from shipment_details  as s inner join payment_details as p on s.c_id=p.c_id
group by payment_status;



 -- Q13) Select all records from shipment_details where shipping charges is greater than 
-- avg shipping charges for all the customers
select * from shipment_details;
select * from customer;
select s.sh_id,s.sh_content,s.sh_domain,s.c_id,avg(s.sh_charges),c.c_id,c.C_name from shipment_details as s
left join customer as c on s.c_id=c.c_id where sh_charges>(select avg(s.sh_charges) from shipment_details);

-- Q14) Select average shipping weight and sum of shipping charges based on shipping details

select * from shipment_details;
select sh_domain,sh_weight,avg(sh_weight),sum(sh_charges) from shipment_details group by sh_domain;
 
 -- Q15) Find customer names, their email, contact,c_type and payment amount where C_type 
-- is either Wholesale or Retail
select * from customer;
select * from payment_details;
select c.c_name,c.c_email_id,c.c_cont_no,c.c_type,p.amount from customer as c left join 
payment_details as p on c.c_id=p.c_id where c_type in('wholesale' , 'Retail');

-- Q16) Find Emp_Id,Emp_Name, C_Id, shipping charges  the employees are managing customers 
-- whose shipping charges are over 1000
select * from employee_details;
select * from shipment_details;
select * from customer;
select e.e_id,e.e_name,c.c_id,s.sh_charges from employee_details as e
inner join customer as c on e.E_ADDR=c.c_addr
inner join shipment_details as s on s.c_id=c.c_id
where sh_charges>1000; 

-- Q17) Find Employee branch and employee designation wise count of employee designation
-- who have managed customers whose shipping weight < 500. 

select * from employee_details;
select * from shipment_details;
select * from customer;

select e.e_branch,e.e_designation,count(e.e_designation),c.c_name,s.sh_charges,s.sh_weight
from employee_details as e inner join customer as c on e.e_addr=c.c_addr 
inner join shipment_details as s on s.c_id=c.c_id where sh_weight<500 group by e_designation;

-- Q18) Select all records from employees table where employee Name ends with 'da'
select * from employee_details;
select e_id,e_name,e_designation,e_addr,e_branch,e_cont_no employee_details from employee_details
 where e_name like '%da'; 
 
-- Q19  Select all the data of employees that do not work in branch ct or branch oh.
select * from employee_details where e_branch != "ct" or "oh";

 
-- Q20 Select the number of employees in each designation
select e_name,e_designation,count(e_name)  from employee_details group by e_name;

