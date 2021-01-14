Use PatientAppointmentsDB_VRughwani;
go

Create or Alter View vNoOfAppointmentsPerPatient -- Number of Appointments Per Patient
	As Select Top 1000000000 p.PatientID, p.PatientFirstName + ' ' + p.PatientLastName as PatientName, 
              [NoOfVisits] = Count(a.AppointmentPatientID)
	From Patients as p
	Join Appointments as a
		On a.AppointmentPatientID = p.PatientID
    Group By PatientID, PatientFirstName + ' ' + PatientLastName
    Order By -Count(a.AppointmentPatientID);
go


 -- Select * From vNoOfAppointmentsPerPatient;