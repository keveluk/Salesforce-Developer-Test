import { LightningElement, wire } from 'lwc';
import getNationalHolidays from '@salesforce/apex/NationalHolidaysController.getNationalHolidays';

export default class NationalHolidays extends LightningElement {
    holidays;
    error;
    holidayName;
    isHoliday;


    @wire(getNationalHolidays)
    wiredHolidays({ error, data }) {
        if (data) {
            if(data.length == 0){
                this.holidays = false;
            }else{
                console.log('data')
                console.log(data)
                this.holidays = data;
                this.error = undefined;
                this.verifyHoliday();
                this.holidays =  this.holidays.map(holiday => {
                    return {
                        ...holiday,
                        formattedDate: this.formattedDate(holiday.Date__c),
                        countdown: this.calculateCountdown(holiday.Date__c) == 0 ? 'TODAY': this.calculateCountdown(holiday.Date__c),
                        isHoliday: this.calculateCountdown(holiday.Date__c) == 0 ? true: false
                    };
                })   
            }
            
        
        } else if (error) {
            this.error = error.body.message;
            this.holidays = undefined;
        }
    }

    verifyHoliday() {
        let today = new Date().toISOString().split('T')[0];        
        this.holidays.some(holiday => {
            if(holiday.Date__c === today){
                this.isHoliday = true;
                this.holidayName = holiday.Name;
            }
            
        });
    }

    formattedDate(dateString) {
        let options = { day: '2-digit', month: '2-digit', year: 'numeric' };
        let dateParts = dateString.split('-');
        let year = parseInt(dateParts[0]);
        let month = parseInt(dateParts[1]) - 1; 
        let day = parseInt(dateParts[2]);


        let date = new Date(year, month, day);


        let formattedDate = new Intl.DateTimeFormat('pt-BR', {
            timeZone: 'America/Sao_Paulo',
            ...options
        }).format(date);

        return formattedDate;
    }

    calculateCountdown(dateString) {
        let dateParts = dateString.split('-');
        let year = parseInt(dateParts[0]);
        let month = parseInt(dateParts[1]) - 1;
        let day = parseInt(dateParts[2]);

        let holidayDate = new Date(year, month, day);
        let today = new Date();
        let dateOnly = new Date(today.getFullYear(), today.getMonth(), today.getDate());

        if(holidayDate.getMonth() == dateOnly.getMonth() && holidayDate.getDay() == dateOnly.getDay()){
            return 0;
        }else{
            let oneDay = 24 * 60 * 60 * 1000; 
            let diffDays = Math.round(Math.abs((today - holidayDate) / oneDay));
            return diffDays +1;
        }
    }
}