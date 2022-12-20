public class VlocityJSONParseUtil {
    
    public final static string attributeFieldNameInJSON = 'attributedisplayname__c'; 
    public final static string isHiddenAttributeInJSON = 'ishidden__c';
    public final static string isRequiredAttributeInJSON = 'isrequired__c';
    public final static string hasPricingAttributeInJSON = 'has_pricing__c';
    public final static string isReadOnlyAttributeInJSON = 'isreadonly__c';
    public final static string attributeValueFieldNameInJSON = 'value__c';
    public final static string runTimeInfoValueFieldNameInJSON = 'value';
    public final static string attributeRunTimeINfoMapNameInJSON = 'attributeRunTimeInfo';
    public final static string runTimeInfoDefaultFieldNameInJSON = 'default';
    public final static string DefaultDisplayTextFieldNameInJSON = 'displayText';
    public final static string DefaultDisplayTextFieldValueInJSON = 'value';
    public final static string selectedItemMapNameInJSON = 'selectedItem';
    public final static string selectedItemDisplayTextFieldNameInJSON = 'displayText';
    public final static string selectedItemDisplayTextFieldValueInJSON = 'value';
    public final static string selectedItemNCIdJSON = 'id';
    public final static string selectedItemValueFieldNameInJSON = 'value';
    public final static string uiDisplayTypeFieldNameInJSON     = 'uiDisplayType';
    public final static string dataTypeFieldNameInJSON     = 'dataType';
    public final static string picklistDataType     = 'Picklist';
    public final static string checkboxDataType     = 'Checkbox';
    public final static string dropdownDataType     = 'Dropdown';
    public final static string textDataType     = 'Text';
    public final static string numberDataType     = 'Number';
    public final static string radiobuttonDataType     = 'Radiobutton';
    public final static string dateDataType     = 'Date';
    public final static string attributeuniquecodeInJSON  = 'attributeuniquecode__c';
    public final static string attributeIdFieldNameInJSON='attributeid__c';
    public final static string attributeidInJSON  = 'attributeid__c';
    public final static string isCustomerFacingAttribute  = 'show_on_customer_facing_material__c';
    
    //public static Map<String,Map<String,JSONWrapper>>  jsonAttributeCacheMap; //Added as part of caching the Json Attributes in Map
    // This Method will return Map of all attributes in Map.
public static Map<String,JSONWrapper> getAttributesFromJSON(String JSONString){
        System.debug('getAttributesFromJSON');
        System.debug('JSONString: ' + JSONString);
        
        Map<String,JSONWrapper>  JSONAttrMap = new  Map<String,JSONWrapper>();
        if(String.isNotBlank(JSONString)){
            Map<String, Object> attributes =  new Map<String, Object>();
            try{
                attributes = (Map<String, Object>) JSON.deserializeUntyped(JSONString);
            }catch(exception ex){
                // throw ex;
                System.debug('Exception occurred while parsing the json '+ex.getMessage());
                return JSONAttrMap;
            }
            try{
                
            for (String key : attributes.keySet()) {
                System.debug('attributes Key::'+key);
                List<Object> JSONAttriList = (List<Object>)attributes.get(key);
                System.debug('JSONAttriList:'+JSONAttriList);
                if(JSONAttriList !=null){
                for (Object attribute : JSONAttriList) {
                    JSONWrapper JSONWrap = new JSONWrapper();
                    Map<String, Object> attributeMap = (Map<String, Object>) attribute;
                    String attributeName = (String) attributeMap.get(attributeFieldNameInJSON);
                    System.debug('attributeName:'+attributeName);
                    String attributeId=(String) attributeMap.get(attributeIdFieldNameInJSON);
                    System.debug('attributeId:'+attributeId);
                    System.debug('ATTRIBUTEMAP: ' +attributeMap);
                    if(String.isBlank(attributeName)){
                        System.debug('attributeName: ' +attributeName);
                        continue;
                    }
                    System.debug('isHiddenAttributeInJSON:::' +isHiddenAttributeInJSON);
                    //Populate if an Attribute is hidden
                    if(null !=attributeMap.get(isHiddenAttributeInJSON)){
                        JSONWrap.isHiddenOnUI = Boolean.valueOf(attributeMap.get(isHiddenAttributeInJSON));
                        System.debug('JSONWrap.isHiddenOnUI: ' +JSONWrap.isHiddenOnUI);
                    }
                    //Populate if an Attribute is ready only
                    if(null !=attributeMap.get(isReadOnlyAttributeInJSON)){
                        JSONWrap.isReadOnly = Boolean.valueOf(attributeMap.get(isReadOnlyAttributeInJSON));
                        System.debug('JSONWrap.isReadOnly: ' +JSONWrap.isReadOnly);
                    }
                    //Populate if an Attribute is required
                    if(null !=attributeMap.get(isRequiredAttributeInJSON)){
                        JSONWrap.isRequired = Boolean.valueOf(attributeMap.get(isRequiredAttributeInJSON));
                        System.debug('JSONWrap.isRequired: ' +JSONWrap.isRequired);
                    }
                    //Populate if an Attribute has pricing
                    if(null !=attributeMap.get(hasPricingAttributeInJSON)){
                        JSONWrap.hasPricing = Boolean.valueOf(attributeMap.get(hasPricingAttributeInJSON));//Boolean.valueof(attributeMap.get(hasPricingAttributeInJSON))
                        System.debug('JSONWrap.hasPricing: ' +JSONWrap.hasPricing);
                    }
                    //Populate if an Attribute is required
                    if(null !=attributeMap.get(attributeuniquecodeInJSON)){
                        JSONWrap.attributeuniquecode = (String) attributeMap.get(attributeuniquecodeInJSON);
                        System.debug('JSONWrap.attributeuniquecode: ' +JSONWrap.attributeuniquecode);
                    }
                    
                    if(null !=attributeMap.get(attributeidInJSON)){
                        JSONWrap.attributeid = (String) attributeMap.get(attributeidInJSON);
                        System.debug('JSONWrap.attributeid: ' +JSONWrap.attributeid);
                    }
                    System.debug('attributeMap====>'+attributeMap);
                    if(null!=attributeMap.get(isCustomerFacingAttribute)){
                        JSONWrap.isCustomerFacing = Boolean.valueOf(attributeMap.get(isCustomerFacingAttribute));
                        System.debug('JSONWrap.isCustomerFacing: ' +JSONWrap.isCustomerFacing);
                    }
                    //.....................................................................//
                    Object attrRunTimeInfoMap=attributeMap.get(attributeRunTimeINfoMapNameInJSON); 
                    System.debug('attrRunTimeInfoMap' +attrRunTimeInfoMap);
                    String charactersticsValue; 
                    String runTimeInfoCharactersticValue;
                    if(attrRunTimeInfoMap instanceof Map<String,Object>){
                        Map<String,Object> attrRunTimeInfoKeyValMap=(Map<String,Object>)attrRunTimeInfoMap;
                        System.debug('attrRunTimeInfoKeyValMap' +attrRunTimeInfoKeyValMap);
                        String dataType=String.valueOf(attrRunTimeInfoKeyValMap.get(dataTypeFieldNameInJSON));   // string value is : 'dataType'
                        System.debug('dataType' +dataType);
                        if(dataType!=null){
                            if(dataType.equals(checkboxDataType)){ // string value is : 'Checkbox'
                                charactersticsValue=null;
                                String defaultVal=String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoDefaultFieldNameInJSON)); // string value is : 'default'
                                if(defaultVal!=null && defaultVal.equals('true')){
                                    charactersticsValue='Selected';
                                } else{
                                    String selectedOrNot=String.valueOf(attributeMap.get(attributeValueFieldNameInJSON)); // string value is : 'value__c'
                                    if(selectedOrNot!=null && selectedOrNot.equals('Selected')){
                                        charactersticsValue='Selected';
                                    }
                                }
                            }
                            if(dataType.equals(picklistDataType)){ // string value is : 'Picklist'
                                String uiDisplayTypeVal=String.valueOf(attrRunTimeInfoKeyValMap.get(uiDisplayTypeFieldNameInJSON)); // string value is : 'uiDisplayType'
                                if(uiDisplayTypeVal!=null){
                                    if(uiDisplayTypeVal.equals(dropdownDataType)){ // string value is : 'Dropdown'
                                        charactersticsValue=null;
                                        Object selectedItemObj=attrRunTimeInfoKeyValMap.get(selectedItemMapNameInJSON); // string value is : 'selectedItem'
                                        if(selectedItemObj!=null && selectedItemObj instanceof Map<String,Object>){
                                           // Map<String,Object> selectedItemObjMap=(Map<String,Object>)selectedItemObj; commented by yasaswini as it is unused
                                            Map<String,Object> selectedItemMap=(Map<String,Object>)selectedItemObj;
                                            charactersticsValue = String.valueOf(selectedItemMap.get(selectedItemDisplayTextFieldValueInJSON));// String value is 'value'
                                            if(String.isBlank(charactersticsValue)){
                                                charactersticsValue = String.valueOf(selectedItemMap.get(selectedItemDisplayTextFieldNameInJSON)); // string value is : 'displayText'
                                            }
                                            
                                            JSONWrap.selectedPicklistValueNCId =  String.valueOf(selectedItemMap.get(selectedItemNCIdJSON)); // string value is : 'id'
                                            JSONWrap.selectedPicklistValue = String.valueOf(selectedItemMap.get(selectedItemDisplayTextFieldNameInJSON)); // string value is : 'displayText'
                                        }
                                        if(charactersticsValue==null || charactersticsValue.equals('null') || String.isEmpty(charactersticsValue)){
                                            charactersticsValue=null;
                                            List<Object> defaultValList=(List<Object>)attrRunTimeInfoKeyValMap.get(runTimeInfoDefaultFieldNameInJSON); // string value is : 'default'
                                            for(Object defaultValMapObj : defaultValList){
                                                Map<String,Object> defaultValMap = (Map<String,Object> ) defaultValMapObj;
                                                // Added by Arvind to fix Term Issue for "National Internet Premium offer"  
                                                charactersticsValue = String.valueOf(defaultValMap.get(DefaultDisplayTextFieldValueInJSON));// String value is 'value'
                                                if(String.isBlank(charactersticsValue)){
                                                    charactersticsValue = String.valueOf(defaultValMap.get(DefaultDisplayTextFieldNameInJSON)); // string value is : 'displayText'
                                                }
                                                //charactersticsValue = String.valueOf(defaultValMap.get(DefaultDisplayTextFieldNameInJSON));  // string value is : 'displayText'
                                                JSONWrap.selectedPicklistValueNCId =  String.valueOf(defaultValMap.get(selectedItemNCIdJSON)); // string value is : 'id'
                                                JSONWrap.selectedPicklistValue =  String.valueOf(defaultValMap.get(selectedItemDisplayTextFieldNameInJSON)); // string value is : 'displayText'
                                            }
                                        }
                                        //Fix for ETL gap to set default value for a picklist added by Aditya Jamwal
                                        if(charactersticsValue==null || charactersticsValue.equals('null') || String.isEmpty(charactersticsValue)){
                                            charactersticsValue=null;
                                            charactersticsValue= String.valueOf(attributeMap.get(attributeValueFieldNameInJSON)); // string value is : 'value__c'
                                        }
                                    }
                                    if(uiDisplayTypeVal.equals(radiobuttonDataType)){ // string value is : 'Radiobutton'
                                        charactersticsValue=null;
                                        List<Object> defaultValList=(List<Object>)attrRunTimeInfoKeyValMap.get(runTimeInfoDefaultFieldNameInJSON); // string value is : 'default'
                                        for(Object defaultValMapObj : JSONAttriList){
                                            Map<String,Object> defaultValMap = (Map<String,Object> ) defaultValMapObj;
                                            charactersticsValue=String.valueOf(defaultValMap.get(DefaultDisplayTextFieldNameInJSON));  // string value is : 'displayText'
                                        }
                                    }
                                }
                            }
                            if(dataType.equals(textDataType)){ // string value is : 'Text'
                                
                                charactersticsValue= String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON)); // string value is : 'value'
                                if(String.isBlank(charactersticsValue)){
                                    charactersticsValue= String.valueOf(attributeMap.get(attributeValueFieldNameInJSON)); // string value is : 'value'
                                }
                                if(String.isBlank(charactersticsValue)){
                                    charactersticsValue=String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoDefaultFieldNameInJSON)); // string value is : 'default'
                                }
                                
                                runTimeInfoCharactersticValue = String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON));
                                
                            }
                            if(dataType.equals(dateDataType)){ // string value is : 'Date'
                                charactersticsValue= String.valueOf(attributeMap.get(attributeValueFieldNameInJSON)); // string value is : 'value__c'
                                if(String.isBlank(charactersticsValue)){
                                    charactersticsValue=String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoDefaultFieldNameInJSON)); // string value is : 'default'
                                }
                                if(String.isBlank(charactersticsValue)){
                                    charactersticsValue=String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON)); // string value is : 'value'
                                }
                                runTimeInfoCharactersticValue = String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON));
                                JSONWrap.dateTimeValue = attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON);
                            }
                            if(dataType.equals(numberDataType)){ // string value is : 'Number'
                                charactersticsValue= String.valueOf(attributeMap.get(attributeValueFieldNameInJSON)); // string value is : 'value__c'
                                if(String.isBlank(charactersticsValue)){
                                    charactersticsValue=String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoDefaultFieldNameInJSON)); // string value is : 'default'
                                }
                                if(String.isBlank(charactersticsValue)){
                                    charactersticsValue=String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON));  // string value is : 'value'
                                }
                                runTimeInfoCharactersticValue = String.valueOf(attrRunTimeInfoKeyValMap.get(runTimeInfoValueFieldNameInJSON));
                            }
                        }
                        
                        JSONWrap.attributeName = attributeName; 
                        JSONWrap.value = charactersticsValue; 
                        JSONWrap.runTimeInfoValue = runTimeInfoCharactersticValue;
                        JSONWrap.dataType = dataType ;
                        JSONWrap.attributeId=attributeId;
                        JSONAttrMap.put(JSONWrap.attributeId,JSONWrap); //replaced attributeName with attributeId
                    }
                    //.....................................................................//
                }
             }
            }
         }catch(exception ex){
             System.debug('getAttributesFromJSON() ' + ex.getMessage() + ' ' + ex.getStackTraceString());
         }
        }
        System.debug('JSONAttrMap: ' + JSONAttrMap);
        return JSONAttrMap;
    }
	    public class JSONWrapper{
        public String attributeId {get;set;}
        public String attributeName {get;set;}
        public String value {get;set;}
        public String selectedPicklistValueNCId {get;set;}
        // Added to get the SelectedPicklistValue
        public String selectedPicklistValue {get;set;}
        public String dataType {get;set;}
        public boolean isHiddenOnUI {get;set;}
        public boolean isRequired {get;set;}
        public boolean hasPricing {get;set;}
        public boolean isReadOnly {get;set;}
        public String attributeuniquecode {get;set;}
        public String runTimeInfoValue {get;set;}
        public boolean isCustomerFacing {get;set;}
        public Object dateTimeValue{get;set;}
        
        public JSONWrapper(String attributeName,String value,String dataType){
            this.attributeName = attributeName;
            this.value = value;
            this.dataType = dataType;
        }
        public JSONWrapper(){
        }
        public boolean getCustomerFacing(){
            return this.isCustomerFacing;
        }
    }

}