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
/* Description: Test class for the AM_CaseController */
@isTest
private class AM_CaseController_Test {
    
    @isTest static void testCaseController1() {
        List<AM_Asset__c> assets = AM_TestUtilities.createTestAssets(1);

        ApexPages.StandardController sc = new ApexPages.StandardController(assets[0]);
        AM_CaseController con = new AM_CaseController(sc);
        
        PageReference casePage = Page.AM_CasePage;
        Test.setCurrentPage(casePage);
        
        
        //Subject is empty
        con.createCase();
        System.assert(con.errormessages.size()>0);

        con.aCase.subject = 'TestSubject';
        
        //Asset is empty
        con.aCase.AM_Asset__c = null;
        con.createCase();
        System.assert(con.errormessages.size()>0);
        
        con.aCase.AM_Asset__c = con.asset.id;
         
        //Description is empty
        con.createCase();
        System.assert(ApexPages.hasMessages());
                
        con.aCase.description = 'TestDescription';
        con.aCase.AM_Mark_Asset_as_out_of_service__c = false;
        
        con.attach.body = Blob.valueOf('Unit Test Attachment Body');
        con.attach.Name = 'Test file name'; 
      
        con.createCase();
        
        Case c = [select id, subject from Case where id =: con.newCaseId limit 1];
        Attachment a = [select id, Name from Attachment where parentId =: c.Id];
        System.AssertEquals(c.subject, 'TestSubject');
        System.AssertEquals(a.Name, 'Test file name');
        System.assert(!con.showLookUp);
        
        //Try creating case with the same case ID
        con.aCase.Id = con.newCaseId;
        con.aCase.AM_Asset__c = assets[0].Id;
        con.aCase.subject = 'TestSubject';
        con.aCase.description = 'TestDescription';
                
        con.createCase(); 
        System.assert(ApexPages.hasMessages());
        System.assert(!con.showConfirmation);       
 
    }
    
    @isTest static void testCaseController2() {
        List<Contact> contacts = AM_TestUtilities.createTestContacts(1);

        ApexPages.StandardController sc = new ApexPages.StandardController(contacts[0]);
        AM_CaseController con = new AM_CaseController(sc);
        System.assert(ApexPages.hasMessages());       
 
    }

    @isTest static void testNoAttachment() {
        List<AM_Asset__c> assets = AM_TestUtilities.createTestAssets(1);

        ApexPages.StandardController sc = new ApexPages.StandardController(assets[0]);
        AM_CaseController con = new AM_CaseController(sc);
        
        PageReference casePage = Page.AM_CasePage;
        Test.setCurrentPage(casePage);
        
        con.aCase.subject = 'TestSubject';     
  		con.aCase.description = 'TestDescription';
        con.aCase.AM_Mark_Asset_as_out_of_service__c = false;
        
        con.createCase();
        
        Case c = [select id, subject from Case where id =: con.newCaseId limit 1];
        System.AssertEquals(c.subject, 'TestSubject');
        System.assert(con.showConfirmation);
        
        
    }            
}