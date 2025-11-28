public class Day38_SG_Conditional_Apex {
   /* public static void demo38(Integer a, Integer b){
        //Case 1) Find out the maximum among two Numbers.
        Integer max;
        if(a>b){
            max = a;
            System.debug('Max is A: '+max);
        }
        else if(a<b){
            max = b;
            System.debug('Max is B: '+max);
        }
    }*/
   /* //Case 2: Check whether a person is eligible to vote or not.
    public static void voteAge(Integer VoterAge101){
        List<Account> listAc1;
        Account acc = new Account();
        if(VoterAge101>= 18){
            acc.Acc_Active__c = true;
            System.debug('Yes you are Age is : '+VoterAge101+ ' , Eligible For Voting.');
        } else if(VoterAge101<18){
            System.debug('Yes you are Age is : '+VoterAge101+ ' , NOT Eligible For Voting.');
        }
    }*/
    // Case 3) Check whether Number is even or odd.
    /*public static void checkNoEven(Integer a1101){
        if(math.mod(a1101, 2) ==0){
            System.debug('Entered Number is Even : '+a1101);
        }
        else  if(math.mod(a1101, 2) != 0){
            System.debug('Entered Number is Odd : '+a1101);
        }
    }*/
    /*// Case 4) Check whether a number is positive, negative or zero using the else-if ladder.
    public static void checkNumber(Integer a24){
        if(a24>0){
            System.debug('Eneterd Number is Positive : '+a24);
        }
        else if(a24<0){
            System.debug('Eneterd Number is Negative : '+a24);
        }
        else if(a24==0){
            System.debug('Eneterd Number is Zero : '+a24);
        }
    }*/
}