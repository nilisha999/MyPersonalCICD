// Date : 25-3-25
// Scenario : Whenever a case is created with origin as email then set status as new and priority as Medium.
// Trigger Context : Before Insert

public class CaseCreationTrigHandler {
    public static void setStatusCase(List<Case> lisCase){
		// Create a List to Insert Case
		//List<Case> insertCase = new List<Case>();
        try{
            if(!lisCase.isEmpty()){
                for(Case cs : lisCase){
                    if(cs.Origin=='Email'){
                        cs.Status = 'New';
                        cs.Priority = 'Medium';
                        //insertCase.add(cs);
                    }
                }
            }
            
            /*
			if(!insertCase.isEmpty()){
                Insert insertCase;
            }*/
        }
        catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
}