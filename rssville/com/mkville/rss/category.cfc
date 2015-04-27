<cfcomponent name="category" displayname="Feed Category" extends="com.mkville.rss.rss">
<!---
PROGRAM: category.cfc
UPDATES:
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
--->
	<!--- TODO: add domain property; generates as an attribute of the category tag; see http://www.rssboard.org/rss-specification#ltcategorygtSubelementOfLtitemgt --->

	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.category">
		<cfset super.init()>
		<cfset variables.instance.name="">
		<cfset variables.instance.taxonomyUri="">
		<cfreturn this />
	</cffunction>

	<cffunction name="getName" access="public" output="false" returntype="any">
		<cfreturn variables.instance.name />
	</cffunction>

	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="name" type="any" required="true" />
		<cfset variables.instance.name = arguments.name />
		<cfreturn />
	</cffunction>

	<cffunction name="getTaxonomyUri" access="public" output="false" returntype="any">
		<cfreturn variables.instance.taxonomyUri />
	</cffunction>

	<cffunction name="setTaxonomyUri" access="public" output="false" returntype="void">
		<cfargument name="taxonomyUri" type="any" required="true" />
		<cfset variables.instance.taxonomyUri = arguments.taxonomyUri />
		<cfreturn />
	</cffunction>

	<!--- this cannot be toString() because of a built-in ColdFusion function by the same name --->
	<cffunction name="_toString" access="public" output="false" returntype="String">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("[").append("Name").append("=").append(getName()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("TaxonomyUri").append("=").append(getTaxonomyUri()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>

	<cffunction name="generate_rss091" access="private" output="false" returntype="string">
		<!--- rss 0.91 does not have categories --->
		<cfreturn "">
	</cffunction>

	<cffunction name="generate_rss092" access="private" output="false" returntype="string">
		<!--- rss 0.92 allows for one category --->
		<cfreturn generateTypicalRss()>
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss()>
	</cffunction>

	<cffunction name="generateTypicalRss" access="private" output="false" returntype="string">
		<cfreturn createXmlItem(getName(), "category") />
	</cffunction>
</cfcomponent>