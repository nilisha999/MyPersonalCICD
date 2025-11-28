public class Day36_SanjayGupta_Set {
    public static void createAccWithUsingSet(){
        // Case 1) Create set of Account Ids and Display ids using system.debug();
        Set<Id> setAcc1 = new Set<Id>();
        List<Account> acc1 = new List<Account>();
        acc1 = [Select Id, Name From Account Limit 5];
        for(Account acc202 : acc1){
            setAcc1.add(acc202.Id);
        }
        System.debug('Account 1 id : '+ setAcc1);
    }
}