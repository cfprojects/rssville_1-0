<cfcomponent name="entry" extends="com.mkville.rss.rss">
<!---
PROGRAM: entry.cfc
UPDATES:
	 2-OCT-2006-MBM: added rss 0.91 and rss 0.92 logic
--->

	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.entry">
		<cfset super.init()>
		<cfset variables.instance.author=""><!--- "e-mail address" or "e-mail (name)" --->
		<cfset variables.instance.categories=ArrayNew(1)>
		<cfset variables.instance.contents=ArrayNew(1)>
		<cfset variables.instance.contributors=ArrayNew(1)>
		<cfset variables.instance.description=""><!--- ONE OF title/description REQUIRED FOR RSS 2.0 SPEC --->
		<cfset variables.instance.enclosures=ArrayNew(1)>
		<cfset variables.instance.link="">
		<cfset variables.instance.pubDate=now()>
		<cfset variables.instance.summary="">
		<cfset variables.instance.title=""><!--- ONE OF title/description REQUIRED FOR RSS 2.0 SPEC --->
		<cfset variables.instance.uri="">
		<cfset variables.instance.modules=ArrayNew(1)>
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

	<cffunction name="getCategories" access="public" output="false" returntype="array">
		<cfreturn variables.instance.categories />
	</cffunction>

	<cffunction name="setCategories" access="public" output="false" returntype="void">
		<cfargument name="categories" type="array" required="true" />
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

	<cffunction name="getContents" access="public" output="false" returntype="array">
		<cfreturn variables.instance.contents />
	</cffunction>

	<cffunction name="setContents" access="public" output="false" returntype="void">
		<cfargument name="contents" type="array" required="true" />
		<cfset variables.instance.contents = arguments.contents />
		<cfreturn />
	</cffunction>

	<cffunction name="getContributors" access="public" output="false" returntype="array">
		<cfreturn variables.instance.contributors />
	</cffunction>

	<cffunction name="setContributors" access="public" output="false" returntype="void">
		<cfargument name="contributors" type="array" required="true" />
		<cfset variables.instance.contributors = arguments.contributors />
		<cfreturn />
	</cffunction>

	<cffunction name="getDescription" access="public" output="false" returntype="any">
		<cfreturn variables.instance.description />
	</cffunction>

	<cffunction name="setDescription" access="public" output="false" returntype="void">
		<cfargument name="description" type="com.mkville.rss.description" required="true" />
		<cfset variables.instance.description = arguments.description />
		<cfreturn />
	</cffunction>

	<cffunction name="setDescriptionSimple" access="public" output="false" returntype="void">
		<cfargument name="descValue" type="string" required="true" />
		<cfargument name="descType" type="string" default="" />
		<cfset var description = CreateObject("component", "com.mkville.rss.description").init() />
	    <cfset description.setValue(arguments.descValue)>
	    <cfif len(arguments.descType)>
		    <cfset description.setType(arguments.descType)>
		</cfif>
	    <cfset setDescription(description)>
		<cfreturn />
	</cffunction>

	<cffunction name="getEnclosures" access="public" output="false" returntype="array">
		<cfreturn variables.instance.enclosures />
	</cffunction>

	<cffunction name="setEnclosures" access="public" output="false" returntype="void">
		<cfargument name="enclosures" type="array" required="true" />
		<cfset variables.instance.enclosures = arguments.enclosures />
		<cfreturn />
	</cffunction>

	<cffunction name="addEnclosure" access="public" output="false" returntype="void">
		<cfargument name="enclosure" type="com.mkville.rss.enclosure" required="true" />
		<cfset variables.instance.enclosures.add(arguments.enclosure) />
	</cffunction>

	<cffunction name="addEnclosureSimple" access="public" output="false" returntype="void">
		<cfargument name="enclosureUrl" type="string" required="true" />
		<cfargument name="enclosureLength" type="string" required="true" />
		<cfargument name="enclosureType" type="string" required="true" />
		<cfset var enclosure = CreateObject("component", "com.mkville.rss.enclosure").init() />
	    <cfset enclosure.setUrl(arguments.enclosureUrl)>
	    <cfset enclosure.setLength(arguments.enclosureLength)>
	    <cfset enclosure.setType(arguments.enclosureType)>
	    <cfset addEnclosure(enclosure)>
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

	<cffunction name="getPubDate" access="public" output="false" returntype="date">
		<cfreturn variables.instance.pubDate />
	</cffunction>

	<cffunction name="setPubDate" access="public" output="false" returntype="void">
		<cfargument name="pubDate" type="date" required="true" />
		<cfset variables.instance.pubDate = arguments.pubDate />
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

	<!--- this cannot be toString() because of a built-in ColdFusion function by the same name --->
	<cffunction name="_toString" access="public" output="false" returntype="String">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var local=StructNew()>
		<cfset sb.append("[").append("Author").append("=").append(getAuthor()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Contents").append("=").append(ArrayToList(getContents())).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Contributors").append("=").append(ArrayToList(getContributors())).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Description").append("=").append(getDescription().getValue()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Link").append("=").append(getLink()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("pubDate").append("=").append(getpubDate()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Summary").append("=").append(getSummary()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Title").append("=").append(getTitle()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append("[").append("Uri").append("=").append(getUri()).append("]").append(variables.instance.LINE_DELIMITER)>
		<cfif ArrayLen(getCategories())>
			<cfset local.categories=getCategories()>
			<cfset sb.append("[").append("CATEGORIES_BEGIN").append("]").append(variables.instance.LINE_DELIMITER)>
			<cfloop from="1" to="#ArrayLen(local.categories)#" index="local.categoryCtr">
				<cfset sb.append(local.categories[local.categoryCtr]._toString())>
			</cfloop>
			<cfset sb.append("[").append("CATEGORIES_END").append("]").append(variables.instance.LINE_DELIMITER)>
		</cfif>
		<!--- TODO: enclosures, modules --->
		<cfreturn sb.toString() />
	</cffunction>

	<cffunction name="generate_rss091" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS091>
		<cfset var local=StructNew()>
		<cfset sb.append("<item>").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append(createXmlItem(getTitle(), "title"))>
		<cfset sb.append(createXmlItem(getLink(), "link"))>
		<cfif isObject(getDescription())>
			<cfset sb.append(getDescription().generate(FEED_TYPE))>
		</cfif>
		<cfset sb.append("</item>").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>

	<cffunction name="generate_rss092" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS092>
		<cfset var local=StructNew()>
		<cfset sb.append("<item>").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append(createXmlItem(getTitle(), "title"))>
		<cfset sb.append(createXmlItem(getLink(), "link"))>
		<cfif isObject(getDescription())>
			<cfset sb.append(getDescription().generate(FEED_TYPE))>
		</cfif>
		<!--- 0.92 spec allows for a single enclosure --->
		<cfif ArrayLen(getEnclosures())>
			<cfset local.enclosures=getEnclosures()>
			<cfif ArrayLen(local.enclosures) GTE 1>
				<cfset sb.append(local.enclosures[1].generate(FEED_TYPE))>
			</cfif>
		</cfif>
		<!--- 0.92 spec allows for a single category (I think) --->
		<cfif ArrayLen(getCategories())>
			<cfset local.categories=getCategories()>
			<cfif ArrayLen(local.categories) GTE 1>
				<cfset sb.append(local.categories[1].generate(FEED_TYPE))>
			</cfif>
		</cfif>
		<cfset sb.append("</item>").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS20>
		<cfset var local=StructNew()>
		<cfset sb.append("<item>").append(variables.instance.LINE_DELIMITER)>
		<cfset sb.append(createXmlItem(getTitle(), "title"))>
		<cfset sb.append(createXmlItem(getLink(), "link"))>
		<cfif isObject(getDescription())>
			<cfset sb.append(getDescription().generate(FEED_TYPE))>
		</cfif>
		<cfset sb.append(createXmlItem(getDateAsRFC822(getPubDate()), "pubDate"))>
		<cfset sb.append(createXmlItem(getLink(), "guid"))>
		<!---<cfif arguments.includeNamespaceDC>
			<cfset sb.append("<dc:creator>").append(local.entries[local.entryCtr].getAuthor()).append("</dc:creator>").append(CHR(13))>
		</cfif> --->
		<cfif ArrayLen(getEnclosures())>
			<cfset local.enclosures=getEnclosures()>
			<cfloop from="1" to="#ArrayLen(local.enclosures)#" index="local.enclosureCtr">
				<cfset sb.append(local.enclosures[local.enclosureCtr].generate(FEED_TYPE))>
			</cfloop>
		</cfif>
		<cfif ArrayLen(getCategories())>
			<cfset local.categories=getCategories()>
			<cfloop from="1" to="#ArrayLen(local.categories)#" index="local.categoryCtr">
				<cfset sb.append(local.categories[local.categoryCtr].generate(FEED_TYPE))>
			</cfloop>
		</cfif>
		<cfif ArrayLen(getModules())>
			<cfset local.modules=getModules()>
			<cfloop from="1" to="#ArrayLen(local.modules)#" index="local.moduleCtr">
				<cfset sb.append(local.modules[local.moduleCtr].generate(FEED_TYPE))>
			</cfloop>
		</cfif>
		<cfset sb.append("</item>").append(variables.instance.LINE_DELIMITER)>
		<cfreturn sb.toString() />
	</cffunction>
</cfcomponent>