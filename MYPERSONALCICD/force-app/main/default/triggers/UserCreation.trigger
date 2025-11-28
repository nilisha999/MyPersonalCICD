// Date : 22-3-25 @Np
// Scenario : On creation of a new active user, make sure it is assigned 3 permission sets(create 3 new permission sets). 
trigger UserCreation on User (after insert, after Update) {
    
    List<User> newActiveUsers  = new List<User>();
    List<User> oldInActiveUsers = new List<User>();
    if(Trigger.isAfter){
        for(User user : Trigger.New){
            User oldUser = Trigger.oldMap.get(user.Id);
            if((Trigger.isInsert && user.isActive) || (Trigger.isUpdate && user.isActive != oldUser.isActive && user.isActive) ){
            	newActiveUsers.add(user);
        	}
            else if((Trigger.isUpdate && user.isActive != oldUser.isActive && !user.isActive)){
                oldInActiveUsers.add(user);
            }
        }
        
    }
    
    if(!newActiveUsers.isEmpty()){
        UserCreationHandler.UserOperation(newActiveUsers);
    }
    
    if(!oldInActiveUsers.isEmpty()){
        UserCreationHandler.UserAssignementRemove(oldInActiveUsers);
    }
}