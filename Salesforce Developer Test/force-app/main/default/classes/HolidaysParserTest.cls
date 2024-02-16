@isTest
public class HolidaysParserTest {
    @testSetup
    static void setup() {
        TestDataFactory.createNationalHoliday(Date.today());
    }


    @isTest
    static void parseResponseFromBrasilApiWithHolidaysListSuccess() {
        String response = '[{"date":"2024-01-01","name":"Confraternização mundial","type":"national"},{"date":"2024-02-13","name":"Carnaval","type":"national"}]';
        Test.startTest();
        List<National_Holidays__c> parsedData= HolidaysParser.parseResponseToNationalHolidays(response);
        Test.stopTest();

        System.assertEquals(2, parsedData.size());
    }

    @isTest
    static void parseResponseFromBrasilApiWithHolidaysListInvalidKey() {
        String response = '[{"date":"2024-01-01","name":"Confraternização mundial","type":"national", "invalidKey":"invalidValue"},{"date":"2024-02-13","name":"Carnaval","type":"national", "invalidKey":"invalidValue"}]';
        Boolean exceptionLaunched = false;
        try {         
            Test.startTest();
                List<National_Holidays__c> parsedData= HolidaysParser.parseResponseToNationalHolidays(response);
            Test.stopTest();
        } catch (Exception e) {
            exceptionLaunched = true;
        }

        System.assert(true, exceptionLaunched);
    }
}