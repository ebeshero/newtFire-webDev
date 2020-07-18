<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs math" version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:apply-templates select="descendant::titleStmt/title"/></title>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="descendant::titleStmt/title"/>
                </h1>
                <h2>Cast List</h2>
                <table style="width:100%">
                    <tr>
                        <th>ID</th>
                        <th>Character</th>
                    </tr>
                    <xsl:apply-templates select="descendant::profileDesc//person">
                        <xsl:sort select="attribute::xml:id"/>
                    </xsl:apply-templates>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="descendant::profileDesc//person">
        <tr>
            <td><xsl:apply-templates select="attribute::xml:id"/></td>
            <td><xsl:apply-templates select="child::persName[1]"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>