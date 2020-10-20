@IsTest (SeeAllData=false) 
public with sharing class C501_TEST_Update_Fund_Spenddown {

    @IsTest
    static void testFundSpendown() {

        Test.startTest();

        User thisUser = [
            SELECT Id FROM User
            WHERE Id = :UserInfo.getUserId()
            LIMIT 1]; 

        System.runAs(thisUser) {
            Campaign facilityFundSource = C501_Test_Utility.createTestVolCampaign('Volunteer Campaign', 'Test Vol Campaign');
            insert facilityFundSource;
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown facilityFundSource: ' + facilityFundSource);
            
            List<Contact> facilityContactList = C501_Test_Utility.createTestContact(null, 'Facility', 1);
            insert facilityContactList;
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown facilityContactList: ' + facilityContactList);

            C501_Facility_Shift_Fund_Status__c facilityFundStatus = C501_Test_Utility.createfacilityFundStatus(
                facilityContactList[0].Id,
                facilityFundSource.Id);
            insert facilityFundStatus;
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown facilityFundSource: ' + facilityFundSource);

            List<Contact> substituteContactList = C501_Test_Utility.createTestContact(null, 'Contact', 1);
            insert substituteContactList;
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown substituteContactList: ' + substituteContactList);

            GW_Volunteers__Volunteer_Job__c job = C501_Test_Utility.createTestVolJob(
                'Test Job',
                facilityContactList[0].Id,
                facilityFundSource.Id,
                facilityFundStatus.Id,
                System.NOW().addDays(7));
            insert job;
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown job: ' + job);

            GW_Volunteers__Volunteer_Shift__c shift = [
                SELECT Id, GW_Volunteers__Duration__c
                FROM GW_Volunteers__Volunteer_Shift__c
                WHERE GW_Volunteers__Volunteer_Job__c=:job.Id
                LIMIT 1];
            //insert shift;

            List<GW_Volunteers__Volunteer_Hours__c> insertHours = new List<GW_Volunteers__Volunteer_Hours__c>();
            List<String> hourStatusList = new List<String> {'Confirmed'};
            for (String hourStatus :hourStatusList) {
                insertHours.add(C501_Test_Utility.createJobHour(
                    substituteContactList[0].Id,
                    job.Id,
                    shift.Id,
                    hourStatus,
                    System.TODAY().addDays(7),
                    shift.GW_Volunteers__Duration__c));
            }
            insert insertHours;

            GW_Volunteers__Volunteer_Job__c jobUpdated = [
                SELECT Id, C501_Confirmed_Hours__c, GW_Volunteers__Number_of_Volunteers_Still_Needed__c
                FROM GW_Volunteers__Volunteer_Job__c
                LIMIT 1];

            System.assert(jobUpdated.C501_Confirmed_Hours__c == 1);
            System.assert(jobUpdated.GW_Volunteers__Number_of_Volunteers_Still_Needed__c == 1);

            C501_Facility_Shift_Fund_Status__c facilityFundStatusBefore = [
                SELECT Id, C501_Available_Hours__c, C501_Pending_Hours__c
                FROM C501_Facility_Shift_Fund_Status__c
                LIMIT 1];
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown facilityFundStatusBefore: ' + facilityFundStatusBefore);

            C501_Update_Fund_Spenddown.updateFundStatus(new List<Id> {facilityContactList[0].Id});
            
            C501_Facility_Shift_Fund_Status__c facilityFundStatusUpdated = [
                SELECT Id, C501_Available_Hours__c, C501_Pending_Hours__c, C501_Requested_Hours__c
                FROM C501_Facility_Shift_Fund_Status__c
                LIMIT 1];
            System.debug(LoggingLevel.DEBUG, '*****C501_TEST_Update_Fund_Spenddown::testFundSpendown facilityFundStatusUpdated: ' + facilityFundStatusUpdated);
            
            System.assert(facilityFundStatusUpdated.C501_Available_Hours__c == 48, 'Available Hours: ' +
                string.valueOf(facilityFundStatusUpdated.C501_Available_Hours__c));
            //System.assert(facilityFundStatusUpdated.C501_Requested_Hours__c==2,'Requested Hours: '+string.valueOf(facilityFundStatusUpdated.C501_Requested_Hours__c));
        }

        Test.stopTest();
    }
}