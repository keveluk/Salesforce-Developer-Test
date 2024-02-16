public with sharing class NationalHolidaysController {
    @AuraEnabled(cacheable=true)
    public static List<National_Holidays__c> getNationalHolidays() {
        return [SELECT Id, Name, Date__c, Type__c FROM National_Holidays__c  WHERE Date__c >= TODAY ORDER BY Date__c];
    }
}
