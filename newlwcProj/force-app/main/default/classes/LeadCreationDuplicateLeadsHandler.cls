public class LeadCreationDuplicateLeadsHandler {
    public static void DuplicateEmails(List<Lead> lisLeads){
        try{
            // Step 1 : Get the Records Which have same Emails
            List<Lead> newLead = new List<Lead>();
            //newLead = [Select Id, LastName, Email From Lead];
            //
            
            Set<String> emailSet = new Set<String>();
            for(Lead es : lisLeads){
                if(es.Email != Null){
                    emailSet.add(es.Email);
                }
            }
            newLead = [Select Email From Lead Where Email IN : emailSet];
            Map<String, Lead> mapLead = new Map<String, Lead>();
            
            // Step 2 : Operate on Each new lead to check this lead email exists
            if(!lisLeads.IsEmpty()){
                For(Lead lea : lisLeads){
                    For(Lead oldLea : newLead){
                        if(lea.Email == oldLea.Email){
                            lea.Email.addError('We Already exists lead with this email');
                        }
                    }
                    
                }
            }
        }
        Catch(Exception e){
            System.debug('System Error Occured : '+e.getMessage());
        }
        
    }			
}