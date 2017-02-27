<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:srv="http://standards.iso.org/iso/19115/-3/srv/2.0"
  xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0"
  xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
  xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0"
  xmlns:mrl="http://standards.iso.org/iso/19115/-3/mrl/1.0"
  xmlns:mrs="http://standards.iso.org/iso/19115/-3/mrs/1.0"
  xmlns:mrd="http://standards.iso.org/iso/19115/-3/mrd/1.0"
  xmlns:mco="http://standards.iso.org/iso/19115/-3/mco/1.0"
  xmlns:msr="http://standards.iso.org/iso/19115/-3/msr/1.0"
  xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0"
  xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0"
  xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0"
  xmlns:mdq="http://standards.iso.org/iso/19157/-2/mdq/1.0"
  xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/1.0"
  xmlns:gmd="http://standards.iso.org/iso/19115/-3/gmd"
  xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0" xmlns:gmx="http://standards.iso.org/iso/19115/-3/gmx"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:geonet="http://www.fao.org/geonetwork" xmlns:exslt="http://exslt.org/common"
  xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon"
  exclude-result-prefixes="#all">

  <xsl:import href="metadata-geo.xsl"/>

  <xsl:template name="view-with-header-iso19115-3">
    <xsl:param name="tabs"/>
    
    <xsl:call-template name="md-content">
      <xsl:with-param name="title">
        <xsl:apply-templates mode="localised"
          select="mdb:identificationInfo/*/mri:citation/cit:CI_Citation/cit:title">
          <xsl:with-param name="langId" select="$langId"/>
        </xsl:apply-templates>
      </xsl:with-param>
      <xsl:with-param name="exportButton"/>
      <xsl:with-param name="abstract">
        <xsl:call-template name="addLineBreaksAndHyperlinks">
          <xsl:with-param name="txt">
            <xsl:apply-templates mode="localised" select="mdb:identificationInfo/*/mri:abstract">
              <xsl:with-param name="langId" select="$langId"/>
            </xsl:apply-templates>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="logo">
        <img src="../../images/logos/{//geonet:info/source}.gif" alt="logo" class="logo"/>
      </xsl:with-param>
      <xsl:with-param name="relatedResources">
        <xsl:apply-templates mode="iso19115-3-relatedResources" select="." />
      </xsl:with-param>
      <xsl:with-param name="tabs" select="$tabs"/>
      
    </xsl:call-template>
    
    
  </xsl:template>



  <!-- View templates are available only in view mode and does not provide editing
  capabilities. Template MUST start with "view". -->
  <!-- ===================================================================== -->
  <!-- iso19115-3-simple -->
  <xsl:template name="metadata-iso19115-3view-simple" match="metadata-iso19115-3view-simple">
    <!--<xsl:apply-templates mode="iso19115-3-simple" select="*"/>-->

    <xsl:call-template name="view-with-header-iso19115-3">
      <xsl:with-param name="tabs">
        <xsl:call-template name="complexElementSimpleGui">
          <xsl:with-param name="title"
            select="/root/gui/schemas/iso19115-3/strings/understandResource"/>
          <xsl:with-param name="content">
            <xsl:apply-templates mode="iso19115-3-simpleviewmode"
              select="
                mdb:identificationInfo/*/mri:citation/cit:CI_Citation/cit:date
                |mdb:identificationInfo/*/mri:extent/*/gex:temporalElement
                "/>
            <xsl:apply-templates mode="iso19115-3-simpleviewmode"
                  select="
                  mdb:identificationInfo/*/mri:defaultLocale/lan:PT_Locale/lan:language
                  |mdb:identificationInfo/*/mri:citation/cit:CI_Citation/cit:edition
                  |mdb:identificationInfo/*/mri:topicCategory
                  |mdb:identificationInfo/*/mri:descriptiveKeywords
                  |mdb:identificationInfo/*/cit:graphic[1]
                  |mdb:identificationInfo/*/mri:extent/gex:EX_Extent/gex:geographicElement
                  "/>
            <xsl:apply-templates mode="iso19115-3-simpleviewmode"
              select="mdb:referenceSystemInfo/*/mrs:referenceSystemIdentifier"/>
          </xsl:with-param>
        </xsl:call-template>


        <xsl:call-template name="complexElementSimpleGui">
          <xsl:with-param name="title" select="/root/gui/schemas/iso19115-3/strings/contactInfo"/>
          <xsl:with-param name="content">
            <xsl:apply-templates mode="iso19115-3-simpleviewmode"
              select="mdb:identificationInfo/*/mri:pointOfContact"/>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="complexElementSimpleGui">
          <xsl:with-param name="title" select="/root/gui/schemas/iso19115-3/strings/mdContactInfo"/>
          <xsl:with-param name="content">
            <xsl:apply-templates mode="iso19115-3-simpleviewmode"
              select="mdb:contact"/>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:call-template name="complexElementSimpleGui">
          <xsl:with-param name="title" select="/root/gui/schemas/iso19115-3/strings/techInfo"/>
          <xsl:with-param name="content">
            <xsl:apply-templates mode="iso19115-3-simpleviewmode"
              select="
              mdb:identificationInfo/*/mri:spatialResolution[1]
              |mdb:identificationInfo/*/mri:spatialRepresentationType
              |mdb:resourceLineage/mrl:LI_Lineage/mrl:statement
              |mdb:identificationInfo/*/mri:resourceConstraints[1]
              "
            > </xsl:apply-templates>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:variable name="modifiedDate"
                      select="mdb:dateInfo/
                                cit:CI_Date[cit:dateType/cit:CI_DateTypeCode/@codeListValue = 'revision']/
                                cit:date/*[1]"/>
        <span class="madeBy">
          <xsl:value-of select="/root/gui/strings/changeDate"/>&#160;<xsl:value-of 
            select="if (contains($modifiedDate, 'T')) then substring-before($modifiedDate, 'T') else $modifiedDate"/> | 
          <xsl:value-of select="/root/gui/strings/uuid"/>&#160;
          <xsl:value-of select="mdb:metadataIdentifier/
                                  mcc:MD_Identifier[mcc:codeSpace/gco:CharacterString = 'urn:uuid']/
                                  mcc:code"/>
        </span>

      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:identificationInfo/*/mri:citation/cit:CI_Citation/cit:date[1]"
    priority="10000">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title" select="/root/gui/schemas/iso19115-3/strings/refDate"/>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple" select=".|following-sibling::node()[name(.)='cit:date']"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:identificationInfo/*/mri:extent/*/gex:temporalElement"
    priority="100">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title" select="/root/gui/schemas/iso19115-3/strings/temporalRef"/>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple" select="
						 */gex:extent/*/gml:beginPosition
            |*/gex:extent/*/gml:endPosition
            |*/gex:extent//gml:timePosition"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:identificationInfo/*/mri:resourceConstraints[1]"
    priority="100">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title" select="/root/gui/schemas/iso19115-3/strings/constraintInfo"/>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple"
          select="*|following-sibling::node()[name(.)='mri:resourceConstraints']/*"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:contact|mdb:identificationInfo/*/mri:pointOfContact" priority="100">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:for-each select="*/cit:role/cit:CI_RoleCode/@codeListValue">
          <xsl:value-of
            select="geonet:getCodeListValue(/root/gui/schemas, 'iso19115-3', 'cit:CI_RoleCode', normalize-space(.))"
          /><xsl:value-of select="if (position() != last()) then ',' else ''"/>&#160;
        </xsl:for-each>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple"
          select="
          */descendant::node()[(gco:CharacterString and normalize-space(gco:CharacterString)!='')]
          "/>
        
        <xsl:for-each select="*/descendant::node()[mcc:linkage]">
          
          <xsl:call-template name="simpleElement">
            <xsl:with-param name="id" select="generate-id(.)"/>
            <xsl:with-param name="title">
              <xsl:call-template name="getTitle">
                <xsl:with-param name="name" select="'cit:linkage'"/>
                <xsl:with-param name="schema" select="$schema"/>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="help"></xsl:with-param>
            <xsl:with-param name="content">
              <a href="{cit:CI_OnlineResource/cit:linkage/gco:CharacterString}" target="_blank">
                <xsl:value-of select="cit:CI_OnlineResource/cit:name/gco:CharacterString"/>
              </a>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
        
        <xsl:if test="descendant::gmx:FileName">
          <img src="{descendant::gmx:FileName/@src}" alt="logo" class="logo orgLogo" style="float:right;"/>
          <!-- FIXME : css -->
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:identificationInfo/*/mri:descriptiveKeywords/mri:MD_Keywords"
    priority="90">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
        
        <xsl:if test="mri:thesaurusName/cit:CI_Citation/cit:title/gco:CharacterString">
          (<xsl:value-of
            select="mri:thesaurusName/cit:CI_Citation/cit:title/gco:CharacterString"/>)
        </xsl:if>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:for-each select="mri:keyword">
          <xsl:if test="position() &gt; 1"><xsl:text>, </xsl:text></xsl:if>
          
          
          <xsl:choose>
            <xsl:when test="gmx:Anchor">
              <a href="{gmx:Anchor/@xlink:href}"><xsl:value-of select="if (gmx:Anchor/text()) then gmx:Anchor/text() else gmx:Anchor/@xlink:href"/></a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="translatedString">
                <xsl:with-param name="schema" select="$schema"/>
                <xsl:with-param name="langId">
                  <xsl:call-template name="getLangId">
                    <xsl:with-param name="langGui" select="/root/gui/language"/>
                    <xsl:with-param name="md" select="ancestor-or-self::*[name(.)='mdb:MD_Metadata' or @gco:isoType='mdb:MD_Metadata']" />
                  </xsl:call-template>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
          
        </xsl:for-each>
        
        
        <xsl:variable name="type" select="mri:type/mri:MD_KeywordTypeCode/@codeListValue"/>
        <xsl:if test="$type != ''">
          (<xsl:value-of
            select="/root/gui/schemas/*[name(.)='iso19115-3']/codelists/codelist[@name = 'mri:MD_KeywordTypeCode']/
            entry[code = $type]/label"/>)
        </xsl:if>
        
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:referenceSystemInfo/*/mrs:referenceSystemIdentifier">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:value-of select="mcc:MD_Identifier/mcc:code/gco:CharacterString"/>
        <xsl:if test="mcc:MD_Identifier/mcc:codeSpace/gco:CharacterString != ''">
          <xsl:value-of select="concat(' (', mcc:MD_Identifier/mcc:codeSpace/gco:CharacterString, ')')"/>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:resourceLineage/mrl:LI_Lineage/mrl:statement"
    priority="90">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple"
          select="mrl:LI_Lineage/mrl:statement"/>
        
        <xsl:if test=".//mrl:source[@uuidref]">
          
          <xsl:call-template name="simpleElement">
            <xsl:with-param name="id" select="generate-id(.)"/>
            <xsl:with-param name="title">
              <xsl:call-template name="getTitle">
                <xsl:with-param name="name" select="'mrl:source'"/>
                <xsl:with-param name="schema" select="$schema"/>
              </xsl:call-template>
            </xsl:with-param>
            <xsl:with-param name="help"></xsl:with-param>
            <xsl:with-param name="content">
              <xsl:for-each select=".//mrl:source[@uuidref]">
                <br/><a href="#" onclick="javascript:catalogue.metadataShow('{@uuidref}');">
                  <xsl:call-template name="getMetadataTitle">
                    <xsl:with-param name="uuid" select="@uuidref"/>
                  </xsl:call-template>
                </a>
              </xsl:for-each>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>



  <xsl:template mode="iso19115-3-simpleviewmode" match="mdb:identificationInfo/*/mri:defaultLocale/lan:PT_Locale/lan:language" priority="99">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:call-template name="iso19115-3GetIsoLanguage">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="edit"   select="false()"/>
          <xsl:with-param name="value" select="gco:CharacterString|mri:defaultLocale/lan:PT_Locale/lan:languageCode/@codeListValue"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="mri:topicCategory
    " priority="98">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:value-of select="mri:MD_TopicCategoryCode"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode"
    match="mdb:identificationInfo/*/mri:extent/gex:EX_Extent/gex:geographicElement" priority="99">
    <xsl:apply-templates mode="iso19115-3" select="gex:EX_GeographicBoundingBox">
      <xsl:with-param name="schema" select="$schema"/>
      <xsl:with-param name="edit" select="false()"/>
    </xsl:apply-templates>
  </xsl:template>


  <xsl:template mode="iso19115-3-simpleviewmode" match="cit:graphic" priority="98">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <!-- FIXME template name or move to generic layout -->
        <xsl:apply-templates mode="logo"
          select=".|following-sibling::node()[name(.)='cit:graphic']"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


  <xsl:template mode="iso19115-3-simpleviewmode" match="*[*/@codeList]" priority="100">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3GetAttributeText" select="*/@codeListValue">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="edit"   select="false()"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template mode="iso19115-3-simpleviewmode" match="*[gco:Integer]
    " priority="99">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:value-of select="gco:Integer"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="iso19115-3-simpleviewmode" match="*[gco:CharacterString]
    " priority="98">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <!-- TODO multilingual -->
        <xsl:value-of select="gco:CharacterString"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  
  <xsl:template mode="iso19115-3-simpleviewmode" match="mri:spatialResolution" priority="100">
    <xsl:call-template name="simpleElementSimpleGUI">
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="'mri:spatialResolution'"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="name" select="name(.)"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple"
          select="
          mri:MD_Resolution/mri:equivalentScale/mri:MD_RepresentativeFraction/mri:denominator
          |mri:MD_Resolution/mri:distance
          |following-sibling::node()[name(.)='mri:spatialResolution']/mri:MD_Resolution/mri:equivalentScale/mri:MD_RepresentativeFraction/mri:denominator
          |following-sibling::node()[name(.)='mri:spatialResolution']/mri:MD_Resolution/mri:distance
          "/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simpleviewmode" match="*|@*">
    <xsl:apply-templates mode="iso19115-3-simpleviewmode" select="*"/>
  </xsl:template>


  <!-- List of related resources defined in the online resource section of the metadata record.
