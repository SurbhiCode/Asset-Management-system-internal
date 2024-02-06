public class DepreciationCalculationBatch implements Database.Batchable<SObject>, Schedulable {

    public Database.QueryLocator start(Database.BatchableContext context) {
        // Querying the assets for depreciation calculation
        String query = 'SELECT Id, Purchased_Amount__c, Purchased_Date__c, Equipments__c FROM Asset__c WHERE Purchased_Amount__c != null AND Purchased_Date__c != null';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext context, List<Asset__c> assets) {
        
        // Map to store depreciation percentage and residual value
        Map<String, Decimal> depreciationPercentageMap = new Map<String, Decimal>();
        Map<String, Decimal> residualValueMap = new Map<String, Decimal>();
        
		// Fetch Depreciation Percentage and Residual Value from Custom Metadata
        List<Depreciation_Value__mdt> metadataList = [SELECT MasterLabel, Depreciation_Percentage__c, Residual_Value__c FROM Depreciation_Value__mdt];

        for (Depreciation_Value__mdt metadata : metadataList) {
            depreciationPercentageMap.put(metadata.MasterLabel, metadata.Depreciation_Percentage__c / 100.0);
            residualValueMap.put(metadata.MasterLabel, metadata.Residual_Value__c / 100.0);
        }

        // Call the depreciation calculation method
        calculateDepreciation(assets, depreciationPercentageMap, residualValueMap);

        // Update the assets with the calculated depreciation values
        update assets;
    }

    public void finish(Database.BatchableContext context) {
        // Perform any post-processing logic if needed
    }

    public void execute(SchedulableContext sc) {
        // Schedule the batch to run on the last day of every month
        //String cronExpression = '0 0 23 L * ?'; // It will execute at 11:00 PM on the last day of every month
        //System.schedule('DepreciationCalculationBatch', cronExpression, this);
        DepreciationCalculationBatch batch = new DepreciationCalculationBatch();
		Database.executeBatch(batch);
    }

    private void calculateDepreciation(List<Asset__c> assets, Map<String, Decimal> depreciationPercentageMap, Map<String, Decimal> residualValueMap) {
        for (Asset__c asset : assets) {
            // Check if the asset's equipment type exists in the metadata maps
            if (asset.Equipments__c != null && depreciationPercentageMap.containsKey(asset.Equipments__c) && residualValueMap.containsKey(asset.Equipments__c)) {
                Decimal depreciationPercentage = depreciationPercentageMap.get(asset.Equipments__c);
                Decimal residualValue = residualValueMap.get(asset.Equipments__c);

                // Calculate the age of the asset in years
                   Integer assetAgeInDays = asset.Purchased_Date__c.daysBetween( Date.today());
                   Decimal assetAgeInYears = (assetAgeInDays / 365.0);
				 
                // Calculate depreciated value
                Decimal depreciatedValue = asset.Purchased_Amount__c * (1 - depreciationPercentage * assetAgeInYears);
				
                // Ensure Depreciation Value does not go below the residual value
                if (depreciatedValue < residualValue * asset.Purchased_Amount__c) {
                    depreciatedValue = residualValue * asset.Purchased_Amount__c;
                }

                // Update the asset with the calculated depreciation value
                asset.Depreciation_Value__c = asset.Purchased_Amount__c - depreciatedValue;
 
                
                // Rounding of the value to the nearest whole number
                asset.Depreciation_Value__c = asset.Depreciation_Value__c.setScale(0, RoundingMode.HALF_UP);
            }
        }
    }
}