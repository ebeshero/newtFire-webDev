<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>

<!-- Use with 2.0:-->   <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
   <!-- <xsl:mode on-no-match="shallow-copy"/>-->
    <!--ebb: Use with XSLT 3.0 -->
    
    
    
    <xsl:template match="body">
        <body>
        <xsl:apply-templates/>
            <xsl:comment>#include virtual="bottom.html" </xsl:comment>
        </body>
    </xsl:template>
    
   
    
   

</xsl:stylesheet>
