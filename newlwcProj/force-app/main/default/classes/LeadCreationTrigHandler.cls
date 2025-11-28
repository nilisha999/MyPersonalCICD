// @Np : 25-3-25
// Scenario : Whenever Lead is created with LeadSource as Web then give rating as cold otherwise hot
// Trigger Context : Before Insert
// Because as soon as lead is created with leadsource, i need to update lead on creation

public class LeadCreationTrigHandler {
    public static void setLeadRating(List<Lead> lisLead){
        try{
            if(!lisLead.isEmpty()){
                for(Lead lea : lisLead){
                	lea.Rating = (lea.LeadSource!= Null && lea.LeadSource=='Web') ? 'Cold' : 'Hot';
                }
            }
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
}