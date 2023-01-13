trigger OrderUpdate on OrderItem (before Update) {
	if(checkRecursive.runOnce()){
   		Map<Id, OrderItem> itemmap = trigger.newMap;			//Itemmap is the variable used for the incoming records from Trigger
   		System.debug('Trigger Map is ' + itemmap);				//This debug statement is used for testing the trigger.newmap records
   		fetchOrderItem.fieldsofOrderItem(itemmap);				//This class calls a method which uses SOQL once
        System.debug('*CHECK');									//End of Trigger Operation
    }
}