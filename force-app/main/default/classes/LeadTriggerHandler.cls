public with sharing class LeadTriggerHandler extends TriggerHandler {
    
    public enum LeadScoringAttributes {WINTER, SPRING, SUMMER, FALL}
    
    public override void beforeInsert() {
        for(Lead l : (List<Lead>) Trigger.new) {
          //Logic
        }
    }

}