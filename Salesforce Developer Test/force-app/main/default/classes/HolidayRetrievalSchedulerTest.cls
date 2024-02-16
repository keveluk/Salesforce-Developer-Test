@isTest
private class HolidayRetrievalSchedulerTest {
    @TestSetup
    static void makeData(){
        

    }

    @isTest
    static void testScheduleAtJob() {        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        HolidayRetrievalScheduler.scheduleAt(2024, 2, 17, 12, 0);
        Test.stopTest();        

        List<CronTrigger> cronTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Holiday Retrieval Job'];       

        System.assertEquals(1, cronTriggers.size());
    }

    @isTest
    static void testScheduleJob() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        HolidayRetrievalScheduler.schedule();
        Test.stopTest();
        
        List<CronTrigger> cronTriggers = [SELECT Id FROM CronTrigger WHERE CronJobDetail.Name = 'Holiday Retrieval Job'];
    
        System.assertEquals(1, cronTriggers.size());
    }

    @isTest
    static void testExecuteMethod() {
        // Call the execute method directly
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        HolidayRetrievalScheduler scheduler = new HolidayRetrievalScheduler();
        scheduler.execute(null); // Pass null for SchedulableContext since it's not used in the method
        Test.stopTest();

        // Optionally, add assertions to verify the expected behavior of the execute method
        // For example, you can verify if the expected debug message is logged or if other logic inside the execute method behaves as expected
    }
}
