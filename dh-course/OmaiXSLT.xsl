<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xhtml" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:apply-templates select="//titleStmt//title[@type='main']" mode="head"/></title>
                <link rel="stylesheet" type="text/css" href="Omai.css"/>
                <script type="text/javascript" src="ElegyJSColorNotes.js" xml:space="preserve"></script>
            </head>
            <body>
                <h1><xsl:apply-templates select="//titleStmt//title[@type='main']"/></h1>
                <h2><xsl:apply-templates select="//titleStmt//title[@type='sub']"/></h2>
                
                <div>
                    <p>
                        <xsl:apply-templates select="//text//performance"/>
                        <a href="{ref/@target}"><xsl:apply-templates select="ref"/></a>
   
                    </p>
                    
                </div>
                <div>
                    
                    <h2><xsl:apply-templates select="//text/front//castList/head"/> </h2>
                    <table>
                       <xsl:apply-templates select="//text/front//castList/castGroup"/>
                      
                        
                    </table>
                </div>
                <div>
                    
                    
                    <xsl:apply-templates select="//text/body/div[@type='part']"/>
                    
                </div>
               
                        
        
  
            </body>
        </html>
    </xsl:template>
        
        <xsl:template match="div[@type='part']/head">
          
                <h2><xsl:apply-templates/></h2>
                
            
        </xsl:template>
        
     
        <xsl:template match="div[@type='scene']/head">
            <div>
                <h3><xsl:apply-templates/></h3>
                
           
            </div> 
        </xsl:template>

    <xsl:template match="castItem">
       <tr>
           <td> <ul><xsl:apply-templates select="role"/> </ul></td>
           
           <td><ul><xsl:apply-templates select="actor"/>
              
           </ul>
           </td>
           
       </tr>
       
    </xsl:template>
      <xsl:template match="actor">
        <li><xsl:apply-templates/></li>
          
      </xsl:template>
        
        <xsl:template match="role">
            <li><xsl:apply-templates/></li>
            
        </xsl:template>

        <xsl:template match="note">
          
            <span id="N{count(preceding::note)+1}" class="anchor"><xsl:text>[</xsl:text><xsl:value-of select="count(preceding::note)+1"/><xsl:text>]</xsl:text><span class="note"><xsl:apply-templates/> </span></span>
     
        </xsl:template>
        
        <xsl:template match="sp">
            
            
            <p><span class="speech"><xsl:apply-templates/></span>              

            </p>
            
            
        </xsl:template>
        <xsl:template match="speaker">
            <h4><xsl:apply-templates/><xsl-text>: </xsl-text></h4>
            
        </xsl:template>
        
        <xsl:template match="l">
            <xsl:value-of select="count(preceding::l)+1"/><xsl:text> </xsl:text>
            <xsl:apply-templates/><br/> 
            
        </xsl:template>
 <xsl:template match="stage">
     <p> <i>[<span class="stage"><xsl:apply-templates/></span>]</i></p>
     
 </xsl:template>

</xsl:stylesheet>

