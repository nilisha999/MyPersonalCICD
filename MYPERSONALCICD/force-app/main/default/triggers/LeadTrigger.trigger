/* @Nilisha Patil - 11-9-24
Scenario 2 :  When ever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
*/
trigger LeadTrigger on Lead (before insert) {
    LeadTriggerHandler.LeadSourceUpdate(Trigger.New);
}