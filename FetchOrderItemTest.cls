@isTest
public with sharing class FetchOrderItemTest {
    @IsTest
    static void fetchOrderItemTest(){
        
        Test.startTest();
        Map<Id,OrderItem> orderItemMap = new Map<Id,OrderItem>([SELECT Id FROM OrderItem LIMIT 10]);
    	List<orderItem> om  = fetchOrderItem.fieldsofOrderItem(orderItemMap);
        System.debug('Order Item List  ' +om);
        System.debug('SIZE  ' + om.size());
        System.assert(om.isEmpty(), 'List cannot be empty');
        System.assert(om.size()==1, '1 Objects are currently being used');
        System.assert(om.size()>1, 'More than 1 Objects are currently being used');
        Test.stopTest();
    }
}