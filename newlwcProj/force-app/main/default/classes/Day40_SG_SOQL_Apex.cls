public class Day40_SG_SOQL_Apex {
    // case 1) query contact records where Email is not null.
    /*public static void queryCon(){
        List<Contact> listCon101 = new List<Contact>();
        listCon101 = [Select Id, Name, Email From Contact where Email!=NULL LIMIT 5];
        for(Contact con1 : listCon101){
            System.debug('Contact ID : '+con1.id+' ,Contact Name: '+con1.Name+' ,Contact Email : '+con1.Email);
        }
    }*/
    // case 2) Query Account records where Annual Revenue is ≥ 100,000 and <=150,000.
    /*public static void queryAccount(){
        List<Account> listAcc101 = [Select Id, Name, AnnualRevenue From Account Where AnnualRevenue >= 100000 AND AnnualRevenue <=150000 ];
        For(Account acc1 : listAcc101){
            System.debug('Account Name: '+acc1.Name+' , Account Annual Revenue: '+acc1.AnnualRevenue);
        }
    }*/
    // case 3) Query all Opportunities records and sort them based on Opportunity name.
    /*public static void sortOppName(){
        //A) Sort by Ascending Order - Opp name
       	List<Opportunity> listOppQ1 = [Select Id, Name, StageName From Opportunity Where Id!=Null ORDER BY Name ASC Limit 5];
        List<Opportunity> listOppQ2 = [Select Id, Name, StageName From Opportunity Where Id!=Null ORDER BY Name DESC Limit 7];
       
        For(Opportunity opp1 : listOppQ1){
            System.debug('ASC Opportunity Name : '+opp1.Name);
        }
        For(Opportunity opp2: listOppQ2){
            System.debug('DESC Opportunity Name : '+opp2.Name);
        }
    }*/
    // case 4) Query Cases where origin is web and status is New
    /*Public static void queryCases(){
        List<Case> lisCase = [Select Id, Origin, Subject, Status From Case Where Origin = 'Web' AND Status = 'New'];
        for(Case cas1 : lisCase){
            System.debug('Case Subject- '+cas1.Subject+' , Case Origin- '+cas1.Origin+' , Case Status - '+cas1.Status);
        }
    }*/
    // case 5) Count account records based on industry in the query editor.
    /*public static void queryAccIndustry(){
        List<Account> lisAccInd302 = new List<Account>();
        lisAccInd302 = [Select Count(Id), Industry From Account Group by Industry];
        for(Account acc1: lisAccInd302){
            System.debug('Account Industry : '+acc1.Industry);
        }
    }*/
}