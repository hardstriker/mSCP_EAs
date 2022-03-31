
<?xml version="1.0" encoding="UTF-8"?>
<extensionAttribute>
<displayName>mSCP - Baseline Exemptions</displayName>
<displayInCategory>Operating System</displayInCategory>
<dataType>string</dataType>
<description>Lists out any exemptions configured in mSCP</description>
<scriptContentsMac>#!/bin/sh
#
# mSCP-BaselineExemptions.sh
# Written by Jordan Burnette (jburnette@vcu.edu)
# Date Created 2022.03.31
###### Description
# Determines the baseline version being used and lists out any exemptions that are deployed to the machine. 
######

baselineVersion=$(ls -l /Library/Preferences | /usr/bin/grep 'org.*.audit.plist' | /usr/bin/awk '{print $9}')

auditfile="/Library/Managed Preferences/${baselineVersion}"
/usr/bin/plutil -convert xml1 "${auditfile}"

if [[ $(/usr/bin/grep "<key>exempt</key>" "${auditfile}" 2> /dev/null) ]] ; then
	result="$(/usr/bin/defaults read "${auditfile}" 2> /dev/null | /usr/bin/grep -B3 "exempt = 1" | /usr/bin/grep "{" | /usr/bin/cut -d '"' -f2 | tail -2)"
else
	result=""
fi

/bin/echo "<result>$result</result>"
</scriptContentsMac>
</extensionAttribute>
