// @Np : 10-4-25 : Self CustomMetadataType
public class CustomMetaDataTypes {
    public static void UserActive(){
        // Step 1 : Create a Empty List for Fetch Custom Metadata
        List<User_Creation_PS_PG__mdt> lisCM = User_Creation_PS_PG__mdt.getAll().values();
        Map<String, User_Creation_PS_PG__mdt> mapCM = User_Creation_PS_PG__mdt.getAll();
        System.debug('List : '+lisCM);
        System.debug('Map : '+mapCM);
        
        // Step 2 : Get Particular Instamce for PS_America
        User_Creation_PS_PG__mdt mapUserPS = User_Creation_PS_PG__mdt.getInstance('America PS');
        System.debug('Get Instance : '+mapUserPS);
        
        // Step 3 : GetAll Method
        Map<String, User_Creation_PS_PG__mdt> mapCM2 = User_Creation_PS_PG__mdt.getAll();
        System.debug('Map Get All 2 : '+mapCM2);
        
        List<User_Creation_PS_PG__mdt> lisCMPS;
        
        // Step 4 : Get all Permission Set Records Only
        if(mapUserPS != null) { // Check if mapUserPS is not null
            if(mapUserPS.Permission_Set__c == 'America PS'){
                lisCMPS.add(mapUserPS);
                System.debug('List PS Added : '+lisCMPS);
            }
        }
        
        // QUERY the custom metadata type
        List<User_Creation_PS_PG__mdt> metadataRecords = [Select Permission_Set__c From User_Creation_PS_PG__mdt];
        
        if(!metadataRecords.isEmpty()){
            String permissionSetId = metadataRecords[0].Permission_Set__c;
            System.debug('permissionsetId : '+permissionSetId);
        }
        
        
    }
}