@isTest
global class BrasilAPICalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {        
        HTTPResponse res = new HTTPResponse();       
        
        String requestUrl = req.getEndpoint();
        Pattern pattern = Pattern.compile('\\d+$');
        Matcher matcher = pattern.matcher(requestUrl);
        Integer year;        
        matcher.find();        
        year = Integer.valueOf(matcher.group());       


        if ((year >= 1900 && year <= 2199) &&  year != 1 && year != 0) {

            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"date":"2024-01-01","name":"Confraternização mundial","type":"national"}]');
            res.setStatusCode(200);

        } else if ((year < 1900 || year > 2199) &&  year != 1 && year != 0) {
            
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"message":"Ano fora do intervalo suportado entre 1900 e 2199.","type":"feriados_range_error","name":"NotFoundError"}');
            res.setStatusCode(404);
        } else if (year == 0) {
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"message":"Erro ao calcular feriados.","type":"feriados_error","name":"InternalError"}');
            res.setStatusCode(500);

        }else if(year == 1){            
            CalloutException e = (CalloutException)CalloutException.class.newInstance();
            e.setMessage('Exception caused by some unexpected error during callout');
            throw e;
        }
        
        return res;
    }
}
