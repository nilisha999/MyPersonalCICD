public class Day42_SG_DML_DB_Class {
	// case 1) Insert 5 Accounts with different account names and phone = ‘123456’. [Hint: Loop]
    public static void queryInsertAccount(){
        List<Account> lisAcc1 = new List<Account>();
        for(Integer i = 0; i<5; i++){
            Account acc1 = new Account(Name = 'Nilisha Oct 27-10-2023 -  '+i);
            acc1.Phone = '123456';
            lisAcc1.add(acc1);
        }
        insert lisAcc1;
        System.debug('Account New - '+lisAcc1);
    }
}