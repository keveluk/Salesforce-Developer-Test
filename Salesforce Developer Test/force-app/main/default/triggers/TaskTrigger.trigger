trigger TaskTrigger on Task (before insert) {
    TaskTriggerHandler handler = new TaskTriggerHandler();

    if( Trigger.isInsert ){
        if(Trigger.isBefore) {
            handler.OnBeforeInsert(trigger.New);
        }
    }
}