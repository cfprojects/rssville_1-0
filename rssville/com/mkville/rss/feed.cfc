<cfcomponent name="feed" extends="com.mkville.rss.rss">
<!---
PROGRAM: feed.cfc
CREATED: 30-August-2006-MAZELINM
PURPOSE: 
UPDATES:
	30-AUG-2006-MBM: added webmaster and managingEditor
	22-SEP-2006-MBM: added image
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
	 				 modified generate() methods to use passed in feed type
	 				 removed feedtype attribute of this cfc
--->
	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.feed">
		<cfset super.init()>
		<cfset variables.instance.author="">
		<cfset variables.instance.categories=ArrayNew(1)>
		<cfset variables.instance.contributors="">
		<cfset variables.instance.copyright="">
		<cfset variables.instance.description=""><!--- REQUIRED FOR RSS 2.0 SPEC --->
		<cfset variables.instance.CharacterEncoding="UTF-8">
		<cfset variables.instance.entries=ArrayNew(1)>
		<cfset variables.instance.image="">
		<cfset variables.instance.language="">
		<cfset variables.instance.link=""><<!--- REQUIRED FOR RSS 2.0 SPEC --->
		<cfset variables.instance.pubDate=now()>
		<cfset variables.instance.title=""><!--- REQUIRED FOR RSS 2.0 SPEC --->
		<cfset variables.instance.uri="">
		<cfset variables.instance.webmaster="">
		<cfset variables.instance.managingEditor="">
		<cfset variables.instance.generator=variables.instance.GENERATOR_TEXT><!--- IMMUTABLE --->
		<cfset variables.instance.modules=ArrayNew(1)>
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getAuthor" access="public" output="false" returntype="string">
		<cfreturn variables.instance.author />
	</cffunction>

	<cffunction name="setAuthor" access="public" output="false" returntype="void">
		<cfargument name="author" type="string" required="true" />
		<cfset variables.instance.author = arguments.author />
		<cfreturn />
	</cffunction>

	<cffunction name="getCategories" access="public" output="false" returntype="any">
		<cfreturn variables.instance.categories />
	</cffunction>

	<cffunction name="setCategories" access="public" output="false" returntype="void">
		<cfargument name="categories" type="any" required="true" />
		<cfset variables.instance.categories = arguments.categories />
		<cfreturn />
	</cffunction>

	<cffunction name="addCategory" access="public" output="false" returntype="void">
		<cfargument name="category" type="com.mkville.rss.category" required="true" />
		<cfset variables.instance.categories.add(arguments.category) />
		<cfreturn />
	</cffunction>

	<cffunction name="addCategorySimple" access="public" output="false" returntype="void">
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="taxonomyUri" type="string" default="" />
		<cfset var category = CreateObject("component", "com.mkville.rss.category").init() />
	    <cfset category.setName(arguments.categoryName)>
	    <cfset category.setTaxonomyUri(arguments.taxonomyUri)>
	    <cfset addCategory(category)>
		<cfreturn />
	</cffunction>

	<cffunction name="getContributors" access="public" output="false" returntype="any">
		<cfreturn variables.instance.contributors />
	</cffunction>

	<cffunction name="setContributors" access="public" output="false" returntype="void">
		<cfargument name="contributors" type="any" required="true" />
		<cfset variables.instance.contributors = arguments.contributors />
		<cfreturn />
	</cffunction>

	<cffunction name="getCopyright" access="public" output="false" returntype="any">
		<cfreturn variables.instance.copyright />
	</cffunction>

	<cffunction name="setCopyright" access="public" output="false" returntype="void">
		<cfargument name="copyright" type="any" required="true" />
		<cfset variables.instance.copyright = arguments.copyright />
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

	<!--- this cannot be getEncoding() because of a built-in ColdFusion function by the same name --->
	<cffunction name="getCharacterEncoding" access="public" output="false" returntype="string">
		<cfreturn variables.instance.CharacterEncoding />
	</cffunction>

	<cffunction name="setCharacterEncoding" access="public" output="false" returntype="void">
		<cfargument name="CharacterEncoding" type="string" required="true" />
		<cfset variables.instance.CharacterEncoding = arguments.CharacterEncoding />
		<cfreturn />
	</cffunction>

	<cffunction name="getEntries" access="public" output="false" returntype="any">
		<cfreturn variables.instance.entries />
	</cffunction>

	<cffunction name="setEntries" access="public" output="false" returntype="void">
		<cfargument name="entries" type="any" required="true" />
		<cfset variables.instance.entries = arguments.entries />
		<cfreturn />
	</cffunction>

	<cffunction name="addEntry" access="public" output="false" returntype="void">
		<cfargument name="entry" type="com.mkville.rss.entry" required="true" />
		<cfset variables.instance.entries.add(arguments.entry) />
		<cfreturn />
	</cffunction>

	<cffunction name="getLanguage" access="public" output="false" returntype="any">
		<cfreturn variables.instance.language />
	</cffunction>

	<cffunction name="setLanguage" access="public" output="false" returntype="void">
		<cfargument name="language" type="any" required="true" />
		<cfset variables.instance.language = arguments.language />
		<cfreturn />
	</cffunction>

	<cffunction name="getLink" access="public" output="false" returntype="any">
		<cfreturn variables.instance.link />
	</cffunction>

	<cffunction name="setLink" access="public" output="false" returntype="void">
		<cfargument name="link" type="any" required="true" />
		<cfset variables.instance.link = arguments.link />
		<cfreturn />
	</cffunction>

	<cffunction name="getpubDate" access="public" output="false" returntype="date">
		<cfreturn variables.instance.pubDate />
	</cffunction>

	<cffunction name="setpubDate" access="public" output="false" returntype="void">
		<cfargument name="pubDate" type="date" required="true" />
		<cfset variables.instance.pubDate = arguments.pubDate />
		<cfreturn />
	</cffunction>

	<cffunction name="getTitle" access="public" output="false" returntype="any">
		<cfreturn variables.instance.title />
	</cffunction>

	<cffunction name="setTitle" access="public" output="false" returntype="void">
		<cfargument name="title" type="any" required="true" />
		<cfset variables.instance.title = arguments.title />
		<cfreturn />
	</cffunction>

	<cffunction name="getUri" access="public" output="false" returntype="any">
		<cfreturn variables.instance.uri />
	</cffunction>

	<cffunction name="setUri" access="public" output="false" returntype="void">
		<cfargument name="uri" type="any" required="true" />
		<cfset variables.instance.uri = arguments.uri />
		<cfreturn />
	</cffunction>

	<cffunction name="getWebmaster" access="public" output="false" returntype="any">
		<cfreturn variables.instance.webmaster />
	</cffunction>

	<cffunction name="setWebmaster" access="public" output="false" returntype="void">
		<cfargument name="webmaster" type="any" required="true" hint="e-mail@dot.com (First LastName)" />
		<cfset variables.instance.webmaster = arguments.webmaster />
		<cfreturn />
	</cffunction>

	<cffunction name="getManagingEditor" access="public" output="false" returntype="any">
		<cfreturn variables.instance.managingEditor />
	</cffunction>

	<cffunction name="setManagingEditor" access="public" output="false" returntype="void">
		<cfargument name="managingEditor" type="any" required="true" hint="e-mail@dot.com (First LastName)" />
		<cfset variables.instance.managingEditor = arguments.managingEditor />
		<cfreturn />
	</cffunction>

	<cffunction name="getImage" access="public" output="false" returntype="any">
		<cfreturn variables.instance.image />
	</cffunction>

	<cffunction name="setImage" access="public" output="false" returntype="void">
		<cfargument name="image" type="com.mkville.rss.image" required="true" />
		<cfset variables.instance.image = arguments.image />
		<cfreturn />
	</cffunction>

	<cffunction name="getModules" access="public" output="false" returntype="any">
		<cfreturn variables.instance.modules />
	</cffunction>

	<cffunction name="setModules" access="public" output="false" returntype="void">
		<cfargument name="modules" type="any" required="true" />
		<cfset variables.instance.modules = arguments.modules />
		<cfreturn />
	</cffunction>

	<cffunction name="addModule" access="public" output="false" returntype="void">
		<cfargument name="module" type="com.mkville.rss.rss" required="true" />
		<cfset variables.instance.modules.add(arguments.module) />
		<cfreturn />
	</cffunction>

	<cffunction name="getGenerator" access="public" output="false" returntype="any">
		<cfreturn variables.instance.generator />
	</cffunction>

	<!--- this cannot be toString() because of a built-in ColdFusion function by the same name --->
	<cffunction name="_toString" access="public" output="false" returntype="String">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("[").append("Author").append("=").append(getAuthor()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Categories").append("=").append(getCategories()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Contributors").append("=").append(getContributors()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Copyright").append("=").append(getCopyright()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Description").append("=").append(getDescription()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("CharacterEncoding").append("=").append(getCharacterEncoding()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Entries").append("=").append(getEntries()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("FeedType").append("=").append(getFeedType()).append("]").append(CHR(13))>
<!---		<cfset sb.append("[").append("Image").append("=").append(getImage()).append("]").append(CHR(13))> --->
		<cfset sb.append("[").append("Language").append("=").append(getLanguage()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Link").append("=").append(getLink()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("pubDate").append("=").append(getpubDate()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Title").append("=").append(getTitle()).append("]").append(CHR(13))>
		<cfset sb.append("[").append("Uri").append("=").append(getUri()).append("]").append(CHR(13))>
		<cfreturn sb.toString() />
	</cffunction>
	
	
	<!--- RSS 0.9x --->
	<cffunction name="generateHeader_rss091" access="public" output="false" returntype="any">
		<cfargument name="feedType" type="string" />
		<cfargument name="headerSb" type="any" required="true">
		<cfargument name="stylesheet" default="">
		<cfreturn generateHeader_rss09x(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="generate_rss091" access="public" output="false" returntype="string">
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS091>
		<cfreturn generate_rss09x(FEED_TYPE)>
	</cffunction>
	
	<cffunction name="generateHeader_rss092" access="public" output="false" returntype="any">
		<cfargument name="feedType" type="string" />
		<cfargument name="headerSb" type="any" required="true">
		<cfargument name="stylesheet" default="">
		<cfreturn generateHeader_rss09x(argumentCollection=arguments)>
	</cffunction>
	
	<cffunction name="generate_rss092" access="public" output="false" returntype="string">
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS092>
		<cfreturn generate_rss09x(FEED_TYPE)>
	</cffunction>

	<cffunction name="generateHeader_rss09x" access="public" output="false" returntype="any">
		<cfargument name="feedType" type="string" />
		<cfargument name="headerSb" type="any" required="true">
		<cfargument name="stylesheet" default="">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("<?xml version=""1.0"" encoding=""#getCharacterEncoding()#""?>").append(variables.instance.LINE_DELIMITER)>
		<cfif len(arguments.stylesheet)>
			<cfset sb.append("<?xml-stylesheet type=""text/css"" href=""#arguments.stylesheet#"" ?>").append(variables.instance.LINE_DELIMITER)>
		</cfif>
		<cfset sb.append("<rss")>
		<cfset sb.append(" version=""0.#ListLast(arguments.FeedType, ".")#"">").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb />
	</cffunction>
	
	<cffunction name="generate_rss09x" access="public" output="false" returntype="string">
		<cfargument name="feedType" type="string" required="true">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var headerSb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var local=StructNew()>
		<cfset var FEED_TYPE=arguments.feedType>
		<!--- channel --->
		<cfset sb.append("<channel>").append(CHR(13))>
		<cfset sb.append(createXmlItem(getTitle(), "title"))>
		<cfset sb.append(createXmlItem(getLink(), "link"))>
		<cfset sb.append(createXmlItem(getDescription(), "description"))>
		<cfset sb.append(createXmlItem(getLanguage(), "language"))>
		<!--- un-encode the copyright symbol --->
		<cfset sb.append(Replace(createXmlItem(getCopyright(), "copyright"), "&amp;##xA9;", "&##xA9;"))>
		<cfset sb.append(createXmlItem(getWebmaster(), "webMaster"))>
		<cfset sb.append(createXmlItem(getManagingEditor(), "managingEditor"))>
		<cfset sb.append(createXmlItem(getDateAsRFC822(getPubDate()), "pubDate"))>
		<cfif isObject(getImage())>
			<cfset sb.append(getImage().generate(FEED_TYPE))>
		</cfif>
		<!--- items --->
		<cfif ArrayLen(getEntries())>
			<cfset local.entries=getEntries()>
			<cfloop from="1" to="#ArrayLen(local.entries)#" index="local.entryCtr">
				<cfset sb.append(local.entries[local.entryCtr].generate(FEED_TYPE))>
			</cfloop>
		</cfif>
		<!--- closing tags --->
		<cfset sb.append("</channel>").append(CHR(13))>
		<cfset sb.append("</rss>").append(CHR(13))>
		<!--- header --->
		<cfset sb.insert(0, generateHeader(FEED_TYPE, headerSb))>
		<!--- return xml data as a string --->
		<cfreturn sb.toString() />
	</cffunction>



	<!--- RSS 2.0 --->
	<cffunction name="generateHeader_rss20" access="public" output="false" returntype="any">
		<cfargument name="feedType" type="string" />
		<cfargument name="headerSb" type="any" required="true">
		<cfargument name="stylesheet" default="">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset sb.append("<?xml version=""1.0"" encoding=""#getCharacterEncoding()#""?>").append(variables.instance.LINE_DELIMITER)>
		<cfif len(arguments.stylesheet)>
			<cfset sb.append("<?xml-stylesheet type=""text/css"" href=""#arguments.stylesheet#"" ?>").append(variables.instance.LINE_DELIMITER)>
		</cfif>
		<cfset sb.append("<rss")>
		<cfif arguments.headerSb.length()>
			<cfset sb.append(arguments.headerSb)>
		</cfif>
		<cfset sb.append(" version=""2.0"">").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb />
	</cffunction>
	
	<cffunction name="generate_rss20" access="public" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var headerSb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var local=StructNew()>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS20>
		<!--- channel --->
		<cfset sb.append("<channel>").append(CHR(13))>
		<cfset sb.append(createXmlItem(getTitle(), "title"))>
		<cfset sb.append(createXmlItem(getLink(), "link"))>
		<cfset sb.append(createXmlItem(getDescription(), "description"))>
		<cfset sb.append(createXmlItem(getLanguage(), "language"))>
		<!--- un-encode the copyright symbol --->
		<cfset sb.append(Replace(createXmlItem(getCopyright(), "copyright"), "&amp;##xA9;", "&##xA9;"))>
		<cfset sb.append(createXmlItem(getGenerator(), "generator"))>
		<cfset sb.append(createXmlItem(getWebmaster(), "webmaster"))>
		<cfset sb.append(createXmlItem(getManagingEditor(), "managingEditor"))>
		<cfset sb.append(createXmlItem(getDateAsRFC822(getPubDate()), "pubDate"))>
		<cfif isObject(getImage())>
			<cfset sb.append(getImage().generate(FEED_TYPE))>
		</cfif>
		<cfif isArray(getModules()) and ArrayLen(getModules())>
			<cfset local.modules=getModules()>
			<cfloop from="1" to="#ArrayLen(local.modules)#" index="local.moduleCtr">
				<cfset sb.append(local.modules[local.moduleCtr].generate(FEED_TYPE))>
				<!--- generate module's header information --->
				<cfset headerSb.append(local.modules[local.moduleCtr].generateHeader(FEED_TYPE))>
			</cfloop>
		</cfif>
		<!--- items --->
		<cfif ArrayLen(getEntries())>
			<cfset local.entries=getEntries()>
			<cfloop from="1" to="#ArrayLen(local.entries)#" index="local.entryCtr">
				<cfset sb.append(local.entries[local.entryCtr].generate(FEED_TYPE))>
			</cfloop>
		</cfif>
		<!--- closing tags --->
		<cfset sb.append("</channel>").append(CHR(13))>
		<cfset sb.append("</rss>").append(CHR(13))>
		<!--- header (do this after looping through modules) --->
		<cfset sb.insert(0, generateHeader(FEED_TYPE, headerSb))>
		<!--- return xml data as a string --->
		<cfreturn sb.toString() />
	</cffunction>
</cfcomponent>