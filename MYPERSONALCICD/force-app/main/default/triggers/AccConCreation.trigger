// @Np : 25-3-25
// Scenario : Whenever New Account Record is created then needs to create associated Contact record automatically
// Trigger Context : After Insert
// Because we donot have account id in Before Trigger context to associated to the associated contact
trigger AccConCreation on Account (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        AccConCreationHandler.AccountCreation(Trigger.New);
    }
}