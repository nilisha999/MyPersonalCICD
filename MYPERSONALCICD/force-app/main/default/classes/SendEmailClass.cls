public with sharing class SendEmailClass {
	@AuraEnabled
    public static string processEmail(String email, String Subject, String Message){
        String sMessage='';
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {email}; 
                mail.setToAddresses(toAddresses);
            mail.setSubject(Subject);
            mail.setHtmlBody(Message);
            Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            sMessage='Success';
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
        }
        return sMessage;
    }
    public static List<Lead> getDetails(){
    return [ SELECT Id, Email FROM Lead];

  }
}