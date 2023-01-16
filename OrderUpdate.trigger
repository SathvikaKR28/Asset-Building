trigger OrderUpdate on OrderItem (before Update) {
	if(checkRecursive.runOnce()){
		Map<Id, OrderItem> itemmap = trigger.newMap;			//Itemmap is the variable used for the incoming records from Trigger
		System.debug('Trigger Map is ' + itemmap);				//This debug statement is used for testing the trigger.newmap records
		//This static map contains the already fetched sObject records and doesn't allow SOQL to run again.
	 Map<Id,SObject> cachedSObjectByIds = new Map<Id, SObject>();
	 fetchOrderItem.fieldsofOrderItem(itemmap, cachedSObjectByIds);
	 MapOfStringWrapper.displaymap(itemmap, cachedSObjectByIds); //This class calls a method which uses SOQL onceSystem.debug('*CHECK');									//End of Trigger Operation
    }
}