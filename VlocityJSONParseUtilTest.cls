@isTest(SeeAllData=true)
public class VlocityJSONParseUtilTest {
    @isTest(SeeAllData=true)
    static void JSONParse(){
        
        Test.startTest();
        List<OrderItem> orderItemList = [SELECT vlocity_cmt__JSONAttribute__c FROM OrderItem LIMIT 1];                             
        System.debug('orderItemList' +orderItemList);				//Fetched List of Order Item containing JSON Attributes
        String jsonStr = String.join(orderItemList,',');
        System.debug('jsonStr' +jsonStr);
        		//CheckJson class converts the JSON Attribute in required formatr
		System.debug(VlocityJSONParseUtil.getAttributesFromJSON(CheckJson.checkjsonparse(orderItemList))); 
        System.debug('Attribute field name is:::' + VlocityJSONParseUtil.attributeFieldNameInJSON);
        //VlocityJSONParseUtil.textDataType = 'String';
        //VlocityJSONParseUtil.JSONWrapper();
        //jsonWrapMap.put('attributedisplayname__c',JSONWrapper.attributeName);
        //jsonWrapMap.put('ishidden__c',JSONWrapper.isHiddenOnUI);
        //Set <String> keySetFromMap = new Set<String>();
        //keySetFromMap = jsonWrapMap.keySet();
        //System.debug('keySetFromMap' +keySetFromMap);
        //System.debug('jsonWrapMap' +keySetFromMap);
		Map<String,VlocityJSONParseUtil.JSONWrapper> wrappermap = VlocityJSONParseUtil.getAttributesFromJSON(CheckJson.checkjsonparse(orderItemList));
        System.debug('OUTPUT MAP IS:::' +wrappermap);
		//wrappermap.attributeId;
		//
		/*
	 	JSONWrapper wrapper = VlocityJSONParseUtil.getAttributesFromJSON(jsonStr);
        test.stopTest();
        System.assertNotEquals(null, wrapper);
        System.assertNotEquals(null,wrapper.ATT_CODE_IS[0].ishidden);
		*/
    }
}