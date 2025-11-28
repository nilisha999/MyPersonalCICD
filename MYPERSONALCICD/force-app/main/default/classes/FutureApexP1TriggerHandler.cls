public class FutureApexP1TriggerHandler {
    public static void handleAssignPSToFutureApex(List<User> userList){
        try{
            if(!userList.isEmpty()){
                // Step 1 : get the Permission Set for the User
                List<PermissionSet> queryPermissionSet = [Select Id From PermissionSet Where Name = 'User_PS_1'];
                FutureApexP1.assignPermissionSet();
            }
			
            
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
        
        
    }
}