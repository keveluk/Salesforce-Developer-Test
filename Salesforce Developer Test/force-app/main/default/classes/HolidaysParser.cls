public class HolidaysParser {

	public static National_Holidays__c holidaysConverter(JSONParser parser) {
        National_Holidays__c obj = new National_Holidays__c();
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'date') {
						obj.Date__c = Date.valueOf(parser.getText());
					} else if (text == 'name') {
						obj.Name = parser.getText();
					} else if (text == 'type') {
						obj.Type__c = parser.getText();
					} else {
                        consumeObject(parser);
                        throw new IntegrationException('HolidaysParser consuming unrecognized property: '+text);
					}
				}
			}
		}
        return obj;
	}
	
	
	public static List<National_Holidays__c> parseResponseToNationalHolidays(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return arrayOfHolidaysParser(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

    private static List<National_Holidays__c> arrayOfHolidaysParser(System.JSONParser p) {
        List<National_Holidays__c> res = new List<National_Holidays__c>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(holidaysConverter(p));
        }
        return res;
    }


}