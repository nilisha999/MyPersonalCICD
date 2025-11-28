public class AccountContactFlowActions {
	@InvocableMethod(label='Get Accounts with Contacts' description='Calls')
    public static void getAccountAndContactData(List<String> accountIds){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        // Setup the context to stimuate the call
        RestContext.request = req;
        RestContext.response = res;
        
        // Call your existing REST Class Method
        //SAP_AccountContactData.getAccountWithContacts();
        
        PayloadSender.constructPayload(accountIds);
        
/*        
// The response body is a Blob, convert it to a string
        String jsonResponse = res.responseBody.toString();
        
        // Create an output variable list for the flow
        List<FlowOutput> outputs = new List<FlowOutput>();
        
        FlowOutput output = new FlowOutput();
        output.jsonPayload = jsonResponse;
        outputs.add(output);
        
        return outputs;
    }
    
    // This inner class defines the output structure that the flow will receive.
    public class FlowOutput{
        @InvocableVariable(label='JSON Payload' description='The JSON response')
        public string jsonPayload;
    }*/
}
}