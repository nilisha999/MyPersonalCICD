// Purpose  : you use **res.responseBody to build the body of a RestResponse** to send data back to a client that called your Salesforce endpoint.
@RestResource(urlMapping='/accountss/*')
global class AccountData {
	@HttpGet
    global static void getAccounts(){
        RestResponse res = RestContext.response;
        res.addheader('Content-Type','application/json');
        try{
            List<Account> accounts = [Select Id, Name From Account Limit 2];
            res.responseBody = Blob.valueOf(JSON.serialize(accounts));
            System.debug('Response Body Class : '+res.responseBody.toString());
            res.StatusCode=200;
            System.debug('Success Status Code Class : '+res.StatusCode);
        }
        Catch(Exception e){
            res.StatusCode = 401;
            res.responseBody=Blob.valueOf('{"error"}');
            System.debug('Error Response : '+res.responseBody);
        }
    }
}