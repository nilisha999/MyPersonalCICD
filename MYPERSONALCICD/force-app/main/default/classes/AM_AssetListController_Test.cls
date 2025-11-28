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
@isTest
private class AM_AssetListController_Test {
    
    @isTest static void test_method_one() {
        List<AM_Asset__c> assetList = AM_TestUtilities.createTestAssets(3);
        AM_AssetListController con = new AM_AssetListController();
        PageReference assets = Page.AM_AssetListPage;
        Test.setCurrentPage(assets);
        
        con.getFilterSection();
        con.initializeQuery();
        con.executeAssetQuery();
        
        con.assetStatus = '';
        con.executeAssetQuery();
        
        con.searchTerm = 'Available';
        con.executeAssetQuery();
        System.debug('ssc: ' + con.ssc.getRecords());
        
        List<ApexPages.Message> msg = con.errormessages;
        con.getAssetRecords();
        con.addStatusToQuery('test', true);
        
        List<RecordType> rtList= [select Id, 
                                         DeveloperName,
                                         Name 
                                  from RecordType
                                  where sObjectType =: AM_Constants.AM_ASSET_API_NAME]; 
        
        ApexPages.currentPage().getParameters().put('recType', rtList[0].Id);
        con.initializeQuery();
        
    }
    
}