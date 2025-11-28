/* @Nilisha Patil - 11-9-24
Scenario 3 : Whenever New Account Record is created then needs to create associated Contact Record automatically
*/
trigger AccountAfterUpdateTrigger on Account (after insert, after Update) {
    AccountAfterUpdateTriggerHandler.AccConCreated(Trigger.New);
}