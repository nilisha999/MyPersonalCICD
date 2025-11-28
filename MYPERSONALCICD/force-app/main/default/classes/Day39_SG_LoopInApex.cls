public class Day39_SG_LoopInApex {
	//case a) Print Table of a Number
    /*public static void dispalyTable(Integer tableNo){
        Integer temp = 0;
        while(temp<tableNo*10){
            Integer result = tableNo + temp;
            System.debug('Table of '+tableNo+' : '+result);
        	temp = temp + tableNo;
        }
    }*/
    // case b) Print Even or Odd Number up to N.
   /* public static void printEvenOddNo(Integer evodd){
    	List<Integer> listEvenNo = new List<Integer>();
        List<Integer> listOddNo = new List<Integer>();
        Integer a1 = 0;
        while(a1<=evodd){
            if(math.mod(a1,2)==0){
                listEvenNo.add(a1);
                a1++;
            }
        	if(math.mod(a1,2)!=0){
                listOddNo.add(a1);
                a1++;
            }
        }
        System.debug('Even Numbers upto : '+evodd+' is- '+listEvenNo);
        System.debug('Odd Numbers upto : '+evodd+' is- '+listOddNo);
    }*/
    // case c) Print sum of natural numbers
    /*public static void sumOfNaturalNo(Integer varNaturalNo1){
        List<Integer> listSumOfNatural = new List<Integer>();
        Integer temp=1;
        Integer sum= 0;
        while(temp<=varNaturalNo1){
            sum = sum + temp;
            
            listSumOfNatural.add(sum);
            temp++;
        }
        System.debug('Sum of Natural number is : '+listSumOfNatural);
    }*/
    // case d) Iterate on Account List and Display account Information
   /* public static void displayAccountInfo(){
        List<Account> listAcc101 = [Select Id, Name, Phone, Active__c From Account LIMIT 10];
        for(Account acc202: listAcc101){
            System.debug('Account Name : '+acc202.Name+' ,Account Phone: '+acc202.Phone+' , Account Active = '+acc202.Active__c);
        }
    }*/
    // Case e) Iterate on Account List and create a set of account ids.
    public static void displaySetOfAccId(){
        List<Account> listAcc303 = [Select Id, Name From Account];
        Set<Id> setAccId = new Set<Id>();
        for(Account acc202 : listAcc303){
            setAccId.add(acc202.Id);
        }
        System.debug('Ids : '+setAccId);
    }
}