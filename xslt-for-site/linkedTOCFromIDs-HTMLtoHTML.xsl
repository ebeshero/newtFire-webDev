<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="html" version="5.0" encoding="utf-8" />
    <!--2020-05-06 eb: This stylesheet reads ids from any heading element in the content of an HTML document, 
        and creates a linked table of contents at the top of the document following the first top-level title.
    NOTE: Learned from this how to deliver the simple <!DOCTYPE html> at the top of the file from 
    https://stackoverflow.com/questions/3387127/set-html5-doctype-with-xslt
    -->
    <xsl:mode on-no-match="shallow-copy"/>
    
   <xsl:template match="body">
      <body>
       <xsl:apply-templates select="comment()"/>
        <xsl:apply-templates select="child::*[1]"/>
       <ul>
           <xsl:for-each select="descendant::*[name()[matches(., '^h[2-9]$')]][@id]">
               <li><a href="#{@id}"><xsl:apply-templates select="current()"/></a></li>
           </xsl:for-each>
       </ul>
        <xsl:apply-templates select="child::*[position() gt 1]"/>
      </body>
   </xsl:template>
    
</xsl:stylesheet>