public class OpportunityTriggerHandler extends TriggerHandler{

  final static Id RECTYPECAMPUS = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('DIY Campus Sale').getRecordTypeId();
  final static Id RECTYPEGROUP = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('DIY Group Sale').getRecordTypeId();
    

    public override void beforeInsert() {
        List<Id> wonOpp = new List<Id>();
        List<Id> otherOpp = new List<Id>();
        List<Account_Interest__c> acInterests = new List<Account_Interest__c>();

        for (Opportunity opp : (List<Opportunity>)Trigger.new) {
                if (opp.Number_of_Students__c > 50) {
                    opp.recordTypeId = RECTYPECAMPUS;
                }
                else {
                    opp.recordTypeId = RECTYPEGROUP;
                }
                if (opp.StageName == 'Closed Won') {
                    wonOpp.add(opp.Id);
                }
                else {
                    otherOpp.add(opp.Id);
                }
        }
        system.debug('opp:' + wonOpp);
        
        if (!wonOpp.isEmpty()) {
            for (OpportunityLineItem OLI : [SELECT Id, Name, OpportunityId, Product2Id FROM OpportunityLineItem WHERE OpportunityId IN : wonOpp]) {
                system.debug('OLI' + OLI);     
                Account_Interest__c acInt = new Account_Interest__c(Deal_Link__c = OLI.OpportunityId, Product__c = OLI.Product2Id);
                acInterests.add(acInt);
            }
            system.debug('AccInterests1' + acInterests);
           insert acInterests;
     
        }
        if (!otherOpp.isEmpty()) { 
            List<Account_Interest__c> interToDelete = [SELECT Id FROM Account_Interest__c WHERE Deal_Link__c IN : otherOpp];
            if (!interToDelete.isEmpty()) {
                delete interToDelete;
            }
           
        }       

    }

    public override void beforeUpdate() {
        List<Id> wonOpp = new List<Id>();
        List<Id> otherOpp = new List<Id>();
        List<Account_Interest__c> acInterests = new List<Account_Interest__c>();

        for (Opportunity opp : (List<Opportunity>)Trigger.new) {
                if (opp.Number_of_Students__c > 50) {
                    opp.recordTypeId = RECTYPECAMPUS;
                }
                else {
                    opp.recordTypeId = RECTYPEGROUP;
                }
                if (opp.StageName == 'Closed Won') {
                    wonOpp.add(opp.Id);
                }
                else {
                    otherOpp.add(opp.Id);
                }
        }
        system.debug('opp:' + wonOpp);
        
        if (!wonOpp.isEmpty()) {
            for (OpportunityLineItem OLI : [SELECT Id, Name, OpportunityId, Product2Id FROM OpportunityLineItem WHERE OpportunityId IN : wonOpp]) {
                system.debug('OLI' + OLI);     
                Account_Interest__c acInt = new Account_Interest__c(Deal_Link__c = OLI.OpportunityId, Product__c = OLI.Product2Id);
                acInterests.add(acInt);
            }
            system.debug('AccInterests1' + acInterests);
           insert acInterests;
     
        }
        if (!otherOpp.isEmpty()) { 
            List<Account_Interest__c> interToDelete = [SELECT Id FROM Account_Interest__c WHERE Deal_Link__c IN : otherOpp];
            if (!interToDelete.isEmpty()) {
                delete interToDelete;
            }
           
        }
    }
}