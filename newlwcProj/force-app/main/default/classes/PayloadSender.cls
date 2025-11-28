// Purpose : In summary, you use a Map to construct a payload for an HttpRequest to send data out of Salesforce.
public class PayloadSender {
    public static void constructPayload(List<String> accountId){
        List<Account> getAccountList = [Select Id, Name ,(Select Id, LastName From Contacts)
                                        From Account 
                                        Where Id In: accountId];
        System.debug('Account List Fetched : '+getAccountList);
        // Check if any accounts Founds or not
        if(getAccountList.isEmpty()){
           System.debug('No accounts found for the given IDs.');
            return;
        }
        
        // 2. Create the Main payload map
        Map<String, Object> finalPayload = new Map<String, Object>();
        // 3. Loop through the query results to build the structured payload
        List<Map<String, Object>> accountsData = new List<Map<String, Object>>();
        for(Account acc : getAccountList){
            Map<String, Object> accountMap = new Map<String, Object>();
            accountMap.put('Name', acc.Name);
            accountMap.put('Id',acc.Id);
            
            // 4. Create a list to hold the Contact data for the current account
            List<Map<String, Object>> contactData = new List<Map<String, Object>>();
            for(Contact con : acc.Contacts){
                Map<String, Object> contactMap = new Map<String, Object>();
                contactMap.put('Id',con.Id);
                contactMap.put('LastName',con.LastName);
                contactData.add(contactMap);
            }
            accountMap.put('Contacts',contactData);
            accountsData.add(accountMap);
        }
        System.debug('AccountData : '+accountsData);
        
        // Put the list of Accounts into the finalPayload map
        finalPayload.put('Accounts',accountsData);
        System.debug('Final Payload : '+finalPayload);
        
        String jsonPayload = JSON.serialize(finalPayload);
        System.debug('Build JsonPayload : '+jsonPayload);
        sendPayloadToEndpoint('https://00ad3565bec953a1cd72b127e18e697f.m.pipedream.net', jsonPayload);
    }
    public static void sendPayloadToEndpoint(String endpointUrl, String jsonPayload){
        // Create an instance of the HttpRequest class
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpointUrl);
        req.setHeader('Content-Type', 'application/json');
        
        // Set the Request body
        req.setBody(jsonPayload);
        System.debug('Set Post Endpointurl : '+endpointUrl);
        System.debug('Request Body : '+jsonPayload);
        
        try{
            // Create an instance of the Http class and send the request
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            // Check the status code and response body
            if(res.getStatusCode()==200){
                System.debug('Success! Status Code : '+res.getStatusCode());
                System.debug('Success! Response body: '+res.getBody());
            }
            else{
                System.debug('Error! Status Code: '+res.getStatusCode() + ' , Response body: '+res.getBody());
            }
        }
        Catch(Exception e){
            System.debug('Callout Error: '+e.getMessage());
        }
    }
}