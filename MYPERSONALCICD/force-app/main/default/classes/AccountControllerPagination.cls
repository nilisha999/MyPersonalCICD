public with sharing class AccountControllerPagination{
    @AuraEnabled
    public static List<Account> getAccounts(){
        List<Account> accountList = [
                                        SELECT Id, Name 
                                        From Account
                                        WITH SECURITY_ENFORCED
                                    ];
        return accountList;
    }
}