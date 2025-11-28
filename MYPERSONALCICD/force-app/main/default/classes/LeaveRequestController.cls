public with sharing class LeaveRequestController {

    /**
     * Method to submit a new leave request.
     * @param leaveData A map or a custom wrapper to hold the leave details.
     */
    @AuraEnabled
    public static void submitLeaveRequest(String leaveType, Date fromDate, Date toDate) {
        // You can use a custom wrapper class instead of individual parameters for better practice.
        // For simplicity, let's use parameters here.

        Leave_Request__c newLeave = new Leave_Request__c();
        newLeave.Employee__c = getEmployeeId(); // Call a helper method to get the current user's Employee record Id
        newLeave.Leave_Type__c = leaveType;
        newLeave.From_Date__c = fromDate;
        newLeave.To_Date__c = toDate;
        newLeave.Status__c = 'Pending'; // Set default status to 'Pending' for approval flow

        try {
            insert newLeave;
        } catch (DmlException e) {
            // Handle exceptions, e.g., validation rules.
            throw new AuraHandledException('Error submitting leave: ' + e.getMessage());
        }
    }

    /**
     * Method to fetch all leave requests for the logged-in employee.
     */
    @AuraEnabled(cacheable=true)
    public static List<Leave_Request__c> getUserLeaveHistory() {
        // Query for the Employee__c record linked to the current User.
        // You'll need to link the User to the Employee record (e.g., via a lookup field on Employee__c).
        Id currentEmployeeId = getEmployeeId();

        if (currentEmployeeId != null) {
            return [
                SELECT Id, Name, Leave_Type__c, From_Date__c, To_Date__c, Status__c,
                       Employee__r.Name // Example to get Employee name
                FROM Leave_Request__c
                WHERE Employee__c = :currentEmployeeId
                ORDER BY CreatedDate DESC
            ];
        }
        return new List<Leave_Request__c>();
    }

    /**
     * Helper method to find the Employee record for the current user.
     * You will need a lookup field from User to Employee or a matching email address.
     */
    private static Id getEmployeeId() {
        // In a real scenario, you would query the Employee__c object based on User.
        // For this assignment, let's assume a match on the email.
        User currentUser = [SELECT Id, Email FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        List<Employee__c> employeeRecords = [SELECT Id FROM Employee__c WHERE Email__c = :currentUser.Email LIMIT 1];

        if (!employeeRecords.isEmpty()) {
            return employeeRecords[0].Id;
        }
        return null;
    }
}