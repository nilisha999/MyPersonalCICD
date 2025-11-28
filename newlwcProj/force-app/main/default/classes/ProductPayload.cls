public class ProductPayload {
	@InvocableMethod(label='Send Product Payload to Endpoint' description='Sends a list of product details to an external endpoint.')
    public static void constructPayload(List<String> productIds){
        List<Product2> getProductList = [Select Id, Name, ProductCode, ExternalId
                                         From Product2 
                                         Where Id In: productIds];
        System.debug('Product list Fetched : '+getProductList);
        
        if(getProductList.isEmpty()){
            System.debug('No Product Id Found to proccess.');
            return;
        }
        
        Map<String, Object> finalPayloadMap = new Map<String, Object>();
        List<Map<String, Object>> productData = new List<Map<String, Object>>();
        for(Product2 prod : getProductList){
            Map<String, Object> productMap = new Map<String, Object>();
            productMap.put('productId',prod.Id);
            productMap.put('productName',prod.Name);
            System.debug('productMap : '+productMap);
            productData.add(productMap);
            System.debug('productData : '+productData);
        }
        finalPayloadMap.put('products',productData);
        System.debug('finalPayloadMap : '+finalPayloadMap);
        
        String jsonPayload = JSON.serialize(finalPayloadMap);
        System.debug('jsonPayload : '+jsonPayload);
        sendPayloadToEndpoint('https://00ad3565bec953a1cd72b127e18e697f.m.pipedream.net', jsonPayload);
        
    }
    
    public static void sendPayloadToEndpoint(String endpointUrl, String jsonPayload){
        // Create the instance of HttpRequest class
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpointUrl);
        req.setHeader('Content-Type','application/json');
        // set the request body
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