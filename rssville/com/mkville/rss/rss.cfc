<cfcomponent name="rss" hint="Base RSS component with shared constants and functions.">
<!---
PROGRAM: rss.cfc
CREATED: 30-August-2006-MAZELINM
PURPOSE: 
SPECIFICATIONS:
	Note that RSS 0.9x are not extendable through modules.
	
	RSS 0.91: http://backend.userland.com/rss091
	RSS 0.92: http://backend.userland.com/rss092
	RSS 1.0 :
	RSS 2.0 :
	atom 1.0:
UPDATES:
	30-AUG-2006-MBM: added leading H to the getDateAsRFC822() TimeFormat function call b/c the feed was not validating
	27-SEP-2006-MBM: added variables.instance.MODULE_NAME_KEY
					 added getIsModule() and getModuleName()
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
	 				 modified generate() method to require feedtype to be passed in
	 				 exposed FEED_TYPE constants as PUBLIC variables
	 				 added isValidFeedType()
	 				 addeed variables.instance.VALID_FEED_TYPE_LIST constant
--->

	<cfset variables.instance = structNew()>
	<!--- expose PUBLIC variables --->
	<cfset this.FEED_TYPE_ATOM10="atom_1.0">
	<cfset this.FEED_TYPE_RSS091="rss_0.91">
	<cfset this.FEED_TYPE_RSS092="rss_0.92">
	<cfset this.FEED_TYPE_RSS10="rss_1.0">
	<cfset this.FEED_TYPE_RSS20="rss_2.0">

	<cffunction name="init" access="public" output="false" returntype="any">
		<cfset variables.instance.GENERATOR_TEXT="RSSVille ColdFusion FeedMaker, version 1.0">
		<cfset variables.instance.LINE_DELIMITER=CHR(13)>
		<cfset variables.instance.FEED_TYPE_ATOM10=this.FEED_TYPE_ATOM10>
		<cfset variables.instance.FEED_TYPE_RSS091=this.FEED_TYPE_RSS091>
		<cfset variables.instance.FEED_TYPE_RSS092=this.FEED_TYPE_RSS092>
		<cfset variables.instance.FEED_TYPE_RSS10=this.FEED_TYPE_RSS10>
		<cfset variables.instance.FEED_TYPE_RSS20=this.FEED_TYPE_RSS20>
		<cfset variables.instance.VALID_FEED_TYPE_LIST="">
		<cfset variables.instance.VALID_FEED_TYPE_LIST=ListAppend(variables.instance.VALID_FEED_TYPE_LIST, variables.instance.FEED_TYPE_ATOM10)>
		<cfset variables.instance.VALID_FEED_TYPE_LIST=ListAppend(variables.instance.VALID_FEED_TYPE_LIST, variables.instance.FEED_TYPE_RSS091)>
		<cfset variables.instance.VALID_FEED_TYPE_LIST=ListAppend(variables.instance.VALID_FEED_TYPE_LIST, variables.instance.FEED_TYPE_RSS092)>
		<cfset variables.instance.VALID_FEED_TYPE_LIST=ListAppend(variables.instance.VALID_FEED_TYPE_LIST, variables.instance.FEED_TYPE_RSS10)>
		<cfset variables.instance.VALID_FEED_TYPE_LIST=ListAppend(variables.instance.VALID_FEED_TYPE_LIST, variables.instance.FEED_TYPE_RSS20)>
		<cfset variables.instance.MODULE_NAME_KEY="MODULE_NAME">
		<cfreturn this />
	</cffunction>

	<cffunction name="getDateAsRFC822" access="public" output="false" returntype="string">
		<cfargument name="localDate" type="string" required="true">
		<cfset var DateGMT="">
		<cfif isDate(arguments.localDate)>
			<cfset DateGMT=DateConvert("local2Utc", arguments.localDate)>
			<cfreturn DateFormat(DateGMT, "ddd, dd mmm yyyy") & " " & TimeFormat(DateGMT, "HH:mm:ss") & " GMT" />
		<cfelse>
			<cfthrow message="Invalid date: #arguments.localDate#">
			<cfreturn />
		</cfif>
	</cffunction>
	
	<cffunction name="getIsModule" access="public" output="false" returntype="boolean">
		<cfif StructKeyExists(variables.instance, variables.instance.MODULE_NAME_KEY)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
	<cffunction name="getModuleName" access="public" output="false" returntype="string">
		<cfif getIsModule()>
			<cfreturn variables.instance[variables.instance.MODULE_NAME_KEY]>
		<cfelse>
			<cfreturn "">
		</cfif>
	</cffunction>
	
	<cffunction name="isValidFeedType" access="public" output="false" returntype="boolean">
		<cfargument name="feedType" type="string" required="true">
		<cfif ListFindNoCase(variables.instance.VALID_FEED_TYPE_LIST, arguments.feedType)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
	<cffunction name="createXmlItem" access="public" output="false" returntype="string">
		<cfargument name="itemValue" required="true">
		<cfargument name="itemTag" required="true">
		<cfargument name="attributeName" default="" type="string">
		<cfargument name="includeEndTag" default="true" type="boolean">
		<cfargument name="emptyTagIfBlank" default="false" type="boolean">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfif len(trim(arguments.itemValue))>
			<cfif len(arguments.attributeName)>
				<cfset sb.append("<").append(arguments.itemTag).append(" ").append(arguments.attributeName)>
				<cfset sb.append("=""").append(XmlFormat(arguments.itemValue)).append("""")>
				<cfif arguments.includeEndTag>
					<cfset sb.append(" /")>
				</cfif>
				<cfset sb.append(">").append(variables.instance.LINE_DELIMITER)>
			<cfelse>
				<cfset sb.append("<").append(arguments.itemTag).append(">").append(XmlFormat(arguments.itemValue))>
				<cfif arguments.includeEndTag>
					<cfset sb.append("</").append(arguments.itemTag).append(">")>
				</cfif>
				<cfset sb.append(variables.instance.LINE_DELIMITER)>
			</cfif>
		<cfelseif arguments.emptyTagIfBlank>
			<cfset sb.append("<").append(arguments.itemTag)>
			<cfif arguments.includeEndTag>
				<cfset sb.append(" /")>
			</cfif>
			<cfset sb.append(">").append(variables.instance.LINE_DELIMITER)>
			<cfset retVal="<#arguments.itemTag# />#variables.instance.LINE_DELIMITER#">
		</cfif>
		<cfreturn sb.toString() />
	</cffunction>

<!---	<cffunction name="_toString" access="public" output="false" returntype="String">
		<cfargument name="separator" type="string" default="#variables.instance.LINE_DELIMITER#">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var sortedKeyList=ListSort(StructKeyList(variables.instance), "textnocase")>
		<cfset var currKey="">
		<cfloop list="#sortedKeyList#" index="currKey">
			<!--- don't process uppercase keys b/c they are constants --->
			<cfif not currkey.equals(Ucase(currKey))>
				<cftry>
					<cfset sb.append("[").append(currKey).append("=").append(evaluate("get#currKey#()")).append("]").append(arguments.separator)>
				<cfcatch>
					<cfset sb.append("[COULD NOT APPEND ").append(currKey).append("]").append(arguments.separator)>
				</cfcatch>
				</cftry>
			</cfif>
		</cfloop>
		<cfreturn sb.toString() />
	</cffunction> --->
	

	<!--- generate methods --->
	<cffunction name="generate" access="public" output="false" returntype="string">
		<cfargument name="feedType" type="string" required="true" />
		<cfswitch expression="#arguments.feedType#">
			<cfcase value="atom_1.0">
				<cfreturn generate_atom10(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_0.91">
				<cfreturn generate_rss091(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_0.92">
				<cfreturn generate_rss092(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_1.0">
				<cfreturn generate_rss10(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_2.0">
				<cfreturn generate_rss20(argumentCollection=arguments)>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="Invalid feedType [#arguments.feedType#]">
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="generate_atom10" access="private" output="false" returntype="string">
		<cfthrow message="generate_atom10() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generate_rss091" access="private" output="false" returntype="string">
		<cfthrow message="generate_rss091() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generate_rss092" access="private" output="false" returntype="string">
		<cfthrow message="generate_rss092() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generate_rss10" access="private" output="false" returntype="string">
		<cfthrow message="generate_rss10() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfthrow message="generate_rss20() is not implemented in this component">
	</cffunction>
	
	<!--- generate_header methods --->
	<cffunction name="generateHeader" access="public" output="false" returntype="any">
		<cfargument name="feedType" type="string" default="" />
		<cfargument name="headerSb" type="any" default="" />
		<cfargument name="stylesheet" default="" />
		<cfswitch expression="#arguments.feedType#">
			<cfcase value="atom_1.0">
				<cfreturn generateHeader_atom10(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_0.91">
				<cfreturn generateHeader_rss091(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_0.92">
				<cfreturn generateHeader_rss092(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_1.0">
				<cfreturn generateHeader_rss10(argumentCollection=arguments)>
			</cfcase>
			<cfcase value="rss_2.0">
				<cfreturn generateHeader_rss20(argumentCollection=arguments)>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="Invalid feedType [#arguments.feedType#]">
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="generateHeader_atom10" access="private" output="false" returntype="any">
		<cfthrow message="generateHeader_atom10() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generateHeader_rss091" access="private" output="false" returntype="any">
		<cfthrow message="generateHeader_rss091() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generateHeader_rss092" access="private" output="false" returntype="any">
		<cfthrow message="generateHeader_rss092() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generateHeader_rss10" access="private" output="false" returntype="any">
		<cfthrow message="generateHeader_rss10() is not implemented in this component">
	</cffunction>
	
	<cffunction name="generateHeader_rss20" access="private" output="false" returntype="any">
		<cfthrow message="generateHeader_rss20() is not implemented in this component">
		<!--- 
		<cfargument name="stylesheet" default="">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("<?xml version=""1.0"" encoding=""#getCharacterEncoding()#""?>").append(CHR(13))>
		<cfif len(arguments.stylesheet)>
			<cfset sb.append("<?xml-stylesheet type=""text/css"" href=""#arguments.stylesheet#"" ?>").append(CHR(13))>
		</cfif>
<!---		<cfset sb.append("<rss xmlns:taxo=""http://purl.org/rss/1.0/modules/taxonomy/"" xmlns:rdf=""http://www.w3.org/1999/02/22-rdf-syntax-ns##"" xmlns:itunes=""http://www.itunes.com/dtds/podcast-1.0.dtd"" xmlns:dc=""http://purl.org/dc/elements/1.1/"" version=""2.0"">").append(CHR(13))> --->
		<cfset sb.append("<rss")>
		<cfif includeNamespaceTaxonomy>
			<cfset sb.append(" xmlns:taxo=""http://purl.org/rss/1.0/modules/taxonomy/""")>
		</cfif>
		<cfif includeNamespaceRDF>
			<cfset sb.append(" xmlns:rdf=""http://www.w3.org/1999/02/22-rdf-syntax-ns##""")>
		</cfif>
		<cfif includeNamespaceITunes>
			<cfset sb.append(" xmlns:itunes=""http://www.itunes.com/dtds/podcast-1.0.dtd""")>
		</cfif>
		<cfif includeNamespaceDC>
			<cfset sb.append(" xmlns:dc=""http://purl.org/dc/elements/1.1/"" version=""2.0"">")>
		</cfif>
		<cfset sb.append(" version=""2.0"">").append(CHR(13))>
		<cfreturn sb />
		--->		
	</cffunction>

</cfcomponent>