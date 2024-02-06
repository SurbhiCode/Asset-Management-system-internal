public with sharing class MyController {
    // @AuraEnabled(cacheable=true)
    // public static List<Asset__c> getOptions() {
    //     return [SELECT Id, Name FROM Asset__c];
    // }
//     @AuraEnabled(cacheable=true)
//     public static List<Asset__c> getAssets(String searchTerm) {
//         String query = 'SELECT Id, Name FROM Asset__c';
//         if (!String.isBlank(searchTerm)) {
//             query += ' WHERE Name LIKE \'%' + String.escapeSingleQuotes(searchTerm) + '%\'';
//         }
//         return Database.query(query);
//     }
// }

    @AuraEnabled(cacheable=true)
    public static Employee__c searchEmployees(String searchTerm) {
        // Perform your query to find the employee based on the searchTerm
        String query = 'SELECT Id, Name FROM Employee__c WHERE Name LIKE \'%' + String.escapeSingleQuotes(searchTerm) + '%\' LIMIT 1';
        List<Employee__c> employees = Database.query(query);

        if (!employees.isEmpty()) {
            return employees[0];
        }

        return null;
    }
}