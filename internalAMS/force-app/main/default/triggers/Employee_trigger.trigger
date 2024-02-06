trigger Employee_trigger on Employee__c (After  insert) {
    if(trigger.isAfter && trigger.isupdate)
    {
        //Employee_Handler.Asset_Assigment_to_employee(trigger.new);
    }

}