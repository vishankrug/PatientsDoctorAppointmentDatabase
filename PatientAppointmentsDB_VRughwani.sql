--**********************************************************************************************--
-- Title: Milestone 02 - Final
-- Author: VRughwani
-- Desc: This file creates; 
--       tables, constraints, views, stored procedures, and permissions
--***********************************************************************************************--

Begin Try
	Use Master;
	If Exists(Select Name From SysDatabases Where Name = 'PatientAppointmentsDB_VRughwani')
	 Begin 
	  Alter Database [PatientAppointmentsDB_VRughwani] set Single_user With Rollback Immediate;
	  Drop Database PatientAppointmentsDB_VRughwani;
	 End
	Create Database PatientAppointmentsDB_VRughwani;
End Try
Begin Catch
	Print Error_Number();
End Catch
go
Use PatientAppointmentsDB_VRughwani;

-- Create Tables -- 

Create Table Clinics( 
	ClinicID int Constraint pkClinic Primary Key Not Null Identity(1,1),
	ClinicName nvarchar(100) Not Null,
	ClinicPhoneNumber nvarchar(100) Not Null,
	ClinicAddress nvarchar(100) Not Null,
	ClinicCity nvarchar(100) Not Null,
	ClinicState nchar(2) Not Null,
	ClinicZipCode nvarchar(10) Not Null
);
go 

Create Table Patients( 
	PatientID int Constraint pkPatients Primary Key Not Null Identity(1,1),
	PatientFirstName nvarchar(100) Not Null,
	PatientLastName nvarchar(100) Not Null,
	PatientPhoneNumber nvarchar(100) Not Null,
	PatientAddress nvarchar(100) Not Null,
	PatientCity nvarchar(100) Not Null,
	PatientState nchar(2) Not Null,
	PatientZipCode nvarchar(10) Not Null
);
go 

Create Table Doctors( 
	DoctorID int Constraint pkDoctors Primary Key Not Null Identity(1,1),
	DoctorFirstName nvarchar(100) Not Null,
	DoctorLastName nvarchar(100) Not Null,
	DoctorPhoneNumber nvarchar(100) Not Null,
	DoctorAddress nvarchar(100) Not Null,
	DoctorCity nvarchar(100) Not Null,
	DoctorState nchar(2) Not Null,
	DoctorZipCode nvarchar(10) Not Null
);
go 

Create Table Appointments( 
	AppointmentID int Constraint pkAppointments Primary Key Not Null Identity(1,1),
	AppointmentDateTime datetime Not Null,
	AppointmentPatientID int Not Null,
	AppointmentDoctorID int Not Null,
	AppointmentClinicID int Not Null
);
go 

-- Add Constraints -- 

	-- Clinics
Alter Table Clinics
    Add Constraint uqClinicName Unique (ClinicName);
go

