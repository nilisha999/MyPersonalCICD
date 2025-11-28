//@Np : 14-12-2024
// Scenario 1 : When ever a case is created with origin as email then set status as new and Priority as Medium
trigger CaseTrigger_14120224 on Case (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CaseTriggerHandler_14120224.caseOrigin(Trigger.new);
        }
    }
}