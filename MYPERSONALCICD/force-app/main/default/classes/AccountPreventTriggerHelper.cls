public class AccountPreventTriggerHelper {
    
    public static void preventDuplicateAccount(List<Account> accountList){
        
        try{
            
            // step 1 : Get all existing Account where name and rating like this new accountList
            // Below is wrong Approach
            //List<Account> queryExistingAccount = [Select Id From Account Where Name IN accountList.Name AND Rating =: accountList.Rating];
            // Step 1.1 : Create a set where store account name
            Set<String> accountName = new Set<String>();
            
            // Step 1.2 : Create a set where store account rating
            Set<String> accountRating = new Set<String>();
            
            for(Account acc : accountList){
                if(acc.Name != null){
                    accountName.add(acc.Name);
                }
                if(acc.Rating!=null){
                    accountRating.add(acc.Rating);
                }
            }
            
            List<Account> queryExistingAccount = [Select Id From Account Where Name IN: accountName AND Rating IN: accountRating];
            
            for(Account acc : accountList){
                if(acc.Name != null && acc.Rating!=null && queryExistingAccount.size()>0){
                    acc.Name.addError('AccountPreventTriggerHelper- Duplicate Records Found with this Account Name and Rating');
                }
            }
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
        
    }
    
    // When No of Locations field Updated on Account Insertion, Then Create LOcation Record related to Account
    // After Insert
    public static void handleCreateLocationRecord(List<Account> accountLocationList){
        try{
            List<New_Location__c> locToInsert = new List<New_Location__c>();
            
            Integer count = 0;
            for(Account acc : accountLocationList){
                count = 0;
                if(acc.NumberofLocations__c!=null && acc.NumberofLocations__c>0){
                    While(count <acc.NumberofLocations__c){
                        New_Location__c loc = new New_Location__c();
                        loc.Name = acc.Name + 'Loc Insert';
                        loc.Account__c = acc.Id;
                        locToInsert.add(loc);
                        count = count +1;
                    }
                }
            }
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<Messaging.SingleEmailMessage> mailToSend = new List<Messaging.SingleEmailMessage>();
            List<String> toAddresses = new List<String>{'patilneelisha9@gmail.com'};
			//List<String> toCCAddresses = new List<String>();
                
                for(Account acc : accountLocationList){
                    if(String.isBlank(acc.Industry) && String.isBlank(acc.Phone)){
                        mail.setSubject('The phone and Industry of the Account are Blank - Action Required: Account "' + acc.Name + '" is Missing Key Information');
                        String emailBody = 'A new account "' + acc.Name + '" has been created in Salesforce. ' +
                            'The account is missing some important information: Phone & Industry.\n\n' +
                            'Please try to collect this information and update the account ASAP.\n\n' +
                            'Thanks & Regards,';
                        mail.setPlainTextBody(emailBody);
                        mail.setToAddresses(toAddresses);
                        //toCCAddresses.add(acc.Owner.Email);
                        List<String> toCCAddresses = new List<String>{acc.Owner.Email};
                        mail.setCcAddresses(toCCAddresses);
                        mailToSend.add(mail);
                        System.debug(' - '+emailBody +' - '+toAddresses+' - '+acc.Owner.Email + ' ==== '+mail);
                    }
                }
            
            // Insert the Location records
            if(!locToInsert.isEmpty()){
                insert locToInsert;
            }
            
            // Send the Email
            if(!mailToSend.isEmpty()){
                Messaging.sendEmail(mailToSend);
                System.debug('Sent Email Successfully!!!');
            }
            
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
    
    public static void handleCreateLocationRecord(List<Account> accountLocationList, Integer locNo){
        try{
            List<New_Location__c> locToInsert = new List<New_Location__c>();
            List<New_Location__c> locToDelete = new List<New_Location__c>();
            Integer count = 0;
            for(Account acc : accountLocationList){
                count = 0;
                if(acc.NumberofLocations__c!=null && acc.NumberofLocations__c>0){
                    While(count <locNo){
                        New_Location__c loc = new New_Location__c();
                        loc.Name = acc.Name + 'Loc Insert';
                        loc.Account__c = acc.Id;
                        
                        locToInsert.add(loc);
                        count = count +1;
                    }
                }
            }
            
            // Insert the Location records
            if(!locToInsert.isEmpty()){
                insert locToInsert;
            }
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
    
    public static void handleExistingDeleteLocationRecord(List<Account> accountLocationList, Integer locNo){
        try{
            
            List<New_Location__c> locToDelete = new List<New_Location__c>();
            Integer count = 0;
            Set<Id> accId = new Set<Id>();
            for(Account acc : accountLocationList){
                accId.add(acc.Id);
            }
            List<New_Location__c> queryExistingLoc = [Select Id From New_Location__c Where Account__c =: accId];
            if(!queryExistingLoc.isEmpty()){
                
                count = 0;
                While(count <locNo){
                    locToDelete.add(queryExistingLoc[0]);
                    count = count +1;
                }
                
            }
            
            // Insert the Location records
            if(!locToDelete.isEmpty()){
                Delete locToDelete;
            }
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
    
    // When No of Locations field Updated on Account UPDATED, Then Create LOcation Record related to Account
    public static void handleUpdateLocation(List<Account> accountNew, Map<Id, Account> accountOldMap){
        try{
            Integer Diff = 0;
            
            for(Account acc : accountNew){
                Account oldAcc = accountOldMap.get(acc.Id);
                if(acc.NumberofLocations__c<> oldAcc.NumberofLocations__c && acc.NumberofLocations__c!= null && oldAcc.NumberofLocations__c != null && acc.NumberofLocations__c>0 && oldAcc.NumberofLocations__c >0){
                    //(old value)4>3(new Value) = 4-3 =1(delete)
                    if(oldAcc.NumberofLocations__c > acc.NumberofLocations__c){
                        
                        Diff = Integer.valueOf(oldAcc.NumberofLocations__c - acc.NumberofLocations__c);
                        handleExistingDeleteLocationRecord(accountNew, Diff);
                    }
                    //(old value)2<3(new Value) = 3-2 =1(add)
                    else if(oldAcc.NumberofLocations__c < acc.NumberofLocations__c){
                        Diff = Integer.valueOf(acc.NumberofLocations__c - oldAcc.NumberofLocations__c );
                        handleCreateLocationRecord(accountNew, Diff);
                    }
                    
                }
            }
            System.debug('Success handleUpdateLocation !!');
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
    }
    
    // Before Delete
    // prevent account from deletion if account having contact more than 2 contacts
    public static void handleBeforeDeleteAccount(List<Account> accountDelList){
        try{
            // Store Account Ids in the Set
            Set<Id> accountIdSet = new Set<Id>();
            if(!accountDelList.isEmpty()){
                for(Account acc : accountDelList){
                    accountIdSet.add(acc.Id);
                }
                
                // Fetch Related Contacts Of this Account
            List<Contact> contactList = [Select Id, Name, Account.Name From Contact Where AccountId =: accountIdSet AND AccountId!=null];
            System.debug('contactList : '+contactList);
            
                if(!contactList.isEmpty()){
                    for(Account acc : accountDelList){
                        if(contactList.size()>2){
                            acc.addError('handleAfterDeleteContacts - You cannot delete Account where more than 2 contact  exists');
                        }
                    }
                }
            }
        }
        Catch(Exception e){
            System.debug('Error Occured : '+e.getMessage());
        }
        
    }
}