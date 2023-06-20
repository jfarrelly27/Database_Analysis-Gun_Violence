CREATE TABLE EVENT(
    Case_Id number(3) primary key,
    Case_Name varchar(100) Not Null,
    Case_Date date ,
    Fatalities number(3),
    Injured number(3),
    Total_Victims number(3),
    Target varchar(100),
    Type varchar(100)
);

CREATE TABLE PERSON(
    First_Name varchar(100),
    Middle_Name varchar(100),
    Last_Name varchar(100),
    Suffix varchar(4),
    Age_at_Shooting number(2),
    Prior_Mental_Health_Complications varchar(100),
    Race varchar(100),
    Gender varchar(100),
    Case_Id number(3) references EVENT(Case_Id)
);

CREATE TABLE WEAPON(
    Legally_Obtained varchar(100),
    Location_Obtained varchar(100),
    Weapon_Type varchar(200),
    Case_Id number(3) references EVENT(Case_Id)
);

CREATE TABLE LOCATION(
    City varchar(100),
    State varchar(100),
    Longitude number(10),
    Latitude number(10),
    Case_Id number(3) references EVENT(Case_Id)
);

CREATE TABLE DATE(
    YEAR number(4)
    QUARTER number(1)
    HALF number(1)
    MONTH number(2)
    CASE_ID number(3)
);
