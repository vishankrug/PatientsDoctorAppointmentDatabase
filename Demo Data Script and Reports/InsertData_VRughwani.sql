Use PatientAppointmentsDB_VRughwani;
go
-- Insert --

    -- Deleting Data

Delete From Appointments; 
go
Delete From Patients;
go
Delete From Doctors;
go
Delete From Clinics;
go

    -- Reseting Identity

DBCC CHECKIDENT ('Appointments', RESEED, 0);
GO
DBCC CHECKIDENT ('Patients', RESEED, 0);
GO
DBCC CHECKIDENT ('Doctors', RESEED, 0);
GO
DBCC CHECKIDENT ('Clinics', RESEED, 0);
GO


    -- Insert into Clinics
Exec pInsClinics @ClinicName = 'Aster Clinic', @ClinicPhoneNumber = '205-233-2433', @ClinicAddress = '293 Burj',
  							 @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '29103';
go

Exec pInsClinics @ClinicName = 'ABCD Clinic', @ClinicPhoneNumber = '206-859-2313', @ClinicAddress = '1545 8th Ave',
  							 @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '37203';
go

Exec pInsClinics @ClinicName = 'Childrens Clinic', @ClinicPhoneNumber = '201-357-6993', @ClinicAddress = '830 Maple',
  							 @ClinicCity = 'Tacoma', @ClinicState = 'WA', @ClinicZipCode = '39204';
go

Exec pInsClinics @ClinicName = 'Coca Clinic', @ClinicPhoneNumber = '404-404-4040', @ClinicAddress = '5583 Lander',
  							 @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '50173';
go

Exec pInsClinics @ClinicName = 'Fork Clinic', @ClinicPhoneNumber = '293-402-5830', @ClinicAddress = '2048 Elm',
  							 @ClinicCity = 'Seattle', @ClinicState = 'WA', @ClinicZipCode = '29438';
go

    -- Insert Into Doctors

Exec pInsDoctors @DoctorFirstName = 'Robert', @DoctorLastName = 'Brian', @DoctorPhoneNumber = '103-333-2940',
 						    @DoctorAddress = '2032 Lander' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '20392';
go

Exec pInsDoctors @DoctorFirstName = 'Fatimah', @DoctorLastName = 'Ahmed', @DoctorPhoneNumber = '206-779-0402',
 						    @DoctorAddress = '2032 Egor' , @DoctorCity = 'Tacoma' , @DoctorState = 'WA', @DoctorZipCode = '20132';
go

Exec pInsDoctors @DoctorFirstName = 'Tyra', @DoctorLastName = 'Roberts', @DoctorPhoneNumber = '421-424-2213',
 						    @DoctorAddress = '1038 Jumeirah' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '50382';
go

Exec pInsDoctors @DoctorFirstName = 'Jiya', @DoctorLastName = 'Singer', @DoctorPhoneNumber = '230-334-2344',
 						    @DoctorAddress = '503 Executive' , @DoctorCity = 'Tacoma' , @DoctorState = 'WA', @DoctorZipCode = '20492';
go

Exec pInsDoctors @DoctorFirstName = 'Rayyan', @DoctorLastName = 'Jamel', @DoctorPhoneNumber = '504-394-2930',
 						    @DoctorAddress = '504 JLT' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '20480';
go

Exec pInsDoctors @DoctorFirstName = 'Ramia', @DoctorLastName = 'Shazar', @DoctorPhoneNumber = '503-203-2690',
 						    @DoctorAddress = '7069 Springs' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '20193';
go

Exec pInsDoctors @DoctorFirstName = 'Joshua', @DoctorLastName = 'Dan', @DoctorPhoneNumber = '492-103-5930',
 						    @DoctorAddress = '2948 IDK' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '20403';
go

Exec pInsDoctors @DoctorFirstName = 'Zeina', @DoctorLastName = 'Zaks', @DoctorPhoneNumber = '205-305-6999',
 						    @DoctorAddress = '3940 Caris' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '45059';
go

Exec pInsDoctors @DoctorFirstName = 'Vish', @DoctorLastName = 'Rug', @DoctorPhoneNumber = '203-584-3085',
 						    @DoctorAddress = '5272 8th Ave' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '19302';
go

Exec pInsDoctors @DoctorFirstName = 'Samin', @DoctorLastName = 'Atta', @DoctorPhoneNumber = '404-290-1039',
 						    @DoctorAddress = '3980 Gell' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '29310';
go

Exec pInsDoctors @DoctorFirstName = 'Valentino', @DoctorLastName = 'Rossi', @DoctorPhoneNumber = '201-493-5039',
 						    @DoctorAddress = '2409 Moto' , @DoctorCity = 'Seattle' , @DoctorState = 'WA', @DoctorZipCode = '20210';
