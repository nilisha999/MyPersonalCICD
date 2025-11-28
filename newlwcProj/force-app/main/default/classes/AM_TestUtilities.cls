/*

Copyright (c) 2011, salesforce.com, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
    * Neither the name of the salesforce.com, Inc. nor the names of its contributors 
    may be used to endorse or promote products derived from this software 
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
OF THE POSSIBILITY OF SUCH DAMAGE.

*/

/*
*---------------------------------------------------------------------------
*     Date     |        Description                |
*---------------------------------------------------------------------------
*  07/09/2014      Utility test class to generate test data
*/

@isTest
public class AM_TestUtilities {

    //Assets
    public static List<AM_Asset__c> createTestAssets(Integer numAssets) {
        //Recordtypes
        List<RecordType> rtList= [select Id, 
                                         DeveloperName,
                                         Name 
                                  from RecordType
                                  where sObjectType =: AM_Constants.AM_ASSET_API_NAME]; 

        List<AM_Asset__c> assetList = new List<AM_Asset__c>();
        for (Integer i=0; i<numAssets; i++) {
            assetList.add(new AM_Asset__c(AM_ID__c = 'TestAsset ' + i, RecordTypeId = rtList[0].Id));
        }
        insert assetList;
        return assetList;
    } 

    //Contacts
    public static List<Contact> createTestContacts(Integer numContacts) {
        List<Contact> contactList = new List<Contact>();
        Account a = new Account(Name='TestAccount');
        insert a;
        for(Integer j=0;j<numContacts;j++) {
            contactList.add(new Contact(firstname='Test'+j,lastname='Test'+j,AccountId=a.Id));
        }
        insert contactList;     
        return contactList;
    }

    //Cases
    public static List<Case> createTestCases(Integer numCases, AM_Asset__c asset) {
        List<Case> cases = new List<Case>();
        for (Integer i=0; i<numCases; i++) {
            cases.add(new Case(AM_Asset__c=asset.Id, Origin='Web', AM_Mark_Asset_as_out_of_service__c=true, subject='TestCase'+i));
        }
        insert cases;
        return cases;
    }

    //Allocations List
    public static List<AM_Asset_Allocation__c> createTestAllocations() {
        List<Contact> conList = createTestContacts(1);
        asset = new AM_Asset__c();
        insert asset;

        List<AM_Asset_Allocation__c> allocList = new List<AM_Asset_Allocation__c>();
        allocList.add(new AM_Asset_Allocation__c(AM_Start_date__c = Date.today(), AM_End_date__c = Date.today() + 5, AM_Asset__c = asset.Id, AM_Contact__c = conList[0].Id));
        insert allocList;
        return allocList;
    }

    //Single Allocation
    public static AM_Asset_Allocation__c createTestAllocation(AM_Asset__c asset) {
        List<Contact> conList = createTestContacts(1);

        AM_Asset_Allocation__c newAlloc = new AM_Asset_Allocation__c(AM_Start_date__c = Date.today(), AM_End_date__c = Date.today() + 5, AM_Asset__c = asset.Id, AM_Contact__c = conList[0].Id);
        insert newAlloc;
        return newAlloc;
    }    
    
    public static AM_Asset__c asset {
        get; private set;
    }

    //Test User
    public static User createTestUser() {

         Profile p = [select id from profile where name='Standard User']; 

         User newUser = new User(alias = 'auser', 
                           email='assetuser@assetapp.com', 
                           emailencodingkey='UTF-8', 
                           lastname='Testing', 
                           languagelocalekey='en_US', 
                           localesidkey='en_US', 
                           profileid = p.Id, 
                           timezonesidkey='America/Los_Angeles',
                           username='assetuser@assetapp.com');

         insert newUser;

         return newUser;

    }

    //Method to check if a message exists
    public static Boolean checkMessageExists(List<ApexPages.Message> msgs, String msgText)
    {
        Boolean messageExists = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains(msgText))
            {
                messageExists = true;
                break;
            } 
        }
        return messageExists;            
    }
    
    static testmethod void test1() {
        List<AM_Asset__c> assets = AM_TestUtilities.createTestAssets(3);
        AM_TestUtilities.createTestContacts(3);
        AM_TestUtilities.createTestCases(3, assets[0]);    
        AM_TestUtilities.createTestAllocations();    
    }
}