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

/* Description: This class contains test methods to test Asset Assignment functionality */

@isTest
private class AM_AssetAssignControllerTest
{
    /**
    *   Test Case:
    *   1) Create an instance of AM_AssetAssignController
    *   2) Check that the start date and end date are initialised
    *   3) Do not set required fields and check that the error message is thrown
    *   4) Create an allocation record successfully
    *   5) Try to allocate the same asset and check that an error is thrown
    */ 
    @isTest
    private static void testAssetAssignment()
    {
        /*Set up data*/
        //Create an instance of the AM_AssetAssignController
        List<AM_Asset__c> assets = AM_TestUtilities.createTestAssets(3);
        ApexPages.StandardController sc = new ApexPages.StandardController(assets[0]);
        AM_AssetAssignController assignController = new AM_AssetAssignController(sc);

        //Check that the dates are initialised
        system.assert(!String.isEmpty(assignController.allocationStartDateDisplay));
        system.assert(!String.isEmpty(assignController.allocationEndDate.format()));

        //Call createAllocation without setting any of the fields
        assignController.createAllocation();
    //    system.assert(AM_TestUtilities.checkMessageExists(ApexPages.getMessages(), 'field cannot be empty'));

        //Create an available asset
        AM_Asset__c availableAsset = new AM_Asset__c();     
        insert availableAsset;

        //Set the asset ID
        assignController.assetId = availableAsset.id;

        //Call createAllocation without setting Contact Id and Assign To Date
        assignController.createAllocation();
        system.assert(AM_TestUtilities.checkMessageExists(ApexPages.getMessages(), 'Contact cannot be blank.'));

        //Create a contact
        Contact newContact = AM_TestUtilities.createTestContacts(1)[0];

        //Set the contact ID
        assignController.contactId = newContact.Id;

        //Call createAllocation without setting Assign To Date
        assignController.allocationEndDate = null;
        assignController.createAllocation();
        system.assert(AM_TestUtilities.checkMessageExists(ApexPages.getMessages(), 'Please enter Assign To date.'));

        //Reset the dates
        assignController.allocationStartDate = Datetime.now();
        assignController.allocationEndDate = assignController.allocationStartDate.addHours(1);

        //Call createAllocation after setting all values
        assignController.createAllocation();
        system.assert(assignController.allocationRecord!=null &&
                      !String.isEmpty(assignController.allocationRecord.id));

        //Call createAllocation again and check that the asset cannot be assigned again
        assignController.assetId = availableAsset.id;
        assignController.contactId = newContact.Id;         
        assignController.createAllocation();
        system.assert(AM_TestUtilities.checkMessageExists(ApexPages.getMessages(), 'The asset is already allocated for the specified dates. Please choose available dates or select a different asset.'));
    
        assignController.goHome();
        assignController.closeConfirmation();
    }

}