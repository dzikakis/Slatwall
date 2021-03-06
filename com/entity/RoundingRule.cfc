/*

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component displayname="Rounding Rule" entityname="SlatwallRoundingRule" table="SlatwallRoundingRule" persistent=true output=false accessors=true extends="BaseEntity" {
	
	// Persistent Properties
	property name="roundingRuleID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="roundingRuleName" ormtype="string";
	property name="roundingRuleExpression" ormtype="string";
	property name="roundingRuleDirection" ormtype="string"; 
	
	// Audit properties
	property name="createdDateTime" ormtype="timestamp";
	property name="createdByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="createdByAccountID";
	property name="modifiedDateTime" ormtype="timestamp";
	property name="modifiedByAccount" cfc="Account" fieldtype="many-to-one" fkcolumn="modifiedByAccountID";
	
	// Related Object Properties
	property name="priceGroupRates" singularname="priceGroupRate" cfc="PriceGroupRate" fieldtype="one-to-many" fkcolumn="roundingRuleID" inverse="true";    

	public numeric function roundValue(required any value) {
		return getService("roundingRuleService").roundValueByRoundingRule(value=arguments.value, roundingRule=this);
	}
	
	public array function getRoundingRuleDirectionOptions() {
		return [
			{value="Closest", name="Round to Closest"},
			{value="Up", name="Only Round Up"},
			{value="Down", name="Only Round Down"}
		];
	}
	
	public boolean function hasExpressionWithListOfNumericValuesOnly() {
		for(var i=1; i<=listLen(getRoundingRuleExpression()); i++) {
			var thisValue = listGetAt(getRoundingRuleExpression(), i);
			if((len(thisValue) - find(".", thisValue)) != 2 || !isNumeric(thisValue)) {
				return false;
			}
		}
		return true;
	}
	
	// ============ START: Non-Persistent Property Methods =================
	
	// ============  END:  Non-Persistent Property Methods =================
		
	// ============= START: Bidirectional Helper Methods ===================
	
	// =============  END:  Bidirectional Helper Methods ===================
	
	// =================== START: ORM Event Hooks  =========================
	
	// ===================  END:  ORM Event Hooks  =========================
}