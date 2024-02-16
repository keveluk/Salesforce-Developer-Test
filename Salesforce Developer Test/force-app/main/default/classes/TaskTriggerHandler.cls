public with sharing class TaskTriggerHandler {
    public void OnBeforeInsert(List<Task> newTasks){
        TaskTriggerHelper.checkIfTaskDateIsHoliday(newTasks);
    }
}