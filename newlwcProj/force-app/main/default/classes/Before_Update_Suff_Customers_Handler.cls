/* Date : 28-8-24, @Nilisha Patil
Requirement : On Create or update, Add Prefix to Name based On Gender of the Customers
*/
public class Before_Update_Suff_Customers_Handler {
    public static void addPrefixToCustomerName(List<Customers__c> lisCus){
        String existingFirstName;
        String cleanedFirstName;
        if(!lisCus.isEmpty()){
            for(Customers__c cus :lisCus){
                if(cus.First_Name__c != NULL){
                    if(cus.Gender__c == 'Male'){
                        
                        existingFirstName = cus.First_Name__c;
                        cleanedFirstName = existingFirstName.replaceAll('^Mr\\. |^Ms\\. |^Mx\\. |^others - ','');
                        cus.First_Name__c = 'Mr. ' + cleanedFirstName;
                    }
                    else if(cus.Gender__c == 'Female'){
                        
                        existingFirstName = cus.First_Name__c;
                        cleanedFirstName = existingFirstName.replaceAll('^Mr\\. |^Ms\\. |^Mx\\. |^others - ','');
                        cus.First_Name__c = 'Ms. ' + cleanedFirstName;
                    }
                    else if(cus.Gender__c == 'Others'){
                        
                        existingFirstName = cus.First_Name__c;
                        cleanedFirstName = existingFirstName.replaceAll('^Mr\\. |^Ms\\. |^Mx\\. |^others - ','');
                        cus.First_Name__c = 'others - ' + cleanedFirstName;
                    }
                }
            }
        }
    }
    
    public static void calDOB(List<Customers__c> lisCus1){
        if(!lisCus1.isEmpty()){
            for(Customers__c cus2 : lisCus1){
                if(cus2.Date_of_Birth__c != NULL){
                    Date today = Date.today();
                    cus2.Age__c = today.year() - cus2.Date_of_Birth__c.year();
                }
            }
        }
    }
}