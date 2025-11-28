/* @Nilisha Patil - 11-9-24
Scenario 3 : Whenever New Account Record is created then needs to create associated Contact Record automatically
*/
public class AccountAfterUpdateTriggerHandler {
    public static void AccConCreated(List<Account> lisAcc){
        if(!lisAcc.isEmpty()){
            Set<Id> setAccId = new Set<Id>();
            for(Account acc : lisAcc){
                setAccId.add(acc.Id);
            }
            List<Contact> lisCon = new List<Contact>();
            /*for(Account acc : lisAcc){
                if(setAccId.contains(acc.Id)){
                    Contact con = new Contact();
                    con.AccountId = setAccId.contains(acc.Id);
                }
            }*/
            for(Id accId : setAccId){
                Contact con = new Contact();
                con.AccountId = accId;
                lisCon.add(con);
            }
            
            
        }
    }
}