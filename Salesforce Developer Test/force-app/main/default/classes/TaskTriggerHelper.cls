public with sharing class TaskTriggerHelper {
    public static void checkIfTaskDateIsHoliday ( List<Task> newTasks)
    {
        List<National_Holidays__c> holidays = [SELECT Date__c FROM National_Holidays__c];
        Set<Date> holidayDates = new Set<Date>();
        for(National_Holidays__c holiday : holidays) {
            holidayDates.add(holiday.Date__c);
        }
        for(Task task : newTasks) {
            if(holidayDates.contains(task.ActivityDate)) {
                task.Is_Holiday__c = true;
            } else {
                task.Is_Holiday__c = false;
            }
        }
    }
}