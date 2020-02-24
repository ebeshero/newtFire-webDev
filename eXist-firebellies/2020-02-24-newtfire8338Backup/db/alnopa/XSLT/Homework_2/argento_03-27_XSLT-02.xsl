<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs math" version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat" omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:apply-templates select="descendant::titleStmt/title"/></title>
                <link rel="stylesheet" href="argento_03-29_XSLT-02_css.css"/>
            </head>
            <body>
                <h1>
                    <xsl:apply-templates select="descendant::titleStmt/title"/>
                </h1>
                <h2>Cast List</h2>
                <div class="cast">
                    <div class="castAlphabet">
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Character</th>
                                <th>Count</th>
                            </tr>
                            <xsl:apply-templates select="descendant::profileDesc//person">
                                <xsl:sort select="attribute::xml:id"/>
                            </xsl:apply-templates>
                        </table>
                    </div>
                    <div class="castMentions">
                        <table>
                            <tr>
                                <th>ID</th>
                                <th>Character</th>
                                <th>Count</th>
                            </tr>
                            <xsl:apply-templates select="descendant::profileDesc//person">
                                <xsl:sort select="following::body//sp[substring-after(@who, '#') = current()/@xml:id] =&gt; count()" order="descending"/>
                            </xsl:apply-templates>
                        </table>
                    </div>
                </div>
                <h2>Script</h2>
                <div class="script">
                    <xsl:apply-templates select="descendant::body/sp"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="descendant::profileDesc//person">
        <tr>
            <td><xsl:apply-templates select="attribute::xml:id"/></td>
            <td><xsl:apply-templates select="child::persName[1]"/></td>
            <td><xsl:apply-templates select="following::body//sp[substring-after(@who, '#') = current()/@xml:id] =&gt; count()"/></td>
        </tr>
    </xsl:template>
    <xsl:template match="descendant::body/sp">
        <div class="sp">
            <span class="num"><xsl:apply-templates select="@n"/></span>
            <xsl:choose>
                <xsl:when test="current()[substring-after(@who, '#') = ('takashi', 'masaru', 'kiyoko', 'akira', 'miyako')]">
                    <span class="espers">
                        <strong>
                            <xsl:apply-templates select="substring-after(@who, '#')"/>
                            <xsl:text>: </xsl:text>
                        </strong>
                    </span>
                </xsl:when>
                <xsl:when test="current()[substring-after(@who, '#') = ('joker')]">
                    <span class="clown">
                        <strong>
                            <xsl:apply-templates select="substring-after(@who, '#')"/>
                            <xsl:text>: </xsl:text>
                        </strong>
                    </span>
                </xsl:when>
                <xsl:when test="current()[substring-after(@who, '#') = ('kaneda', 'tetsuo', 'yamagata', 'kai', 'kaori')]">
                    <span class="capsule">
                        <strong>
                            <xsl:apply-templates select="substring-after(@who, '#')"/>
                            <xsl:text>: </xsl:text>
                        </strong>
                    </span>
                </xsl:when>
                <xsl:when test="current()[substring-after(@who, '#') = ('kei', 'nezu')]">
                    <span class="resistance">
                        <strong>
                            <xsl:apply-templates select="substring-after(@who, '#')"/>
                            <xsl:text>: </xsl:text>
                        </strong>
                    </span>
                </xsl:when>
                <xsl:when test="current()[substring-after(@who, '#') = ('doctor', 'colonel')]">
                    <span class="government">
                        <strong>
                            <xsl:apply-templates select="substring-after(@who, '#')"/>
                            <xsl:text>: </xsl:text>
                        </strong>
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="extra">
                        <strong>
                            <xsl:apply-templates select="substring-after(@who, '#')"/>
                            <xsl:text>: </xsl:text>
                        </strong>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
            <span class="lines"><xsl:apply-templates select="l"/></span>
            <span class="time">
                <xsl:apply-templates select="@from"/>
                <xsl:text>-</xsl:text>
                <xsl:apply-templates select="@to"/>
            </span>
        </div>
    </xsl:template>

</xsl:stylesheet>