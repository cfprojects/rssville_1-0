<cfcomponent name="image" displayname="Feed Image" extends="com.mkville.rss.rss">
<!---
PROGRAM: image.cfc
UPDATES:
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
--->

	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.image">
		<cfset super.init()>
		<cfset variables.instance.url=""><!--- REQUIRED; gif, jpeg, or png --->
		<!--- according to the RSS 2.0 spec, "in practice, the image title and link should have the same value as the channel title and link" --->
		<cfset variables.instance.title=""><!--- REQUIRED; use in ALT attribute of IMG tag --->
		<cfset variables.instance.link=""><!--- REQUIRED --->
		<cfset variables.instance.width=0><!--- max: 144; default: 88 --->
		<cfset variables.instance.height=0><!--- max: 400; default: 31 --->
		<cfset variables.instance.description=""><!--- included in the TITLE attribute of the link formed around the image in the HTML rendering --->
		<cfreturn this />
	</cffunction>

	<cffunction name="getUrl" access="public" output="false" returntype="string">
		<cfreturn variables.instance.url />
	</cffunction>

	<cffunction name="setUrl" access="public" output="false" returntype="void">
		<cfargument name="url" type="string" required="true" />
		<cfset variables.instance.url = arguments.url />
		<cfreturn />
	</cffunction>

	<cffunction name="getTitle" access="public" output="false" returntype="string">
		<cfreturn variables.instance.title />
	</cffunction>

	<cffunction name="setTitle" access="public" output="false" returntype="void">
		<cfargument name="title" type="string" required="true" />
		<cfset variables.instance.title = arguments.title />
		<cfreturn />
	</cffunction>

	<cffunction name="getLink" access="public" output="false" returntype="string">
		<cfreturn variables.instance.link />
	</cffunction>

	<cffunction name="setLink" access="public" output="false" returntype="void">
		<cfargument name="link" type="string" required="true" />
		<cfset variables.instance.link = arguments.link />
		<cfreturn />
	</cffunction>

	<cffunction name="getWidth" access="public" output="false" returntype="numeric">
		<cfreturn variables.instance.width />
	</cffunction>

	<cffunction name="setWidth" access="public" output="false" returntype="void">
		<cfargument name="width" type="numeric" required="true" />
		<cfset variables.instance.width = arguments.width />
		<cfreturn />
	</cffunction>
	
	<cffunction name="getHeight" access="public" output="false" returntype="numeric">
		<cfreturn variables.instance.height />
	</cffunction>

	<cffunction name="setHeight" access="public" output="false" returntype="void">
		<cfargument name="height" type="numeric" required="true" />
		<cfset variables.instance.height = arguments.height />
		<cfreturn />
	</cffunction>

	<cffunction name="getDescription" access="public" output="false" returntype="string">
		<cfreturn variables.instance.description />
	</cffunction>

	<cffunction name="setDescription" access="public" output="false" returntype="void">
		<cfargument name="description" type="string" required="true" />
		<cfset variables.instance.description = arguments.description />
		<cfreturn />
	</cffunction>

	<cffunction name="generateTypicalRss" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("<image>").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append(createXmlItem(getUrl(), "url"))>
		<cfset sb.append(createXmlItem(getTitle(), "title"))>
		<cfset sb.append(createXmlItem(getLink(), "link"))>
		<cfif getWidth()>
			<cfset sb.append(createXmlItem(getWidth(), "width"))>
		</cfif>
		<cfif getHeight()>
			<cfset sb.append(createXmlItem(getHeight(), "height"))>
		</cfif>
		<cfif len(getDescription())>
			<cfset sb.append(createXmlItem(getDescription(), "description"))>
		</cfif>
		<cfset sb.append("</image>").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>

	<cffunction name="generate_rss091" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss()>
	</cffunction>

	<cffunction name="generate_rss092" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss()>
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss()>
	</cffunction>
</cfcomponent>