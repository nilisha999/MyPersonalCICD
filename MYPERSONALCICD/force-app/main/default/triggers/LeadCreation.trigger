trigger LeadCreation on Lead(before insert){
    if(Trigger.isBefore && Trigger.isInsert){
        for(Lead newLead : Trigger.New){
            LeadCreationHandler.checkLeadSourceOnInsert(Trigger.New);
        }
    }
}