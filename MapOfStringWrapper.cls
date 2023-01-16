public class MapOfStringWrapper {       //This is a class of Execution
    public static String objName = 'OrderItem';
    public static List<String> fieldName = new List<String>{'vlocity_cmt__JSONAttribute__c'};

    public static List<Map<String, VlocityJSONParseUtil.JSONWrapper>> displaymap(Map<Id,OrderItem> m, Map<Id,SObject> cachedSObjectByIds){
        System.debug('HEAP SIZE BEFORE QUERY ' + Limits.getHeapSize());
        List<Id> listofkeys = new List<Id>();
        listofkeys.addAll(m.keyset());
        String condition = 'WHERE Id = \'' + String.valueOf(listofkeys[0])+'\'';
		Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> fetchedRecords = UTILS.getItemsAttributes(cachedSObjectByIds,m.keyset(),objName, fieldName,condition);
        System.debug('fetched Map with Id and JSON Wrapper is:::' + fetchedRecords);
        System.debug('HEAP SIZE AFTER QUERY ' + Limits.getHeapSize());
        List<Map<String, VlocityJSONParseUtil.JSONWrapper>> listoforderitems = new List<Map<String, VlocityJSONParseUtil.JSONWrapper>>();
        listoforderitems = fetchedRecords.values();
        return listoforderitems;
    }
}