go


    -- Insert Into Patients

Exec pInsPatients @PatientFirstName = 'Uday', @PatientLastName = 'Jalu', @PatientPhoneNumber = '206-392-5099', 
                  @PatientAddress = '456 Water', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '40903';
go

Exec pInsPatients @PatientFirstName = 'Abdul', @PatientLastName = 'Maru', @PatientPhoneNumber = '504-392-4058', 
                  @PatientAddress = '456 EH', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '20199';
go

Exec pInsPatients @PatientFirstName = 'Senor', @PatientLastName = 'Frog', @PatientPhoneNumber = '392-490-1948', 
                  @PatientAddress = '456 Pond', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '11002';
go

Exec pInsPatients @PatientFirstName = 'Mike', @PatientLastName = 'Dunt', @PatientPhoneNumber = '201-594-2049', 
                  @PatientAddress = '2944 Pond', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '20949';
go

Exec pInsPatients @PatientFirstName = 'Nandan', @PatientLastName = 'Ravib', @PatientPhoneNumber = '459-382-5804', 
                  @PatientAddress = '456 Prague', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '59430';
go

Exec pInsPatients @PatientFirstName = 'Anita', @PatientLastName = 'Hajab', @PatientPhoneNumber = '340-392-4898', 
                  @PatientAddress = '583 Pond', @PatientCity = 'Tacoma', @PatientState = 'WA',  
                  @PatientZipCode = '29102';
go

Exec pInsPatients @PatientFirstName = 'Clark', @PatientLastName = 'Thomas', @PatientPhoneNumber = '206-444-8888', 
                  @PatientAddress = '456 Rich', @PatientCity = 'Tacoma', @PatientState = 'WA',  
                  @PatientZipCode = '18304';
go

Exec pInsPatients @PatientFirstName = 'Eric', @PatientLastName = 'Kim', @PatientPhoneNumber = '206-583-1020', 
                  @PatientAddress = '2018 8th Ave', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '50438';
go

Exec pInsPatients @PatientFirstName = 'Isaac', @PatientLastName = 'Ick', @PatientPhoneNumber = '203-504-3939', 
                  @PatientAddress = '456 Senor', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '10243';
go

Exec pInsPatients @PatientFirstName = 'Justin', @PatientLastName = 'Eras', @PatientPhoneNumber = '404-392-9999', 
                  @PatientAddress = '2940 Gand', @PatientCity = 'Seattle', @PatientState = 'WA',  
                  @PatientZipCode = '10394';
go

    -- Insert Into Appointments

Exec pInsAppointments @AppointmentDateTime = '6/1/20 08:30', @AppointmentPatientID = 2, 
                      @AppointmentDoctorID = '5', @AppointmentClinicID = '5';
go

Exec pInsAppointments @AppointmentDateTime = '6/6/20 09:30', @AppointmentPatientID = '3', 
                      @AppointmentDoctorID = '3', @AppointmentClinicID = '3';
go

Exec pInsAppointments @AppointmentDateTime = '6/10/20 10:30', @AppointmentPatientID = '4', 
                      @AppointmentDoctorID = '5', @AppointmentClinicID = '5';
go

Exec pInsAppointments @AppointmentDateTime = '6/20/20 11:30', @AppointmentPatientID = '8', 
                      @AppointmentDoctorID = '7', @AppointmentClinicID = '4';
go

Exec pInsAppointments @AppointmentDateTime = '6/21/20 13:30', @AppointmentPatientID = '8', 
                      @AppointmentDoctorID = '9', @AppointmentClinicID = '3';
go

Exec pInsAppointments @AppointmentDateTime = '7/1/20 15:30', @AppointmentPatientID = '9', 
                      @AppointmentDoctorID = '9', @AppointmentClinicID = '5';
go

Exec pInsAppointments @AppointmentDateTime = '6/5/20 17:30', @AppointmentPatientID = '10', 
                      @AppointmentDoctorID = '3', @AppointmentClinicID = '2';
go

Exec pInsAppointments @AppointmentDateTime = '6/19/20 13:50', @AppointmentPatientID = '7', 
                      @AppointmentDoctorID = '8', @AppointmentClinicID = '2';
go

Exec pInsAppointments @AppointmentDateTime = '6/24/20 17:40', @AppointmentPatientID = '3', 
                      @AppointmentDoctorID = '9', @AppointmentClinicID = '2';
go

Exec pInsAppointments @AppointmentDateTime = '6/25/20 10:45', @AppointmentPatientID = '10', 
                      @AppointmentDoctorID = '10', @AppointmentClinicID = '4';
go


/*
Select * from vClinics;
go
Select * from vDoctors;
go
Select * from vPatients;
go
Select * from vAppointments;
go
Select * from vAppointmentsByPatientsDoctorsAndClinics;
go
*/