-->
  <xsl:template mode="iso19115-3-relatedResources" match="*">
    <table class="related">
      <tbody>
        <tr style="display:none;"><!-- FIXME needed by JS to append other type of relation from xml.relation service -->
          <td class="main"></td><td></td>
        </tr>
        <xsl:for-each-group select="mdb:distributionInfo/descendant::mrd:onLine[cit:CI_OnlineResource/cit:linkage/gco:CharacterString!='']" group-by="cit:CI_OnlineResource/cit:protocol">
        <tr>
          <td class="main">
            <!-- Usually, protocole format is OGC:WMS-version-blahblah, remove ':' and get
            prefix of the protocol to set the CSS icon class-->
            <span class="{translate(substring-before(current-grouping-key(), '-'), ':', '')} icon">
                <xsl:value-of select="/root/gui/schemas/iso19115-3/labels/element[@name = 'cit:protocol']/helper/option[@value=normalize-space(current-grouping-key())]"/>
            </span>
          </td>
          <td>
            <ul>
              <xsl:for-each select="current-group()">
                <xsl:variable name="desc">
                  <xsl:apply-templates mode="localised"
                    select="cit:CI_OnlineResource/cit:description">
                    <xsl:with-param name="langId" select="$langId"/>
                  </xsl:apply-templates>
                </xsl:variable>
                <li>
                  <a href="{cit:CI_OnlineResource/cit:linkage/gco:CharacterString}">
                    <xsl:choose>
                      <xsl:when test="contains(current-grouping-key(), 'OGC') or contains(current-grouping-key(), 'DOWNLOAD')">
                        <!-- Name contains layer, feature type, coverage ... -->
                        <xsl:choose>
                          <xsl:when test="normalize-space($desc)!=''">
                            <xsl:value-of select="$desc"/>
                            <xsl:if test="cit:CI_OnlineResource/cit:name/gmx:MimeFileType/@type">
                              (<xsl:value-of select="cit:CI_OnlineResource/cit:name/gmx:MimeFileType/@type"/>)
                            </xsl:if>
                          </xsl:when>
                          <xsl:when
                            test="normalize-space(cit:CI_OnlineResource/cit:name/gco:CharacterString)!=''">
                            <xsl:value-of select="cit:CI_OnlineResource/cit:name/gco:CharacterString"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="cit:CI_OnlineResource/cit:linkage/gco:CharacterString"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:if test="normalize-space($desc)!=''">
                          <xsl:attribute name="title"><xsl:value-of select="$desc"/></xsl:attribute>
                        </xsl:if>
                        <xsl:choose>
                          <xsl:when
                            test="normalize-space(cit:CI_OnlineResource/cit:name/gco:CharacterString)!=''">
                            <xsl:value-of select="cit:CI_OnlineResource/cit:name/gco:CharacterString"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="cit:CI_OnlineResource/cit:linkage/gco:CharacterString"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>
                  </a>
                  
                  <!-- Display add to map action for WMS -->
                  <xsl:if test="contains(current-grouping-key(), 'WMS')">
                  &#160;
                  <a href="#" class="md-mn addLayer"
                    onclick="app.switchMode('1', true);app.getIMap().addWMSLayer([[
                              '{cit:CI_OnlineResource/cit:description/gco:CharacterString}', 
                              '{cit:CI_OnlineResource/cit:linkage/gco:CharacterString}', 
                              '{cit:CI_OnlineResource/cit:name/gco:CharacterString}', '{generate-id()}']]);">&#160;</a>
                  </xsl:if>
                </li>
              </xsl:for-each>
            </ul>
          </td>
        </tr>
      </xsl:for-each-group>
      </tbody>
    </table>
  </xsl:template>


  <!-- Extract logo -->
  <xsl:template mode="logo" match="cit:graphic">
    <xsl:variable name="fileName" select="mcc:MD_BrowseGraphic/mcc:fileName/gco:CharacterString"/>
    <xsl:if test="normalize-space($fileName)!=''">
      <xsl:variable name="url"
        select="if (contains($fileName, '://')) 
        then $fileName 
        else geonet:get-thumbnail-url($fileName, //geonet:info, /root/gui/locService)"/>
  
      <a href="{$url}" rel="lightbox-viewset">
        <img class="thumbnail" src="{$url}" alt="thumbnail"
          title="{mcc:MD_BrowseGraphic/mcc:fileDescription/gco:CharacterString}"/>
      </a>
    </xsl:if>
  </xsl:template>


  <!-- Hide them -->
  <xsl:template mode="iso19115-3-simple" match="
    geonet:*|*[@gco:nilReason='missing']|@gco:isoType" priority="99"/>
  <!-- Don't display -->
  
  <!-- these elements should be boxed -->
  <xsl:template mode="iso19115-3-simple"
    match="mdb:identificationInfo|mdb:distributionInfo
    |mri:descriptiveKeywords|mri:thesaurusName
    |mdb:spatialRepresentationInfo
    |mri:pointOfContact|mdb:contact
    |mdb:dataQualityInfo
    |mco:MD_Constraints|mco:MD_LegalConstraints|mco:MD_SecurityConstraints
    |mdb:referenceSystemInfo|mri:equivalentScale
    |mri:extent|gex:EX_TemporalExtent
    |mrd:MD_Distributor
    |srv:containsOperations|srv:SV_CoupledResource|mdb:metadataConstraints"
    priority="2">
    <xsl:call-template name="complexElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="helpLink">
        <xsl:call-template name="getHelpLink">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3-simple" select="@*|*">
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


  <xsl:template mode="iso19115-3-simple"
    match="
    *[gco:Integer|gco:Decimal|gco:Boolean|gco:Real|gco:Measure|gco:Length|gco:Distance|gco:Angle|gco:Scale|gco:RecordType|gmx:MimeFileType]"
    priority="2">
    
    <xsl:call-template name="simpleElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="help"></xsl:with-param>
      <xsl:with-param name="content">
       <xsl:value-of
          select="gco:Integer|gco:Decimal|gco:Boolean|gco:Real|gco:Measure
          |gco:Length|gco:Distance|gco:Angle|gco:Scale|gco:RecordType|gmx:MimeFileType"
        />
        <xsl:if test="gco:Distance/@uom"><xsl:text>&#160;</xsl:text>
          <xsl:choose>
            <xsl:when test="contains(gco:Distance/@uom, '#')">
              <a href="{gco:Distance/@uom}"><xsl:value-of select="substring-after(gco:Distance/@uom, '#')"/></a>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="gco:Distance/@uom"/></xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Do not display date type (displayed next to each dates)
  in this mode. -->
  <xsl:template mode="iso19115-3-simpleviewmode"
                match="cit:dateType" priority="199"/>

  <!-- Display date and type. -->
  <xsl:template mode="iso19115-3-simple"
    match="
    cit:date|
    srv:date"
    priority="99">

    <xsl:call-template name="simpleElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="' '"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="help"></xsl:with-param>
      <xsl:with-param name="content">
        <xsl:value-of
          select="./cit:CI_Date/cit:date/gco:Date|cit:CI_Date/cit:date/gco:DateTime"
        /> 
        <xsl:if test="normalize-space(cit:CI_Date/cit:dateType/cit:CI_DateTypeCode/@codeListValue)!=''">
          (<xsl:apply-templates mode="iso19115-3GetAttributeText" select="cit:CI_Date/cit:dateType/cit:CI_DateTypeCode/@codeListValue">
            <xsl:with-param name="schema" select="$schema"/>
            <xsl:with-param name="edit"   select="false()"/>
          </xsl:apply-templates>)
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>


  <!-- gco:CharacterString are swallowed -->
  <!-- TODO : PT_FreeText -->
  <xsl:template mode="iso19115-3-simple" match="*[gco:CharacterString]" priority="2">

    <xsl:call-template name="simpleElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="help"></xsl:with-param>
      <xsl:with-param name="content">
        <xsl:call-template name="addLineBreaksAndHyperlinks">
          <xsl:with-param name="txt">
            <xsl:apply-templates mode="localised" select=".">
              <xsl:with-param name="langId" select="$langId"/>
            </xsl:apply-templates>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- TODO other gml time information may be used. -->
  <xsl:template mode="iso19115-3-simple" match="gml:endPosition|gml:beginPosition|gml:timePosition" priority="2">
    <xsl:call-template name="simpleElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="help"></xsl:with-param>
      <xsl:with-param name="content">
        <xsl:value-of select="."/>
        
        <xsl:for-each select="@*">
          <xsl:variable name="label">
            <xsl:call-template name="getTitle">
              <xsl:with-param name="name" select="name(.)"/>
              <xsl:with-param name="schema" select="$schema"/>
            </xsl:call-template>
          </xsl:variable>
          | <xsl:value-of select="concat($label, ': ', .)"/>
        </xsl:for-each>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template mode="iso19115-3-simple" match="*[*/@codeList]">
    
    <xsl:call-template name="simpleElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="type" select="*/@codeListValue"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="help"></xsl:with-param>
      <xsl:with-param name="content">
        <xsl:apply-templates mode="iso19115-3GetAttributeText" select="*/@codeListValue">
          <xsl:with-param name="schema" select="$schema"/>
          <xsl:with-param name="edit"   select="false()"/>
        </xsl:apply-templates>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- All others
   -->
  <xsl:template mode="iso19115-3-simple" match="*|@*">
    <xsl:call-template name="simpleElement">
      <xsl:with-param name="id" select="generate-id(.)"/>
      <xsl:with-param name="title">
        <xsl:call-template name="getTitle">
          <xsl:with-param name="name" select="name(.)"/>
          <xsl:with-param name="schema" select="$schema"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="help"></xsl:with-param>
      <xsl:with-param name="content">
        <xsl:variable name="empty">
          <xsl:apply-templates mode="iso19115-3IsEmpty" select="."/>
        </xsl:variable>
        <xsl:if test="$empty!=''">
          <xsl:apply-templates mode="iso19115-3-simple" select="*|@*"/>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>

  </xsl:template>

</xsl:stylesheet>
