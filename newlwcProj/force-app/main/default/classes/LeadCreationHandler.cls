public  class LeadCreationHandler{
    public static void checkLeadSourceOnInsert(List<Lead> lisLead){
        try {
            if(!lisLead.isEmpty()){
                for(Lead newLead : lisLead){
                    if(newLead.LeadSource=='Web'){
                        newLead.Rating = 'Cold';
                    }
                    else{
                        newLead.Rating = 'Hot';
                            }
                }
            }
        }
        Catch(Exception e){
            System.debug(e.getMessage());
        }
    }
}