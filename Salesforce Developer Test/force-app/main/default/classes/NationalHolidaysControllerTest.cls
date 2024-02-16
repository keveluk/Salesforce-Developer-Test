@isTest
public with sharing class NationalHolidaysControllerTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createNationalHoliday(Date.today());
    }

    @isTest
    static void getHolidaysList() {
        List<National_Holidays__c> holidays = new List<National_Holidays__c>();
        
        Test.startTest();
        holidays = NationalHolidaysController.getNationalHolidays();
        Test.stopTest();

        System.assertEquals(1, holidays.size());
    }

}