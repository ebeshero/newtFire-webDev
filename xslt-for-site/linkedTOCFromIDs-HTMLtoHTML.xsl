<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.w3.org/1999/xhtml"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" omit-xml-declaration="yes" />
    <!--2020-05-06 eb: This stylesheet reads ids from any heading element in the content of an HTML document, 
        and creates a linked table of contents at the top of the document following the first top-level title.
    This is also an up-conversion from github markdown files as they were displayed on a GitHub repo, 
    so the stylesheet is also relocating pointers to images. 
   Note: This stylesheet also updates how I get the DOCTYPE declaration following advice on the oXygen forum:
    https://www.oxygenxml.com/forum/topic6745.html
    -->
    
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
   <xsl:template match="body">
      <body>
       <xsl:apply-templates select="comment()"/>
        <xsl:apply-templates select="child::*[1]"/>
        <h2>Contents</h2>
       <ul>
           <xsl:for-each select="descendant::*[name()[matches(., '^h[2-9]$')]][@id]">
               <li><a href="#{@id}"><xsl:value-of select="current()"/></a></li>
           </xsl:for-each>
       </ul>
        <xsl:apply-templates select="child::*[position() gt 1]"/>
      </body>
   </xsl:template>
   <xsl:template match="a[img] | img">
       <xsl:element name="{name()}">
           <xsl:copy-of select="current()/@*[not(name() = ('href', 'src'))]"/>
           <xsl:if test="name() = 'a'">
               <xsl:attribute name="href">
                   <xsl:value-of select="substring-after(@href, 'QGIS/')"/>
               </xsl:attribute>
           </xsl:if>
           <xsl:if test="name() = 'img'">
               <xsl:attribute name="src">
                   <xsl:value-of select="substring-after(@src, 'QGIS/')"/>
               </xsl:attribute>
           </xsl:if>
           <xsl:apply-templates/>
       </xsl:element>
       
   </xsl:template>
    
</xsl:stylesheet>