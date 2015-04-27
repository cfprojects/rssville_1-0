<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">
<!---
PROGRAM: /rssville/Simple Sample.cfm
CREATED: 17-OCT-2006-MBM
UPDATES:
--->
<cfparam name="asxml" default="true">
<cfif asXml>
	<cfcontent type="application/xml">
</cfif>
<!---feed/channel --->
<cfset syndFeed = CreateObject("component", "com.mkville.rss.feed").init()>
<!--- validate the passed feed type --->
<cfparam name="feedtype" default="#syndFeed.FEED_TYPE_RSS20#">
<cfif NOT syndFeed.IsValidFeedType(feedtype)>
	<cfthrow message="Invalid feed type specified.">
</cfif>

<cfset syndFeed.setTitle("Simple Sample RSS Feed")>
<cfset syndFeed.setDescription("Your source for what's new and exciting at my site.")>
<cfset syndFeed.setAuthor("The Author Name")>
<cfset syndFeed.setLink("http://www.yourcompany.com/your/web/site")>
<cfset syndFeed.setCopyright("This work is Copyright &##xA9; #year(now())# by Whomever You Want")>
<cfset syndFeed.setLanguage("en-us")>
<!--- free-form category --->
<cfset syndFeed.addCategorySimple("News")>
<cfset syndFeed.setWebmaster("webmaster@yourcompany.com")>

<!--- items: typically loop through a query to create a series of items; here we'll just manually add some --->
<!--- item number 1 --->
<cfset entry = CreateObject("component", "com.mkville.rss.entry").init()>
<cfset entry.setTitle("Story item number 1")>
<!--- free-form category --->
<cfset entry.addCategorySimple("News")>
<cfset entry.setDescriptionSimple("Part or all of your story item.")>
<cfset entry.setLink("http://www.yourcompany.com/your/web/site/unique/story/item/url/1")>
<cfset entry.setPubDate(DateAdd("d", now(), -1))>
<!--- add the entry to the feed --->
<cfset syndFeed.addEntry(entry)>

<!--- item number 2 --->
<cfset entry = CreateObject("component", "com.mkville.rss.entry").init()>
<cfset entry.setTitle("Story item number 2")>
<!--- free-form category --->
<cfset entry.addCategorySimple("News")>
<cfset entry.setDescriptionSimple("Part or all of your story item.")>
<cfset entry.setLink("http://www.yourcompany.com/your/web/site/unique/story/item/url/2")>
<cfset entry.setPubDate(DateAdd("d", now(), -2))>
<!--- add the entry to the feed --->
<cfset syndFeed.addEntry(entry)>

<!--- generate the feed output --->
<cfoutput>#syndFeed.generate(feedType)#</cfoutput>
