@IsTest (SeeAllData=false) 
public with sharing class C501_Test_Utility {
    /*
    Created By: Jason Best
    Created On: 8/20/2019
    Purpose: Test Factory to provide Utility methods for IsTest classes/methods.  Creation of data, etc.
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Modified By: Jason Best
    Modified On:  6/29/2020
    Modification: Added Volunteer Job, Hours, Facility Fund Status
    */
    
    public class TestData_Structure {
        public LIST<Account> acctLIST;
        public LIST<Contact> contLIST;
        public LIST<Lead> leadLIST;
        public LIST<Opportunity> oppLIST;
        public LIST<Case> caseLIST;
        public LIST<Campaign> campLIST;
    } // END TestData_Structure
    public static TestData_Structure tds = new TestData_Structure();
    
    //Does not insert the account -- that still client code's responsibility
    public static LIST<Account> createTestAccount(String strRecordType, integer nCount) {
        
        system.debug('Received RT: ' + strRecordType);
        LIST<Account> acctLIST = new LIST<account>();
        Account acct = new Account();
        Schema.DescribeSObjectResult AccntRes = Account.SObjectType.getDescribe();
        Map<String,Schema.RecordTypeInfo> AccRecordTypeInfo = AccntRes.getRecordTypeInfosByName();
        ID rtID = AccRecordTypeInfo.get(strRecordType).getRecordTypeId();
        
        for (integer nLoop = 1; nLoop <= nCount; nLoop++) {
            
            acct = new Account(
                Name = 'Test Account ' + string.valueOf(nLoop),
                BillingStreet='851 Cypress Creek Rd',
                BillingCity = 'Fort Lauderdale',
                BillingState = 'FL',
                BillingPostalCode = '33309',
                BillingCountry = 'USA',
                c501_cm__C501_Imagine_WA_County__c='Adams',
                RecordTypeID = rtID);
            acctLIST.add(acct);
        } // END for (integer nLoop = 1; nLoop <= nCount; nLoop++)
        
        return acctLIST;
    } // END createTestAccount
    
    public static LIST<Account> getTestAccount(String strRecordType, integer nCount) {
        
        LIST<Account> acctLIST = C501_Test_Utility.createTestAccount(strRecordType, nCount);
        insert acctLIST;
        system.debug('Inserted Account Test LIST: ' + acctLIST);
        
        return acctLIST;
    } // END getTestAccount
    
    public static LIST<Contact> createTestContact(Account acct, string strRecordType, integer nCount) {
        // Creates nCount records of Contact for the strRecordType Record Type name with the provided Account as the linked account
        
        Schema.DescribeSObjectResult ContRes = Contact.SObjectType.getDescribe();
        Map<String,Schema.RecordTypeInfo> ContRecordTypeInfo = ContRes.getRecordTypeInfosByName();
        LIST<Contact> contLIST = new LIST<Contact>();
        Contact cont = new Contact();
        ID rtID = Schema.SObjectType.Contact.getRecordTypeInfosByName().get(strRecordType).getRecordTypeId();
        
        for (integer nLoop = 1; nLoop <= nCount; nLoop++) {
            String C501_Imagine_WA_County;
            String mphone = '';
            String Imagine_Mobile_Phone = '';
            boolean C501_SMS_Opt_Out=true;
            boolean emailOptout;
            String ii_Unit_Status='';
            boolean ii_Licensed;
            String ii_Substitute_Pool_Status;
            String ii_Initial_Training_Requirement;
            String ii_Languages;
            String ii_Cpr_Cert_Status=null;

            String ii_FamLink_Id = String.valueOf(nLoop) + String.valueOf(DateTime.now().hourGmt()) + String.valueOf(DateTime.now().millisecondGMT());
            String ii_Stars_Id = String.valueOf(nLoop) + String.valueOf(DateTime.now().hourGmt()) + String.valueOf(DateTime.now().millisecondGMT());

            if(math.mod(nLoop,2) == 0){
                    C501_Imagine_WA_County = 'Adams';
                }else{
                    C501_Imagine_WA_County = 'King';
                }
                switch on math.mod(nLoop,3){
                    when 2{
                        
                        emailOptout = true;
                        mphone = '5005550006';
                        ii_Unit_Status='In-Unit';
                        ii_Licensed=true;
                        ii_Languages='English';
                        ii_Substitute_Pool_Status='Eligible';
                        ii_Cpr_Cert_Status='test';
                    }
                    when else{
                        C501_SMS_Opt_Out = false;
                        emailOptout = false;
                        Imagine_Mobile_Phone = '5005550006';
                        ii_Unit_Status='Out-of-Unit';
                        ii_Licensed=false;
                        ii_Languages='Spanish';
                        ii_Substitute_Pool_Status='Pending';
                    }
                }

            cont = new Contact(
                FirstName = 'FirstName' + string.valueOf(nLoop),
                LastName = 'LastName' + string.valueOf(nLoop),
                email = 'FirstName' + string.valueOf(nLoop) + '.LastName' + string.valueOf(nLoop) + '@test-citrix.com',
                County__c=C501_Imagine_WA_County,
                MobilePhone=mphone,
                c501_cm__Imagine_Mobile_Phone__c=Imagine_Mobile_Phone,
                c501_cm__C501_SMS_Opt_Out__c=C501_SMS_Opt_Out,
                HasOptedOutOfEmail=emailOptout,
                c501_cm__ii_Unit_Status__c=ii_Unit_Status,
                c501_cm__ii_Substitute_Pool_Status__c=ii_Substitute_Pool_Status,
                c501_cm__ii_Cpr_Cert_Status__c=ii_Cpr_Cert_Status,
                c501_cm__ii_FamLink_Id__c=ii_FamLink_Id,
                c501_cm__ii_Stars_Id__c=ii_Stars_Id,
                Imported_From__c='Imagine',

                RecordTypeID = rtID);
            contLIST.add(cont);
        } // END for (integer nLoop = 1; nLoop <= nCount; nLoop++)
        system.debug('Created Contact Test LIST: ' + contLIST);
        
        return contLIST;
    } // END createTestContact
    public static LIST<Campaign> createTestCampaign(string classType,string sName, integer nCount) {
        // Creates nCount records of Campaign

        LIST<Campaign> campLIST = new LIST<Campaign>();
        Campaign camp = new Campaign();

        
        for (integer nLoop = 1; nLoop <= nCount; nLoop++) {
            String C501_Outreach_WA_Counties,Language;
            String Class_Type=classType;
            Datetime custom_Start_DateTime=datetime.now().addDays(20);
            if(math.mod(nLoop,2) == 0){
                    Language='English';
                }else{
                    Language='Spanish';
                }
                switch on math.mod(nLoop,3){
                    when 2{
                        
                        C501_Outreach_WA_Counties = 'Adams';
                    }
                    when else{
                        C501_Outreach_WA_Counties = 'King';
                    }
                }

            camp = new Campaign(

                Name = sName + string.valueOf(nLoop),
                c501_cm__custom_Start_DateTime__c=custom_Start_DateTime,
                c501_cm__C501_Outreach_WA_Counties__c=C501_Outreach_WA_Counties,
                c501_cm__Language__c=Language,
                c501_cm__Training_Name__c=sName + string.valueOf(nLoop) ,   
                c501_cm__Class_Type__c=Class_Type,            
                c501_cm__City__c='Test'


                );
            campLIST.add(camp);
        } // END for (integer nLoop = 1; nLoop <= nCount; nLoop++)
        system.debug('Created Campaign Test LIST: ' + campLIST);
        
        return campLIST;
    } // END createTestContact
    public static Campaign createTestVolCampaign(string strRecordType,string sName) {
        // Creates single record of Campaign for the strRecordType Record Type name 
        Campaign camp = new Campaign();
        ID rtID = Schema.SObjectType.Campaign.getRecordTypeInfosByName().get(strRecordType).getRecordTypeId();
            camp = new Campaign(
  
                Name = sName,
                C501_Available_Hours_per_Faciility__c=50,
                C501_Available_Hours_Total__c=500,
                
                c501_cm__Language__c='English',
                EndDate =System.TODAY().addDays(20),

                RecordTypeID = rtID
                );
        system.debug('Created Campaign Test : ' + camp);
        
        return camp;
    } // END createTestVolCampaign
    public static GW_Volunteers__Volunteer_Job__c createTestVolJob(string sName,string sContact,string sVolCampaign,string sShiftFundStatus, datetime dStartDate) {
        // Creates single record of GW_Volunteers__Volunteer_Job__c 
        GW_Volunteers__Volunteer_Job__c job = new GW_Volunteers__Volunteer_Job__c();
            job = new GW_Volunteers__Volunteer_Job__c(
                Name = sName,
                ContactId__c=sContact,
                GW_Volunteers__Campaign__c= sVolCampaign,
                C501_Facility_Shift_Fund_Status__c=sShiftFundStatus,
                C501_Passthrough_Shift_Start_Time__c='06',
                C501_Passthrough_Shift_Start_Minute__c='00',
                C501_Passthrough_Shift_Start_AMPM__c='AM',
                C501_Passthrough_Shift_End_Time__c='07',
                C501_Passthrough_Shift_End_Minute__c='00',
                C501_Passthrough_Shift_End_AMPM__c='AM',
                C501_Passthrough_Shift_Duration__c=1,
                C501_Passthrough_Shift_Start_Date__c=dStartDate,
                C501_Passthrough_Shift_of_Desired_Subs__c=2,
                Currently_in_Flow__c=true

                );
        system.debug('Created Job Test : ' + job);
        
        return job;
    } // END createTestVolCampaign



public static C501_Facility_Shift_Fund_Status__c createFacilityFundStatus(string sFacContact,string sVolCampaign) {
        // Creates single record of C501_Facility_Shift_Fund_Status__c
        C501_Facility_Shift_Fund_Status__c fs = new C501_Facility_Shift_Fund_Status__c();        
            fs = new C501_Facility_Shift_Fund_Status__c(
                C501_Eligible__c=true,
                C501_Funding_Source__c=sVolCampaign,
                C501_Contact__c=sFacContact
                );
        
        system.debug('Created Fund Status Test : ' + fs);
        
        return fs;
    } // END createFacilityFundStatus
public static GW_Volunteers__Volunteer_Hours__c createJobHour(string sSubContact,string sVolCampaign,string sVolShift,string sStatus,date dStartDate, Decimal shiftDuration) {

        GW_Volunteers__Volunteer_Hours__c hour = new GW_Volunteers__Volunteer_Hours__c();
        
        
        
            
            hour = new GW_Volunteers__Volunteer_Hours__c(
                GW_Volunteers__Volunteer_Shift__c = sVolShift,
                GW_Volunteers__Volunteer_Job__c = sVolCampaign,
                GW_Volunteers__Contact__c = sSubContact,
                GW_Volunteers__Status__c = sStatus,
                GW_Volunteers__Start_Date__c = dStartDate,
                GW_Volunteers__Hours_Worked__c = shiftDuration
            );
        
        system.debug('Created Fund Status Test : ' + hour);
        
        return hour;
    } // END createFacilityFundStatus


    public static LIST<Contact> getTestContact(string strRecordType, integer nCount) {
        // Inserts nCount records of Contact for the strRecordType Record Type name including linking accounts.
        LIST<Account> acctLIST = C501_Test_Utility.getTestAccount(strRecordType, nCount);
        Schema.DescribeSObjectResult ContRes = Contact.SObjectType.getDescribe();
        Map<String,Schema.RecordTypeInfo> ContRecordTypeInfo = ContRes.getRecordTypeInfosByName();
        ID rtID = ContRecordTypeInfo.get(strRecordType).getRecordTypeId();
        
        LIST<Contact> contLIST = new LIST<Contact>();
        Contact cont = new Contact();
        
        LIST<Contact> contToDeleteLIST = new LIST<Contact>();
        for (integer nLoop = 1; nLoop <= nCount; nLoop++) {
            cont = new Contact(
                AccountId = acctLIST[nLoop-1].Id,
                FirstName = 'FirstName' + string.valueOf(nLoop),
                LastName = 'LastName' + string.valueOf(nLoop)+ System.now(),
                //Contact_Status__c = strStatus,
                email = 'FirstName' + string.valueOf(nLoop) + '.LastName' + string.valueOf(nLoop) + '@EXAMPLE.com',
                MailingStreet = acctLIST[nLoop-1].BillingStreet,
                MailingCity = acctLIST[nLoop-1].BillingCity,
                MailingPostalCode = acctLIST[nLoop-1].BillingPostalCode,
                MailingCountry = acctLIST[nLoop-1].BillingCountry,
                RecordTypeID = rtID);
            contLIST.add(cont);
        } // END for (integer nLoop = 1; nLoop <= nCount; nLoop++)
        insert contLIST;
        system.debug('Inserted Contact Test LIST: ' + contLIST);
        
        return contLIST;
    } // END getTestContact
    
    public static TestData_Structure getTestContact(string strRecordType, integer nCount, boolean bReturnTestDataStructure) {
        // Inserts nCount records of Contact for the strRecordType Record Type name including linking accounts.
        LIST<Account> acctLIST = C501_Test_Utility.getTestAccount(strRecordType, nCount);
		tds.acctLIST = acctLIST;

        Schema.DescribeSObjectResult ContRes = Contact.SObjectType.getDescribe();
        Map<String,Schema.RecordTypeInfo> ContRecordTypeInfo = ContRes.getRecordTypeInfosByName();
        ID rtID = ContRecordTypeInfo.get(strRecordType).getRecordTypeId();
        
        LIST<Contact> contLIST = new LIST<Contact>();
        Contact cont = new Contact();
        
        LIST<Contact> contToDeleteLIST = new LIST<Contact>();
        for (integer nLoop = 1; nLoop <= nCount; nLoop++) {
            cont = new Contact(
                AccountId = acctLIST[nLoop-1].Id,
                FirstName = 'FirstName' + string.valueOf(nLoop),
                LastName = 'LastName' + string.valueOf(nLoop)+ System.now(),
                //Contact_Status__c = strStatus,
                email = 'FirstName' + string.valueOf(nLoop) + '.LastName' + string.valueOf(nLoop) + '@EXAMPLE.com',
                MailingStreet = acctLIST[nLoop-1].BillingStreet,
                MailingCity = acctLIST[nLoop-1].BillingCity,
                MailingPostalCode = acctLIST[nLoop-1].BillingPostalCode,
                MailingCountry = acctLIST[nLoop-1].BillingCountry,
                RecordTypeID = rtID);
            contLIST.add(cont);
        } // END for (integer nLoop = 1; nLoop <= nCount; nLoop++)
        insert contLIST;
        system.debug('Inserted Contact Test LIST: ' + contLIST);
        tds.contLIST = contLIST;
        
        //return contLIST;
        
        return tds;
    } // END getTestContact
    
    public static User createTestUser(string strProfileName, string strYourTestMethod) {
		// (strYourTestMethod is to keep the user Unique in case of asynchronous tests)
        
        Profile prof = [select Id, Name from Profile where Name = :strProfileName LIMIT 1];
        User usr = new User(
            UserName = strYourTestMethod + '@yourcompany.com',
            FirstName = 'Test-First-Name',
            LastName = 'Test-Last-Name',
            isActive = true,
            Alias = 'test',
            Email = strYourTestMethod + '@yourcompany.com',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocalesIdKey = 'en_US',
            TimezonesIdKey = 'America/Los_Angeles',
            ProfileId = prof.Id
        );
        return usr;
        
    } // END createTestUser
}