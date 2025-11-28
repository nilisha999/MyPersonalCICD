public with sharing class VerificationController {
    
    /**
     * @AuraEnabled(cacheable=true)
     * Retrieves the Email and Phone for the currently logged-in User.
     * This is used by the LWC's @wire adapter to display the details.
     */
    @AuraEnabled(cacheable=true)
    public static User getVerificationContactDetails() {
        // Query for the current user's data
        // Ensure the running user has access to these fields
        return [SELECT Email, Phone FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
    }
    
    /**
     * @AuraEnabled(cacheable=false)
     * Executes the business logic to resend the verification link.
     * This is called imperatively in the LWC's connectedCallback.
     */
    @AuraEnabled(cacheable=false)
    public static String resendVerificationLink() {
        // -------------------------------------------------------------------
        // TODO: ADD YOUR ACTUAL BUSINESS LOGIC HERE 
        // Logic to generate and send the verification email.
        // -------------------------------------------------------------------
        
        // Return a simple success message string
        return 'Link successfully resent by server logic.'; 
    }
}