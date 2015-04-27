<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">
<!---
PROGRAM: /rssville/Podcast Sample.cfm
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

<cfset syndFeed.setTitle("Podcast Sample RSS Feed")>
<cfset syndFeed.setDescription("Your source for what's new and exciting at my site.")>
<cfset syndFeed.setAuthor("The Author Name")>
<cfset syndFeed.setLink("http://www.yourcompany.com/your/web/site")>
<cfset syndFeed.setCopyright("This work is Copyright &##xA9; #year(now())# by Whomever You Want")>
<cfset syndFeed.setLanguage("en-us")>
<!--- free-form category --->
<cfset syndFeed.addCategorySimple("News")>
<cfset syndFeed.setWebmaster("webmaster@yourcompany.com")>
<!--- add an image --->
<cfset syndImage = CreateObject("component", "com.mkville.rss.image").init()>
<cfset syndImage.setUrl("http://www.cedarville.edu/president/images/brown_podcast_feed.jpg")>
<cfset syndImage.setTitle(syndFeed.getTitle())>
<cfset syndImage.setLink(syndFeed.getLink())>
<cfset syndImage.setWidth(144)>
<cfset syndImage.setHeight(144)>
<cfset syndFeed.setImage(syndImage)>

<!---modules - iTunes --->
<cfset itunesFeed = CreateObject("component", "com.mkville.rss.modules.itunes.feed").init()>
<!--- these must be official iTunes categories --->
<cfset itunesFeed.addCategorySimple("Education", "Higher Education")>
<cfset itunesFeed.addCategorySimple("Society & Culture", "Philosophy")>
<cfset itunesFeed.setOwnerSimple("The Owner", "webmaster@yourcompany.com")>
<cfset itunesFeed.addKeyword("Philosophy,Higher Education,Knowledge")>
<cfset itunesFeed.setAuthor(syndFeed.getAuthor())><!---iTunes "Artist" --->
<cfset itunesFeed.setSummary(syndFeed.getDescription())>
<cfset itunesFeed.setImage("http://www.yourcompany.com/podcast/images_podcast_itunes.jpg")><!---image URL; images must be jpg or png, at least 300x300 square --->
<cfset syndFeed.addModule(itunesFeed)>

<!--- items: typically loop through a query to create a series of items; here we'll just manually add some --->
<!--- item number 1 --->
<cfset entry = CreateObject("component", "com.mkville.rss.entry").init()>
<cfset entry.setTitle("Story item number 1")>
<!--- free-form category --->
<cfset entry.addCategorySimple("News")>
<cfset entry.setDescriptionSimple("Part or all of your story item.")>
<cfset entry.setLink("http://www.yourcompany.com/your/web/site/unique/story/item/url/1")>
<cfset entry.setPubDate(DateAdd("d", now(), -1))>
<!--- add the enclosure --->
<cfset entry.addEnclosureSimple("http://www.yourcompany.com/your/web/site/unique/story/item/url/1.mp3", "4561230", "audio/mpeg")>
<!--- iTunes module --->
<cfset itunesEntry = CreateObject("component", "com.mkville.rss.modules.itunes.entry").init()>
<cfset itunesEntry.setDurationTimeSimple("0:10:34")><!--- zero hours, ten minutes, thirty four seconds --->
<cfset itunesEntry.setAuthor("The Author of the Podcast")>
<cfset itunesEntry.setSummary("A great description of the podcast.")>
<cfset entry.addModule(itunesEntry)>
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
<!--- add the enclosure --->
<cfset entry.addEnclosureSimple("http://www.yourcompany.com/your/web/site/unique/story/item/url/2.mp3", "78123654", "audio/mpeg")>
<!--- iTunes module --->
<cfset itunesEntry = CreateObject("component", "com.mkville.rss.modules.itunes.entry").init()>
<cfset itunesEntry.setDurationTimeSimple("0:52:10")>
<cfset itunesEntry.setAuthor("The Author of the Podcast")>
<cfset itunesEntry.setSummary("A great description of the podcast.")>
<cfset entry.addModule(itunesEntry)>
<!--- add the entry to the feed --->
<cfset syndFeed.addEntry(entry)>

<!--- generate the feed output --->
<cfoutput>#syndFeed.generate(feedType)#</cfoutput>
