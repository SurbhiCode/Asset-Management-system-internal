// Trigger handler for Maintenance records after update
trigger Maintenance_Trigger on Maintenance__c (After update) {
    if(trigger.isAfter && trigger.isupdate)
    {
         // Call the update_next_maintenance method from Maintenance_Handler to handle updates on Maintenance records
        Maintenance_Handler.update_next_maintanamaintenance(trigger.new,Trigger.oldMap);
    }
}