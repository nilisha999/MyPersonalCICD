public class OrderPayloadInvocable {

    @InvocableMethod(label='Send Order Payload to Endpoint' description='Sends Order and its OrderItems data to an external endpoint.')
    public static void sendPayload(List<String> orderIds) {
        
        List<Order> ordersWithItems = [
            SELECT Id, OrderNumber, (SELECT Id, PricebookEntryId, Quantity FROM OrderItems)
            FROM Order
            WHERE Id IN :orderIds
        ];

        if (ordersWithItems.isEmpty()) {
            System.debug('No Orders found for the provided IDs. No payload sent.');
            return;
        }

        // Use a wrapper class to structure the payload cleanly
        OrderPayloadWrapper payload = new OrderPayloadWrapper();
        payload.orderPayload = new List<OrderInfo>();
        
        for (Order ord : ordersWithItems) {
            OrderInfo orderInfo = new OrderInfo(ord);
            payload.orderPayload.add(orderInfo);
        }

        String jsonPayload = JSON.serialize(payload);
        System.debug('Generated JSON Payload: ' + jsonPayload);

        sendPayloadToEndpoint('https://00ad3565bec953a1cd72b127e18e697f.m.pipedream.net', jsonPayload);
    }
    
    //-------------------------------------------------------------
    
    // Method for sending the HTTP callout (can remain a private helper)
    private static void sendPayloadToEndpoint(String endpointUrl, String jsonPayload) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(endpointUrl);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonPayload);

        try {
            Http http = new Http();
            HttpResponse res = http.send(req);
            System.debug('Callout Status Code: ' + res.getStatusCode() + ', Body: ' + res.getBody());
        } catch(Exception e) {
            System.debug('Callout Error: ' + e.getMessage());
        }
    }
    
    //-------------------------------------------------------------
    
    // Wrapper classes for clean JSON serialization
    public class OrderPayloadWrapper {
        public List<OrderInfo> orderPayload;
    }
    
    public class OrderInfo {
        public String OrderId;
        public String OrderName;
        public List<OrderItemInfo> OrderItems;

        public OrderInfo(Order ord) {
            this.OrderId = ord.Id;
            this.OrderName = ord.OrderNumber;
            this.OrderItems = new List<OrderItemInfo>();
            
            if (ord.OrderItems != null) {
                for (OrderItem oi : ord.OrderItems) {
                    this.OrderItems.add(new OrderItemInfo(oi));
                }
            }
        }
    }
    
    public class OrderItemInfo {
        public String orderproductId;
        public Double orderproductQty;

        public OrderItemInfo(OrderItem oi) {
            this.orderproductId = oi.Id;
            this.orderproductQty = oi.Quantity;
        }
    }
}