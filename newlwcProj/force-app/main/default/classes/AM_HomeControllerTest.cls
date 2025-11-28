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

/* Description: This class contains test methods to test Home Page functionality */


@isTest
private class AM_HomeControllerTest
{

	/**
	*   Test Case:
	*   1) Get a list of recordtypes
	*   2) Create an instance of AM_HomeController
	*   3) Check that the list of recordtype is identical to recordTypeOptions
	*/ 	
	@isTest
	private static void testRecordTypeCount()
	{

	//Record Type List
	List<RecordType> rtList= [select Id, 
                                 	 DeveloperName,
                                 	 Name 
                          	  from RecordType
                          	  where sObjectType =: AM_Constants.AM_ASSET_API_NAME];
                                  	   
		//Create controller instance
		AM_HomeController newController = new AM_HomeController();

		//Test recordtypes 
		system.assertEquals(rtList.size(), newController.recordTypeCount);	                                       		
	}

	/**
	*   Test Case:
	*   1) Create a user with AM_Asset_Record_Type__c blank
	*   2) Select a record type
	*   3) AM_Asset_Record_Type__c field in user should be populated with the selected recordtype
	*/ 	
	@isTest
	private static void testRecordTypeSelection()
	{
		//Create a user
		User newUser = AM_TestUtilities.createTestUser();

		//Run the test as new user
		system.runAs(newUser)
		{
			List<RecordType> rtList= [select Id, 
                                         	 DeveloperName,
                                         	 Name 
                                  	  from RecordType
                                  	  where sObjectType =: AM_Constants.AM_ASSET_API_NAME];

			//Create controller instance
			AM_HomeController newController = new AM_HomeController();

			//Set the recordtype
			newController.selectedRecordTypeId = rtList[0].Id;

			//Call the Refresh method
			newController.refreshHomepage();

			//Get the user record
			User updatedUser = [select Id, 
									   AM_Asset_Record_Type__c
							    from User
							    where Id = :newUser.Id];

			//Check that the AM_Asset_Record_Type__c field is set
			system.assertEquals(rtList[0].Id, updatedUser.AM_Asset_Record_Type__c);	

			//Check the label
			system.assertEquals(newController.assetlabel, rtList[0].Name);						    

		}	                                       		
	}

	/**
	*   Test Case:
	*   1) Create 4 Available, 3 Assigned and 2 Out of Service Assets
	*   2) Check if correct count is obtained
	*/ 	
	@isTest
	private static void testAssetCounts()
	{
		//Record Types
		List<RecordType> rtList= [select Id, 
                                         	 DeveloperName,
                                         	 Name 
                                  	  from RecordType
                                  	  where sObjectType =: AM_Constants.AM_ASSET_API_NAME];
		//Available assets
		List<AM_Asset__c> availableAssets = AM_TestUtilities.createTestAssets(4);

		//Assigned assets
		List<AM_Asset__c> assignedAssets = AM_TestUtilities.createTestAssets(3);
		
		//For each asset create an allocation
		for(AM_Asset__c assignAsset: assignedAssets)
		{
			AM_TestUtilities.createTestAllocation(assignAsset);
		}

		//Out of service assets
		List<AM_Asset__c> oosAssets = AM_TestUtilities.createTestAssets(2);	

		//Mark them OOS
		for(AM_Asset__c oos: oosAssets)
		{
			oos.AM_Out_of_Service__c = true;
		}			

		update oosAssets;

		//Create a new user
		User newUser = AM_TestUtilities.createTestUser();
		newuser.AM_Asset_Record_Type__c = rtList[0].Id;

		update newUser;

		system.runAs(newUser)
		{
			AM_HomeController newController = new AM_HomeController();
			system.assertEquals(newController.availableCount, 6);
			system.assertEquals(newController.assignedCount, 3);
			system.assertEquals(newController.outOfServiceCount, 2);
		}
	}

	/**
	*   Test Case:
	*   1) Create 5 cases
	*   2) Check if the cases are retrieved
	*/ 	
	@isTest
	private static void testCaseCounts()
	{
		//Record Types
		List<RecordType> rtList= [select Id, 
                                         	 DeveloperName,
                                         	 Name 
                                  	  from RecordType
                                  	  where sObjectType =: AM_Constants.AM_ASSET_API_NAME];

		//Create a new user
		User newUser = AM_TestUtilities.createTestUser();
		newuser.AM_Asset_Record_Type__c = rtList[0].Id;

		update newUser;

		system.runAs(newUser)
		{
			//Available assets
			List<AM_Asset__c> availableAssets = AM_TestUtilities.createTestAssets(1);

			//Create Cases
			List<Case> newCases = AM_TestUtilities.createTestCases(4, availableAssets[0]);	
					
			//Create controller instance		
			AM_HomeController newController = new AM_HomeController();

			//Assert
			system.assertEquals(newController.caseList.size(), 4);

		}
	}			
}