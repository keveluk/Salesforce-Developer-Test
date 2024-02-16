@isTest
public with sharing class BrasilAPIIntegrationHandlerTest {
    @isTest
    static void makeApiCalloutSuccess200() {
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        Boolean exceptionLaunched = false;
        try {         
            Test.startTest();
            BrasilAPIIntegration.updateNationalHolidays(2024);        
            Test.stopTest();
        } catch (Exception e) {
            exceptionLaunched = true;
        }
            
        System.assertEquals(false, exceptionLaunched);
    }
    @isTest
    static void makeApiCalloutFail404() {
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        Boolean exceptionLaunched = false;
        try {         
            Test.startTest();
            BrasilAPIIntegration.updateNationalHolidays(3000);        
            Test.stopTest();
        } catch (Exception e) {
            exceptionLaunched = true;
        }
            
        System.assertEquals(true, exceptionLaunched);
    }
    @isTest
    static void makeApiCalloutFail500() {
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        Boolean exceptionLaunched = false;
        try {         
            Test.startTest();
            BrasilAPIIntegration.updateNationalHolidays(0);            
            Test.stopTest();
        } catch (Exception e) {
            exceptionLaunched = true;
        }

        System.assertEquals(true, exceptionLaunched);
    }
}