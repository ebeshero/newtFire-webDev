<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    version="3.0">
 <!--ebb: This adds week numbers to the schedule template for a given semester. Updated in August 2018 to work on table elements rather than divs. -->   
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="table[@type='week']">
        
        <table type="week" n="{count(preceding-sibling::table[@type='week']) + 1}"><xsl:apply-templates/></table>
    </xsl:template>
    
    
</xsl:stylesheet>
    
