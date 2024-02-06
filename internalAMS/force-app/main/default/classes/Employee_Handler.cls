public class Employee_Handler {
    public static void Asset_Assigment_to_employee(list<Employee__c> employeedata)
    {
        list<Asset__c> Laptop_Asset_data=new list<Asset__c>([select id,Equipments__c from Asset__c Where Asset_Status__c = 'Not Assigned' and Equipments__c='Laptop']);//getting the laptop data
		list<Asset__c> chair_Asset_data=new list<Asset__c>([select id,Equipments__c from Asset__c Where Asset_Status__c = 'Not Assigned' and Equipments__c='Chair']);//getting the chair data
        list<Asset__c> table_Asset_data=new list<Asset__c>([select id,Equipments__c from Asset__c Where Asset_Status__c = 'Not Assigned' and Equipments__c='Table']);//getting the table data
        list<Asset_Assignment__c> new_Asset_Assignment=new list<Asset_Assignment__c>();
        //assigning assets to the employee
	    for(integer i=0;i<=employeedata.size();i++)
        {
            if(Laptop_Asset_data.size()<=employeedata.size())//checking the availability 
            {
                Asset_Assignment__c laptop=new Asset_Assignment__c();
                laptop.Asset_Id__c=Laptop_Asset_data[i].id;
                laptop.Assgined_Date__c=system.today();
                laptop.Employee__c=employeedata[i].Id;
                laptop.Department__c=employeedata[i].Department_Name__c;
                new_Asset_Assignment.add(laptop);
            }
            if(chair_Asset_data.size()<=employeedata.size()){//checking the availability 
                Asset_Assignment__c chair=new Asset_Assignment__c();
                 chair.Asset_Id__c=Laptop_Asset_data[i].id;
                chair.Assgined_Date__c=system.today();
                chair.Employee__c=employeedata[i].Id;
                chair.Department__c=employeedata[i].Department_Name__c;
                new_Asset_Assignment.add(chair);
            }
             if(table_Asset_data.size()<=employeedata.size()){//checking the availability 
                Asset_Assignment__c table=new Asset_Assignment__c();
                  table.Asset_Id__c=Laptop_Asset_data[i].id;
                table.Assgined_Date__c=system.today();
                table.Employee__c=employeedata[i].Id;
                table.Department__c=employeedata[i].Department_Name__c;
                 new_Asset_Assignment.add(table);
            }
        }
         // Perform the update operation on Asset records
        try {
			insert(new_Asset_Assignment);
            system.debug(new_Asset_Assignment);
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
            
    }
}