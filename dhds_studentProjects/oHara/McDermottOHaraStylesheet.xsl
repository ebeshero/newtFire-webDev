<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.ord/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" indent="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:preserve-space elements="p li name"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Frank O'Hara Poetry</title>
            </head>
            <body>
                <h1>Poetry by Frank O'Hara</h1>
                <hr/>
                <h2><xsl:apply-templates select="//title"/></h2>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="ref">
        <a href="{@what}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <xsl:template match="line">
        <xsl:if test="not(position()=last())">
            <xsl:apply-templates/><br/>
        </xsl:if>
        <xsl:if test="position()=last()">
            <xsl:apply-templates/><br/><br/>
        </xsl:if>
    </xsl:template>
    
   
    
    </xsl:stylesheet>