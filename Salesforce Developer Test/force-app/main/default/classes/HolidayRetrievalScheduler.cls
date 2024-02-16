global class HolidayRetrievalScheduler implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        Integer currentYear = Date.today().year();
        BrasilAPIIntegration.updateNationalHolidays(currentYear);

        System.debug('Holiday retrieval job completed for year ' + currentYear);
    }

    public static void Schedule(){
        System.schedule('Holiday Retrieval Job', '0 0 0 1 1 ? *', new HolidayRetrievalScheduler());
    }
    public static void scheduleAt(Integer year, Integer month, Integer day, Integer hour, Integer minute) {
        String cronExp = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ? ' + year;
        System.schedule('Holiday Retrieval Job', cronExp, new HolidayRetrievalScheduler());
    }
}
