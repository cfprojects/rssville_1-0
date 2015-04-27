<cfcomponent name="owner" extends="com.mkville.rss.rss">

	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.modules.itunes.owner">
		<cfset super.init()>
		<cfset variables.instance.name="">
		<cfset variables.instance.email="">
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

	<cffunction name="getEmail" access="public" output="false" returntype="any">
		<cfreturn variables.instance.email />
	</cffunction>

	<cffunction name="setEmail" access="public" output="false" returntype="void">
		<cfargument name="email" type="any" required="true" />
		<cfset variables.instance.email = arguments.email />
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("<itunes:owner>").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append(createXmlItem(getName(), "itunes:name"))>
		<cfset sb.append(createXmlItem(getEmail(), "itunes:email"))>
		<cfset sb.append("</itunes:owner>").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>
</cfcomponent>