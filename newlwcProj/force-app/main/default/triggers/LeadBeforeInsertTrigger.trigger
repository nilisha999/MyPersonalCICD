//@Np  :14-12-24
/*
Scenario 2 : When ever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
*/
trigger LeadBeforeInsertTrigger on Lead (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            LeadTriggerHandler.LeadSourceUpdate(Trigger.New);
        }
    }
}