<?xml version="1.0" encoding="UTF-8"?><sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
   <sch:title xmlns="http://www.w3.org/2001/XMLSchema" xml:lang="en">Schematron validation for Version 2.0 of Geoscience Australia profile of ISO 19115-1:2014 standard</sch:title>
   
   <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
   <sch:ns prefix="srv" uri="http://standards.iso.org/19115/-3/srv/2.0/2014-12-25"/>
   <sch:ns prefix="cit" uri="http://standards.iso.org/19115/-3/cit/1.0/2014-12-25"/>
   <sch:ns prefix="gex" uri="http://standards.iso.org/19115/-3/gex/1.0/2014-12-25"/>
   <sch:ns prefix="mco" uri="http://standards.iso.org/19115/-3/mco/1.0/2014-12-25"/>
   <sch:ns prefix="mdb" uri="http://standards.iso.org/19115/-3/mdb/1.0/2014-12-25"/>
   <sch:ns prefix="mex" uri="http://standards.iso.org/19115/-3/mex/1.0/2014-12-25"/>
   <sch:ns prefix="mmi" uri="http://standards.iso.org/19115/-3/mmi/1.0/2014-12-25"/>
   <sch:ns prefix="mrc" uri="http://standards.iso.org/19115/-3/mrc/1.0/2014-12-25"/>
   <sch:ns prefix="mrd" uri="http://standards.iso.org/19115/-3/mrd/1.0/2014-12-25"/>
   <sch:ns prefix="mri" uri="http://standards.iso.org/19115/-3/mri/1.0/2014-12-25"/>
   <sch:ns prefix="mrs" uri="http://standards.iso.org/19115/-3/mrs/1.0/2014-12-25"/>
   <sch:ns prefix="mcc" uri="http://standards.iso.org/19115/-3/mcc/1.0/2014-12-25"/>
   <sch:ns prefix="lan" uri="http://standards.iso.org/19115/-3/lan/1.0/2014-12-25"/>
   <sch:ns prefix="gco" uri="http://standards.iso.org/19139/gco/1.0/2014-12-25"/>
   <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
   <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
   <sch:ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema"/>

	 <!-- ============================================================================================================ -->
	 <!-- Assert that metadataIdentifier (at least one) is present -->
	 <!-- ============================================================================================================ -->
   <sch:diagnostics>
      <sch:diagnostic id="rule.ga.mdb.metadataidentifierpresent-failure-en" xml:lang="en">The metadata identifier is not present.</sch:diagnostic>
      
    
      <sch:diagnostic id="rule.ga.mdb.metadataidentifierpresent-success-en" xml:lang="en">The metadata identifier is present
      "<sch:value-of select="normalize-space($mdid)"/>"
      .</sch:diagnostic>
      
  </sch:diagnostics>
   <sch:pattern id="rule.ga.mdb.metadataidentifierpresent">
      <sch:title xml:lang="en">Metadata identifier must be present.</sch:title>
      
    
      <sch:rule context="//mdb:metadataIdentifier[1]/mcc:MD_Identifier">
      
         <sch:let name="mdid" value="mcc:code/gco:CharacterString"/>
         <sch:let name="hasMdid" value="normalize-space($mdid) != ''"/>
      
         <sch:assert test="$hasMdid" diagnostics="rule.ga.mdb.metadataidentifierpresent-failure-en"/>
      
         <sch:report test="$hasMdid" diagnostics="rule.ga.mdb.metadataidentifierpresent-success-en"/>
      </sch:rule>
  </sch:pattern>

	 <!-- mdb:metadataScope/mdb:MD_MetadataScope/mdb:resourceScope/mcc:MD_ScopeCode -->

	 <!-- mdb:parentMetadata/cit:CI_Citation/cit:identifier/mcc:MD_Identifier/mcc:code/gco:CharacterString -->

	 <!-- ============================================================================================================ -->
	 <!-- Assert that parentIdentifier is conditionally present -->
	 <!-- ============================================================================================================ -->
   <sch:diagnostics>
      <sch:diagnostic id="rule.ga.mdb.metadataparentidentifierpresent-failure-en" xml:lang="en">The metadata parent identifier must be present if metadataScope is one of ('feature','featureType','attribute','attributeType').</sch:diagnostic>
      
    
      <sch:diagnostic id="rule.ga.mdb.metadataparentidentifierpresent-success-en" xml:lang="en">The metadata parent identifier is present "<sch:value-of select="normalize-space($parentId)"/>" and metadataScope is "<sch:value-of select="normalize-space($scopeCode)"/>".</sch:diagnostic>
      
  </sch:diagnostics>

   <sch:pattern id="rule.ga.mdb.metadataparentidentifierpresent">
      <sch:title xml:lang="en">Metadata parent identifier must be present if metadataScope is one of ('feature','featureType','attribute','attributeType').</sch:title>
      
    
      <sch:rule context="/mdb:MD_Metadata">
      
         <sch:let name="scopeCode" value="mdb:metadataScope/mdb:MD_MetadataScope/mdb:resourceScope/mcc:MD_ScopeCode"/>
         <sch:let name="parentId" value="mdb:parentMetadata/cit:CI_Citation/cit:identifier/mcc:MD_Identifier/mcc:code/gco:CharacterString"/>
         <sch:let name="hasParent" value="normalize-space($parentId) or not($scopeCode = ('feature','featureType','attribute','attributeType'))"/>
      
         <sch:assert test="$hasParent" diagnostics="rule.ga.mdb.metadataparentidentifierpresent-failure-en"/>
      
         <sch:report test="$hasParent" diagnostics="rule.ga.mdb.metadataparentidentifierpresent-success-en"/>
      </sch:rule>
  </sch:pattern>
	 <!-- ============================================================================================================ -->
	 <!-- Assert that dataSetURI (now an identifier in the identificationInfo//citation) is conditionally present -->
	 <!-- ============================================================================================================ -->
   <sch:diagnostics>
      <sch:diagnostic id="rule.ga.mdb.dataseturipresent-failure-en" xml:lang="en">The dataSetURI identifier must be present if metadataScope is one of ('dataset','').</sch:diagnostic>
      
    
      <sch:diagnostic id="rule.ga.mdb.dataseturipresent-success-en" xml:lang="en">The dataSetURI identifier is present "<sch:value-of select="normalize-space($dataseturi)"/>" and metadataScope is "<sch:value-of select="normalize-space($scopeCode)"/>".</sch:diagnostic>
  </sch:diagnostics>

   <sch:pattern id="rule.ga.mdb.dataseturipresent">
      <sch:title xml:lang="en">Dataset URI must be present if metadataScope is 'dataset'.</sch:title>
      
    
      <sch:rule context="/mdb:MD_Metadata">
      
         <sch:let name="scopeCode" value="mdb:metadataScope/mdb:MD_MetadataScope/mdb:resourceScope/mcc:MD_ScopeCode"/>
         <sch:let name="dataseturi" value="mdb:identificatioInfo/*/mri:citation/*/cit:identifier/mcc:MD_Identifier[mcc:codeSpace/gco:CharacterString='ga-dataSetURI']/mcc:code/gco:CharacterString"/>
         <sch:let name="hasDataseturi" value="normalize-space($dataseturi) or not($scopeCode = ('dataset',''))"/>
      
         <sch:assert test="$hasDataseturi" diagnostics="rule.ga.mdb.dataseturipresent-failure-en"/>
      
         <sch:report test="$hasDataseturi" diagnostics="rule.ga.mdb.dataseturipresent-success-en"/>
      </sch:rule>
  </sch:pattern>
	 <!-- ============================================================================================================ -->
	 <!-- Assert that metadataProfile with title and edition for GA profile are present -->
	 <!-- ============================================================================================================ -->
   <sch:diagnostics>
      <sch:diagnostic id="rule.ga.mdb.metadataprofilepresent-failure-en" xml:lang="en">The metadata profile information (mdb:metadataProfile) is not present or may be incorrect - looking for title: 'Geoscience Australia Community Metadata Profile of ISO 19115-1:2014' and edition/version: 'Version 2.0, April 2015'.</sch:diagnostic>
      
    
      <sch:diagnostic id="rule.ga.mdb.metadataprofilepresent-success-en" xml:lang="en">The metadata identifier is present "<sch:value-of select="normalize-space($title)"/>" with "<sch:value-of select="normalize-space($edition)"/>".</sch:diagnostic>
      
  </sch:diagnostics>
   <sch:pattern id="rule.ga.mdb.metadataprofilepresent">
      <sch:title xml:lang="en">Metadata profile must be present and correctly filled out.</sch:title>
      
    
      <sch:rule context="//mdb:metadataProfile/cit:CI_Citation">
      
         <sch:let name="title" value="cit:title/gco:CharacterString"/>
         <sch:let name="hasTitle" value="normalize-space($title) != 'Geoscience Australia Community Metadata Profile of ISO 19115-1:2014'"/>
         <sch:let name="edition" value="cit:edition/gco:CharacterString"/>
         <sch:let name="hasEdition" value="normalize-space($edition) != 'Version 2.0, April 2015'"/>
      
         <sch:assert test="$hasTitle and $hasEdition" diagnostics="rule.ga.mdb.metadataprofilepresent-failure-en"/>
      
         <sch:report test="$hasTitle and $hasEdition" diagnostics="rule.ga.mdb.metadataprofilepresent-success-en"/>
      </sch:rule>
  </sch:pattern>
</sch:schema>
