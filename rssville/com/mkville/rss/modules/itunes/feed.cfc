<cfcomponent name="feed" extends="com.mkville.rss.modules.itunes.itunes"><!--- com.mkville.rss.module --->

	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.modules.itunes.feed">
		<cfset super.init()>
		<cfset variables.instance.image=""><!--- Image URL --->
		<cfset variables.instance.categories=ArrayNew(1)><!--- itunes category only!! --->
		<cfset variables.instance.owner="">
		<cfset variables.instance.newfeedurl="">
		<cfreturn this />
	</cffunction>

	<cffunction name="getImage" access="public" output="false" returntype="any">
		<cfreturn variables.instance.image />
	</cffunction>

	<cffunction name="setImage" access="public" output="false" returntype="void">
		<cfargument name="image" type="any" required="true" />
		<cfset variables.instance.image = arguments.image />
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
		<cfargument name="category" type="com.mkville.rss.modules.itunes.category" required="true" />
		<cfset variables.instance.categories.add(arguments.category) />
		<cfreturn />
	</cffunction>

	<cffunction name="addCategorySimple" access="public" output="false" returntype="void">
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="subCategoryName" type="string" default="" />
		<cfset var category = CreateObject("component", "com.mkville.rss.modules.itunes.category").init() />
	    <cfset category.setName(arguments.categoryName)>
	    <cfset category.setSubcategory(arguments.subCategoryName)>
	    <cfset addCategory(category)>
		<cfreturn />
	</cffunction>

	<cffunction name="getOwner" access="public" output="false" returntype="com.mkville.rss.modules.itunes.owner">
		<cfreturn variables.instance.owner />
	</cffunction>

	<cffunction name="setOwner" access="public" output="false" returntype="void">
		<cfargument name="owner" type="com.mkville.rss.modules.itunes.owner" required="true" />
		<cfset variables.instance.owner = arguments.owner />
		<cfreturn />
	</cffunction>

	<cffunction name="setOwnerSimple" access="public" output="false" returntype="void">
		<cfargument name="ownerName" type="string" required="true" />
		<cfargument name="ownerEmail" type="string" default="" />
		<cfset variables.instance.owner=CreateObject("component", "com.mkville.rss.modules.itunes.owner").init() />
	    <cfset variables.instance.owner.setName(arguments.ownerName)>
	    <cfset variables.instance.owner.setEmail(arguments.ownerEmail)>
		<cfreturn />
	</cffunction>

	<cffunction name="getNewFeedUrl" access="public" output="false" returntype="any">
		<cfreturn variables.instance.newfeedurl />
	</cffunction>

	<cffunction name="setNewFeedUrl" access="public" output="false" returntype="void">
		<cfargument name="newfeedurl" type="any" required="true" />
		<cfset variables.instance.newfeedurl = arguments.newfeedurl />
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS20>
		<cfset var local=StructNew()>
		<cfset sb.append(super.generate_rss20())>
		<cfset sb.append(createXmlItem(getNewFeedUrl(), "itunes:new-feed-url"))>
		<cfif ArrayLen(getCategories())>
			<cfset local.categories=getCategories()>
			<cfloop from="1" to="#ArrayLen(local.categories)#" index="local.categoryCtr">
				<cfset sb.append(local.categories[local.categoryCtr].generate(FEED_TYPE))>
			</cfloop>
		</cfif>
		<cfset sb.append(createXmlItem(getImage(), "itunes:image", "href"))>
		<cfif isObject(getOwner())>
			<cfset sb.append(getOwner().generate(FEED_TYPE))>
		</cfif>
		<cfreturn sb.toString() />
	</cffunction>

	<cffunction name="generateHeader_rss20" access="public" output="false" returntype="any">
		<cfreturn " xmlns:itunes=""http://www.itunes.com/dtds/podcast-1.0.dtd""">
	</cffunction>
</cfcomponent>