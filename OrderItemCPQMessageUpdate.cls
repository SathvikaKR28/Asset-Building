public class OrderItemCPQMessageUpdate {                               //This is a class of Execution

    	
        //The Query is formulated to obtain the 15 rows of OrderLine Items from the map of trigger.update
   	public static String objName = 'OrderItem';
    public static List<String> fieldName = new List<String>{'vlocity_cmt__JSONAttribute__c'};
    public static String condition = 'LIMIT 15';
    
    	//This method again calls UTILS class and check for updation of CPQMessage data without running the SOQL again
    public static List<OrderItem> updateCPQMessage(Map<Id,OrderItem> m){
        System.debug('cachedSObjectByIds'+ fetchOrderItem.cachedSObjectByIds);
        List<OrderItem> fetchedRecords = UTILS.findByIds(fetchOrderItem.cachedSObjectByIds,m.keyset(),objName, fieldName,condition);
        System.debug('ABC' + fetchedRecords);
        for(OrderItem a : fetchedRecords){
            a.vlocity_cmt__ItemName__c = 'Newly Added Line Item';
        }
        System.debug('Updated the CPQ Message Successfully');
        return fetchedRecords;
    }
}