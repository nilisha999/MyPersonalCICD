/*
@Np : 19-7-25 : Case : The business got to know that there are multiple accounts with same name and rating. 
Now as a developer, 
you need to make sure that no new duplicates are being created with same name and rating.
*/
trigger AccountPreventTrigger on Account (before insert, after insert, after Update, before delete) {
	AccountPreventTriggerDispatcher.handleEvents(Trigger.operationType);
}