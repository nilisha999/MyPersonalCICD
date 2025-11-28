public class AccountPreventTriggerDispatcherHandler {
    public static boolean recursiveFlag = false;
    public static void handleBeforeInsert(List<Account> accountList){
        recursiveFlag = True;
        if(recursiveFlag = True){
            AccountPreventTriggerHelper.preventDuplicateAccount(accountList);
        }
        recursiveFlag = false;
        
    }
     // When No of Locations field Updated on Account, Then Create LOcation Record related to Account
    public static void handleAfterInsert(List<Account> accountLocationList){
        AccountPreventTriggerHelper.handleCreateLocationRecord(accountLocationList);
    }
    
    // When No of Locations field Updated on Account UPDATED, Then Create LOcation Record related to Account
    public static void handleAfterUpdate(List<Account> accountNew, Map<Id, Account> accountOldMap){
        AccountPreventTriggerHelper.handleUpdateLocation(accountNew, accountOldMap);
        
    }
    
    // prevent account from deletion if account having contact more than 2 contacts
    public static void handleAfterDelete(List<Account> accountDelList){
        AccountPreventTriggerHelper.handleBeforeDeleteAccount(accountDelList);
    }
}