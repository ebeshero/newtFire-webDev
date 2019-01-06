<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
   
    <xsl:output method="xhtml" doctype-system="about:legacy-compat" 
        omit-xml-declaration="yes"/> 
    <!--<xsl:strip-space elements="*"/>-->
    <!-- ebb: This XSLT reads from the current TEI syllabus file and outputs the course policies page.-->
    <xsl:template match="/">
       
        <html>
       
            <head>
                <title><xsl:apply-templates select="//fileDesc//title"/> </title>
                <meta name="Description"
                    content="Supported by the University of Pittsburgh at Greensburg"/>
                <meta name="keywords"
                    content="Digital Humanities, Syllabus, XML, TEI, XSLT, XQuery, Schematron, Relax NG, SVG, digital scholarship, digital edition, electronic edition, electronic text, humanities computing, electronic editing, Beshero-Bondar"/>
               <link rel="stylesheet" type="text/css" href="syllsched.css"/>
             
               

            </head>
            <body>
                
                <xsl:comment>#include virtual="top-indexCDV19.html" </xsl:comment>
                <!--ebb: make a new top for each XML for each new semester course-->

                <h1><span class="banner"><xsl:apply-templates select="//text/front/div[@type='courseID']/head"/></span></h1>
                    
                    <h2><span class="banner"><xsl:apply-templates select="//text/front/div[@type='courseID']/p/text()"/></span></h2>
                   
                   
             <div id="main">   <div id="courseInfo">
                   <xsl:apply-templates select="//div[@type='meetTimes']"/>
                    
                 <h2><a href="CDVSyll.html">Syllabus: Spring 2019</a></h2><!--ebb: Check link URL! -->
                    
                    <xsl:apply-templates select="//div[@type='CRN']"/>
                 
               
                    
                   
                    
                    <xsl:apply-templates select="//div[@type='faculty']"/>
                 <xsl:apply-templates select="//div[@type='projects']"/>
                 
                 <xsl:apply-templates select="//div[@type='guides']/head"/>
                    
                    
                    
                    <xsl:apply-templates select="//div[@type='online']"/>
                    
                    
                    
                    <xsl:apply-templates select="//div[@type='courseMtls']"/>
                    
                </div>
                
                <div id="description">
                    
                    <xsl:apply-templates select="//div[@type='description']"/>
                    
                    <xsl:apply-templates select="//div[@type='objectives']"/>
                    
                   <xsl:apply-templates select="//div[@type='optionalTexts']"/>
                </div>
                <div id="grading">
                    
                    <xsl:apply-templates select="//div[@type='grading']"/>
                    
      
                </div>
                <div id="policies">
                    <xsl:apply-templates select="//div[@type='policies']"/>
                    
                </div>
                
                <div id="resources">
                    
                    <xsl:apply-templates select="//div[@type='resources']"/>
                </div>
                
                <div id="extProjects">
                    <xsl:apply-templates select="//div[@type='extProjects']"/>
                </div>
                
                    
                    
             
              
                
                </div>
                <hr/>
               
                    


            </body>
        </html>


    </xsl:template>
    
    <xsl:template match="div[@style='main']/head">
        <h2><xsl:apply-templates/></h2>
        
    </xsl:template>
    
    <xsl:template match="div[not(@style='main')][not(@style='outer')]/head">
        <h3><xsl:apply-templates/></h3>
        
    </xsl:template>
    
    <xsl:template match="list[not(@type='numbered')]">
        <ul>
            <xsl:apply-templates/>
            
        </ul>
        
    </xsl:template>
    
    <xsl:template match="list[@type='numbered']">
        <ol>
            <xsl:apply-templates/>
            
        </ol>
        
    </xsl:template>
    
    <xsl:template match="item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
        
    <xsl:template match="ref">
        <a href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
  
      <xsl:template match="hi[@rend='em'] | hi[not(@rend)]">
          <strong><xsl:apply-templates/></strong>          
      </xsl:template>
    <xsl:template match="hi[@rend='ital'] | hi[@rend='italic'] | hi[@rend='italics']">
        <em><xsl:apply-templates/></em>          
    </xsl:template>
    
    
    <xsl:template match="note">
        <xsl:text> </xsl:text><span class="smaller"><xsl:apply-templates/></span>
    </xsl:template>


    <xsl:template match="text//title[not(@level)] | text//title[@level='m']">
       <cite><xsl:apply-templates/></cite>  
   </xsl:template>
    
    <xsl:template match="text//title[@level='a']">
        <cite class="sub"><xsl:apply-templates/></cite>     
    </xsl:template>
    
    <xsl:template match="q">
        <q><xsl:apply-templates/></q>
    </xsl:template>

</xsl:stylesheet>
