trigger LeadCreationDuplicateLeads on Lead (before insert) {
	if(Trigger.isBefore && Trigger.isInsert){
		LeadCreationDuplicateLeadsHandler.DuplicateEmails(Trigger.New);
		
	}
}