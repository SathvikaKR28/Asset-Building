public with sharing class fetchOrderItem {						//This is a class of execution
    
    	//This static map contains the already fetched sObject records and doesn't allow SOQL to run again.
    public static Map<Id,SObject> cachedSObjectByIds = new Map<Id, SObject>();
    
        //The Query is formulated to obtain the 15 rows of OrderLine Items from the map of trigger.update
    public static String objName = 'OrderItem';
    public static List<String> fieldName = new List<String>{'vlocity_cmt__JSONAttribute__c'};
    public static String condition = 'LIMIT 15';

		//The following method calls one class UTILS just to fetch and check if SOQL is running correctly or not
    public static Map<Id, Map<String, VlocityJSONParseUtil.JSONWrapper>> fieldsofOrderItem(Map<Id,OrderItem> m){
        System.debug('HEAP SIZE BEFORE QUERY ' + Limits.getHeapSize());
        Map<Id, Map<String, VlocityJSONParseUtil.JSONWrapper>> fetchedRecords = UTILS.getItemsAttributes(cachedSObjectByIds,m.keyset(),objName, fieldName,condition);
        System.debug('fetched Map with Id and JSON Wrapper is:::' + fetchedRecords);
        return fetchedRecords;
    }
    
    	//The following method calls UTILS class again and we obtain that SOQL is not running again
		//Also this method changes the description of newly fetched records
    public static List<orderItem> updateroderitemdescription(Map<Id,OrderItem> m){
        List<OrderItem> fetchedRecords = UTILS.findByIds(cachedSObjectByIds,m.keyset(),objName, fieldName,condition);
        System.debug('ABC' + fetchedRecords);//change the name of object newly created
        for(OrderItem a : fetchedRecords){
            a.Description = 'Newly Added and Description Updated';
            System.debug('Order Item' + a);
        }
        return fetchedRecords;
    }
}