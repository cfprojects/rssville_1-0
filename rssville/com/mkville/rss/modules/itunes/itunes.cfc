<cfcomponent name="itunes" extends="com.mkville.rss.rss">
<!---
PROGRAM: itunes.cfc
PURPOSE: 
UPDATES:
	27-SEP-2006-MBM: added variables.instance.module_name key
--->

<!--- NOTES:
	itunes: 
		* all values should be plain text
		* all values are limited to 255 characters, except for itunes:summary which is limited to 4000 characters
		* whitespace is significant and will show in iTunes
--->

	<cfset variables.instance = structNew()>
	
	<!--- 
	BOTH
	author
	block
	explicit
	keywords
	subtitle
	summary
	
	CHANNEL/FEED ONLY
	category R
	image
	new-feed-url
	owner R
	
	ITEM/ENTRY ONLY
	duration
	--->
	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.modules.itunes.itunes">
		<cfset super.init()>
		<cfset variables.instance.author=""><!--- iTunes "Artist" --->
		<cfset variables.instance.block=false>
		<cfset variables.instance.explicit=false>
		<cfset variables.instance.keywords=ArrayNew(1)>
		<cfset variables.instance.subtitle="">
		<cfset variables.instance.summary="">
		<cfset variables.instance[variables.instance.MODULE_NAME_KEY]="itunes"><!--- static --->
		<cfreturn this />
	</cffunction>

	<cffunction name="getAuthor" access="public" output="false" returntype="any">
		<cfreturn variables.instance.author />
	</cffunction>

	<cffunction name="setAuthor" access="public" output="false" returntype="void">
		<cfargument name="author" type="any" required="true" />
		<cfset variables.instance.author = arguments.author />
		<cfreturn />
	</cffunction>

	<cffunction name="getBlock" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.block />
	</cffunction>

	<cffunction name="getBlockYesNo" access="public" output="false" returntype="boolean">
		<cfif getBlock()>
			<cfreturn "yes" />
		<cfelse>
			<cfreturn "no" />
		</cfif>
	</cffunction>

	<cffunction name="setBlock" access="public" output="false" returntype="void">
		<cfargument name="block" type="boolean" required="true" />
		<cfset variables.instance.block = arguments.block />
		<cfreturn />
	</cffunction>

	<cffunction name="getExplicit" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.explicit />
	</cffunction>

	<cffunction name="getExplicitYesNo" access="public" output="false" returntype="boolean">
		<cfif getExplicit()>
			<cfreturn "yes" />
		<cfelse>
			<cfreturn "no" />
		</cfif>
	</cffunction>

	<cffunction name="setExplicit" access="public" output="false" returntype="void">
		<cfargument name="explicit" type="boolean" required="true" />
		<cfset variables.instance.explicit = arguments.explicit />
		<cfreturn />
	</cffunction>

	<cffunction name="getKeywords" access="public" output="false" returntype="any">
		<cfreturn variables.instance.keywords />
	</cffunction>

	<cffunction name="getKeywordsList" access="public" output="false" returntype="any">
		<cfif isArray(getKeywords()) and ArrayLen(getKeywords())>
			<cfreturn ArrayToList(getKeywords())>
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="setKeywords" access="public" output="false" returntype="void">
		<cfargument name="keywords" type="any" required="true" />
		<cfset variables.instance.keywords = arguments.keywords />
		<cfreturn />
	</cffunction>

	<cffunction name="addKeyword" access="public" output="false" returntype="void">
		<cfargument name="keyword" type="string" required="true" />
		<cfset variables.instance.keywords.add(arguments.keyword) />
		<cfreturn />
	</cffunction>

	<cffunction name="getSubtitle" access="public" output="false" returntype="any">
		<cfreturn variables.instance.subtitle />
	</cffunction>

	<cffunction name="setSubtitle" access="public" output="false" returntype="void">
		<cfargument name="subtitle" type="any" required="true" />
		<cfset variables.instance.subtitle = arguments.subtitle />
		<cfreturn />
	</cffunction>

	<cffunction name="getSummary" access="public" output="false" returntype="any">
		<cfreturn variables.instance.summary />
	</cffunction>

	<cffunction name="setSummary" access="public" output="false" returntype="void">
		<cfargument name="summary" type="any" required="true" />
		<cfset variables.instance.summary = arguments.summary />
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS20>
		<cfset var local=StructNew()>
		<cfset sb.append(createXmlItem(getAuthor(), "itunes:author"))>
		<cfset sb.append(createXmlItem(getBlockYesNo(), "itunes:block"))>
		<cfset sb.append(createXmlItem(getExplicitYesNo(), "itunes:explicit"))>
		<cfset sb.append(createXmlItem(getKeywordsList(), "itunes:keywords"))>
		<cfset sb.append(createXmlItem(getSubTitle(), "itunes:subtitle"))>
		<cfset sb.append(createXmlItem(getSummary(), "itunes:summary"))>
		<cfreturn sb.toString() />
	</cffunction>
</cfcomponent>