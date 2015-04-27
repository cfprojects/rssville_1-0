<cfcomponent name="enclosure" extends="com.mkville.rss.rss">
<!---
PROGRAM: enclosure.cfc
UPDATES:
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
--->

	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.enclosure">
		<cfset super.init()>
		<cfset variables.instance.length="">
		<cfset variables.instance.type="">
		<cfset variables.instance.url="">
		<cfreturn this />
	</cffunction>

	<cffunction name="getLength" access="public" output="false" returntype="any">
		<cfreturn variables.instance.length />
	</cffunction>

	<cffunction name="setLength" access="public" output="false" returntype="void" hint="Size of file in bytes">
		<cfargument name="length" type="any" required="true" />
		<cfset variables.instance.length = arguments.length />
		<cfreturn />
	</cffunction>

	<cffunction name="getType" access="public" output="false" returntype="any">
		<cfreturn variables.instance.type />
	</cffunction>

	<cffunction name="setType" access="public" output="false" returntype="void">
		<cfargument name="type" type="any" required="true" />
        <!---
		valid types according to http://www.apple.com/itunes/podcasts/techspecs.html
        File  	Type
        .mp3 	audio/mpeg
        .m4a 	audio/x-m4a
        .mp4 	video/mp4
        .m4v 	video/x-m4v
        .mov 	video/quicktime
        .pdf 	application/pdf
		--->
		<cfset variables.instance.type = arguments.type />
		<cfreturn />
	</cffunction>

	<cffunction name="getUrl" access="public" output="false" returntype="any">
		<cfreturn variables.instance.url />
	</cffunction>

	<cffunction name="setUrl" access="public" output="false" returntype="void">
		<cfargument name="url" type="any" required="true" />
		<cfset variables.instance.url = arguments.url />
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss091" access="private" output="false" returntype="string">
		<!--- rss 0.91 does not have enclosures --->
		<cfreturn "">
	</cffunction>

	<cffunction name="generate_rss092" access="private" output="false" returntype="string">
		<!--- rss 0.92 allows one enclosure --->
		<cfreturn generateTypicalRss() />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfreturn generateTypicalRss() />
	</cffunction>

	<cffunction name="generateTypicalRss" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<!--- <enclosure url="http://cdrmedia.cedarville.edu/cdr/chapel_20060821.mp3" length="10000" type="audio/mpeg" />--->
		<!---  D:\web\bookstore\esd\2\2006\08_August\0608212.mp3 --->
		<cfset sb.append("<enclosure url=""").append(XmlFormat(getUrl())).append(""" length=""").append(XmlFormat(getLength())).append(""" type=""").append(XmlFormat(getType())).append(""" />").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>
</cfcomponent>