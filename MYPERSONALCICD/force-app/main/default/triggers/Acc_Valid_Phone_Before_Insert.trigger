// date : 16-6-24
// case scenario : Your company wants to ensure that all new Account records have a valid phone number before they are inserted into the system. This could be important for organizations that rely heavily on phone 
// communication with their customers or need to keep accurate contact information for compliance purposes.
trigger Acc_Valid_Phone_Before_Insert on Account (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            Acc_Valid_Phone_Before_Insert_handler.checkPhoneNo(Trigger.New);
        }
    }
}