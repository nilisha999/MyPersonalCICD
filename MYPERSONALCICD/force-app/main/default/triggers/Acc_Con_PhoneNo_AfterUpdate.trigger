// 17-6-24
// Case 3 : Suppose you are a sales manager for a company that sells products to other businesses. Your team uses Salesforce to manage customer accounts and contacts, 
// and you want to ensure that all contacts associated with a particular account 
// have the same phone number as the account.
trigger Acc_Con_PhoneNo_AfterUpdate on Account ( After Update) {
     if(Trigger.isUpdate){
        if(trigger.isAfter){
            Acc_Con_PhoneNo_AfterUpdate_Handler.AccConPhoneSync(Trigger.New, Trigger.oldMap);
        }
    }
    
}