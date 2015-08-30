<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>

<!-- ebb: Use with XSLT version 2.0-->   
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
   <!-- <xsl:mode on-no-match="shallow-copy"/>-->
    <!--ebb: Use with XSLT 3.0 -->
    
    <xsl:template match="div[@id='space']">
        <xsl:apply-templates/>
        
    </xsl:template>
    
    <xsl:template match="body">
        <body>
          <xsl:comment>#include virtual="top.html" </xsl:comment>
        <xsl:apply-templates/>
        </body>
    </xsl:template>
    
    <xsl:template match="div[@id='title']">
        <h1><span class="banner"><xsl:value-of select=".//span[@class='banner']"/></span></h1>    
    </xsl:template>
    
    <xsl:template match="b">
      <xsl:choose>  
        <xsl:when test="./parent::body | parent::div">
            <h3><xsl:apply-templates/></h3>
        </xsl:when>
      <xsl:otherwise>
          <b><xsl:apply-templates/></b>
      </xsl:otherwise>
      </xsl:choose>
        
    </xsl:template>
    
    
    <xsl:template match="p[@class='boilerplate']">    
    </xsl:template>
    
    <xsl:template match="hr">    
    </xsl:template>
    
   

</xsl:stylesheet>
