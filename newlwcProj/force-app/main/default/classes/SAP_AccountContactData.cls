@RestResource(urlMapping='/account/*')
global class SAP_AccountContactData {
    @HttpGet
    global static void getAccountWithContacts(){
        RestResponse res = RestContext.response;
        res.addheader('Content-Type', '/application-json');
        try{
            List<Account> accounts = [SELECT Id, IsDeleted, MasterRecordId, Name, LastName, FirstName, Salutation, Type, RecordTypeId, ParentId, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
                                      BillingStateCode, BillingCountryCode, BillingLatitude, BillingLongitude, BillingGeocodeAccuracy, BillingAddress, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, 
                                      ShippingCountry, ShippingStateCode, ShippingCountryCode, ShippingLatitude, ShippingLongitude, ShippingGeocodeAccuracy, ShippingAddress, Phone, Fax, AccountNumber, Website, PhotoUrl, Sic, 
                                      Industry, AnnualRevenue, NumberOfEmployees, Ownership, TickerSymbol, Description, Rating, Site, CurrencyIsoCode, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, 
                                      LastActivityDate, LastViewedDate, LastReferencedDate, IsPartner, IsCustomerPortal, PersonContactId, IsPersonAccount, ChannelProgramName, ChannelProgramLevelName, PersonMailingStreet, PersonMailingCity, 
                                      PersonMailingState, PersonMailingPostalCode, PersonMailingCountry, PersonMailingStateCode, PersonMailingCountryCode, PersonMailingLatitude, PersonMailingLongitude, PersonMailingGeocodeAccuracy, 
                                      PersonMailingAddress, PersonOtherStreet, PersonOtherCity, PersonOtherState, PersonOtherPostalCode, PersonOtherCountry, PersonOtherStateCode, PersonOtherCountryCode, PersonOtherLatitude, PersonOtherLongitude, 
                                      PersonOtherGeocodeAccuracy, PersonOtherAddress, PersonMobilePhone, PersonHomePhone, PersonOtherPhone, PersonAssistantPhone, PersonEmail, PersonTitle, PersonDepartment, PersonAssistantName, PersonLeadSource, 
                                      PersonBirthdate, PersonLastCURequestDate, PersonLastCUUpdateDate, PersonEmailBouncedReason, PersonEmailBouncedDate, PersonIndividualId, Jigsaw, JigsawCompanyId, CleanStatus, AccountSource, DunsNumber, Tradestyle, 
                                      NaicsCode, NaicsDesc, YearStarted, SicDesc, DandbCompanyId, OperatingHoursId, CustomerPriority__c, SLA__c, Active__c, NumberofLocations__c, UpsellOpportunity__c, SLASerialNumber__c, SLAExpirationDate__c, 
                                      Client_Rating__c, Acc_Active__c, Contact_Point_Email__c, new_test_turbo__c, Account_Owner_Email_Id__c, Test_Date_1__c, Test_Date_time_2__c, test_Formula_date_1__c, test_Formula_date_time_2__c, 
                                      Test_Credit_Score_Percent__c, test_Credit_Score_Test__c, Test_Turbo_Follow_up_date__c, Test_New_Turbo_DT__c, Phenoxy_Probable_close_date__c, rh2__Describe__c, Count_of_Probable_close_date_changed__c, 
                                      rh2__testCurrency__c, users_task__c, Primary_Contact__c, Contact_Size__c, Geo_Location_Account__c, Level__pc, Languages__pc, rh2__Currency_Test__pc, rh2__Describe__pc, rh2__Integer_Test__pc, 
                                      rh2__Formula_Test__pc, Company__pc, Title__pc, Company_Size__pc, Industry__pc, Contact_Created_Date__pc, cc_bcc_email__pc, Aadhar_Card_Number__pc, Pan_Number__pc, Check_OCR__pc, Primary_Contact__pc,
                                      dueDate__pc,
                                      (SELECT Id, IsDeleted, MasterRecordId, AccountId, IsPersonAccount, LastName, FirstName, Salutation, Name, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry, OtherStateCode, 
                                       OtherCountryCode, OtherLatitude, OtherLongitude, OtherGeocodeAccuracy, OtherAddress, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingStateCode, 
                                       MailingCountryCode, MailingLatitude, MailingLongitude, MailingGeocodeAccuracy, MailingAddress, Phone, Fax, MobilePhone, HomePhone, OtherPhone, AssistantPhone, ReportsToId, Email, Title, 
                                       Department, AssistantName, LeadSource, Birthdate, Description, CurrencyIsoCode, OwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, 
                                       LastCURequestDate, LastCUUpdateDate, LastViewedDate, LastReferencedDate, EmailBouncedReason, EmailBouncedDate, IsEmailBounced, PhotoUrl, Jigsaw, JigsawContactId, CleanStatus, IndividualId, 
                                       IsPriorityRecord, ContactSource, Level__c, Languages__c, rh2__Currency_Test__c, rh2__Describe__c, rh2__Integer_Test__c, rh2__Formula_Test__c, Company__c, Title__c, Company_Size__c, Industry__c, 
                                       Contact_Created_Date__c, cc_bcc_email__c, Aadhar_Card_Number__c, Pan_Number__c, Check_OCR__c, Primary_Contact__c, dueDate__c 
                                       FROM Contacts)
                                      FROM Account Limit 3];
            res.responseBody = Blob.valueOf(JSON.serialize(accounts));
            System.debug('SAP Account Class Response Body : '+res.responseBody.toString());
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