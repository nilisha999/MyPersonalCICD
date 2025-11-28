/* @Nilisha Patil - 11-9-24
Scenario 2 :  Whenever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
*/

public class LeadTriggerHandler {
    public static void LeadSourceUpdate(List<Lead> lisLead){
        if(!lisLead.isEmpty()){
            for(Lead lea : lisLead){
                if(lea.LeadSource=='Web'){
                    lea.Rating = 'Cold';
                }else{
                    lea.Rating = 'Hot';
                }
            }
        }
    }
}