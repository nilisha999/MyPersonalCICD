public class CaseTriggerHandler_14120224 {
    public static void caseOrigin(List<Case>lisCase){
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