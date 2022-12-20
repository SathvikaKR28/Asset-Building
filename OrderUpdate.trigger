trigger OrderUpdate on OrderItem(before Update){
	if(checkRecursive.runOnce()){
   		Map<Id, OrderItem> itemmap = trigger.newMap;			//Itemmap is the variable used for the incoming records from Trigger
   		System.debug('Trigger Map is ' + itemmap);				//This debug statement is used for testing the trigger.newmap records
   		//System.debug(itemmap.get('8028W00000H77wYQAR'));		//This debug statement is specefic for OrderNumber 00000215 to check values
   		fetchOrderItem.fieldsofOrderItem(itemmap);				//This class calls a method which uses SOQL once
        //fetchOrderItem.updateroderitemdescription(itemmap);		//This class again calls a different method but SOQL is not used again
        //OrderItemCPQMessageUpdate.updateCPQMessage(itemmap);	//This class also calls a method but once again SOQL is not used again
        //fetchOrderItem.checkdatatype(itemmap);
        System.debug('*CHECK');									//End of Trigger Operation
    }
}