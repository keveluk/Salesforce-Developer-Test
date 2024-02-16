public with sharing class BrasilAPIIntegrationHandler {
    
    public static void handleResponse(HttpResponse response) {        
        Integer statusCode = response.getStatusCode();
        if (statusCode == 200) {
            try {
                insert HolidaysParser.parseResponseToNationalHolidays(response.getBody());      
            } catch (Exception e) {
                throw new IntegrationException('Error parsing JSON response');
            }         

        } else if (statusCode == 404) {

            BrasilAPIHttpError error = (BrasilAPIHttpError)JSON.deserialize(response.getBody(), BrasilAPIHttpError.class);
            throw new IntegrationException(error.message);

        } else if (statusCode == 500) {
            
            BrasilAPIHttpError error = (BrasilAPIHttpError)JSON.deserialize(response.getBody(), BrasilAPIHttpError.class);
            throw new IntegrationException(error.message);
        }
    }

    public class BrasilAPIHttpError {
        public String type;
        public String message;
        public String name;
    }
}
