<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="UTF-8" indent="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/> 
    <xsl:template match="/">
        <html>
        <p>Comments:</p>
        <ul>
            <xsl:apply-templates select="//comment//sentence"/>
        </ul>
        </html>
    </xsl:template>
    <xsl:template match="sentence">
        <li><span class="{../@tone}">
            <xsl:apply-templates />
        </span></li>
    </xsl:template>
</xsl:stylesheet>