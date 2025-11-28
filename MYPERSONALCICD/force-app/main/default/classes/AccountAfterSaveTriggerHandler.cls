public class AccountAfterSaveTriggerHandler {
	public static void ContactCreation(List<Account> lisAcc){
        if(!lisAcc.isEmpty()){
            // Step 0 : Create Empty Contact type list
			List<Contact> lisCon = new List<Contact>();
			
		
			// Step 1 : For Each Account
			for(Account acc : lisAcc){

				// Step 0.1 : Check Each Account's Industry = Bankig
				if(acc.Industry=='Banking'){
					// Step 2 : Create Contact Instance
					Contact con = new Contact();
					con.LastName = acc.Name;
					con.Phone = acc.Phone;
					con.AccountId = acc.Id;

					// Step 3 : Add to Contact list
					lisCon.add(con);
				}
			}
		

		//Step 4 : if Contact lis is not empty then insert into data base
		if(!lisCon.isEmpty()){
			insert lisCon;
		}
	}
        }
			
}