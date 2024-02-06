public class AssetApexController {
            @AuraEnabled(cacheable=true)
            public static List<String> getBrandOptions() {
                List<String> picklistValues = new List<String>();
                Schema.DescribeFieldResult fieldResult = Asset__c.Brand_Name__c.getDescribe();
                List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
                
                for (Schema.PicklistEntry entry : picklistEntries) {
                    picklistValues.add(entry.getLabel());
                }
                
                System.debug('======> Line 36' + picklistValues);
                return picklistValues;
            }
            @AuraEnabled(cacheable=true)
            public static List<String> getEquipmentsOptions() {
                List<String> picklistValues2 = new List<String>();
                Schema.DescribeFieldResult fieldResult = Asset__c.Equipments__c.getDescribe();
                List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                       picklistValues2.add(entry.getLabel());
                    
                }
                System.debug('Line 48'+picklistValues2);
                return picklistValues2;
            }
            @AuraEnabled(cacheable=true)
            public static List<String> getStatusOptions() {
                List<String> picklistValues3 = new List<String>();
                Schema.DescribeFieldResult fieldResult = Asset__c.Asset_Status__c.getDescribe();
                List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                        picklistValues3.add(entry.getLabel());
                    
                }
                System.debug('Line 48'+picklistValues3);
                return picklistValues3; 
            }
            @AuraEnabled(cacheable=true)
            public static List<String> getLocationOptions() {
                List<String> picklistValues4 = new List<String>();
                Schema.DescribeFieldResult fieldResult = Asset__c.Location__c.getDescribe();
                List<Schema.PicklistEntry> picklistEntries = fieldResult.getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                        picklistValues4.add(entry.getLabel());
                    
                }
                System.debug('Line 48'+picklistValues4);
                return picklistValues4; 
              
            }
            @AuraEnabled
            public static string createRecords(string equipmentValuess,string brandnamess,string status,string location,date purchasedate,Integer Amount,integer Number_of_Records) {
                List<Asset__c> newAssets = new List<Asset__c>();
            if(equipmentValuess != null || brandnamess != null || location != null || purchasedate != null || Amount != null){
                for (Integer i = 0; i < Number_of_Records; i++) {
                    Asset__c  new_data= new Asset__c();
                    new_data.Asset_Status__c=status;
                    new_data.Equipments__c=equipmentValuess;
                    new_data.Brand_Name__c=brandnamess;
                    new_data.Location__c=location;
                    new_data.Purchased_Date__c=purchasedate;
                    new_data.Purchased_Amount__c=Amount;
                    newAssets.add(new_data);
                }
            }
            //  if(Number_of_Records==0){
            //     Asset__c  new_data= new Asset__c();
            //     new_data.Asset_Status__c=status;
            //     new_data.Equipments__c=equipmentValuess;
            //     new_data.Brand_Name__c=brandnamess;
            //     new_data.Location__c=location;
            //     Insert new_data;

            //  }
                try {
                    insert newAssets;
                    return 'Success';
                } catch (Exception e) {
                    // Handle exception, log error, or perform other actions
                    throw new AuraHandledException('Error creating records: ' + e.getMessage());
                    
                    
                }
            }
           @AuraEnabled
           public static string createRecordssingle(string equipmentValuess,string brandnamess,string status,string location,date purchasedate,Integer Amount,integer Number_of_Records) 
            {
            if(equipmentValuess != null || brandnamess != null || location != null || purchasedate != null || Amount != null){

                Asset__c  new_data= new Asset__c();
                new_data.Asset_Status__c=status;
                new_data.Equipments__c=equipmentValuess;
                new_data.Brand_Name__c=brandnamess;
                new_data.Location__c=location;
                new_data.Purchased_Date__c=purchasedate;
                new_data.Purchased_Amount__c=Amount;
                
                 try {
                    insert(new_data);
                    return 'success';
                } catch (Exception e) {
                    // Handle the exception
                    System.debug('Exception caught: ' + e.getMessage());
                    return e.getMessage();
                }
            }
            else{
                return 'null data';
            }
               
            }
            
        }