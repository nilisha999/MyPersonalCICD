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

/* Description: This class is the controller for the case creation page */

public with sharing class AM_CaseController{

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
    
    //Asset Name
    public String assetName {get; set;}  

    //Asset Object 
    public AM_Asset__c asset {get; set;}

    //Case Object
    public Case aCase {get; set;}

    //New Case Id
    public Id newCaseId {get; private set;}

    //Attachment Object
    public Attachment attach {get; set;}

    //Attachment Name
    public String attachmentName {get; set;}

    //RecordType parameter sent via URL
    public String assetRecordType {get; set;}

    //Asset Label
    public String assetLabel {get;private set;}

     //Boolean to determine if confirmation should be shown or not
    public Boolean showConfirmation {get; private set;} {showConfirmation = false;}     

    //Boolean to determine if look up should be shown or not
    public Boolean showLookUp {get; private set;} {showLookUp = true;}

    //Constructor
    public AM_CaseController(ApexPages.StandardController controller) {

        //Set the Record type
        this.assetRecordType = AM_SettingsUtil.setAssetRecordTypeId(ApexPages.currentPage().getParameters().get('recType'));

        //Set the Asset Label
        this.assetLabel = AM_SettingsUtil.setAssetLabel(this.assetRecordType);

        //Initialise the case
        this.aCase = new Case();

        //If the screen is launched via publisher action then set the asset ID
        if(controller.getRecord()!=null && !String.isEmpty(controller.getRecord().id))
        {
            try
            {
                //Get the Asset
                this.asset = [Select Id,
                                     Name
                              from AM_Asset__c
                              where Id = :controller.getRecord().Id limit 1];

                //Set the asset ID
                aCase.AM_Asset__c = this.asset.Id;

                //Set the asset Name
                this.assetName = this.asset.Name;

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

        //Initialise the attachment
        this.attach = new Attachment(); 

    }

    public PageReference createCase() 
    {
        //Check if Asset has been selected
        if(aCase.AM_Asset__c == null || String.isEmpty(aCase.AM_Asset__c))
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                       this.assetLabel + ' field cannot be empty.'));             
        }
        else if(String.isEmpty(aCase.subject))
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                       'Subject cannot be blank.'));             
        }
        else if(String.isEmpty(aCase.description))
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                       'Description cannot be blank.'));             
        } 
        else
        {
            //Create case
            try 
            {
                //Get the record type associated with the Asset Management app
                RecordType caseRecordType = [Select Id from RecordType where DeveloperName =: AM_Constants.AM_CASE_RT_NAME Limit 1];

                //Set the new case's record Type
                aCase.RecordTypeId = caseRecordType.Id;

                //Check if the user has access to create the object record
                if(User.sObjectType.getDescribe().isCreateable())
                {
                    //Insert record
                    Database.SaveResult sr = Database.insert(aCase); 
                    
                    //If error show an error message
                    if(!sr.isSuccess())
                    {
                        //Do not show confirmation
                        this.showConfirmation = false;  
                                          
                        Database.Error err = sr.getErrors()[0];

                        //Add a message that there was an error creating records
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                                   'Error creating Case. ' + err.getMessage())); 
                                                                                      
                    }
                    //If case creation is success, create the attachment
                    else
                    {
                        //If attachment is uploaded by user then attach it to the case
                        if(aCase != null && !String.isEmpty(aCase.id) && 
                           !String.isEmpty(attach.name) && 
                           attach.body != null) 
                        {
                            //Set the newly created case as the parent of the attachment
                            attach.ParentId = aCase.Id;

                            //Insert the attachment
                            try 
                            {
                                //Check if the user has access to create the object record
                                if(Attachment.sObjectType.getDescribe().isCreateable())
                                {
                                    //Insert record
                                    Database.SaveResult sresult = Database.insert(attach); 

                                    //If error show an error message
                                    if(!sresult.isSuccess())
                                    {
                                        //Do not show confirmation
                                        this.showConfirmation = false;  
                                                          
                                        Database.Error err = sresult.getErrors()[0];

                                        //Add a message that there was an error creating records
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                                                   'Case created, but attachment could not be added. Please contact administrator' + err.getMessage()));                      
                                        
                                    }
                                    //Else reset everything and show confirmation
                                    else
                                    {
                                        newCaseId = aCase.Id;
                                        aCase = new Case();
                                        this.assetName = '';
                                        attach = new Attachment();
                                        this.showConfirmation = true;
                                    }
                                }
                                else
                                {
                                	//Do not show confirmation
                   					this.showConfirmation = false;
                    
                                    //Add a message if there is an error creating case
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,
                                                                               'Insufficient access level to create attachments.'));                    

                                }                

                            } 
                            catch (Exception e) 
                            {
                            	//Do not show confirmation
                    			this.showConfirmation = false;
                    			
                                //Add a message if there is an error creating an attachment
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,
                                                                           String.format('Case created, but attachment could not be added. Please contact administrator. {0}',
                                                                                         new List<String>{e.getMessage()})));

                            }            
                        }

                        else
                        {   
                            newCaseId = aCase.Id;
                            aCase = new Case();
                            this.assetName = '';
                            this.showConfirmation = true;
                        }                        
                        
                    }
                }
                else
                {
            	    //Do not show confirmation
                    this.showConfirmation = false; 
                    
                    //Add a message that there was an error creating records
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                               'Insufficient access level to create case')); 
                
                }

            } catch (Exception e) 
            {
    	        //Do not show confirmation
                this.showConfirmation = false; 
                
                //Add a message if there is an error creating case
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,
                                                           String.format('Error creating case. {0}',
                                                                         new List<String>{e.getMessage()})));
            }
             
        }       


        return null;
  
        
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