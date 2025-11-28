trigger CaseTrigger on Case (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CaseTriggerHandlerNew.CaseRelatedTask(Trigger.New);
        }else if(Trigger.isUpdate){
            CaseTriggerHandlerNew.CaseRelatedTask(Trigger.New);
        }
    }
}