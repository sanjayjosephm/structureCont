<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="refID" select="1" />
  <!-- Identity template to copy all content by default -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- Template to match <sec> elements and remove them -->
  <xsl:template match="sec">
    <xsl:apply-templates select="*" />
  </xsl:template>

  <!-- Template to match <title> elements that are direct children of <sec> and add the data-level
  attribute -->
  <xsl:template match="sec/title">
    <xsl:copy>
      <xsl:attribute name="data-level">
        <!-- Calculate data-level based on the count of ancestor sec elements -->
        <xsl:value-of select="count(ancestor::sec)" />
      </xsl:attribute>
      <xsl:apply-templates
        select="@*|node()" />
    </xsl:copy>
  </xsl:template>


  <xsl:template match="/">
    <xsl:apply-templates select="*" />
  </xsl:template>


  <xsl:template match="fig">
    <xsl:variable name="id" select="@id" />
  <xsl:variable name="data-id" select="concat('BLK_', $id)" />
  <fig
      data-stream-name="a_{$id}" data-id="{$data-id}" position="{@position}" fig-type="figure"
      orientation="{@orientation}">
      <xsl:apply-templates select="@*[name() != 'id'] | node()[not(self::caption/title)]" />
      <xsl:apply-templates select="caption/title" />
    </fig>
  </xsl:template>

  <xsl:template match="table-wrap">
    <xsl:copy>
      <!-- Add attributes with sequential numbers -->
      <xsl:attribute name="data-id">
        <xsl:text>BLK_</xsl:text>
        <xsl:number />
      </xsl:attribute>
      <xsl:attribute
        name="data-stream-name">
        <xsl:text>a_T</xsl:text>
          <xsl:number />
      </xsl:attribute>
      <xsl:apply-templates
        select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- Match caption and wrap its children inside a new title element with data-id attribute -->
  <xsl:template match="table-wrap/caption">
    <xsl:variable name="tableWrapId" select="../@id" />
  <xsl:copy>
      <title data-id="{$tableWrapId}">
        <xsl:apply-templates select="node()" />
      </title>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="label">
    <xsl:variable name="tableWrapId" select="../@id" />
  <xsl:copy>
      <xsl:attribute name="data-id">
        <xsl:value-of select="$tableWrapId" />
      </xsl:attribute>
      <xsl:apply-templates
        select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- Template to match the title tag inside caption tag within a fig tag -->
  <xsl:template match="fig/caption">
    <caption>
      <title data-id="{../@id}">
        <xsl:apply-templates select="@* | node()" />
      </title>
    </caption>
  </xsl:template>

  <xsl:template match="xref">
    <!-- Create the xref element with additional attributes -->
    <xref ref-type="{@ref-type}" rid="{@rid}"
      data-citation-string=" {@rid} ">
      <!-- Copy the content of the xref element -->
      <xsl:copy-of select="node()" />
    </xref>
  </xsl:template>

  <xsl:template match="xref[contains(@rid, 'RR') and not(contains(@rid, 'RRR'))]">
    <xsl:copy>
      <!-- Copy all attributes except 'rid' as is -->
      <xsl:copy-of select="@*[local-name() != 'rid']" />
      <!-- Modify 'rid' attribute by removing one 'R' -->
      <xsl:attribute name="rid">
        <xsl:choose>
          <xsl:when test="substring(@rid, 1, 1) = 'R' and substring(@rid, 2, 1) = 'R'">
            <xsl:value-of select="concat('R', substring(@rid, 3))" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring(@rid, 1, 1) = 'R'" />
                  <xsl:value-of
              select="substring(@rid, 3)" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <!-- Copy all child nodes -->
      <xsl:apply-templates
        select="node()" />
    </xsl:copy>
  </xsl:template>

  
<xsl:template match="ref-list/ref">
  <xsl:copy>
    <xsl:attribute name="data-id">
      <xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:attribute name="data-class">jrnlRefText</xsl:attribute>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

  <xsl:template match="ref-list/title">
    <xsl:variable name="dataLevel" select="count(preceding-sibling::title) + 1"/>
    <xsl:copy>
      <xsl:attribute name="data-level">
        <xsl:value-of select="$dataLevel"/>
      </xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>