// @Np :  dATE : 18-3-25 [Handler Class]
// Scenario 1 : when Account is created show’s Account Id in Account’s Comment field
public class ShowAccountIdOnComm {
    
    // After Insert
    public static void ShowAccIdOnDescription(List<Account> accId){
        
        
        try{
            // Step 0 : Create a List of type Account, which will use to update Description on Account
            List<Account> accDesc = new List<Account>();
            if(!accId.isEmpty()){
                
                // Step 3 : Now Iterate over each New accId list record
                for(Account acc : accId){
                    // Step 4 : this condition will return boolean true : if new account id is equal to the stored account id in the set, and if not False and exists the for loop
                    Account acc101 = new Account(Id = acc.Id, Description = acc.Id); // This will update the description field of account
                    accDesc.add(acc101);
                }
            }
            update accDesc; // If not, then it will commit update list to the database
        }
        catch(Exception e){
            System.debug('An error occurred during the DML update: ' + e.getMessage());
        	// Create an Error_Log__C recprd
        	Error_Log__c log = new Error_Log__c( Error_Message__c = e.getMessage(), Stack_Trace__c = e.getStackTraceString() );
            System.debug('Error Message : '+e.getMessage());
            System.debug('Stack Trace : '+e.getStackTraceString());
		}
    }
    
    // Scenario 2 : When an account is created , also create an contact corresponding to it. Then populate Contact’s Description field value to the associated account’s Description field. 
    // And As many Contact’s Created to that Account, Merge each contact’s Description to the account’s description field
    // After Insert
    public static void handleAccountInsert(List<Account> accList){
        try{
            // Step 0.2 : Craete a List of type contact to insert contacts into database
            List<Contact> conList = new List<Contact>();
            
            // Step 3 : Show Update Contact Description on Account
            // 	Create a List of type of ACCOUNT to update the account record
            List<Account> accListUpdate = new List<Account>();
            
            // Step 1 : Check Null condition for new account record list is not null
            if(!accList.isEmpty()){
                for(Account acc : accList){
                    // Step 2 : Create new Instance of type Contact
                    Contact con = new Contact();
                    con.LastName = acc.Name; // Assigned Account Name to the contact lastname
                    con.AccountId = acc.Id; // Assigned the AccountId to the contact AccountId
                    con.Description = acc.Name+' : , Contact created through Trigger /n';
                    conList.add(con); // add the con record to the list
                    Account acc101 = new Account(Id = acc.Id, Description = con.Description);
                    accListUpdate.add(acc101);
                } 
            }
            
            // Step 2 : Insert the contact list
            if(!conList.isEmpty()){
                insert conList;
            }
            
            // Step 3 : Update the account List
            if(!accListUpdate.isEmpty()){
                update accListUpdate;
            }
        }
        catch(Exception e){
            System.debug('An error occurred during the DML update: ' + e.getMessage());
        	ErrorMessageLog.LogError(e);
            System.debug('Error Message : '+e.getMessage());
            System.debug('Stack Trace : '+e.getStackTraceString());
        }
    }
}