public class AccConCreationHandler {
    public static void AccountCreation(List<Account> lisAcc){
        try{
            List<Contact> lisCon = new List<Contact>();
            if(!lisAcc.isEmpty()){
                for(Account acc: lisAcc){
                    Contact con = new Contact();
                    con.AccountId = acc.Id;
                    con.LastName = acc.Name;
                    lisCon.add(con);
                }
            }
            
            if(!lisCon.isEmpty()){
                Insert lisCon;
            }
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
}