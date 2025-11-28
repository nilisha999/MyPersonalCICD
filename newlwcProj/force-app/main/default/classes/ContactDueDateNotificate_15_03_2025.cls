public class ContactDueDateNotificate_15_03_2025 implements Database.Batchable<sObject>{
    // Step 1 : Query the required Records from Database
    public Database.QueryLocator start(Database.BatchableContext BC){
        Date today = Date.today(); // Assigned today's date in the today variable
        
        // Calcuate the [today's date + 3 days ] and store in the threeDaysLater
        Date threeDaysLater = today.addDays(3);
        
        // Query the records from Database
        String query = 'Select Id, LastName, dueDate__c, OwnerId   From Contact Where dueDate__c >= :today AND dueDate__c <= :threeDaysLater';
        return Database.getQueryLocator(query);
    }
    
    // Step 2 : Process the queried records
    public void execute (Database.BatchableContext BC, List<Contact> scope){
        // Step 2.0.1 : Create Set of type Id to store the ownerId's
        Set<Id> ownerIds = new Set<Id>();
        
        // Step 2.0.2 : Iterate overe each contact and store its ownerId in the Set
        for(Contact conOwnerId : scope){
            ownerIds.add(conOwnerId.OwnerId);
        }
        
        // Step 2.0.3 : Create a map to get each contact's owner's email who's id store in set
        Map<Id, User> ownerMap = new Map<Id, User>([Select Id, Email From User Where Id =:ownerIds]);
        
        
        // Step 2.1 : Create a List of type Messaging type
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
        
        // Step 2.2 : For Each Contact, iterate over each contact records
        for(Contact con : scope){
            User owner = ownerMap.get(con.OwnerId);
            if(owner!=null){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {owner.Email});
                mail.setSubject('Contact Due Date Notifications');
                mail.setPlainTextBody('The Contact '+con.LastName + ' Has a due date of '+ contact.dueDate__c);
                emailsToSend.add(mail);
            }
        }
        
        Messaging.sendEmail(emailsToSend);    
    }
    
    public void finish(Database.BatchableContext BC){
        
    }
}