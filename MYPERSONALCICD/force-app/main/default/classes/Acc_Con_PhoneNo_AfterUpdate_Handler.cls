// 17-6-24
// Case 3 : Suppose you are a sales manager for a company that sells products to other businesses. Your team uses Salesforce to manage customer accounts and contacts, 
// and you want to ensure that all contacts associated with a particular account 
// have the same phone number as the account.
public class Acc_Con_PhoneNo_AfterUpdate_Handler {
    public static void AccConPhoneSync(List<Account> lisAcc, Map<Id, Account> oldLisAcc){
        // Create a Map to store old account id and phone
        Map<Id, Account> accMap = new Map<Id, Account>();
        if(!lisAcc.isEmpty()){
            for(Account acc : lisAcc){
                //if(acc.Phone != oldLisAcc.get(acc.Phone).Phone)
                if(acc.Phone != oldLisAcc.get(acc.Id).Phone){
                    accMap.put(acc.Id, acc);
                }
            }
        }
        
        // Get all the related Contacts of these accounts
        List<Contact> queryCon = [Select Id, LastName, Phone, AccountId from Contact Where AccountId IN: accMap.keySet()];
        
        // Create a List for Contacts To Update Phone
        List<Contact> conPhone = new List<Contact>();
        
        if(!queryCon.isEmpty()){
            for(Contact con : queryCon){
                con.Phone = accMap.get(con.AccountId).Phone;
                conPhone.add(con);
            }
        }
        // Update the contacts with the new phone numbers
            if(!conPhone.isEmpty()){
                update conPhone;
            }
        
        
    }
}