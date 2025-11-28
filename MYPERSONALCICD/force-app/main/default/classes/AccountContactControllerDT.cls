public with sharing class AccountContactControllerDT {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountContacts() {
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, Name, Phone, Email FROM Contacts) FROM Account LIMIT 20];
        System.debug(accounts);
        return accounts;
    }
}