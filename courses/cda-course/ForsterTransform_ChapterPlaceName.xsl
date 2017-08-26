<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Places Mentioned in Georg Forster Account</title>
            </head>
            <body>
                <h1>Places Listed in Each Chapter of Georg Forster's Voyage Record</h1>
                
                <ul>
                    <xsl:apply-templates select="//text/body//div[@type='chapter']"/>
                </ul>
            </body>
            
        </html>
    </xsl:template>
    
    <xsl:template match="div[@type='chapter']">
        
        <li><xsl:apply-templates select="head/l"/>
           
            <xsl:apply-templates select=".//placeName"/>
            
        </li>
        
    </xsl:template>
    
    <xsl:template match="placeName">
        <ul>
        <li><xsl:apply-templates/></li>
        </ul>
        
    </xsl:template>
</xsl:stylesheet> 