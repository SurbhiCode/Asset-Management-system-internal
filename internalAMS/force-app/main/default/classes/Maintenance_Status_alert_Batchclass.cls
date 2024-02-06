global class Maintenance_Status_alert_Batchclass implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Maintenance_Name__c,Name,Assets__c,Asset_Received_For_Maintenance__c FROM Maintenance__c where Asset_Received_For_Maintenance__c !=True';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Maintenance__c> Maintenance_list) {
       
        List<id> Asset_ids=new list<Id>();
        for(Maintenance__c data:Maintenance_list)
        {
           Asset_ids.add(data.Assets__c) ;
        }
        list<Asset_Assignment__c> Email_list = new list<Asset_Assignment__c>([select id,Asset_Id__c,Employee__c,Employee__r.Email__c from Asset_Assignment__c where Employee__c != null ]);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        try {
            // Update the Account Record
           // update accList;
        
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
  }
}