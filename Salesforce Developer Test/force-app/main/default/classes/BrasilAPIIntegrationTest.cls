@isTest
public with sharing class BrasilAPIIntegrationTest {
    
    @isTest
    static void makeApiCalloutSuccess() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        BrasilAPIIntegration.updateNationalHolidays(2024);
        Test.stopTest();

        List<National_Holidays__c> holidays = [SELECT Id FROM National_Holidays__c];

        System.assertEquals(1, holidays.size());
    }
    @isTest
    static void makeApiCalloutException() {
        Boolean exceptionLaunched = false;
        try {         
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
            BrasilAPIIntegration.updateNationalHolidays(1);
            
            Test.stopTest();
        } catch (Exception e) {
            exceptionLaunched = true;
        }

        System.assertEquals(true, exceptionLaunched);
    }

}