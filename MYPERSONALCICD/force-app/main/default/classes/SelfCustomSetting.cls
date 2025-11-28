// @Np : 5-4-25 : Self Practicing Custom Settings
public class SelfCustomSetting {
    public static void CSPublicGroup(){
        // Step 1 : Create an Empty List of Type Custom Settings
        List<PG__c> lisCS = [Select Id, Name From PG__c];
        
        System.debug('Public Group : '+lisCS);
    }
}