public class FutureApexP1TriggerDispatcher {
    public static void handleAfterInsert(System.TriggerOperation operationType){
        Switch on operationType{
            WHEN AFTER_INSERT{
                FutureApexP1TriggerHandler.handleAssignPSToFutureApex(Trigger.New);
            }
        }
    }
}