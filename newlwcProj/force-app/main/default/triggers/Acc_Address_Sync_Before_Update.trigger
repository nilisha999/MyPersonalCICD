// 17-6-24
// Case Scenario :  2.  Your Company wants to ensure that the shipping address of an Account record is always in sync with the billing address
trigger Acc_Address_Sync_Before_Update on Account (before insert, before update) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            Acc_Address_Sync_Before_Update_Handler.syncAccountAddress(Trigger.New);
        }
    }else if (Trigger.isUpdate){
        if(Trigger.isBefore){
            Acc_Address_Sync_Before_Update_Handler.syncAccountAddress(Trigger.New);
        }
    }
    
}