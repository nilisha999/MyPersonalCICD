// Case a : Create an Account Record
public class Day34_SanjayGupta_CreateAcc {
    public static ID createAccount(){
        Account acc1 = new Account();
        acc1.Name = 'Day 34 Account Nilisha 22:30 PM 1';
        acc1.Rating = 'Warm';
        acc1.Type = 'Channel Partner / Reseller';
        insert acc1;
        return acc1.Id;
    }
    /*public static void insertData(String name, String rating, String active){
        Account acc101 = new Account();
        acc101.Name = name;
        acc101.Rating = rating;
        acc101.Active__c = active;
        insert acc101;
    }*/
    // Case b : b) Create an Account with Related Contact by calling method created in step a;
    public static ID  createAccWithCon(){
        ID ConAccId101= createAccount();
        Contact con= new Contact();
        con.AccountId = ConAccId101;
        con.LastName='Contact1 22:30 PM 1';
        insert con;
        System.debug('Contacts Related Acc : '+con.AccountId);
        return con.AccountId;
    }
    // Case c: c) Create an Account with Related Contact and Opportunity.
    public static ID createAccRelatedConOpp(){
        Opportunity opp101 = new Opportunity();
        ID oppAccid = createAccWithCon();
        opp101.Name = 'Opportunity 22:30 PM 1';
        opp101.AccountId= oppAccid;
        opp101.StageName = 'Closed Lost';
        opp101.CloseDate = System.Today();
        insert opp101;
        return opp101.AccountId;
    }
    // Case d : d) Create an Account with Related Contact, Opportunity and Case
    public static void createAccWithConOppCase(){
        Case cas101 = new Case();
        cas101.AccountId = createAccRelatedConOpp();
        cas101.Status = 'Working';
        cas101.Origin = 'Phone';
        cas101.AM_Asset__c = 'a052w00000GZUC6AAP';
        insert cas101;
    }
}