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

/* Description: This class is the controller for the app's asset assignment page */

public with sharing class AM_AssetAssignController {

    //Variable for errormessage
    public List<ApexPages.Message> errormessages 
    {
        get
        {
            //Get only error messages
            return AM_SettingsUtil.prepareMessages(ApexPages.getMessages());
        }

        private set;
    }

    //Variable to store the name of the recordtype selected
    public String assetLabel { get; private set; }

    //Asset ID
    public String assetId {get; set;}

    //Asset Name
    public String assetName {get; set;}

    //Asset Record Type
    public String assetRecordType {get; private set;}   

    //Asset object
    public AM_Asset__c assetObject {get; private set;} 

    //Asset Allocation Start Date
    public Datetime allocationStartDate {get; set;}

    //Asset Allocation Start Date for display
    public String allocationStartDateDisplay {get; set;}    

    //Asset Allocation End Date
    public Datetime allocationEndDate {get; set;}

    //Contact ID
    public String contactId {get; set;}

    //Contact Name
    public String contactName {get; set;}   

    //Contact object
    public Contact contactObject {get; private set;} 

    //Allocation object created
    public AM_Asset_Allocation__c allocationRecord {get; private set;}

     //Boolean to determine if confirmation should be shown or not
    public Boolean showConfirmation {get; private set;} {showConfirmation = false;}    

    //Boolean to determine if look up should be shown or not
    public Boolean showLookUp {get; private set;} {showLookUp = true;}    


    //Constructor
    public AM_AssetAssignController(ApexPages.StandardController controller) {

        //Set the Record type
        this.assetRecordType = String.escapeSingleQuotes(AM_SettingsUtil.setAssetRecordTypeId(ApexPages.currentPage().getParameters().get('recType')));

        //Set the asset label
        this.assetLabel = AM_SettingsUtil.setAssetLabel(this.assetRecordType);

        //Set the allocation start date to now
        this.allocationStartDate = Datetime.now();
        this.allocationStartDateDisplay = allocationStartDate.format();

        //Provide a default value for allocation end date by adding an hour to the start date 
        this.allocationEndDate = allocationStartDate.addHours(1);

        //If the screen is launched via publisher action then set the asset ID
        if(controller.getRecord()!=null && !String.isEmpty(controller.getRecord().id))
        {
            try
            {
                //Get the Asset
                this.assetObject = [Select Id,
                                     Name,
                                     AM_Status__c,
                                     AM_Type__c,
                                     AM_Location__c,
                                     AM_Location__r.Name,
                                     AM_Price__c
                              from AM_Asset__c
                              where Id = :controller.getRecord().Id limit 1];

                //Set the asset ID
                this.assetId = this.assetObject.Id;

                //Set the asset Name
                this.assetName = this.assetObject.Name;

                //Set the showLookUp to false
                this.showLookUp = false;                
            }
            catch(Exception e) 
            {
                //Add a message if there is an error fetching the asset id
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,
                                                           String.format('E4: {0} could not be found. Please try again.',
                                                                         new List<String>{this.assetLabel})));

            }

        }        
    }

    /*
    * Description: Method to create the Asset Allocation record
    */
    public PageReference createAllocation()
    {
        //Check if Asset has been selected
        if(String.isEmpty(this.assetId))
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                       this.assetLabel + ' field cannot be empty.'));             
        }
        else if(String.isEmpty(this.contactId))
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                       'Contact cannot be blank.'));             
        }
        else if(this.allocationEndDate==null || String.isEmpty(allocationEndDate.format()))
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                       'Please enter Assign To date.'));             
        }
        else
        {
            try
            {
                //Create asset allocation object
                AM_Asset_Allocation__c newAllocation = new AM_Asset_Allocation__c();

                //Set fields
                newAllocation.AM_Asset__c = this.assetId;
                newAllocation.AM_Contact__c = this.contactId;
                newAllocation.AM_Start_Date__c = allocationStartDate;
                newAllocation.AM_End_Date__c = allocationEndDate;

                //Check if the user has access to create the object record
                if(AM_Asset_Allocation__c.sObjectType.getDescribe().isCreateable())
                {
                    //Insert record
                    Database.SaveResult sr = Database.insert(newAllocation);  

                    //If error show an error message
                    if(!sr.isSuccess())
                    {
                        //Do not show confirmation
                        this.showConfirmation = false;  
                                          
                        Database.Error err = sr.getErrors()[0];

                        //Add a message that there was an error creating records
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                                   'Error creating allocation. ' + err.getMessage()));                      
                    }
                    //If success reset values on the screen
                    else
                    {
                        allocationRecord = newAllocation;
                        this.showConfirmation = true;
                        this.assetId = '';
                        this.assetName = '';
                        this.contactId = '';
                        this.contactName='';
                    }                    
                }
                else
                {
                    //Add a message that there was an error creating records
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                               'Insufficient access level to create allocation.')); 
                }

            }
            catch (Exception e)
            {
                //Do not show confirmation
                this.showConfirmation = false;

                //Add a message that there was an error fetching records
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                           'Error creating allocation. ' + e.getMessage())); 
            }         
        }

        return null;                       
    } 

    /*
    * Description: Method called by the cancel method to go to the home page
    */
    public PageReference goHome()
    {
        return new PageReference('/apex/AM_HomePage');                       
    } 

    /*
    * Description: Method called by the cancel method to go to the home page
    */
    public PageReference closeConfirmation()
    {
        this.showConfirmation = false;
        return null;                      
    }     
}