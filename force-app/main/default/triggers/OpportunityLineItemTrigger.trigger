trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, before update) {

    new OpportunityLineItemTriggerHandler().run();

}