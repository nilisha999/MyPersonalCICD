public with sharing class ExampleController {
    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccounts() {
        return [SELECT Id, Name, Industry, (SELECT Id, LastName FROM Contacts) FROM Account LIMIT 50];
    }
}