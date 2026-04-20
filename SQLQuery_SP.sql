-- part 1 :

-- 1-
create table Employees (
Id int primary key ,
FirstName varchar(20) not null ,
LastName varchar(20) not null ,
Salary decimal(10,2) not null
) 
go


create procedure GetAllEmployees 
as
begin

select * 
from Employees

end

execute GetAllEmployees
go

---------------------------------------------------------------------------
-- 2-
create procedure GetHighSalaryEmployees (@MinSalary as decimal(10,2) ) 
as
begin

select * 
from Employees
where Salary > @MinSalary 

end


execute GetHighSalaryEmployees @MinSalary = 5000

go

---------------------------------------------------------------------------
-- 3-
create procedure AddEmployee (@FirstName varchar(20) ,@LastName varchar(20) ,@Salary decimal(10,2))
as
begin

insert into Employees (FirstName , LastName , Salary)
values (@FirstName , @LastName , @Salary)

end 

execute AddEmployee @FirstName = 'Sarah',
                    @LastName  = 'Ahmed',
                    @Salary    = 75000


---------------------------------------------------------------------------
-- part 2 :

create table EmployeeLog (
Id int primary key identity(1,1) ,
EmployeeId int ,
Action varchar(100),
ActionDate datetime default getdate()

constraint FK_EmployeeLog_Employee foreign key (EmployeeId) references Employees(Id)
)
go

create trigger AfterInsertEmployee
on Employees
after insert 
as
begin

insert into EmployeeLog (EmployeeId, Action, ActionDate)
    select
        Id,
        'New employee added ',
        getdate()
    from inserted  
end




