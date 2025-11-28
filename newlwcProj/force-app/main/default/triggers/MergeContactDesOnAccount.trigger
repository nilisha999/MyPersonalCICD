// Date : 20-3-25
// Scenario 2.2 : When an contact created on related to any existing account, then contact's Description should be concatenate 
// with the existing account's Description
// As we are working on creation of contact and account, so we will use after insert
trigger MergeContactDesOnAccount on Contact (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        MergeContactDesOnAccountHandler.MergeContactDes(Trigger.new);
    }
}