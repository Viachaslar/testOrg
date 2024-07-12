public with sharing class OpportunityLineItemTriggerHandler extends TriggerHandler{
    
    public Map <Id, Id> productsFindId = new Map<Id, Id>();  

   
    public override void beforeInsert() { 
        
        for(OpportunityLineItem ol : (List<OpportunityLineItem>) Trigger.new) {
            productsFindId.put(ol.Id, ol.Product2Id);
        }
    
            Map<Id, Product2> productsList = new Map<Id, Product2>([SELECT Family FROM Product2 WHERE Id IN :productsFindId.values()]);
            system.debug(productsList + 'ProductList');
            Map<Id, Product2> prodByOLIKeyMap = new Map<Id, Product2>();
    
        for (Id oliId : Trigger.newMap.keySet()) {
                if (productsFindId.containsKey(oliId)) {
                    prodByOLIKeyMap.put(oliId, productsList.get(productsFindId.get(oliId)));
                }
        }
        for (OpportunityLineItem opLin : (List<OpportunityLineItem>) Trigger.new) {
                opLin.Product_Family_Trigger__c = prodByOLIKeyMap.get(opLin.Id).Family;
                system.debug(opLin.Product_Family_Trigger__c + 'ChangeFamily');
    
        }
    }

    public override void beforeUpdate() {
        
        for(OpportunityLineItem ol : (List<OpportunityLineItem>) Trigger.new) {
        productsFindId.put(ol.Id, ol.Product2Id);
      }

        Map<Id, Product2> productsList = new Map<Id, Product2>([SELECT Family FROM Product2 WHERE Id IN :productsFindId.values()]);
        system.debug(productsList + 'ProductList');
        Map<Id, Product2> prodByOLIKeyMap = new Map<Id, Product2>();

        for (Id oliId : Trigger.newMap.keySet()) {
            if (productsFindId.containsKey(oliId)) {
                prodByOLIKeyMap.put(oliId, productsList.get(productsFindId.get(oliId)));
            }
        }
        for (OpportunityLineItem opLin : (List<OpportunityLineItem>) Trigger.new) {
            opLin.Product_Family_Trigger__c = prodByOLIKeyMap.get(opLin.Id).Family;
            system.debug(opLin.Product_Family_Trigger__c + 'ChangeFamily');

        }
    }
}