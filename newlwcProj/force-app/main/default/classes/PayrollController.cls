public with sharing class PayrollController {

    // You can use the same getEmployeeId() helper method from the LeaveRequestController.
    // It's good practice to put utility methods in a shared utility class.
    private static Id getEmployeeId() {
        // Assume you have a field on the User object that links to the Employee__c record.
        // For this assignment, a simple query on the email address will work.
        User currentUser = [SELECT Id, Email FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        List<Employee__c> employeeRecords = [SELECT Id FROM Employee__c WHERE Email__c = :currentUser.Email LIMIT 1];

        if (!employeeRecords.isEmpty()) {
            return employeeRecords[0].Id;
        }
        return null;
    }

    /**
     * @description Fetches all payroll records for the logged-in employee.
     * @param month (Optional) to filter by a specific month.
     * @return List of Payroll__c records.
     */
    @AuraEnabled(cacheable=true)
    public static List<Payroll__c> getMyPayrollSlips() {
        Id employeeId = getEmployeeId();
        if (employeeId != null) {
            return [
                SELECT Id, Name, Month__c, Basic_Salary__c, Allowance__c, Leave_Deduction__c, Net_Salary__c,
                       Employee__r.Name
                FROM Payroll__c
                WHERE Employee__c = :employeeId
                ORDER BY CreatedDate DESC
            ];
        }
        return new List<Payroll__c>();
    }
    @AuraEnabled(cacheable=true)
    public static List<Payroll__c> getAllPayrolls() {
        return [
            SELECT Id, Name, Month__c, Basic_Salary__c, Allowance__c, Leave_Deduction__c, Net_Salary__c,
                   Employee__r.Name, Employee__r.Designation__c
            FROM Payroll__c
            ORDER BY CreatedDate DESC
        ];
    }
}