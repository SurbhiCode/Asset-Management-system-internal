public class Asset_AssignmentTriggerHandler {
    public static void handleBeforeUpdate(List<Asset_Assignment__c> newAssetAssignments, Map<Id, Asset_Assignment__c> oldAssetAssignmentsMap) {
        // Collect Asset IDs that need to be updated
        Set<Id> assetIdsToUpdate = new Set<Id>();

        for (Asset_Assignment__c newAssignment : newAssetAssignments) {
            Asset_Assignment__c oldAssignment = oldAssetAssignmentsMap.get(newAssignment.Id);

            // Check if isAssigned__c is changing from true to false
            if (oldAssignment.Is_Assigned__c && !newAssignment.Is_Assigned__c) {
                assetIdsToUpdate.add(newAssignment.Asset_Id__c);
            }
        }

        // Query and update Asset records
        List<Asset__c> assetsToUpdate = [
            SELECT Id, Asset_Status__c
            FROM Asset__c
            WHERE Id IN :assetIdsToUpdate
        ];

        for (Asset__c asset : assetsToUpdate) {
            // Update AssetStatus__c to 'Not Assigned' or the appropriate value
            asset.Asset_Status__c = 'Not Assigned';
        }

        // Update Asset records
        update assetsToUpdate;
    }
}