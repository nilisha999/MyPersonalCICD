// Opportunity trigger's dispatcher class
public class OpportunityTrigger {
    public static void handleEvents(System.TriggerOperation operationType){
        Switch on operationType{
            WHEN BEFORE_UPDATE{
                OpportunityTriggerHandler.handleBeforeUpdate(Trigger.New);
            }
        }
        
    }
}