<cfcomponent name="duration" hint="The content of this tag is shown in the Time column in iTunes." extends="com.mkville.rss.rss">

	<cfset variables.instance = structNew()>

	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.modules.itunes.duration">
		<cfset super.init()>
		<cfset variables.instance.milliseconds="">
		<cfreturn this />
	</cffunction>

	<cffunction name="getMilliseconds" access="public" output="false" returntype="any">
		<cfreturn variables.instancemilliseconds />
	</cffunction>

	<cffunction name="setMilliseconds" access="public" output="false" returntype="void">
		<cfargument name="milliseconds" type="any" required="true" />
		<cfset variables.instancemilliseconds = arguments.milliseconds />
		<cfreturn />
	</cffunction>

	<cffunction name="setTime" access="public" output="false" returntype="void">
		<cfargument name="durationTime" type="any" required="true" />
		<cfset var ms=0>
		<cfset var numItems=ListLen(arguments.durationTime, ":")>
		<!--- pass in HH:mm:ss or mm:ss or ss --->
		<cfloop from="1" to="#numItems#" index="ctr">
			<cfswitch expression="#ctr#">
				<cfcase value="1"><!--- seconds --->
					<cfset ms=ms + (ListLast(arguments.durationTime, ":") * 1000)>
				</cfcase>
				<cfcase value="2"><!--- minutes --->
					<cfset ms=ms + (ListGetAt(arguments.durationTime, numItems-ctr+1, ":") * 60 * 1000)>
				</cfcase>
				<cfcase value="3"><!--- hours --->
					<cfset ms=ms + (ListGetAt(arguments.durationTime, numItems-ctr+1, ":") * 60 * 60 * 1000)>
				</cfcase>
			</cfswitch>
		</cfloop>
		<cfset variables.instancemilliseconds = ms />
		<cfreturn />
	</cffunction>

	<cffunction name="getDurationHHMMSS" access="public" output="false" returntype="any">
		<!--- FROM: http://www.apple.com/itunes/podcasts/techspecs.html
		The tag can be formatted HH:MM:SS, H:MM:SS, MM:SS, or M:SS (H = hours, M = minutes, S = seconds). 
		If an integer is provided (no colon present), the value is assumed to be in seconds. If one 
		colon is present, the number to the left is assumed to be minutes, and the number to the right 
		is assumed to be seconds. If more than two colons are present, the numbers furthest to the right 
		are ignored.
		--->
		<cfset var dateObj="">
		<cfif len(getMilliseconds())>
			<!--- convert milliseconds to a datetime object --->
			<cfset dateObj=dateAdd("s", getMilliseconds()/1000, "january 1 1970 00:00:00")>
			<cfreturn TimeFormat(dateObj, "HH:mm:ss") />
		<cfelse>
			<cfreturn TimeFormat(0, "HH:mm:ss") />
		</cfif>
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfreturn createXmlItem(getDurationHHMMSS(), "itunes:duration") />
	</cffunction>

</cfcomponent>