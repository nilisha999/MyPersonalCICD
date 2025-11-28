@isTest
public class AccountAfterSaveTriggerHandlerTest{
	// Positive Test Case
	@isTest
	static void AccountHandleAfterSave_Contact(){
		
		// STEP 0 : Create a contact and Account list type
		List<Contact> lisCon = new List<Contact>();
		List<Account> lisAcc = new List<Account>();

		//Step 1 : Create Test Account
		for(Integer i=0; i<20;i++){
			Account acc = new Account();
			acc.Name = 'Nilisha AccCon'+ i;
			acc.Industry = 'Banking';
			acc.Phone = '1234567890';
			lisAcc.add(acc);
		}

		// Step 2 : Insert the Account list
		insert lisAcc;

		// Step 3 : Retrieve the Contact List
		lisCon = [SELECT LastName, Phone FROM Contact WHERE AccountId IN: lisAcc];

		// Step 4 : Verify the Inserted Contact set correctly
		System.assertEquals(20, lisCon.size(), '20 Contacts Created');
        for(Contact con : lisCon){
            System.assertEquals('1234567890', con.Phone);
        }
	}

	// Negative Test Case
	@isTest
	static void AccountHandleAfterSave_WithNoContact(){
		//STEP 0 : Create Account and Contact list type
		List<Account> lisAcc101 = new List<Account>();
		List<Contact> lisCon202 = new List<Contact>();

		// STEP 1 : Create Test Account
		for(Integer j=0;j<20;j++){
			Account accn = new Account();
			// No Assignment for Name, Industry, Phone
			lisAcc101.add(accn);
		}

		// STEP 2 : insert Account
        try{
            insert lisAcc101;
        }
        catch (Exception e){}
		

		// STEP 3 : Retrieve the inserted contact list
		lisCon202 = [SELECT LastName, Phone FROM Contact WHERE AccountId IN: lisAcc101];
		
		// STEP 4 : Verify the inserted Contacts set correctly
		System.assertEquals(0, lisCon202.size(), 'No Contacts Created');

	}
}