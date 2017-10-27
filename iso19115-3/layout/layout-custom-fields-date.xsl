<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0"
                xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
                xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0"
                xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0"
                xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/1.0"
                xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0"
                xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
                xmlns:gml="http://www.opengis.net/gml/3.2"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:gn="http://www.fao.org/geonetwork"
                xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
                exclude-result-prefixes="#all">

  <!--

  Date element is composed of one element with the date
  and one element to describe the type of date.

  ```
   <cit:date>
      <cit:CI_Date>
         <cit:date>
            <gco:DateTime></gco:DateTime>
         </cit:date>
         <cit:dateType>
            <cit:CI_DateTypeCode codeList="codeListLocation#CI_DateTypeCode" codeListValue="creation"/>
         </cit:dateType>
      </cit:CI_Date>
   </cit:date>
  ```

  These templates hide the complexity of the element
  in the editor in all view modes in order to only
  have a dropdown to define the type and one calendar
  control.


  Swallow the complex element having CI_Date
  to simplify the editor for dates
  -->
  <xsl:template mode="mode-iso19115-3" match="*[cit:CI_Date]" priority="33300">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>

    <xsl:message>GGGGGGGGGGGGGGG <xsl:value-of select="name()"/></xsl:message>

    <xsl:apply-templates mode="mode-iso19115-3" select="*/cit:*">
      <xsl:with-param name="schema" select="$schema"/>
      <xsl:with-param name="labels" select="$labels"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Date type is handled in next template -->
  <xsl:template mode="mode-iso19115-3" match="cit:dateType" priority="33300"/>

  <!-- Rendering date type as a dropdown to select type
  and the calendar next to it.
  -->
  <xsl:template mode="mode-iso19115-3"
                priority="2000"
                match="*[gco:Date|gco:DateTime]">
    <xsl:param name="schema" select="$schema" required="no"/>
    <xsl:param name="labels" select="$labels" required="no"/>

    <xsl:variable name="labelConfig"
                  select="gn-fn-metadata:getLabel($schema, name(), $labels)"/>

	<!-- Updated by Joseph - Issue: deleting edition date removes whole block -->
	<xsl:variable name="dateTypeElementRef" select="if (name()='cit:editionDate') then (gn:element/@ref) else (../gn:element/@ref)"/>
    <!--<xsl:variable name="dateTypeElementRef"
                  select="../gn:element/@ref"/>-->

    <xsl:message>SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS <xsl:value-of select="name()"/></xsl:message>

    <div class="form-group gn-field gn-title gn-required"
         id="gn-el-{$dateTypeElementRef}"
         data-gn-field-highlight="">
      <label class="col-sm-2 control-label">
        <xsl:value-of select="$labelConfig/label"/>
      </label>
      <div class="col-sm-3 gn-value">
        <xsl:variable name="codelist"
                      select="gn-fn-metadata:getCodeListValues($schema,
                                  'cit:CI_DateTypeCode',
                                  $codelists,
                                  .)"/>
        <xsl:call-template name="render-codelist-as-select">
          <xsl:with-param name="listOfValues" select="$codelist"/>
          <xsl:with-param name="lang" select="$lang"/>
          <xsl:with-param name="isDisabled" select="ancestor-or-self::node()[@xlink:href]"/>
          <xsl:with-param name="elementRef" select="../cit:dateType/cit:CI_DateTypeCode/gn:element/@ref"/>
          <xsl:with-param name="isRequired" select="true()"/>
          <xsl:with-param name="hidden" select="false()"/>
          <xsl:with-param name="valueToEdit" select="../cit:dateType/cit:CI_DateTypeCode/@codeListValue"/>
          <xsl:with-param name="name" select="concat(../cit:dateType/cit:CI_DateTypeCode/gn:element/@ref, '_codeListValue')"/>
        </xsl:call-template>


        <xsl:call-template name="render-form-field-control-move">
          <xsl:with-param name="elementEditInfo" select="../../gn:element"/>
          <xsl:with-param name="domeElementToMoveRef" select="$dateTypeElementRef"/>
        </xsl:call-template>
      </div>
      <div class="col-sm-6 gn-value">
        <div data-gn-date-picker="{gco:Date|gco:DateTime}"
             data-label=""
             data-element-name="{name(gco:Date|gco:DateTime)}"
             data-element-ref="{concat('_X', gn:element/@ref)}"
				     data-namespaces='{{ "gco": "http://standards.iso.org/iso/19115/-3/gco/1.0", "gml": "http://www.opengis.net/gml/3.2"}}'>
        </div>


        <!-- Create form for all existing attribute (not in gn namespace)
         and all non existing attributes not already present. -->
        <div class="well well-sm gn-attr {if ($isDisplayingAttributes) then '' else 'hidden'}">
          <xsl:apply-templates mode="render-for-field-for-attribute"
                               select="
            ../../@*|
            ../../gn:attribute[not(@name = parent::node()/@*/name())]">
            <xsl:with-param name="ref" select="../../gn:element/@ref"/>
            <xsl:with-param name="insertRef" select="../gn:element/@ref"/>
          </xsl:apply-templates>
        </div>
      </div>

	  <!-- Updated by Joseph - Issue: deleting edition date removes whole block -->
      <div class="col-sm-1 gn-control">
		<xsl:choose>
			<xsl:when test="name()='cit:editionDate'">
				<xsl:call-template name="render-form-field-control-remove">
				  <xsl:with-param name="editInfo" select="gn:element"/>
				  <xsl:with-param name="parentEditInfo" select="gn:element"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="render-form-field-control-remove">
				  <xsl:with-param name="editInfo" select="../gn:element"/>
				  <xsl:with-param name="parentEditInfo" select="../../gn:element"/>
				</xsl:call-template>		
			</xsl:otherwise>
		</xsl:choose>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
