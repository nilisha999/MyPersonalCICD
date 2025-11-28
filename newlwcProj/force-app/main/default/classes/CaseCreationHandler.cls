public class CaseCreationHandler{
    public static void CheckCaseOrigin(List<Case> lisCase){
        for(Case newCase : lisCase){
            if(newCase.Origin=='Email'){
                newCase.Status = 'New';
                newCase.Priority = 'Medium';
            }
        }
    }
}