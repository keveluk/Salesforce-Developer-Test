@isTest
public with sharing class TaskTriggerTest {

    @TestSetup
    static void makeData(){
        TestDataFactory.createNationalHoliday(Date.newInstance(2024, 12, 25));
    }
    @isTest
    static void checkIfTaskDateIsHolidayFalse() {

        Task newTask = new Task();
        newTask.Subject = 'Follow-up Task';
        newTask.Status = 'Not Started';
        newTask.Priority = 'Normal';
        newTask.ActivityDate = Date.today();
        newTask.OwnerId = UserInfo.getUserId();

        Test.startTest();
        insert newTask;
        Test.stopTest();

        Task task = [SELECT Is_Holiday__c FROM Task WHERE Subject = 'Follow-up Task'];
        System.assertEquals(false, task.Is_Holiday__c);
        
    }
    @isTest
    static void checkIfTaskDateIsHolidayTrue() {

        Task newTask = new Task();
        newTask.Subject = 'Follow-up Task';
        newTask.Status = 'Not Started';
        newTask.Priority = 'Normal';
        newTask.ActivityDate = Date.newInstance(2024, 12, 25);
        newTask.OwnerId = UserInfo.getUserId();

        Test.startTest();
        insert newTask;
        Test.stopTest();

        Task task = [SELECT Is_Holiday__c FROM Task WHERE Subject = 'Follow-up Task'];
        System.assertEquals(true, task.Is_Holiday__c);
        
    }
}