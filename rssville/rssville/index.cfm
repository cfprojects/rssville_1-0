<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<meta http-equiv="Content-type" content="text/html; charset=iso-8859-1" />
<title>RSSVille ColdFusion RSS Creation</title>
</head>

<body>
<h1>RSSVille ColdFusion RSS Creation</h1>
<h2>Notes</h2>
<p>iTunes podcasts are only available with RSS 2.0 output because RSS the 0.9x specifications do not allow
for extensible modules. The feed generator will only output the appropriate data for the given feed type,
so even if you define the itunes module in a feed, you won't see the iTunes xml output unless you specify
RSS 2.0 for the feed type.</p>

<h2>Example Feeds</h2>
<cfset baseUrl="http://#cgi.HTTP_HOST#/#ListDeleteAt(cgi.SCRIPT_NAME, ListLen(cgi.SCRIPT_NAME, "/"), "/")#/">
<cfset validateBaseUrl="http://validator.w3.org/feed/check.cgi?#URLEncodedFormat(baseUrl)#">
<cfset feedTypeList="rss_0.91,rss_0.92,rss_2.0">
<cfset showValidateLink=(cgi.HTTP_HOST NEQ "localhost")>
<cfset sampleList="Simple,Podcast">
<cfoutput>
<ul>
	<cfloop list="#sampleList#" index="currSample">
		<li>#currSample# Sample:
			<ul>
				<cfloop list="#feedTypeList#" index="currFeedType">
					<cfset feedLink="#lcase(currSample)#.cfm?feedtype=#currFeedType#">
					<li>
						<a href="#feedLink#">#UCase(Replace(currFeedType, "_", " ", "ALL"))# Feed</a>
						<cfif showValidateLink>
							 | <a href="#validateBaseUrl##URLEncodedFormat(feedLink)#">Validate Feed</a></li>
						</cfif>
					</li>
				</cfloop>
			</ul>
		</li>
	</cfloop>
</ul>
<hr />
<ul>
	<li>Project Home: <a href="http://www.mkville.com/projects/rssville/">http://www.mkville.com/projects/rssville/</a></li>
	<li>MKVille Blog: <a href="http://www.mkville.com/blog/">http://www.mkville.com/blog/</a></li>
</ul>
</cfoutput>
</body>
</html>