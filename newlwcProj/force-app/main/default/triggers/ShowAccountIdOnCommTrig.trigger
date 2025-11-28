// @Np :  dATE : 18-3-25 [Trigger Class]
// Scenario 1 : when Account is created show’s Account Id in Account’s Comment field
// ==========================================================================================================================
// @Np : 18-3-24 [Trigger Class]
// Scenario 2 : When an account is created , also create an contact corresponding to it. Then populate Contact’s Description field value to the associated account’s Description field. 
// And As many Contact’s Created to that Account, Merge each contact’s Description to the account’s description field 
trigger ShowAccountIdOnCommTrig on Account (after insert) {
    /*if(Trigger.isInsert){
        // Approach 1 : Before Insert
        // In Before Insert, as account record is just creating, not commiteed into database so we will donot any accountId. Once the account is created then we will have accountid
        ShowAccountIdOnComm.ShowAccountId(Trigger.new); // Here trigger.new holds the new Account Record, which is pass as the arguments to the list
    }*/
    
    // Approach 2 : After Insert
    // To Use the AccountId we have to use AFter Insert which will hold account Id Value
    if(Trigger.isAfter && Trigger.isInsert){
       // ShowAccountIdOnComm.ShowAccIdOnDescription(Trigger.new); // Here trigger.new holds the new Account Record, which is pass as the arguments to the list
       // ShowAccountIdOnComm.handleAccountInsert(Trigger.new); // when Account creates , it creates Contacts
    }
    
    
}