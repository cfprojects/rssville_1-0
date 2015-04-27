<cfcomponent name="description" extends="com.mkville.rss.rss">
<!---
PROGRAM: description.cfc
UPDATES:
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
--->

	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.description">
		<cfset super.init()>
		<cfset variables.instance.type="text/plain">
		<cfset variables.instance.value="">
		<cfreturn this />
	</cffunction>

	<cffunction name="getType" access="public" output="false" returntype="any">
		<cfreturn variables.instance.type />
	</cffunction>

	<cffunction name="setType" access="public" output="false" returntype="void">
		<cfargument name="type" type="any" required="true" />
		<cfset variables.instance.type = arguments.type />
		<cfreturn />
	</cffunction>

	<cffunction name="getValue" access="public" output="false" returntype="any">
		<cfreturn variables.instance.value />
	</cffunction>

	<cffunction name="setValue" access="public" output="false" returntype="void">
		<cfargument name="value" type="any" required="true" />
		<cfset variables.instance.value = arguments.value />
		<cfreturn />
	</cffunction>

	<cffunction name="generateTypicalRss" access="private" output="false" returntype="string">
		<cfreturn createXmlItem(getValue(), "description") />
	</cffunction>

	<cffunction name="generate_rss091" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss() />
	</cffunction>

	<cffunction name="generate_rss092" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss() />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss() />
	</cffunction>
</cfcomponent>