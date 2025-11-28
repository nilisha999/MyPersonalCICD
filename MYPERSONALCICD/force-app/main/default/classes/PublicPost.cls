@RestResource(urlMapping='/publicPost/*')
global without sharing class PublicPost {
    
    @HttpPost
    global static String doPost() {
        // Parse the request body (JSON)
        RestRequest req = RestContext.request;
        String body = req.requestBody.toString();

        // Deserialize JSON to a Map
        Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(body);

        // Create a new Account record
        Account acc = new Account();
        acc.Name = (String) data.get('name');
        acc.Phone = (String) data.get('phone');
        acc.Website = (String) data.get('website');
        acc.Rating = (String) data.get('rating');
        
        try {
            insert acc;
            return '✅ Account created successfully. Record Id: ' + acc.Id;
        } catch (Exception e) {
            return '❌ Error: ' + e.getMessage();
        }
    }

    @HttpGet
    global static String doGet() {
        return 'GET works — you can create accounts with POST.';
    }
}