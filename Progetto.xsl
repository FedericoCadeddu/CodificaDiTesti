<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
  <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
      <html>
        <head>
          <link rel="stylesheet" type="text/css" href="stile.css" />
          <meta charset="utf-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <title><xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></title>
        </head>

        <body>
          <header>
          </header>

          <main>
          
            <section>
              <div>
                <h1 id="main-title"> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='full']"/></h1>
                <h2> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/></h2>
              </div>
              <div>
              <h4>Descrizione:</h4>
                <p><xsl:apply-templates select="//tei:msDesc" /></p>
              </div>
              <div>
              <h4>Condizioni manoscritto:</h4>
                <p><xsl:apply-templates select="//tei:physDesc" /></p>
              </div>
              <div>
              <h4>Storia:</h4>
                <p><xsl:apply-templates select="//tei:history" /></p>
              </div>
            </section>
           
            <section>
              <div>
                <xsl:apply-templates select="//tei:facsimile" />
              </div>
            </section>
            
            <section>
              <div>
                <h4>Testo:</h4>
                <xsl:apply-templates select="//tei:group" />
              </div>
            </section>
            
            <section>
              <div>
                <xsl:apply-templates select="//tei:listPerson" />
              </div>
            </section>
            
            <section>
              <div>
                <xsl:apply-templates select="//tei:listPlace" />
              </div>
            </section>
            <section>
              <div>
                <xsl:apply-templates select="//tei:listOrg" />
              </div>
            </section>
          </main>
          <footer>
              <div>
                <h4>Bibliografia:</h4>
                <xsl:apply-templates select="//tei:listBibl" />
              </div>
          </footer>
        </body>
      </html>
    </xsl:template>

  
    <xsl:template match="tei:msDesc">
        <div>
            <div >
                <h3>Titolo:</h3>
                <p><xsl:value-of select="tei:msContents/tei:title"/></p>
            </div>
            <div >
                <h3>Autore:</h3>
                <p><xsl:value-of select="tei:msContents/tei:author"/></p>
            </div>
            <div>
                <h3>Luogo:</h3>
                <p><xsl:value-of select="tei:msIdentifier/tei:settlement"/>, 
                    <xsl:value-of select="tei:msIdentifier/tei:country"/></p>
            </div>
            <div>
                <h3>Conservazione:</h3>
                <p><xsl:value-of select="tei:msIdentifier/tei:repository"/>,
                    <xsl:value-of select="tei:msIdentifier/tei:collection"/></p>
            </div>
            <div>
                <h3>Codice documento:</h3>
                <p><xsl:value-of select="tei:msIdentifier/tei:idno"/></p>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:physDesc">
        <div>
            <div>
                <h3>Supporto:</h3>
                <p><xsl:value-of select="tei:objectDesc/tei:supportDesc/tei:support"/></p>
            </div>
            <div >
                <h3>Pagine:</h3>
                <p><xsl:value-of select="tei:objectDesc/tei:supportDesc/tei:extent/tei:measure"/></p>
            </div>
            <div >
                <h3>Condizioni:</h3>
                <p><xsl:value-of select="tei:objectDesc/tei:supportDesc/tei:condition"/></p>
            </div>
            <div>
                <h3>Mani:</h3>
                <p><xsl:value-of select="tei:handDesc/tei:handNote/tei:p"/></p>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="tei:history">
        <p class="hist"><xsl:value-of select="tei:origin/tei:p"/></p>
    </xsl:template>
    

    <xsl:template match="tei:facsimile">
        <xsl:for-each select="tei:surface">
            <xsl:element name="img">
                <xsl:attribute name="class">img_class</xsl:attribute>
                <xsl:attribute name="src"><xsl:value-of select="tei:graphic/@url"/></xsl:attribute>
                <xsl:attribute name="usemap">#<xsl:value-of select="@xml:id"/></xsl:attribute>
                <xsl:attribute name="alt">Pagina <xsl:value-of select="tei:graphic/@n"/></xsl:attribute>
            </xsl:element>
            <xsl:element name="map">
                <xsl:attribute name="name"><xsl:value-of select="@xml:id" /></xsl:attribute>
                <xsl:variable name="width">
                    <xsl:value-of select="substring-before(tei:graphic/@width, 'px')"/>   
                </xsl:variable>          
                <xsl:variable name="ratio" select="750 div $width"/> 
                <xsl:for-each select="tei:zone[@rendition='line']">
                    <xsl:element name="area">
                        <xsl:attribute name="shape">rect</xsl:attribute>
                        <xsl:attribute name="coords">
                            <xsl:value-of select="concat(@ulx*$ratio, ',', @uly*$ratio, ',', @lrx*$ratio, ',', @lry*$ratio)"/>
                        </xsl:attribute>
                        <xsl:attribute name="id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                        <xsl:attribute name="href">##<xsl:value-of select="@xml:id"/></xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
                <xsl:for-each select="tei:zone[@rendition='polygon']">
                    <xsl:variable name="ratio" select="755 div $width"/>
                    <xsl:variable name="array">
                        <xsl:value-of select="concat(
                                    number(substring(@points,1,3))*$ratio, ',', 
                                    number(substring(@points,5,3))*$ratio, ' ', 
                                    number(substring(@points,9,3))*$ratio, ',', 
                                    number(substring(@points,13,3))*$ratio, ' ', 
                                    number(substring(@points,17,3))*$ratio, ',', 
                                    number(substring(@points,21,3))*$ratio, ' ',
                                    number(substring(@points,25,3))*$ratio, ',', 
                                    number(substring(@points,29,3))*$ratio, ' ',
                                    number(substring(@points,33,3))*$ratio, ',',
                                    number(substring(@points,37,3))*$ratio, ' ',
                                    number(substring(@points,41,3))*$ratio, ',',
                                    number(substring(@points,45,3))*$ratio, ' ',
                                    number(substring(@points,49,3))*$ratio, ',',
                                    number(substring(@points,53,3))*$ratio, ' ',
                                    number(substring(@points,57,3))*$ratio, ',',
                                    number(substring(@points,61,3))*$ratio, ' ',
                                    number(substring(@points,65,3))*$ratio, ',',
                                    number(substring(@points,69,3))*$ratio, ' ',
                                    number(substring(@points,73,3))*$ratio, ',',
                                    number(substring(@points,77,3))*$ratio)"/>
    
                    </xsl:variable>
                    <xsl:element name="area">
                        <xsl:attribute name="shape">poly</xsl:attribute>
                        <xsl:attribute name="coords">
                            <xsl:value-of select="$array"/>
                        </xsl:attribute>
                        <xsl:attribute name="id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                        <xsl:attribute name="href">##<xsl:value-of select="@xml:id"/></xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    
    <xsl:template match="tei:lb">
        <xsl:element name="br"></xsl:element>
        <xsl:element name="span">
            <xsl:attribute name="id">
                <xsl:value-of select="@facs"/>
            </xsl:attribute>
            <xsl:attribute name="class">numero_riga</xsl:attribute>
            <xsl:value-of select="@n" />
            <xsl:text>     </xsl:text>
        </xsl:element>
    </xsl:template>

    <xsl:template match = "tei:del">
        <span class = "del" hidden = 'hidden'>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match = "tei:quote">
        <span class = "quote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

     <xsl:template match = "tei:gap">
        <span class = "gap">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match = "tei:del/tei:gap">
        <span class = "del_gap"> 
        </span>
    </xsl:template>
    
    <xsl:template match = "tei:sic/tei:corr">
        <span class = 'corr'>
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <xsl:template match = "tei:sic">
        <span class = "sic" hidden = 'hidden'>
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match = "tei:add">
        <span class = "add" >
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <xsl:template match = "tei:persName">
        <span class = "class_persona">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <xsl:template match = "tei:ab/tei:orgName">
        <span class = "class_org">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <xsl:template match = "tei:ab/tei:placeName">
        <span class = "class_place">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

   
    <xsl:template match="tei:listPerson">
        <h2>Persone</h2>
        <xsl:element name="ul">
            <xsl:for-each select="tei:person[position()&gt;=0 and position()&lt;=8]">
                <xsl:element name="li"> 
                    <span class="person_of_list">
                        <b><xsl:value-of select="tei:persName"/></b>
                    </span>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    
    
    <xsl:template match="tei:listPlace">
        <h2>Luoghi</h2>
        <xsl:element name="ul">
            <xsl:for-each select="tei:place">
                <xsl:element name="li"> 
                    <span class="place_of_list">
                        <b><xsl:value-of select="tei:placeName">
                        </xsl:value-of>, </b>
                        <xsl:value-of select="tei:country">
                        </xsl:value-of>
                    </span>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>  
    </xsl:template>
    
    
    <xsl:template match="tei:listOrg">
        <h2>Organizzazioni</h2>
        <xsl:element name="ul">
            <xsl:for-each select="tei:org">
                <span class="org_of_list">
                    <xsl:element name="li"> 
                        <b><xsl:value-of select="tei:orgName"/></b>
                    </xsl:element>
                </span>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

   
    <xsl:template match="tei:listBibl">
        <xsl:element name="ul">
            <xsl:for-each select="tei:bibl">
                <xsl:element name="li">  
                    <b><xsl:value-of select="tei:title"/></b>,
                    <xsl:for-each select="tei:author">
                        <xsl:value-of select="." />,
                    </xsl:for-each>
                    <xsl:value-of select="tei:publisher"/>,
                    <xsl:value-of select="tei:date"/>
                </xsl:element>
                <p>A cura di<xsl:value-of select="tei:editor"/></p>
                <xsl:element name="br"></xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="//tei:editionStmt">
        <p><xsl:value-of select="tei:edition"/></p>
        <xsl:for-each select="tei:respStmt"> 
            <p>
                <span><xsl:value-of select="tei:resp"/></span>
                <span><xsl:value-of select="tei:name"/></span>
            </p>
        </xsl:for-each>        
    </xsl:template>
  </xsl:stylesheet>



  