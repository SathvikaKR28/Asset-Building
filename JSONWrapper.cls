public class JSONWrapper{
        public String attributeId {get;set;}
        public String attributeName {get;set;}
        public String value {get;set;}
        public String selectedPicklistValueNCId {get;set;}
        // Added to get the SelectedPicklistValue
        public String selectedPicklistValue {get;set;}
        public String dataType {get;set;}
        public boolean isHiddenOnUI {get;set;}
    	public List<OrderItemWrapper> ATT_CODE_IS {get;set;}
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
    public class OrderItemWrapper{
        public boolean ishidden {get;set;}
    }
    
}