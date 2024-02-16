public with sharing class TestDataFactory {

    public static void createNationalHoliday(Date holidayDate) {
        National_Holidays__c holiday = new National_Holidays__c(Date__c = holidayDate, Name = 'Natal', Type__c = 'National');
        insert holiday;
    }

}