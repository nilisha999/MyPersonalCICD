// Date : 25-3-25
// Scenario : Whenever a case is created with origin as email then set status as new and priority as Medium.
// Trigger Context : Before Insert
trigger CaseCreationTrig on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        CaseCreationTrigHandler.setStatusCase(Trigger.New);
    }
}