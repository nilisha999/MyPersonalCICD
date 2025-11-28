public with sharing class AccountService {

    @AuraEnabled(cacheable=true)
    public static List<AccountWrapper> getAccountWithContacts() {
        List<AccountWrapper> accountWrapperList = new List<AccountWrapper>();

        // Get Accounts with related Contacts
        List<Account> accounts = [SELECT Id, Name, (SELECT Id, FirstName, LastName, Email FROM Contacts) FROM Account];

        // Debug the fetched Accounts and Contacts
        System.debug('Fetched Accounts: ' + accounts);
        for (Account acc : accounts) {
            System.debug('Account Id: ' + acc.Id + ', Name: ' + acc.Name);
            if (acc.Contacts != null && !acc.Contacts.isEmpty()) {
                for (Contact con : acc.Contacts) {
                    System.debug('Contact Id: ' + con.Id + ', FirstName: ' + con.FirstName + ', LastName: ' + con.LastName + ', Email: ' + con.Email);
                }
            } else {
                System.debug('No contacts found for Account Id: ' + acc.Id);
            }

            // Populate the wrapper class
            List<Contact> contacts = acc.Contacts;
            AccountWrapper accountWrapper = new AccountWrapper(acc, contacts);
            accountWrapperList.add(accountWrapper);
        }

        return accountWrapperList;
    }

    // Wrapper Class Definition
    public class AccountWrapper {
        public Account acc { get; set; }
        public List<Contact> contacts { get; set; }

        public AccountWrapper(Account acc, List<Contact> contacts) {
            this.acc = acc;
            this.contacts = contacts;
        }
    }
}