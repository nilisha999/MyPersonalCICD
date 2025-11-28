/* @nilisha Patil - 15-12-24
Scenario 4 : When ever the Account is created with Industry as Banking then 
create a contact for account, Contact Lastname as Account name 
and contact phone as account phone
*/
trigger AccountAfterSaveTrigger on Account (after insert) {
	if(trigger.iSAfter){
		if(Trigger.isInsert){
			AccountAfterSaveTriggerHandler.ContactCreation(Trigger.New);
		}
	}
}