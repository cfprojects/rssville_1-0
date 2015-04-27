<cfcomponent name="entry" extends="com.mkville.rss.modules.itunes.itunes">

	<cfset variables.instance = structNew()>
	
	<cffunction name="init" access="public" output="false" returntype="com.mkville.rss.modules.itunes.entry">
		<cfset super.init()>
		<cfset variables.instance.duration="">
		<cfreturn this />
	</cffunction>

	<cffunction name="getDuration" access="public" output="false" returntype="com.mkville.rss.modules.itunes.duration">
		<cfreturn variables.instance.duration />
	</cffunction>

	<cffunction name="setDuration" access="public" output="false" returntype="void">
		<cfargument name="duration" type="com.mkville.rss.modules.itunes.duration" required="true" />
		<cfset variables.instance.duration = arguments.duration />
		<cfreturn />
	</cffunction>
	
	<cffunction name="setDurationSimple" access="public" output="false" returntype="void">
		<cfargument name="durationMilliseconds" type="string" required="true" />
		<cfset var duration = CreateObject("component", "com.mkville.rss.modules.itunes.duration").init() />
	    <cfset duration.setMilliseconds(arguments.durationMilliseconds)>
	    <cfset setDuration(duration)>
		<cfreturn />
	</cffunction>

	<cffunction name="setDurationTimeSimple" access="public" output="false" returntype="void">
		<cfargument name="durationTime" type="string" required="true" />
		<cfset var duration = CreateObject("component", "com.mkville.rss.modules.itunes.duration").init() />
	    <cfset duration.setTime(arguments.durationTime)>
	    <cfset setDuration(duration)>
		<cfreturn />
	</cffunction>

	<cffunction name="generate_rss20" access="private" output="false" returntype="string">
		<cfset var sb=CreateObject("java", "java.lang.StringBuffer")>
		<cfset var FEED_TYPE=variables.instance.FEED_TYPE_RSS20>
		<cfset sb.append(super.generate_rss20())>
		<cfif isObject(getDuration())>
			<cfset sb.append(getDuration().generate(FEED_TYPE))>
		</cfif>
		<cfreturn sb.toString() />
	</cffunction>

</cfcomponent>