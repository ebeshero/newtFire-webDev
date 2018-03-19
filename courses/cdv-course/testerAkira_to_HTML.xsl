<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>

<xsl:template match="/">
    <html>
        <head>
            <title><xsl:apply-templates select="//teiHeader//title"/></title>
            <link rel="stylesheet" type="text/css" href="akira.css"/>
        </head>
 <body>
     <h1><xsl:apply-templates select="//teiHeader//title"/></h1>
     <h2>Cast of Characters Sorted Alphabetically</h2>
     <table>
         <tr>        <th>ID</th><th>Character</th><th>Count</th>
         </tr>
         <xsl:apply-templates select="descendant::particDesc//person">
             <xsl:sort select="@xml:id" order="ascending"/>
             <!--ebb: Here's an alphabetically sorted table.-->
         </xsl:apply-templates>
     </table>
     <h2>Cast of Characters Sorted by Count</h2>
     <table>
         <tr>        <th>ID</th><th>Character</th><th>Count</th>
         </tr>
         <xsl:apply-templates select="descendant::particDesc//person">
             <xsl:sort select="count(//sp[substring-after(@who, '#') = current()/@xml:id])" order="descending"/>
             <!--ebb: Here's a table sorted by the count of the characters. -->
         </xsl:apply-templates>
     </table>
     <h2>Script</h2>
     <xsl:apply-templates select="descendant::body"/>
 </body>
    </html>
</xsl:template>
    
    <xsl:template match="person">
        <tr>
            <td><strong><xsl:apply-templates select="@xml:id"/></strong></td>
            <td><xsl:apply-templates select="child::persName[1]"/></td>
            <td><xsl:value-of select="count(ancestor::TEI//sp[substring-after(@who, '#') = current()/@xml:id])"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="spGrp">
        <div class="spGrp">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="sp">
        <div class="sp">
        <span class="num"><xsl:apply-templates select="@n"/></span>
   <strong><!--ebb: This dereferencing works, but with this team's code it doesn't look great. <xsl:apply-templates select="//particDesc//person[@xml:id=substring-after(current()/@who, '#')]/persName[1]"/>-->
       <xsl:apply-templates select="substring-after(@who, '#')"/>
       <xsl:text>: </xsl:text></strong><xsl:apply-templates/>
           <span class="time"><xsl:apply-templates select="@from"/>-<xsl:apply-templates select="@to"/></span>
        </div>
    </xsl:template>
    <!--ebb: Special template rule for the doctor and the colonel -->
    <xsl:template match="sp[@who='#doctor'] | sp[@who='colonel']">
        <div class="commanders">
            <span class="num"><xsl:apply-templates select="@n"/></span>
            <strong><xsl:apply-templates select="substring-after(@who, '#')"/><xsl:text>: </xsl:text></strong><xsl:apply-templates/>
            <span class="time"><xsl:apply-templates select="@from"/><xsl:text>-</xsl:text><xsl:apply-templates select="@to"/></span>
        </div>
    </xsl:template>
    
</xsl:stylesheet>