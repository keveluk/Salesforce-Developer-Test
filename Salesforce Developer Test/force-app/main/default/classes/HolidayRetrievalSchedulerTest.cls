@isTest
private class HolidayRetrievalSchedulerTest {
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
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new BrasilAPICalloutMock());
        HolidayRetrievalScheduler scheduler = new HolidayRetrievalScheduler();
        scheduler.execute(null); 
        Test.stopTest();
    }
}
