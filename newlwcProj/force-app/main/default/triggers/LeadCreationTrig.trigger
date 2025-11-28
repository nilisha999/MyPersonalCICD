// @Np : 25-3-25
// Scenario : Whenever Lead is created with LeadSource as Web then give rating as cold otherwise hot
// Trigger Context : Before Insert
// Because as soon as lead is created with leadsource, i need to update lead on creation
trigger LeadCreationTrig on Lead (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        LeadCreationTrigHandler.setLeadRating(Trigger.New);
    }
}