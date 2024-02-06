// Class
public class AssetHandler {
    
    // Method to calculate and update Next Maintenance Date for a list of Asset records
    public static void calculateNextMaintenanceDate(List<Asset__c> assets) {
        Map<String, Integer> intervalPeriods = new Map<String, Integer>();
		// Query for custom metadata records
        List<Maintance_intervals__mdt> metaData = [SELECT Label, Interval_Period__c FROM Maintance_intervals__mdt];

        for (Maintance_intervals__mdt data : metaData) {
            intervalPeriods.put(String.valueOf(data.Label), Integer.valueOf(data.Interval_Period__c));
        }

        for (Asset__c asset : assets) {
            if (intervalPeriods.get(asset.Equipments__c) != null) {
                asset.Next_Maintance_Date__c = System.today() + intervalPeriods.get(asset.Equipments__c);
            } else {
                System.debug('Equipments Value Not Present in Metadata');
            }
        }
    }

 // Function for Calculating Depreciation Value
 public static void calculateDepreciation(List<Asset__c> newAssets, Map<Id, Asset__c> oldMap) {
     
    // Query custom metadata records
    List<Depreciation_Value__mdt> depreciationMetadataList = [SELECT MasterLabel, Depreciation_Percentage__c FROM Depreciation_Value__mdt];
    
    // Map to store equipment type and corresponding depreciation percentage from custom metadata
    Map<String, Decimal> equipmentDepreciationMap = new Map<String, Decimal>();
    
    // Populate the map with metadata values
    for (Depreciation_Value__mdt metadataRecord : depreciationMetadataList) {
        // Divide the Depreciation_Percentage__c by 100 to convert it to a decimal percentage
        equipmentDepreciationMap.put(metadataRecord.MasterLabel, metadataRecord.Depreciation_Percentage__c / 100.0);
    }

    for (Asset__c newAsset : newAssets) {
        Asset__c oldAsset = oldMap.get(newAsset.Id);

        if (oldAsset == null ||
            newAsset.Purchased_Amount__c != oldAsset.Purchased_Amount__c ||
            newAsset.Purchased_Date__c != oldAsset.Purchased_Date__c) {

            if (newAsset.Purchased_Amount__c != null && newAsset.Purchased_Date__c != null) {
                Decimal depreciationPercentage = 0.0;

                if (newAsset.Equipments__c != null && equipmentDepreciationMap.containsKey(newAsset.Equipments__c)) {
                    depreciationPercentage = equipmentDepreciationMap.get(newAsset.Equipments__c);
                }

                // Calculate the age of the asset in years
                Integer assetAgeInDays = Date.today().daysBetween(newAsset.Purchased_Date__c);
                Decimal assetAgeInYears = (assetAgeInDays / 365.0)*-1;

                // Calculate depreciated value
                Decimal depreciatedValue = newAsset.Purchased_Amount__c * (1 - depreciationPercentage * assetAgeInYears);
                 
                // Subtract the depreciated value from the purchased amount
                newAsset.Depreciation_Value__c = newAsset.Purchased_Amount__c - depreciatedValue;
                
                // Rounding of the value to the nearest whole number
                newAsset.Depreciation_Value__c = newAsset.Depreciation_Value__c.setScale(0, RoundingMode.HALF_UP);
            }
        }
    }
}


}