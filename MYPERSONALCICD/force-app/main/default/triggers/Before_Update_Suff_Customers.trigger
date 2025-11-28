/* Date : 28-8-24, @Nilisha Patil
Requirement : On Create or update, Add Prefix to Name based On Gender of the Customers
*/
trigger Before_Update_Suff_Customers on Customers__c (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            Before_Update_Suff_Customers_Handler.addPrefixToCustomerName(Trigger.new); // To Add Prefix for First Name
            Before_Update_Suff_Customers_Handler.calDOB(Trigger.new); // To Calcualte Age depend on DOB
        }
    }
}