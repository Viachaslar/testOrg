public with sharing class ProductTriggerHandler extends TriggerHandler {

    public override void beforeInsert() {
        for (Product2 product : (List<Product2>) Trigger.new) {
            switch on product.ProductCode {
                when 'A1020' {
                    product.Family = 'Arduino Board';
                }
                when 'O1080' {
                    product.Family = 'Other Board';
                }
                when 'O1020' {
                    product.Family = 'Other Board';
                }    
                when 'A1040' {
                    product.Family = 'Arduino Board'; 
                }
                when 'O1040' {
                    product.Family = 'Other Board';
                }
                when 'O1060' {
                    product.Family = 'Other Board';
                }
                when 'O2020' {
                    product.Family = 'Other Board';
                }
                when 'O2040' {
                    product.Family = 'Other Board';
                }
                when 'A1060' {
                    product.Family = 'Arduino Board';
                }
                when else {
                    System.debug('Product Code Null');
                }                          
            }
        }
    }

}