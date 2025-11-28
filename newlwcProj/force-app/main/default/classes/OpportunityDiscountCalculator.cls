public class OpportunityDiscountCalculator {
    public static Decimal calculateTotalDiscountAmount(Id opportunityId){
        if(opportunityId==null){
            return 0.00;
        }
        
        Decimal totalDiscountAmount = 0.00;
        
        List<OpportunityLineItem> opportunityLineItems = [Select Id, Product2Id, Quantity, UnitPrice From OpportunityLineItem Where OpportunityId =: opportunityId];
        
        // Step 1: Collect all unique Product2Ids from the OpportunityLineItems
        Set<Id> productIds = new Set<Id>();
        for(OpportunityLineItem oli : opportunityLineItems){
            if(oli.Product2Id != null){
                productIds.add(oli.Product2Id);
            }
        }
        
        // Step 2: Query all relevant Product_Discount__c records in a single SOQL.
        Map<Id, List<Product_Discount__c>> productDiscountMap = new Map<Id, List<Product_Discount__c>>();
        
		List<Product_Discount__c> allProductDiscounts = new List<Product_Discount__c>();

        if(!productIds.isEmpty()){
            allProductDiscounts  = [Select Product__c, Discount_Percentage__c, Min_Quantity__c From Product_Discount__c Where Product__c IN : productIds ORDER BY Product__c, Discount_Percentage__c DESC];
        }
        
        // Populate the map : group discounts by Product__c ID
        for(Product_Discount__c pd : allProductDiscounts ){
            if(!productDiscountMap.containsKey(pd.Product__c)){
                productDiscountMap.put(pd.Product__c, new List<Product_Discount__c>());
            }
            productDiscountMap.get(pd.Product__c).add(pd);
        }
        
        // Step 3 : Iterate through OpportunityLineItems again and use the pre-queried data.
        for(OpportunityLineItem  oli : opportunityLineItems){
            Decimal subtotal = oli.Quantity * oli.UnitPrice;
            Decimal applicableDiscountPercentage = 0.00;
            
            // Check if there are discounts for this product
            if(oli.Product2Id != null && productDiscountMap.containsKey(oli.Product2Id)){
                List<Product_Discount__c> discountsForProduct = productDiscountMap.get(oli.Product2Id);
                
                // Find highest applicable discount for the current OLI's quanity
                for(Product_Discount__c pd : discountsForProduct){
                    if(oli.Quantity >= pd.Min_Quantity__c){
                        applicableDiscountPercentage = pd.Discount_Percentage__c;
                        break;
                    }
                }
            }
            
            Decimal discountSubtotal = subtotal * (1-(applicableDiscountPercentage / 100));
            totalDiscountAmount  += discountSubtotal;
        }
        return totalDiscountAmount;
    }
}