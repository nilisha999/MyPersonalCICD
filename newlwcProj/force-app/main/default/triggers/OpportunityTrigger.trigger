trigger OpportunityTrigger on Opportunity (after update, before update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
    }
    // Before Update
    OpportunityTrigger.handleEvents(Trigger.operationType);
}