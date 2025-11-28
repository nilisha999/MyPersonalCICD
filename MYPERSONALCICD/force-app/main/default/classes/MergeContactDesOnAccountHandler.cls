// Date : 20-3-25
// Scenario 2.2 : When an contact created on related to any existing account, then contact's Description should be concatenate 
// with the existing account's Description
// As we are working on creation of contact and account, so we will use after insert
public class MergeContactDesOnAccountHandler {
    public static void MergeContactDes(List<Contact> lisCon){
        try{
            // Step 0 : store the contact's account id
            Set<Id> conAccId = new Set<Id>();
            Set<Id> conSetIds = new Set<Id>();
            if(!lisCon.isEmpty()){
                for(Contact conId : lisCon){
                    // Check Current Contact record is associated with an account
                    if(conId.AccountId!=Null){
                        conAccId.add(conId.AccountId);	// Add the contact's AccountId into the Set
                    }
                }
            }
            
            // Step 1 : Get the Associated Account record of the contact who's Accountid store in the set
            // We are using Map Here, Because we want to access Associated Account's Description field value also
            Map<Id, Account> mapAccDesc = new Map<Id, Account>([Select Id, Name, Description From Account Where Id IN: conAccId]);        
            
            // Step 2 : Operate on each Contact
            List<Account> lisAccountToUpdate = new List<Account>(); // Final Account List to updates
            Map<Id, Account> accountUpdates = new Map<Id, Account>();
            
            for(Contact con : lisCon){
                Account accInst = new Account();
                accInst = mapAccDesc.get(con.AccountId);
                System.debug('Account Id : '+accInst);
                if(accInst != Null){
                    // Checking Duplicate Account Id
                    if(accountUpdates.containsKey(accInst.Id)){	// Account already in the Map, append Description
                        System.debug('Entered Into Already Account Id Exists block');
                        Account existingAcc = accountUpdates.get(accInst.Id);
                        System.debug('ExistingAcc AccountId : '+existingAcc.Id);
                        existingAcc.Description += ' ' + con.Description;	// Assigned Contact's Description to the Account's Description
                        System.debug('Existing Account Description is : '+existingAcc.Description);
                        lisAccountToUpdate.add(existingAcc);	// Added Account to list
                        System.debug('Old Account Record Added to List : '+lisAccountToUpdate);
                        
                    }
                    else{	// // Account not in the Map, add it
                        System.debug('Entered Into New Account Id Block');
                        System.debug('New AccountId : '+accInst.Id);
                    	accInst.Description += ' ' + con.Description;	// Assigned Contact's Description to the Account's Description
                        System.debug('New Account Description is : ' + accInst.Description);
                        accountUpdates.put(accInst.Id, accInst);
                        System.debug('New Account Updates : '+accountUpdates);
                        lisAccountToUpdate.add(accInst);	// Added Account to list
                        System.debug('New Account Record Added to List : '+lisAccountToUpdate);
                    }
                }
            }
            // Display lisAccountToUpdate
            System.debug('Final Account List To Update : '+lisAccountToUpdate);
            
            // Step 3 : Update the List Account for Description
            if(!lisAccountToUpdate.isEmpty()){
                update lisAccountToUpdate;
            }
        }
        catch (Exception e){
            // Handle DML exception
            System.debug('Error updating accounts : '+e.getMessage());
            
            // Calling Error log Method
            ErrorMessageLog.LogError(e);
        }
    }
}