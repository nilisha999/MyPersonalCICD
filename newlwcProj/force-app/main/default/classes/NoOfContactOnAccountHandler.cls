// @Np : 29-3-25 :
// WrapDrive : Trigger Scenario : If a contact record is inserted or deleted, mention the number of contacts in respective account. 
// Create a custom field on account object named as 'Contact_size__c' and update the details of size of contacts in this custom field.
// Trigger Context : After Insert, After Delete On Contact
public class NoOfContactOnAccountHandler {
	// Insert Contact
    public static void insertContact(List<Contact> newContactInsert){
        ContactInsertDelete(newContactInsert);
    }
    
    // Delete Contact
    public static void deleteContact(List<Contact> oldContactdelete){
        ContactInsertDelete(oldContactdelete);
    }
	
    public static void ContactInsertDelete(List<Contact> lisConInsert){
        try{
            // Step 0 : Null Check
            if(lisConInsert.isEmpty()){
                return ;
            }
            
            // Step 1 : We will Store the Each Contact's Account Id IN THE SET
            Set<Id> accSetId = new Set<Id>();
            if(!lisConInsert.isEmpty()){
                for(Contact con : lisConInsert){
                    if(con.AccountId!=Null){
                        accSetId.add(con.AccountId); // Add the Contact's Account Id in the set
                    }
                }
            }
            
            // Step 0.1 : Get the Accounts with their Related Contacts
            List<Account> lisQueryAccCon = [Select Id, Name, Contact_Size__c ,(Select Id , LastName From Contacts) From Account Where ID IN: accSetId];
            
            //Step 0.1.2 : Create a List of Account Type to Update Account's Contact Size()
            List<Account> updateAccountContactSize = new List<Account>();
            
            // Step 2 : Update account with the Related Contact size
            // (Approach 1:  Using List)
            if(!lisQueryAccCon.isEmpty()){
                for (Account accQuery : lisQueryAccCon){
                    // Step 2.3 :  Need to Update Account , So We will need to create Instance of Account
                    Account acc = new Account(Id = accQuery.Id, Contact_Size__c = accQuery.Contacts.Size());
                    updateAccountContactSize.add(acc);
                }
            }
            
            // (Approach 2 : Using Map)
            Map<Id, Decimal> mapAccountUpdate = new Map<Id, Decimal>();
            if(!lisQueryAccCon.isEmpty()){
                for (Account accQuery : lisQueryAccCon){
                    mapAccountUpdate.put(accQuery.Id, accQuery.Contact_Size__c); // Add the id and Contact Size of Account into Map
                }
                // Update the List of type of Account
                for (Account accQueried : lisQueryAccCon){
                    if(mapAccountUpdate.containsKey(accQueried.Id)){
                        // Step 2.3 :  Need to Update Account , So We will need to create Instance of Account
                        Account acc = new Account(Id = accQueried.Id, Contact_Size__c = accQueried.Contacts.Size());
                        updateAccountContactSize.add(acc);
                    }
                }
            }
            
            // Step 3 : Update the Account list to the database
            if(!updateAccountContactSize.isEmpty()){
                update updateAccountContactSize;
            }
        }
        Catch(Exception e){
            System.debug('System Error Occured : '+e.getMessage());
        }
    }
}