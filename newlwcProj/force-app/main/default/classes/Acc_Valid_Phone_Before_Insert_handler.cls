// date : 16-6-24
// case scenario : Your company wants to ensure that all new Account records have a valid phone number before they are inserted into the system. This could be important for organizations that rely heavily on phone 
// communication with their customers or need to keep accurate contact information for compliance purposes.
public class Acc_Valid_Phone_Before_Insert_handler {
    public static void checkPhoneNo(List<Account> lisAcc){
        if(!lisAcc.isEmpty()){
            For(Account acc : lisAcc){
                if(acc.Phone!=NULL){
                    if(acc.Phone.Length() <> 10){
                        acc.addError('Please Enter Valid Phone No - 16-6-24');
                    }
                }
            }
        }
    }
}