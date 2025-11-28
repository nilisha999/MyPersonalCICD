// 17-6-24
// Case 4 : Suppose you are managing a team of sales reps in a company that sells software solutions to businesses. Your team uses Salesforce to manage customer contacts and associated accounts. You want to ensure that any changes made to a 
// contact’s description field are automatically reflected in the associated account’s description field.
trigger Con_Acc_Description_AfterUpdate on Contact (before insert) {

}