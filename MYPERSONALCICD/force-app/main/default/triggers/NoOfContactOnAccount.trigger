// @Np : 29-3-25 :
// WrapDrive : Trigger Scenario : If a contact record is inserted or deleted, mention the number of contacts in respective account. 
// Create a custom field on account object named as 'Contact_size__c' and update the details of size of contacts in this custom field.
// Trigger Context : After Insert, After Delete On Contact
trigger NoOfContactOnAccount on Contact (after insert, after Delete) {
    If(Trigger.isAfter){
        If(Trigger.isInsert){
            NoOfContactOnAccountHandler.insertContact(Trigger.New); // ON Contact Creation
        }
        else if(Trigger.isDelete){
            NoOfContactOnAccountHandler.insertContact(Trigger.old); // ON Contact Creation
        }
    }
}