public class Maintenance_Handler {
    // Method to update next maintenance dates for completed maintenance records
    public static void update_next_maintanamaintenance(List<Maintenance__c> Maintenance_list,Map<id,Maintenance__c> old_data){
        
        List<Id> Asset_ids=new list<id>();  // List to store Asset Ids for which  Triggered maintenance is completed
        for(Maintenance__c data:Maintenance_list) // Iterate through the Triggered Maintenance records to add asset ids to list
        {
            // Check if maintenance is completed or Maintenance Skipped  and status is changed
            if((data.Maintenance_Status__c=='Completed' || data.Maintenance_Status__c=='Maintenance Skipped')  && data.Maintenance_Status__c != old_data.get(data.id).Maintenance_Status__c )
            {
                Asset_ids.add(data.Assets__c);
            }
        }
        
        Map<string,Integer> Interval_Period=new Map<string,Integer>(); // Map to store interval periods based on Equipment type[Equipment Name,Interval Days]
         // Query the metadata records for maintenance intervals
        list<Maintance_intervals__mdt> Meta_data=new list<Maintance_intervals__mdt>([Select label,Interval_Period__c from Maintance_intervals__mdt]);//Metadata Query
        for(Maintance_intervals__mdt data:Meta_data) // Iterate through the metadata values and store in a map
        {
            Interval_Period.put(String.valueof(data.label),Integer.valueOf(data.Interval_Period__c));
        }
       
        Map<String,Asset__c> Asset_data=new map<String,Asset__c>([select id,Next_Maintance_Date__c,Last_Maintance_Date__c,Equipments__c from Asset__c where id in: Asset_ids]);  // Query to get maintenance related assets 
        for(Asset__c Asset_loop:Asset_data.values())// Update the Last Maintenance Date and calculate and update Next Maintenance Date
        {
            Asset_loop.Last_Maintance_Date__c=system.today();
            if(Interval_Period.get(Asset_loop.Equipments__c) != Null){
                Asset_loop.Next_Maintance_Date__c=system.today()+Interval_Period.get(Asset_loop.Equipments__c);
            }
            else{
                System.debug('Equipments Value Not Present Metadada');
            }
          
        }
        // Perform the update operation on Asset records
        try {
			update(Asset_data.values());
        } catch(Exception e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
            
    }
}