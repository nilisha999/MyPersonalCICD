public class OpportunityTriggerHandler {
    public static void afterUpdate(Map<Id, Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities){
        Set<Id> opportunitiesToRecalculate = new Set<Id>();
        
        for(Id oppId : newOpportunities.keySet()){
            Opportunity newOpp = newOpportunities.get(oppId);
            Opportunity oldOpp = oldOpportunities.get(oppId);
            
            if(newOpp.StageName != oldOpp.StageName && newOpp.StageName == 'Closed Won'){
                opportunitiesToRecalculate.add(oppId);
            }
        }
        
        if(!opportunitiesToRecalculate.isEmpty()){
            for(Id oppId : opportunitiesToRecalculate){
                Decimal finalAmount = OpportunityDiscountCalculator.calculateTotalDiscountAmount(oppId);
                System.debug('Opportunity '+oppId + ' calculated final Amount : '+finalAmount);
            }
        }
    }
    
    // Before Update
    public static void handleBeforeUpdate(List<Opportunity> opportunityList){
        
            if(!opportunityList.isEmpty()){
                for(Opportunity opp : opportunityList){
                    if(opp.StageName=='Closed Won'){
                        opp.addError('handleBeforeUpdate - You cannot update this Opportuntiy');
                    }
                }
            }
            
        
    }
}