public class Day43_SG_ApexScenario {
    public static void demo1(){
        // Case 1) Query Account along with related contacts where account phone≠null . Now display result through system.debug() in following ways:
        //List<Account> listAcc101 = new List<Account>();
        /*listAcc101 = [Select id, Name, Phone, (Select Id, Name From Contacts) From Account Where Phone <> NULL];
        if(!listAcc101.isEmpty()){
            for(Account acc101 : listAcc101){
                System.debug('Account Name'+acc101.Name +'has #' +acc101.Contacts.size()+'related');
            }
        }*/
        // case 2) - Query Account along with related Opportunities where account phone ≠ NULL. Now display results through system.debug() in following ways :
   		// - Account Name has TotalAmountOnRelatedOpp worth Opportunities.
   		/*listAcc101 = [Select Id, Name, (Select Id, Name From Opportunities) From Account Where Phone != NULL];
        If(!listAcc101.isEmpty()){
            for(Account acc202 : listAcc101){
                System.debug('Account Name : '+acc202.Name+'has TotalAmountOnRelatedOpp : #'+acc202.Opportunities.size());
            }
        }*/
        //Case 3) Query Opportunities created This Year. If the Opportunity stage is closed Won then update description as ‘Opportunity is Closed Won’, 
        //in case of closed Lost update description as ‘Opportunity Closed Lost’, other ‘Opportunity is Open’.
        /*List<Opportunity> listOpp1 = new List<Opportunity>();
        listOpp1 = [Select Id, Name, StageName From Opportunity where CreatedDate = This_Year];
        If(!listOpp1.isEmpty()){
            For(Opportunity opp1101 : listOpp1){
                if(opp1101.StageName == 'Closed Won'){
                    opp1101.Description = 'Opportunity is Closed Won';
                }else if (opp1101.StageName == 'Closed Lost'){
                    opp1101.Description = 'Opportunity Closed Lost';
                }else{
                    opp1101.Description = 'Opportunity is Open';
                }
                System.debug('Opp Name :'+opp1101.Name+'Stage  Name :- '+opp1101.StageName + '  Description - '+ opp1101.Description);
            }
        }*/
        // Case 4)  Query Accounts created THIS YEAR. Populated ‘Total Contacts’ Field on Account by 
		//counting number of contacts associated with Account. If No Contact, then Populated 0.
		// Total Contacts ==> No of Locations
		/*// Step 1: Query Account where created date THIS Year with its Related Contacts
        List<Account> listAcc202 = [Select Id, Name, CreatedDate, NumberofLocations__c, (Select Id, Name From Contacts) From Account Where CreatedDate = THIS_YEAR];
        // Step 2: Update the No of Locations Field For Total Associated Contacts with Account
        If(!listAcc202.isEmpty()){
            for(Account acc303 : listAcc202){
                if(acc303.contacts.size()>0){
                    acc303.NumberofLocations__c = acc303.contacts.size();
                }
                else if(acc303.contacts.size()==0){
                    acc303.NumberofLocations__c = 0;
                }
                System.debug('Account Name : '+acc303.Name+' Createdate- '+acc303.CreatedDate+ ' Total Contants # '+acc303.NumberofLocations__c);
            }
        }*/
        // Case 5) Query contacts created LAST WEEK and if Mobile phone is not populated on contact, 
					//then copy Phone of Related Account. [Child - Paren SOQL].
		// Step 1 : Query Contacts Where CreatedDate is Last Week and Their Mobile Phone along with Contacts Account Phone Number
		List<Contact> listCon101 = [Select Id, Name, Phone, Contact.Account.Phone, CreatedDate From Contact Where CreatedDate = LAST_WEEK];
        if(!listCon101.isEmpty()){
            for(Contact con1 : listCon101){
                if(con1.Phone==Null){
                    con1.Phone = con1.Account.Phone;
                }
                
                System.debug('Contact Name : '+con1.Name+'  ,Contact Phone- '+con1.Phone+' Date- '+con1.CreatedDate);
            }
        }
    }
}