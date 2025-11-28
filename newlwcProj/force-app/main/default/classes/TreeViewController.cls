public with sharing class TreeViewController{
    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(Id accountId){
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId =: accountId];
    }
}