public with sharing class FetchOrderItem {						//This is a class of execution
    
    //This static map contains the already fetched sObject records and doesn't allow SOQL to run again.
public static Map<Id,SObject> cachedSObjectByIds = new Map<Id, SObject>();

    //The Query is formulated to obtain the 15 rows of OrderLine Items from the map of trigger.update
public static String objName = 'OrderItem';
public static List<String> fieldName = new List<String>{'vlocity_cmt__JSONAttribute__c'};
public static String condition = 'LIMIT 1';

    //The following method calls one class UTILS just to fetch and check if SOQL is running correctly or not
public static Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> fieldsofOrderItem(Map<Id,OrderItem> m){
    System.debug('HEAP SIZE BEFORE QUERY ' + Limits.getHeapSize());
    Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> fetchedRecords = UTILS.getItemsAttributes(cachedSObjectByIds,m.keyset(),objName, fieldName,condition);
    System.debug('fetched Map with Id and JSON Wrapper is:::' + fetchedRecords);
    return fetchedRecords;
}

}