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

/*Description: This class is the controller for the app's Contact list page*/

public with sharing class AM_ContactListController {

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
    
    //Standard Set Controller
    public ApexPages.StandardSetController ssc {get; private set;}

    //Variable to hold the SOQL query
    private String contactQuery {get; set;} {contactQuery = '';}   

    //Variable for the search term
    public String searchTerm {get; set;}

    //Variable for the search string based on the search term
    public String searchString 
    {
        get 
        {
            return '%' + searchTerm + '%';
        }
         
        set;
     }

    //Constructor
    public AM_ContactListController() {

        //Initialize search term
        searchTerm = '';

        //Search contacts
        this.executeQuery();
    }   

    /**
     * Description: Method to fetch the Asset List using StandardSetController
     */
     public List<Contact> getContactRecords()
     {
        return (List<Contact>)ssc.getRecords();
     }
    
    /**
     * Description: Method to refresh variable values when search is invoked
     */
    public void executeQuery() 
    {
        //Without search term 
        if (searchTerm == null || searchTerm.equalsIgnoreCase('')) 
        {
            this.contactQuery = 'SELECT Id, Name, FirstName, LastName, Email, Phone FROM Contact ORDER By Name';            
        } 
        //With search term
        else 
        {
            this.contactQuery = 'SELECT Id, Name, FirstName, LastName, Email, Phone FROM Contact WHERE (FirstName LIKE :searchString OR LastName LIKE :searchString OR Email LIKE :searchString) ORDER by Name';
        }  

        try
        {
            //Execute query
            ssc = new ApexPages.StandardSetController(Database.query(this.contactQuery));

            //Set Page Size
            ssc.setPageSize(10); 
        }
        catch (Exception e)
        {
            //Add a message that there was an error fetching records
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'E1: Error fetching records. ( ' + e.getMessage() + ' )'));                                                
        }             
    }
    
}