Alter Table Clinics
	Add Constraint chkClinicPhoneNumber Check (ClinicPhoneNumber like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' Or
                                        	   ClinicPhoneNumber Like '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
go

Alter Table Clinics
	Add Constraint chkClinicZipCode Check (ClinicZipCode like '[0-9][0-9][0-9][0-9][0-9]' Or 
										   ClinicZipCode like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
go

	-- Patients

Alter Table Patients
	Add Constraint chkPatientPhoneNumber Check (PatientPhoneNumber like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' Or
                                        	    PatientPhoneNumber Like '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
go

Alter Table Patients
	Add Constraint chkPatientZipCode Check (PatientZipCode like '[0-9][0-9][0-9][0-9][0-9]' Or 
										    PatientZipCode like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
go

	-- Doctors

Alter Table Doctors
	Add Constraint chkDoctorPhoneNumber Check (DoctorPhoneNumber like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' Or
                                        	   DoctorPhoneNumber Like '([0-9][0-9][0-9])-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
go

Alter Table Doctors
	Add Constraint chkDoctorZipCode Check (DoctorZipCode like '[0-9][0-9][0-9][0-9][0-9]' Or 
										   DoctorZipCode like '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
go

	-- Appointments	

Alter Table Appointments
    Add Constraint fkAppointmentPatientID Foreign Key (AppointmentPatientID) References Patients(PatientID);
go

Alter Table Appointments
    Add Constraint fkAppointmentDoctorID Foreign Key (AppointmentDoctorID) References Doctors(DoctorID);
go

Alter Table Appointments
    Add Constraint fkAppointmentClinicID Foreign Key (AppointmentClinicID) References Clinics(ClinicID);
go

-- Add Views -- 

Create View vClinics -- Clinics View
	As Select ClinicID, ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode 
	From Clinics;
go

Create View vPatients -- Patients View
	As Select PatientID, PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, 
			  PatientState, PatientZipCode
	From Patients;
go

Create View vDoctors -- Doctors View
	As Select DoctorID, DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, 
			  DoctorZipCode
	From Doctors;
go

Create View vAppointments -- Appointments View
	As Select AppointmentID, AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID
	From Appointments;
go

Create or Alter View vAppointmentsByPatientsDoctorsAndClinics -- Combines all the data from all tables into a view
As Select a.AppointmentID, convert(nvarchar(10), a.AppointmentDateTime, 101) as AppointmentDate, 
		  convert(nvarchar(5), a.AppointmentDateTime, 108) as AppointmentTime, 
		  p.PatientID, p.PatientFirstName + ' ' + p.PatientLastName as PatientName, p.PatientPhoneNumber, p.PatientAddress, 
		  p.PatientCity, p.PatientState, p.PatientZipCode, d.DoctorID, d.DoctorFirstName + ' ' + d.DoctorLastName as DoctorName, 
		  d.DoctorPhoneNumber, d.DoctorAddress, d.DoctorCity, d.DoctorState, d.DoctorZipCode, c.ClinicID, c.ClinicName, c.ClinicPhoneNumber, 
		  c.ClinicAddress, c.ClinicCity, c.ClinicState, c.ClinicZipCode
	From Appointments as a
	Join Clinics as c
		On a.AppointmentClinicID = c.ClinicID
	Join Patients as p 
		On a.AppointmentPatientID = p.PatientID
	Join Doctors as d
		On a.AppointmentDoctorID = d.DoctorID
go

-- Add Stored Procedures --

go
Create or Alter Procedure pInsClinics
(@ClinicName nvarchar(100), @ClinicPhoneNumber nvarchar(100), @ClinicAddress nvarchar(100),
 @ClinicCity nvarchar(100), @ClinicState nchar(2), @ClinicZipCode nvarchar(10))
/* Author: <VRughwani>
** Desc: Processes Inserts for Clinics Table
** Change Log: When,Who,What
** <2020-26-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Insert Into Clinics (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, 
	  						ClinicZipCode) 
 		Values (@ClinicName, @ClinicPhoneNumber, @ClinicAddress, @ClinicCity, @ClinicState, @ClinicZipCode)
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the data you are entering!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pInsClinics @ClinicName = 'Aster', @ClinicPhoneNumber = '206-111-2222', @ClinicAddress = '123 Main',
 						    @ClinicCity = 'Dubai', @ClinicState = 'UAE' , @ClinicZipCode = '00000';
 Print @Status;
 Select * From Clinics;
*/

go
Create or Alter Procedure pInsPatients
(@PatientFirstName nvarchar(100), @PatientLastName nvarchar(100), @PatientPhoneNumber nvarchar(100), @PatientAddress nvarchar(100),
 @PatientCity nvarchar(100), @PatientState nchar(2), @PatientZipCode nvarchar(10))
/* Author: <VRughwani>
** Desc: Processes Inserts for Patients Table
** Change Log: When,Who,What
** <2020-26-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Insert Into Patients (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, 
	     					PatientZipCode) 
 		Values (@PatientFirstName, @PatientLastName, @PatientPhoneNumber, @PatientAddress, @PatientCity, @PatientState, 
	     		@PatientZipCode)
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the data you are entering!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pInsPatients @PatientFirstName = 'Bob', @PatientLastName = 'Dob', @PatientPhoneNumber = '206-111-2222', 
 							 @PatientAddress = '456 Main', @PatientCity = 'Dubai', @PatientState = 'UAE',  
							 @PatientZipCode = '00000';
 Print @Status;
 Select * From Patients;
*/

go
Create or Alter Procedure pInsDoctors
(@DoctorFirstName nvarchar(100), @DoctorLastName nvarchar(100), @DoctorPhoneNumber nvarchar(100), @DoctorAddress nvarchar(100),
 @DoctorCity nvarchar(100), @DoctorState nchar(2), @DoctorZipCode nvarchar(10))
/* Author: <VRughwani>
** Desc: Processes Inserts for Doctors Table
** Change Log: When,Who,What
** <2020-26-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Insert Into Doctors (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, 
	  						DoctorZipCode) 
 		Values (@DoctorFirstName, @DoctorLastName, @DoctorPhoneNumber, @DoctorAddress, @DoctorCity, @DoctorState, 
	  			@DoctorZipCode)
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the data you are entering!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pInsDoctors @DoctorFirstName = 'Dob', @DoctorLastName = 'Rad', @DoctorPhoneNumber = '206-111-2222',
 						    @DoctorAddress = '678 Main' , @DoctorCity = 'Dubai' , @DoctorState = 'UAE' , 
							@DoctorZipCode = '00000';
 Print @Status;
 Select * From Doctors;
*/

go
Create or Alter Procedure pInsAppointments
(@AppointmentDateTime datetime, @AppointmentPatientID int, @AppointmentDoctorID int, @AppointmentClinicID int)
/* Author: <VRughwani>
** Desc: Processes Inserts for Appointments Table
** Change Log: When,Who,What
** <2020-26-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Insert Into Appointments (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID) 
 		Values (@AppointmentDateTime, @AppointmentPatientID, @AppointmentDoctorID, @AppointmentClinicID)
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the data you are entering!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pInsAppointments @AppointmentDateTime = '6/6/20', @AppointmentPatientID = '1' , @AppointmentDoctorID = '1', 
								 @AppointmentClinicID = '1';
 Print @Status;
 Select * From Appointments;
*/

Create or Alter Procedure pUpdClinics
(@ClinicID int, @ClinicName nvarchar(100), @ClinicPhoneNumber nvarchar(100), @ClinicAddress nvarchar(100),
 @ClinicCity nvarchar(100), @ClinicState nchar(2), @ClinicZipCode nvarchar(10))
/* Author: <VRughwani>
** Desc: Update the Clinics Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Update Clinics Set ClinicName = @ClinicName, ClinicPhoneNumber = @ClinicPhoneNumber, ClinicAddress = @ClinicAddress, 
	  					 ClinicCity = @ClinicCity, ClinicState = @ClinicState, ClinicZipCode = @ClinicZipCode
      Where ClinicID = @ClinicID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the ClinicID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pUpdClinics @ClinicID = '1', @ClinicName = 'Aster', @ClinicPhoneNumber = '205-233-2133', @ClinicAddress = '123 Main',
  							@ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '50394';
 Print @Status;
 Select * From Clinics;
 */

 Create or Alter Procedure pUpdPatients
(@PatientID int, @PatientFirstName nvarchar(100), @PatientLastName nvarchar(100), @PatientPhoneNumber nvarchar(100), 
 @PatientAddress nvarchar(100), @PatientCity nvarchar(100), @PatientState nchar(2), @PatientZipCode nvarchar(10))
/* Author: <VRughwani>
** Desc: Update the Patients Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Update Patients Set PatientFirstName = @PatientFirstName, PatientLastName = @PatientLastName, 
	  					  PatientPhoneNumber = @PatientPhoneNumber, PatientAddress = @PatientAddress, 
						  PatientCity = @PatientCity, PatientState = PatientState, PatientZipCode = @PatientZipCode
      Where PatientID = @PatientID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the PatientID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pUpdPatients @PatientID = '1', @PatientFirstName = 'Bob', @PatientLastName = 'Dob', 
 							 @PatientPhoneNumber = '206-111-2222', @PatientAddress = '456 Main', @PatientCity = 'Seattle', 
							 @PatientState = 'WA',  @PatientZipCode = '33323';
 Print @Status;
 Select * From Patients;
 */

  Create or Alter Procedure pUpdDoctors
(@DoctorID int, @DoctorFirstName nvarchar(100), @DoctorLastName nvarchar(100), @DoctorPhoneNumber nvarchar(100), 
 @DoctorAddress nvarchar(100), @DoctorCity nvarchar(100), @DoctorState nchar(2), @DoctorZipCode nvarchar(10))
/* Author: <VRughwani>
** Desc: Update the Doctors Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Update Doctors Set DoctorFirstName = @DoctorFirstName, DoctorLastName = @DoctorLastName, DoctorPhoneNumber = @DoctorPhoneNumber, 
	  					 DoctorAddress = @DoctorAddress, DoctorCity = @DoctorCity, DoctorState = @DoctorState, 
						 DoctorZipCode = @DoctorZipCode
      Where DoctorID = @DoctorID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the DoctorID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pUpdDoctors @DoctorID = '1', @DoctorFirstName = 'Dob', @DoctorLastName = 'Rad', @DoctorPhoneNumber = '206-111-2222',
 						    @DoctorAddress = '678 Main' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', 
							@DoctorZipCode = '32231';
 Print @Status;
 Select * From Doctors;
 */

  Create or Alter Procedure pUpdAppointments
(@AppointmentID int, @AppointmentDateTime datetime, @AppointmentPatientID int, @AppointmentDoctorID int, @AppointmentClinicID int)
/* Author: <VRughwani>
** Desc: Update the Appointments Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc.
*/
AS
 Begin -- Body
  Declare @RC int = 0;
  Begin Try
   Begin Transaction; 
    -- Transaction Code --
      Update Appointments Set AppointmentDateTime = @AppointmentDateTime, AppointmentPatientID = @AppointmentPatientID, 
	  					 AppointmentDoctorID = @AppointmentDoctorID, AppointmentClinicID = @AppointmentClinicID
      Where AppointmentID = @AppointmentID
   Commit Transaction;
   Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the AppointmentID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pUpdAppointments @AppointmentID = '1', @AppointmentDateTime = '6/6/20 05:30', @AppointmentPatientID = '1' , 
                                 @AppointmentDoctorID = '1', @AppointmentClinicID = '1';
 Print @Status;
 Select * From Appointments;
 */

    Create or Alter Procedure pDelAppointments
(@AppointmentID int)
/* Author: <VRughwani>
** Desc: Deletes from Appointments Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc
*/
AS
  Begin -- Body
  Declare @RC int = 0;
  Begin Try
    Begin Transaction; 
    -- Transaction Code --
      Delete From Appointments Where AppointmentID = @AppointmentID
    Commit Transaction;
    Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the AppointmentID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pDelAppointments @AppointmentID = 1;
 Print @Status;
 Select * From Appointments;
 */

  Create or Alter Procedure pDelClinics
(@ClinicID int)
/* Author: <VRughwani>
** Desc: Deletes from Clinics Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc
*/
AS
  Begin -- Body
  Declare @RC int = 0;
  Begin Try
    Begin Transaction; 
    -- Transaction Code --
      Delete From Clinics Where ClinicID = @ClinicID
    Commit Transaction;
    Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the ClinicID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pDelClinics @ClinicID = 1;
 Print @Status;
 Select * From Clinics;
 */

   Create or Alter Procedure pDelPatients
(@PatientID int)
/* Author: <VRughwani>
** Desc: Deletes from Patients Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc
*/
AS
  Begin -- Body
  Declare @RC int = 0;
  Begin Try
    Begin Transaction; 
    -- Transaction Code --
      Delete From Patients Where PatientID = @PatientID
    Commit Transaction;
    Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the PatientID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pDelPatients @PatientID = 1;
 Print @Status;
 Select * From Patients;
 */

   Create or Alter Procedure pDelDoctors
(@DoctorID int)
/* Author: <VRughwani>
** Desc: Deletes from Doctors Table
** Change Log: When,Who,What
** <2020-12-05>,<VRughwani>,Created Sproc
*/
AS
  Begin -- Body
  Declare @RC int = 0;
  Begin Try
    Begin Transaction; 
    -- Transaction Code --
      Delete From Doctors Where DoctorID = @DoctorID
    Commit Transaction;
    Set @RC = +1;
  End Try
  Begin Catch
    If(@@Trancount > 0) Rollback Transaction;
    Print 'There was an Error! Please check the DoctorID!'
    Print Error_Message();
    Set @RC = -1
  End Catch
  Return @RC;
 End -- Body
go

/* 
 Declare @Status int;
 Exec @Status = pDelDoctors @DoctorID = 1;
 Print @Status;
 Select * From Doctors;
 */

-- Set Permissions

Deny Select, Insert, Update, Delete On Clinics To Public;
Deny Select, Insert, Update, Delete On Patients To Public;
Deny Select, Insert, Update, Delete On Doctors To Public;
Deny Select, Insert, Update, Delete On Appointments To Public;

Grant Select on vClinics To public;
Grant Select on vPatients To public;
Grant Select on vDoctors To public;
Grant Select on vAppointments To public;
Grant Select on vAppointmentsByPatientsDoctorsAndClinics To public;

Grant Execute on pInsClinics To public;
Grant Execute on pUpdClinics To public;
Grant Execute on pDelClinics To public;

Grant Execute on pInsPatients To public;
Grant Execute on pUpdPatients To public;
Grant Execute on pDelPatients To public;

Grant Execute on pInsDoctors To public;
Grant Execute on pUpdDoctors To public;
Grant Execute on pDelDoctors To public;

Grant Execute on pInsAppointments To public;
Grant Execute on pUpdAppointments To public;
Grant Execute on pDelAppointments To public;

-- Test Views and Sprocs --

  -- Test Views

Select * from vClinics;
go
Select * from vPatients;
go
Select * from vDoctors;
go
Select * from vAppointments;
go
Select * from vAppointmentsByPatientsDoctorsAndClinics;
go

  -- Test Sprocs

    -- Inserts

  Declare @Status int;
 Exec @Status = pInsClinics @ClinicName = 'Aster', @ClinicPhoneNumber = '205-233-2133', @ClinicAddress = '123 Main',
  							            @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '50394'
 Select Case @Status
  When +1 Then 'Clinic insert was successful!'
  When -1 Then 'Clinic Insert failed! Common Issues: Duplicate Data'
  End as [Status]
 Select * From Clinics;
go

  Declare @Status int;
 Exec @Status = pInsPatients @PatientFirstName = 'Bob', @PatientLastName = 'Dob', @PatientPhoneNumber = '206-111-2222', 
                             @PatientAddress = '456 Main', @PatientCity = 'Seattle', @PatientState = 'WA',  
                             @PatientZipCode = '33323'
 Select Case @Status
  When +1 Then 'Patient insert was successful!'
  When -1 Then 'Patient Insert failed! Common Issues: Duplicate Data'
  End as [Status]
 Select * From Patients;
go

  Declare @Status int;
 Exec @Status = pInsDoctors @DoctorFirstName = 'Dob', @DoctorLastName = 'Rad', @DoctorPhoneNumber = '206-111-2222',
 						                @DoctorAddress = '678 Main' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '32231'
 Select Case @Status
  When +1 Then 'Doctor insert was successful!'
  When -1 Then 'Doctor Insert failed! Common Issues: Duplicate Data'
  End as [Status]
 Select * From Doctors;
go

  Declare @Status int;
  Declare @CurrentPatientID int = IDENT_CURRENT('Patients')
  Declare @CurrentDoctorID int = IDENT_CURRENT('Doctors')
  Declare @CurrentClinicID int = IDENT_CURRENT('Clinics')
 Exec @Status = pInsAppointments @AppointmentDateTime = '6/6/20 05:30', @AppointmentPatientID = @CurrentPatientID, 
                                 @AppointmentDoctorID = @CurrentDoctorID, @AppointmentClinicID = @CurrentClinicID
 Select Case @Status
  When +1 Then 'Appointment insert was successful!'
  When -1 Then 'Appointment Insert failed! Common Issues: Duplicate Data'
  End as [Status]
 Select * From Appointments;
go

    -- Updates

 Declare @Status int;
 Declare @NewIDpUpdC int = IDENT_CURRENT('Clinics')
 Exec @Status = pUpdClinics @ClinicID = @NewIDpUpdC, @ClinicName = 'UW Medicine', @ClinicPhoneNumber = '205-233-2133', 
                            @ClinicAddress = '123 Main', @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '50394'
 Select Case @Status
  When +1 Then 'Clinic update was successful!'
  When -1 Then 'Clinic update failed!'
  End as [Status]
 Select * From Clinics;
go

 Declare @Status int;
 Declare @NewIDpUpdP int = IDENT_CURRENT('Patients')
 Exec @Status = pUpdPatients @PatientID = @NewIDpUpdP, @PatientFirstName = 'Bob', @PatientLastName = 'Dobup', 
                             @PatientPhoneNumber = '206-111-2222', @PatientAddress = '456 Main', @PatientCity = 'Seattle', 
                             @PatientState = 'WA', @PatientZipCode = '33323'
 Select Case @Status
  When +1 Then 'Patient update was successful!'
  When -1 Then 'Patient update failed!'
  End as [Status]
 Select * From Patients;
go

 Declare @Status int;
 Declare @NewIDpUpdD int = IDENT_CURRENT('Doctors')
 Exec @Status = pUpdDoctors @DoctorID = @NewIDpUpdD, @DoctorFirstName = 'Dob', @DoctorLastName = 'RadUp', 
                            @DoctorPhoneNumber = '206-111-2222', @DoctorAddress = '678 Main' , @DoctorCity = 'Seattle' , 
                            @DoctorState = 'WA', @DoctorZipCode = '32231'
 Select Case @Status
  When +1 Then 'Doctor update was successful!'
  When -1 Then 'Doctor update failed!'
  End as [Status]
 Select * From Doctors;
go

 Declare @Status int;
 Declare @NewIDpUpdA int = IDENT_CURRENT('Appointments')
 Declare @CurrentPatientID int = IDENT_CURRENT('Patients')
 Declare @CurrentDoctorID int = IDENT_CURRENT('Doctors')
 Declare @CurrentClinicID int = IDENT_CURRENT('Clinics')
 Exec @Status = pUpdAppointments @AppointmentID = @NewIDpUpdA, @AppointmentDateTime = '6/6/20 01:30', 
                                 @AppointmentPatientID = @CurrentPatientID, @AppointmentDoctorID = @CurrentDoctorID, 
                                 @AppointmentClinicID = @CurrentClinicID
 Select Case @Status
  When +1 Then 'Appointment update was successful!'
  When -1 Then 'Appointment update failed!'
  End as [Status]
 Select * From Appointments;
go

    -- Deletes

 Declare @Status int;
Declare @NewIDpDelA int = IDENT_CURRENT('Appointments')
 Exec @Status = pDelAppointments @AppointmentID = @NewIDpDelA;
 Select Case @Status
  When +1 Then 'Appointment delete was successful!'
  When -1 Then 'Appointment delete failed!'
  End as [Status]
  Select * From Appointments;
go

 Declare @Status int;
Declare @NewIDpDelC int = IDENT_CURRENT('Clinics')
 Exec @Status = pDelClinics @ClinicID = @NewIDpDelC;
 Select Case @Status
  When +1 Then 'Clinic delete was successful!'
  When -1 Then 'Clinic delete failed! Common Issues: FKConstraint Values must be deleted first'
  End as [Status]
  Select * From Clinics;
go

 Declare @Status int;
Declare @NewIDpDelP int = IDENT_CURRENT('Patients')
 Exec @Status = pDelPatients @PatientID = @NewIDpDelP;
 Select Case @Status
  When +1 Then 'Patient delete was successful!'
  When -1 Then 'Patient delete failed! Common Issues: FKConstraint Values must be deleted first'
  End as [Status]
  Select * From Patients;
go

 Declare @Status int;
Declare @NewIDpDelD int = IDENT_CURRENT('Doctors')
 Exec @Status = pDelDoctors @DoctorID = @NewIDpDelD;
 Select Case @Status
  When +1 Then 'Doctor delete was successful!'
  When -1 Then 'Doctor delete failed! Common Issues: FKConstraint Values must be deleted first'
  End as [Status]
  Select * From Doctors;
go

-- Inserting Data --

Exec pInsClinics @ClinicName = 'UW Clinic', @ClinicPhoneNumber = '205-233-2133', @ClinicAddress = '123 Main',
  							 @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '50394';
go

Exec pInsPatients @PatientFirstName = 'Bob', @PatientLastName = 'Dob', @PatientPhoneNumber = '206-111-2222', 
                  @PatientAddress = '456 Main', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '33323';
go

Exec pInsDoctors @DoctorFirstName = 'Dob', @DoctorLastName = 'Rad', @DoctorPhoneNumber = '206-111-2222',
 						    @DoctorAddress = '678 Main' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '32231';
go

Declare @CurrentPatientID int = IDENT_CURRENT('Patients')
Declare @CurrentDoctorID int = IDENT_CURRENT('Doctors')
Declare @CurrentClinicID int = IDENT_CURRENT('Clinics')
Exec pInsAppointments @AppointmentDateTime = '6/6/20 05:30', @AppointmentPatientID = @CurrentPatientID, 
                      @AppointmentDoctorID = @CurrentDoctorID, @AppointmentClinicID = @CurrentClinicID
go

/**************************************************************************************************/