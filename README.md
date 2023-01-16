# Asset-Building

Goal: To minimize the heap size by using static map.


##Need to check with JSONParseUtilClass that the output is in required format

##Add JSONParseUtilClass in Utils class as a method used.


##The file which contains main CODDE is the UTILS class
##UTILS class can be reused in such a way that user needs to call the getItemsAttributes method
##with 2 input parameters 
##      - one is a static map which stores the fetched records(It needs to be an empty map so as to check that there are no multiple SOQL running to fetch records)
##      - other one is a Map<Id, SOBJECT> which undergo the operation or execution


##As a part of execution, we have a trigger, named OrderUpdate, calling 2 classes 
##The trigger calls 2 classes of execution after an order is updated.
##The 2 classes are FetchOrderItem and MapOfStringWrapper
## As a part of result, we see that there is only 1 SOQL query running and fetching data even when we needed the records twice
##Also The output is in the form of a Map<Id, Map<String,JSONWrapperClass>> 