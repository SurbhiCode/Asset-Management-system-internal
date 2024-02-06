// Trigger
trigger AssetTrigger on Asset__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            AssetHandler.calculateNextMaintenanceDate(Trigger.new);
        }

        if (Trigger.isUpdate) {
            //AssetHandler.calculateDepreciation(Trigger.new, Trigger.oldMap);
        }
    }
}