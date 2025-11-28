trigger FutureApexP1Trigger on User (before insert, after Insert) {
	FutureApexP1TriggerDispatcher.handleAfterInsert(Trigger.operationType);
}