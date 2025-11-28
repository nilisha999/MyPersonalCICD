public class UserCreationHandler {
    public static void UserOperation(List<User> lisUser){
        try{
            if(!lisUser.isEmpty()){
                Map<String, User_Creation_PS_PG__mdt> mapCM = User_Creation_PS_PG__mdt.getAll();
                System.debug('Map : '+mapCM);
                List<PermissionSetAssignment> InsertAssignedPSA = new List<PermissionSetAssignment>();
                List<GroupMember> InsertAssignedGroupMember = new List<GroupMember>();
                List<String> separatePermissionSetId = new List<String>();
                List<String> separateGroupMemberId = new List<String>();
                
                //Query existing PermissionSetAssignments for all users in the list
                List<PermissionSetAssignment> PermissionSetAssignmentQueryList = [SELECT Id, PermissionSetId, PermissionSet.Name,  AssigneeId From PermissionSetAssignment WHERE AssigneeId IN : lisUser];
                
                // Create a map for faster lookup of existing permission sets for each user
                Map<Id, Set<String>> existingPSAsByUser = new Map<Id, Set<String>>();
                
                for(PermissionSetAssignment psa : PermissionSetAssignmentQueryList){
                    if(!existingPSAsByUser.containsKey(psa.AssigneeId)){
                        existingPSAsByUser.put(psa.AssigneeId, new Set<String>());
                    }
                    existingPSAsByUser.get(psa.AssigneeId).add(psa.PermissionSetId);
                }
                
                //Query existing GroupMember for all users in the list
                List<GroupMember> GroupMemberQueryList = [Select Id, GroupId, Group.Name, UserOrGroupId, UserOrGroup.Name From GroupMember];
                
                //Create a map for faster lookup of existing public group for each user
                Map<Id, Set<String>> existingGMByUser = new Map<Id, Set<String>>();
                
                for(GroupMember gm : GroupMemberQueryList){
                    if(!existingGMByUser.containsKey(gm.UserOrGroupId)){
                        existingGMByUser.put(gm.UserOrGroupId, new Set<String>());
                    }
                    existingGMByUser.get(gm.UserOrGroupId).add(gm.GroupId);
                }
                
                for(User usersOperation : lisUser){
                    // Permission Set
                    separatePermissionSetId = mapCM.get(usersOperation.Country).Permission_Set__c.split(',');
                    InsertAssignedPSA = AssignedPSA(usersOperation.Id, separatePermissionSetId, existingPSAsByUser.get(usersOperation.Id));
                    // Public Group
                    separateGroupMemberId = mapCM.get(usersOperation.Country).Public_Groups__c.split(',');
                    InsertAssignedGroupMember = AssignedGM(usersOperation.Id, separateGroupMemberId, existingGMByUser.get(usersOperation.Id));
                    
                }
                
                if(!InsertAssignedPSA.isEmpty()){
                    insert InsertAssignedPSA;
                }
                
                if(!InsertAssignedGroupMember.isEmpty()){
                    insert InsertAssignedGroupMember;
                }
            }
        }Catch(Exception e){
            System.debug('Error Occurred : '+e.getMessage());
        }
    }
    
    // Permission Set Assignments (userId, PermissionSetId)
    public static List<PermissionSetAssignment> AssignedPSA (Id userId, List<String> permissionSetId, set<String> existingPermissionSetIds){
        if(existingPermissionSetIds == null){
            existingPermissionSetIds = new Set<String>();
        }
        System.debug('Successfully Entered into AssignedPSA');
        List<PermissionSetAssignment> AssignedPSAList = new List<PermissionSetAssignment>();
        for(String psaId : permissionSetId){
            String trimPsaId = psaId.trim();
            if(!String.isBlank(trimPsaId) && !existingPermissionSetIds.contains(trimPsaId)){
                PermissionSetAssignment psa = new PermissionSetAssignment();
                psa.AssigneeId = userId;
                psa.PermissionSetId = trimPsaId;
                AssignedPSAList.add(psa);
                System.debug('Successfully Entered for each psaId');
                System.debug('Each AssignedPSAList : '+AssignedPSAList);
            }else if (String.isBlank(trimPsaId)){
                System.debug('Skipping blank Permission Set Id.');
            } else {
                System.debug('User already has Permission Set with Id: '+ trimPsaId + '. Skipping.');
            }
        }
        System.debug('Successfully Out of loop from each psaId');
        
        return AssignedPSAList;
    }
    
    // Public Group Member (userOrGroupId, GroupId)
    public static List<GroupMember> AssignedGM (Id userId, List<String> publicGroupId, Set<String> existingGrpIds){
        if(existingGrpIds == null){
            existingGrpIds = new Set<String>();
        }
        List<GroupMember> AssignedGroupMmemberList = new List<GroupMember>();
        for(String pgId : publicGroupId){
            String trimPGId = pgId.trim();
            if(!String.isBlank(trimPGId) && !existingGrpIds.contains(trimPGId)){
                GroupMember pg = new GroupMember();
                pg.UserOrGroupId = userId;
                pg.GroupId = trimPGId;
                AssignedGroupMmemberList.add(pg);
                System.debug('Successfully Entered for each psaId');
                System.debug('Each AssignedGroupMmemberList : '+AssignedGroupMmemberList);
            }
            else if (String.isBlank(trimPGId)){
                System.debug('Skipping blank Permission Set Id.');
            } else {
                System.debug('User already has Permission Set with Id: '+ trimPGId + '. Skipping.');
            }
        }
        
        return AssignedGroupMmemberList;
    }
    
    // Delete Permission Set on IN Active users
    public static void UserAssignementRemove(List<User> lisUserAssignmentRemove){
        try{
            if(!lisUserAssignmentRemove.isEmpty()){
                System.debug('Entered into UserAssignementRemove Class METHOD!!!');
                
                // PermissionSetAssignments Actually Assigned to user
                List<PermissionSetAssignment> queryListPSA = [Select Id,AssigneeId, PermissionSetId  From PermissionSetAssignment Where AssigneeId IN : lisUserAssignmentRemove];
                System.debug('Queried queryListPSA : '+queryListPSA);
                
                // Below line 122 or after the debug statement for queriedPSAs
                Set<Id> assignedPermissionSetIds = new Set<Id>();
                for (PermissionSetAssignment psa : queryListPSA) {
                    if (psa.PermissionSetId != null) { // Always good to check for null
                        assignedPermissionSetIds.add(psa.PermissionSetId);
                    }
                }
                System.debug('Assigned Permission Set IDs Set: ' + assignedPermissionSetIds);
                
                
                // Fetch Permission Set Assignememt stored in Custom meta data for this user
                Map<String, User_Creation_PS_PG__mdt> mapCM = User_Creation_PS_PG__mdt.getAll();
                System.debug('Map : '+mapCM);
                
                // Store Only the PermissionSet From CMD
                List<String> separatePermissionSetId = new List<String>();
                List<String> finalRemovePermissionSetId = new List<String>();
                for(User userOperation : lisUserAssignmentRemove){
                    separatePermissionSetId = mapCM.get(userOperation.Country).Permission_Set__c.split(',');
                }
                System.debug('separatePermissionSetId : '+separatePermissionSetId);
                
                // Compare Both List of PermissionSetId
                for(String compareStringId : separatePermissionSetId){
                    if(assignedPermissionSetIds.contains(compareStringId)){
                        System.debug('Matched Found : '+ compareStringId);
                    }
                }
                
            }
            
        }
        Catch (Exception e){
            
        }
    }
}