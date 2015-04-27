<cfcomponent name="category" hint="Categories are defined by Apple. See ITMS for a view." extends="com.mkville.rss.rss">

	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.modules.itunes.category">
		<cfset super.init()>
		<cfset variables.instance.name="">
		<cfset variables.instance.subcategory="">
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

 	<cffunction name="getSubcategory" access="public" output="false" returntype="string">
		<cfreturn variables.instance.subcategory />
	</cffunction>

	<cffunction name="setSubcategory" access="public" output="false" returntype="void">
		<cfargument name="subcategory" type="string" required="true" />
		<cfset variables.instance.subcategory = arguments.subcategory />
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfif len(getSubcategory())>
			<cfset sb.append(createXmlItem(getName(), "itunes:category", "text", false))>
			<cfset sb.append(createXmlItem(getSubcategory(), "itunes:category", "text"))>
			<cfset sb.append("</itunes:category>").append(variables.instance.LINE_DELIMITER)>
		<cfelse>
			<cfset sb.append(createXmlItem(getName(), "itunes:category", "text"))>
		</cfif>
		<cfreturn sb.toString() />
	</cffunction>
</cfcomponent>