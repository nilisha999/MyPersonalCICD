// 17-6-24
// Case Scenario :  2.  Your Company wants to ensure that the shipping address of an Account record is always in sync with the billing address
public class Acc_Address_Sync_Before_Update_Handler {
    public static void syncAccountAddress(list<Account> lisAcc){
        if(!lisAcc.isEmpty()){
            for(Account acc : lisAcc){
                if(acc.BillingCity != Null || acc.BillingStateCode != Null || acc.BillingStreet != Null || acc.BillingPostalCode != Null){
                    acc.ShippingCity = acc.BillingCity;
                    acc.ShippingStateCode = acc.BillingStateCode;
                    acc.ShippingStreet = acc.BillingStreet;
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
            }
        }
    }
}