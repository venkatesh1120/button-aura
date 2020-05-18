aura component:
<aura:component controller="countctrl" implements="flexipage:availableForRecordHome,force:hasRecordId" access="global" >
    <aura:attribute name="counted" type="integer" />

	<lightning:recordViewForm recordId="{!v.recordId}" objectApiName="Account"  >
    </lightning:recordViewForm>
 <lightning:button label="Show Data" onclick="{!c.getcount}"/>
	You entered: <ui:outputText value="{!v.counted}"/>	
</aura:component>
controller:
({
	getcount : function(component, event, helper) {
		var idacc =component.get("v.recordId");
        
        var action=component.get("c.getcountcon");
        action.setParams({"idid":idacc});
        action.setCallback(this,function(response){
           var state = response.getState();
            if(state == 'SUCCESS'){
                var res = response.getReturnValue();
                if(res != ''){
                    component.set("v.counted",res);
                    
                }
            }
        });
        $A.enqueueAction(action);
        
	}
})
apex controller:
public class countctrl {
@auraenabled
    public static integer getcountcon(string idid){
        return [select count() from contact where AccountId=:idid];
    }
}