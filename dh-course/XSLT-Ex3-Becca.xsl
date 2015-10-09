<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
  
    xmlns="http://www.w3.org/1999/xhtml"
    >
    <xsl:output method="xhtml" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Nell Nelson Exposes the Working Conditions of Named Companies with Exact Addresses: According to a Chicago Daily News Article Published on July 30th, 1888</title>
            </head>
            <body>
                <table>
                <tr>
                    <th>Company</th>
                    <th>Address</th>
                    <th>Wage Descriptions</th>
                </tr>
                <xsl:apply-templates select="//articleBody"/>
                </table>
            </body>            
        </html>
    </xsl:template>
   <xsl:template match="articleBody">
        <tr>
            <td>
                <xsl:apply-templates select="distinct-values(//company/@ref)"/>
               <!--<xsl:for-each select="company[@ref]">
                    <xsl:value-of select="."/>
                </xsl:for-each>-->
            </td>
            <td>
                <xsl:apply-templates select="distinct-values(//location[@ref][@type='address'])"/>
            </td>
            <td>
                <xsl:apply-templates select="//workingConditions[@ref][@category='wageDesc']"/>
            </td>
        </tr>
   </xsl:template>
    
    
    
</xsl:stylesheet>