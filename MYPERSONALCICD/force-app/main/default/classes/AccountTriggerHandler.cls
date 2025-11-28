public class AccountTriggerHandler {
    public static void AccountCreationContact(List<Account> lisAccount) {
        // Ensure the Account list is not empty
        if (!lisAccount.isEmpty()) {
            List<Contact> lisCon = new List<Contact>();
            
            // Create Contact records
            for (Account acc : lisAccount) {
                Contact con = new Contact();
                con.LastName = 'Nilisha Test';
                con.AccountId = acc.Id;
                lisCon.add(con);
            }
            
            // Insert Contact records if any
            if (!lisCon.isEmpty()) {
                insert lisCon;
            }
        }
    }
}