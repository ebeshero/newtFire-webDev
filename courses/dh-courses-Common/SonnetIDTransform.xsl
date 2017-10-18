<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    <!--ebb: note on xsl:output: In this identity transformation stylesheet, the indent="no" setting should preserve the editor's original line indentation and stop the transformation from "pretty-printing" the output. It might have unexpected consequences, such that we may need to add some returns and white spaces, etc. -->
    
    <xsl:mode on-no-match="shallow-copy"/>
    <!-- This XSLT statement is the opposite of the xsl:template match. It says: 'if I do not write a template rule to match an element, attribute, or comment node, XSLT should simply make a copy of that element and output it.' -->
    
    <!--ghb: This template-match replaces those pesky Roman numerals with digits -->
    <xsl:template match="sonnet">
        <sonnet number="{count(preceding-sibling::sonnet) + 1}">
            <xsl:apply-templates select="line"/>
        </sonnet>
    <!--ghb: SUPER-IMPORTANT: enclose XPath statements that you want to execute inside {curly-braces}. Otherwise, your XPath will appear literally in your output file. Try removing them, above, and see for yourself! -->

    </xsl:template>
    
    
    <!--ghb: This template-match adds line-numbers as n-attributes -->    
    <xsl:template match="line">
        <line n="{position()}"><xsl:apply-templates/></line>
        
    </xsl:template>
      
        
        
    
    
</xsl:stylesheet>