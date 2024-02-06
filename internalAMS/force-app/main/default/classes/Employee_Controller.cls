public with sharing class Employee_Controller {
    @AuraEnabled(cacheable=false)
    public static Id createEmployeeRecord(String employeeName, String phone, String location, String email, String departmentName, Date joiningDate) {
        try {
            Employee__c newEmployee = new Employee__c(
                Employee_Name__c = employeeName,
                Phone__c = phone,
                Location__c = location,
                Email__c = email,
                Department_Name__c = departmentName,
                Joining_Date__c = joiningDate
            );

            insert newEmployee;
            return newEmployee.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating employee record: ' + e.getMessage());
        }
    }
    
}