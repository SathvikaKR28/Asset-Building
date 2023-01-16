public with sharing class FetchOrderItem {						//This is a class of execution
    public static String objName = 'OrderItem';
    public static List<String> fieldName = new List<String>{'vlocity_cmt__JSONAttribute__c'};
		//The following method calls one class UTILS just to fetch and check if SOQL is running correctly or not
    public static Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> fieldsofOrderItem(Map<Id,OrderItem> m, Map<Id,SObject> cachedSObjectByIds){
        System.debug('HEAP SIZE BEFORE QUERY ' + Limits.getHeapSize());
        List<Id> listofkeys = new List<Id>();
        listofkeys.addAll(m.keyset());
        String condition = 'WHERE Id = \'' + String.valueOf(listofkeys[0])+'\'';
		Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> fetchedRecords = UTILS.getItemsAttributes(cachedSObjectByIds,m.keyset(),objName, fieldName,condition);
        System.debug('fetched Map with Id and JSON Wrapper is:::' + fetchedRecords);
        System.debug('HEAP SIZE AFTER QUERY ' + Limits.getHeapSize());
        return fetchedRecords;
    }

}