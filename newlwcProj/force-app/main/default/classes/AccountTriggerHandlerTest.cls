@isTest
public class AccountTriggerHandlerTest {
    // Positive Test Case
    @isTest
    static void AccountHandleAfterInsert_ContactCreate() {
        // Step 0: Create List of Accounts
        List<Account> lisAcc = new List<Account>();
        
        // Step 1: Create Test Account records
        for (Integer i = 0; i < 10; i++) {
            Account acc = new Account();
            acc.Name = 'Nilisha Patil test Acc ' + i;
            lisAcc.add(acc);
        }
        
        // Step 3: Insert Account's List
        insert lisAcc;
        
        // Step 4: Retrieve the Inserted Contacts records
        List<Contact> con101 = [SELECT AccountId FROM Contact WHERE AccountId IN :lisAcc];
        
        // Step 5: Verify the inserted contacts are correctly set
        System.assertEquals(10, con101.size(), 'Expected 10 contacts to be created.');
    }
    
    // Negative Test Case
    @isTest
    static void testHandleAfterInsert_WithoutContact() {
        // Step 0: Create a List of Type Account
        List<Account> lisAccNeg = new List<Account>();
        
        // Step 1: Create Test Account
        for (Integer i = 0; i < 10; i++) {
            Account acc202 = new Account();
            // No Assignment for acc202.Name
            lisAccNeg.add(acc202);
        }
        
        // Step 2: Insert the Account List
        try {
            insert lisAccNeg;
        } catch (Exception e) {
            // Expected behavior: Exception should be thrown due to missing required fields
        }
        
        // Step 3: Retrieve the inserted Contacts Records
        List<Contact> lisCon = [SELECT AccountId FROM Contact WHERE AccountId IN :lisAccNeg];
        
        // Step 4: Verify the inserted contacts are correctly mapped
        System.assertEquals(0, lisCon.size(), 'No contacts should be created due to invalid Account data.');
    }
}