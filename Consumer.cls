public class Consumer{
    public static Map<SObject> mapoffetchedrecords = new Map<SObject>(); // A Map tp store the records already fetched
    public static Map<Id, OrderItem> mapforid = new Map<Id, OrderItem>([SELECT Id FROM OrderItem LIMIT 10]); //Map needed for generating a Set of Id
    public static Set<Id> setofids = mapforid.keyset(); // The set of ID which is used to check if record is present or not
    
    public static String objName = 'OrderItem'; // The object on which we need to operate
    public static List<String> fieldName = new List<String>{'vlocity_cmt__JSONAttribute__c'}; //The fields needed
    public static String condition; //The condition on which SOQL should run
    /*
        List<Id> listofkeys = new List<Id>();
        listofkeys.addAll(mapforid.keyset());
        public static String condition = 'WHERE Id = \'' + String.valueOf(listofkeys[0])+'\'';
    */

    public static Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> usage(Map<SObject> mapoffetchedrecords){
        Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> outputMap = UTILS.getItemsAttributes(mapoffetchedrecords, setofIds, objName, fieldName, condition);
        return outputMap;
    }
}