public class ErrorMessageLog {
    public static void LogError(Exception e){
        try{
            // Create an Empty List of type Error_Log__c, to insert Error_Log__c
            List<Error_Log__c> errorList = new List<Error_Log__c>();
            
            // Error log processing
            Error_Log__c log = new Error_Log__c();
            log.Error_Message__c = e.getMessage();
            log.Stack_Trace__c = e.getStackTraceString();
            
            // Add log into errorlist list
            errorList.add(log);
            System.debug('ErrorMessageLog - Error Message : '+e.getMessage());
            System.debug('ErrorMessageLog - Stack Trace : '+e.getStackTraceString());
            
            // Insert errorlist to the database
            if(!errorList.isEmpty()){
                insert errorList;
            }
        }
        Catch(Exception ce){
            LogError(ce);
        }
    }
}