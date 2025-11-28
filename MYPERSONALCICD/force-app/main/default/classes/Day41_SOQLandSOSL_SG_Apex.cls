public class Day41_SOQLandSOSL_SG_Apex {
	// case 1) Query Accounts created This Week with related contacts. (Parent —→ Child SOQL)
    /*public static void queryAccCon101(){
        List<Account> lisAcc101 = [Select Id, Name, (Select Id, Name, AccountId From Contacts) From Account Where CreatedDate = THIS_WEEK];
        for(Account acc101 : lisAcc101){
            System.debug('Account Name:'+acc101.Name+' , Associated Contact Name: '+acc101.Contacts);
        }
    }*/
    // Case 2) Query Contacts created This Week with related Account Name and Phone. (Child —→ Parent SOQL)
    /*public static void queryChildParent(){
        List<Contact> lisConAcc = [Select Id, Name, Contact.Account.Name, phone, Contact.Account.Phone From Contact Where CreatedDate = THIS_WEEK];
        for(Contact con1: lisConAcc){
            System.debug('Contact Name : '+con1.Name+' , Contact Account Name- '+con1.Account);
        }
    }*/
    // Case 3) Query Account (Id, Name, Phone) with related Opportunities (Name, CloseDate, Stage) where Account Phone ≠ Null. 
    // Sort the records in both ASC or DSC Order based on CreatedDate. (Parent to Child SOQL)
    /*public static void queryAccOpp(){
        List<Account> lisAccOpp = [Select Id, Name, Phone, CreatedDate, (Select Id, Name, CloseDate, StageName From Opportunities) From Account Where Phone!=Null ORDER BY CreatedDate ASC LIMIT 6];
    	List<Account> lisAccOpp1 = [Select Id, Name, Phone, CreatedDate, (Select Id, Name, CloseDate, StageName From Opportunities) From Account Where Phone!=Null ORDER BY CreatedDate DESC LIMIT 8];
        for(Account accOpp : lisAccOpp){
            System.debug('ASC Account Name - '+accOpp.Name+' , Related Opportunity name - '+accOpp.Opportunities);
        }
        for(Account accOpp1 : lisAccOpp1){
            System.debug('DESC Account Name - '+accOpp1.Name+' , Related Opportunity name - '+accOpp1.Opportunities);
        }
    }*/
}