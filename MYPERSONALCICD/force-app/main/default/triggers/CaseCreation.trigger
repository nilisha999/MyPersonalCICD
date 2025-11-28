trigger CaseCreation on Case(before insert){
    if(Trigger.isBefore){
        for(Case newCase : Trigger.New){
            CaseCreationHandler.CheckCaseOrigin(Trigger.New);
        }
    }
}