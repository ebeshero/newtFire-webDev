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
 
 <!--ebb: added 2019-01-06 to transform the bad old div-based template for the schedule. 
The following templates will be unnecessary if I've already started with the TEI table structure.
 -->
   <!-- <xsl:template match="div[@type='day']">
        <row role="day">
            <xsl:apply-templates/>
        </row>
    </xsl:template>
    <xsl:template match="head">
        <cell role="date">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    <xsl:template match="div[@type='inclass']">
        <cell role="inclass">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    <xsl:template match="div[@type='assign']">
        <cell role="assign">
            <xsl:apply-templates/>
        </cell>
    </xsl:template>-->
    
</xsl:stylesheet>
    
