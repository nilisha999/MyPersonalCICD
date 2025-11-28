public class OrderPayloadSender {
    public static void constructPayload(List<String> orderId){
        List<Order> getOrderList = [SELECT Id, OrderNumber, 
                                    (SELECT Id, PricebookEntryId, Quantity FROM OrderItems)
									FROM Order
                                   Where Id In: orderId
                                   ];
        System.debug('Orders with Related Orderproducts Fetched List : '+getOrderList);
        
        // Check if getOrderList is Empty
        if(getOrderList.isEmpty()){
            System.debug('No Sales Order Id found for Construct Payload');
            return;
        }
        
        // 1. Create the map for main payload
        Map<String , Object> finalPayload = new Map<String, Object>();
		// 3. Loop through the query results to build the structured payload
		List<Map<String, Object>> orderData = new List<Map<String, Object>>();
        for(Order ord : getOrderList){
            Map<String, Object> orderMap = new Map<String, Object>();
            orderMap.put('OrderId',ord.Id);
            orderMap.put('OrderName',ord.OrderNumber);
            orderData.add(orderMap);
            System.debug('orderMap : '+orderMap);
            System.debug('orderData: '+orderData);
            
            // 4. Loop for Orde products
            for(OrderItem oi : ord.OrderItems){
                Map<String, Object> orderproductMap = new Map<String, Object>();
                orderproductMap.put('orderproductId',oi.Id);
                //orderproductMap.put('orderproductName',oi.Name);
                orderproductMap.put('orderproductQty',oi.Quantity);
                orderData.add(orderproductMap);
                System.debug('OrderData + Order Products : '+orderData);
            }
        }
        finalPayload.put('orderPayload',orderData);
        System.debug('Final Payload : '+finalPayload);
        
        String jsonPayload = JSON.serialize(finalPayload);
        System.debug('Build Order Json Payload : '+jsonPayload);
        sendPayloadToEndpoint('https://00ad3565bec953a1cd72b127e18e697f.m.pipedream.net', jsonPayload);
    }
    
    public static void sendPayloadToEndpoint(String endpointUrl, String jsonPayload){
        // Create an Instance of HttpRequest class
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpointUrl);
        req.setHeader('Content-Type','application/json');
        
        // Set the Request Body
        req.setBody(jsonPayload);
        System.debug('Set Post Endpointurl for Order : '+endpointUrl);
        System.debug('Request Body for Order : '+jsonPayload);
        
        try{
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