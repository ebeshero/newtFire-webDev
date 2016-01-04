<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xml" indent="no"/>
    <!--ebb: note on xsl:output: In this identity transformation stylesheet, the indent="no" setting should preserve the editor's original line indentation and stop the transformation from "pretty-printing" the output. It might have unexpected consequences, such that we may need to add some returns and white spaces, etc. -->
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <!--ebb: The above template rule makes this an Identity Transformation in XSLT version 2.0, exactly reproducing the entire XML file. We can now write rules to add or alter things in the XML document, such as to number lines. -->
    
   <xsl:template match="sonnet">
        <sonnet number="{count(preceding-sibling::sonnet) + 1}">
            <xsl:apply-templates select="line"/>
        </sonnet>
     
    </xsl:template>
    
    <xsl:template match="line">
        <line n="{position()}"><xsl:apply-templates/></line>
        
    </xsl:template>
            
        
        
    
    
</xsl:stylesheet>