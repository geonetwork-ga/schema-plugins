<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
  xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/1.0"
  xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
  exclude-result-prefixes="#all">
  
  <xsl:template match="/root">
    <xsl:apply-templates select="*[name() != 'env']"/>
  </xsl:template>
  
  <xsl:template match="mdb:MD_Metadata|*[@gco:isoType='mdb:MD_Metadata']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:choose>
			<xsl:when test="/root/env/gaid">
				<mdb:alternativeMetadataReference>
					<cit:CI_Citation>
						<cit:title>
							<gco:CharacterString>
								Geoscience Australia - short identifier for metadata record with
								uuid
								<xsl:value-of select="/root/env/uuid" />
							</gco:CharacterString>
						</cit:title>
						<cit:identifier>
							<mcc:MD_Identifier>
								<mcc:code>
									<gco:CharacterString>
										<xsl:value-of select="/root/env/gaid" />
									</gco:CharacterString>
								</mcc:code>
								<mcc:codeSpace>
									<gco:CharacterString>http://www.ga.gov.au/eCatId</gco:CharacterString>
								</mcc:codeSpace>
							</mcc:MD_Identifier>
						</cit:identifier>
					</cit:CI_Citation>
				</mdb:alternativeMetadataReference>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of
					select="mdb:alternativeMetadataReference[cit:CI_Citation/cit:identifier/mcc:MD_Identifier/mcc:codeSpace/gco:CharacterString='http://www.ga.gov.au/eCatId']" />
			</xsl:otherwise>
		</xsl:choose>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="mdb:alternativeMetadataReference"/>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

