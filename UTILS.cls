public with sharing class UTILS {
    
    //The Object Name and field names are fed as an input from the classes of execution
    //This method calls a dynamic query
    public static List<SObject> getObjectAndFieldNames(String objName, List<String> fieldNames, String condition){
        List<SObject> records;
        //This String runs the dynamic query
        String query = String.join(								
            new List<String>{
                'SELECT',
                String.join(fieldNames,','),
                'FROM',
                objName,
                condition
            }, 
            ' '
        );
        records = Database.query(query);
        return records;        
    }

    //Method that holds the static map values of Id and the current sObject
    public static List<SObject> findByIds(Map<Id,sObject> cachedSObjectByIds, Set<Id> ids,String objName, List<String> fieldNames,String condition) 
    { 
        Boolean newsObjectLoadNeeded = false;						//This flag indicates the presence of any fetched record
        for (Id sObjectId : ids) 
        { 
            if (!cachedSObjectByIds.containsKey(sObjectId)) 
            {
                 newsObjectLoadNeeded = true;
                 System.debug('New QUERY will run to fetch the sObject Record');
                 break;
            } 
        }
        if (newsObjectLoadNeeded)
        	{
                cachedSObjectByIds.putAll(getObjectAndFieldNames(objName,fieldNames,condition));   //if new sObject is loaded: then it is feeded in the map
			}
   		return cachedSObjectByIds.values(); 
    }
    
    // Method to get the generic attributes in the form of sObject
    public static Map<Id,Map<String,VlocityJSONParseUtil.JSONWrapper>> getItemsAttributes(Map<Id,sObject> cachedSObjectByIds, Set<Id> ids,String objName, List<String> fieldNames,String condition){
        Map<Id, Map<String,VlocityJSONParseUtil.JSONWrapper>> objItemsAttributesMap = new Map<Id, Map<String,VlocityJSONParseUtil.JSONWrapper>>();
        List<SObject> orderitemlist = new List<SObject>(findByIds(cachedSObjectByIds, ids, objName, fieldNames, condition));
			for(SObject ordItem : orderitemlist){
                Map<String,VlocityJSONParseUtil.JSONWrapper> tempMap = VlocityJSONParseUtil.getAttributesFromJSON(CheckJson.checkjsonparse(ordItem));
                objItemsAttributesMap.put(ordItem.Id,tempMap );
            } 
        return objItemsAttributesMap;
     }
}