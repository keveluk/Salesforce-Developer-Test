public with sharing class BrasilAPIIntegration {
    
    @future(callout=true) public static void updateNationalHolidays(Integer year) {
        String endpoint;
        BrasilApi__c settings = BrasilApi__c.getOrgDefaults();
        if(settings != null) {
            endpoint = settings.Endpoint__c;
        }
        String apiUrl = endpoint + year;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        List<Holiday> holidays = new List<Holiday>();

        request.setEndpoint(apiUrl);
        request.setMethod('GET');
        try {
            HttpResponse response = http.send(request);
            BrasilAPIIntegrationHandler.handleResponse(response);            
        } catch (Exception e) {
            throw new IntegrationException(e.getMessage());
        }
        
    }
}
