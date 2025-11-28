/* @Nilisha Patil - 11-9-24
Scenario 1 :  When ever a case is created with origin as email then set status as new and Priority as Medium
*/
public class CaseTriggerHandler {
    public static void caseStatusUpdate(List<Case> lisCase){
        if(!lisCase.isEmpty()){
            for(Case cas : lisCase){
                if(cas.Origin=='Email'){
                    cas.Status = 'New';
                    cas.Priority = 'Medium';
                }
            }
        }
    }
}