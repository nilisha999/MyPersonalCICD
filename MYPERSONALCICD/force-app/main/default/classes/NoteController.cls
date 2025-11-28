public with sharing class NoteController {
    // Method to fetch Notes
    @AuraEnabled
    public static List<My_Note__c> getNotes(){
        // check if the user has read permission on My_Note__c Object
        if(!Schema.SObjectType.My_Note__c.isAccessible()){
            throw new AuraHandledException('You do not have permission on My note');
        }
        else{
            return [SELECT Id, Name, Note_Description__c FROM My_Note__c];
        }
        
    }

    // Method to create Notes

    @AuraEnabled
    public static Boolean createNoteRecord(String title, String description) {
        System.debug('createNoteRecord called with title: ' + title + ', description: ' + description);
        try {
            if(String.isBlank(title)) {
                // Check if the user has create permissions
                if(!Schema.sObjectType.My_Note__c.isCreateable()) {
                    throw new AuraHandledException('You do not have create permissions');
                }
                My_Note__c noteRec = new My_Note__c(
                    Name = title,
                    Note_Description__c = description
                );
                insert noteRec;
                System.debug('Note record created: ' + noteRec);
                return true;
            } else {
                System.debug('Title is blank.');
                return false;
            }
        } catch(Exception e) {
            System.debug('Error in createNoteRecord: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}