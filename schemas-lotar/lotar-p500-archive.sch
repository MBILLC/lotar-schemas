<?xml version="1.0" encoding="UTF-8"?>
<!--
  LOTAR Archival Profile — Schematron rule layer for the 500-series ARCHIVE MANIFEST
  ==================================================================================

  Base schema (UNMODIFIED): P500_Archive_Manifest.xsd (p500# namespace; includes
  P500_Series_Common.xsd). Root elements: p500:Archive_Manifest (lotar-500-manifest.xml, the
  top-level manifest of one 500-series archive) and p500:Baseline_Link_Set (the record set of a
  metadata-only baseline link archive).

  Conformance identifier: LOTAR-P500-ARCHIVE

  Origin (2026-10-28, D-25): executes WG decisions S1 (layout), S3 (one canonical decision record
  per archive), S4/S4b (own-XSD top-level manifest, containment only), S5 (part manifest is
  authoritative) and S6 (identifier-only cross-archive references) of
  planning/WG_Decision_Request_Single_500_Series_Archive.md. Ownership: series-wide (NAS9300-500 /
  011–014), drafted by the P520 team — see the XSD header.

  Rule ids: P500-ARCH-100..109 (the 0xx range belongs to lotar-p500-uri.sch's field rules, the
  1xx range to the archive manifest). Letters mark independent failure modes, as elsewhere.

  Schematron has no filesystem access: existence of the files an Entry/Decision_Record names,
  their fixity and size, the Entry-vs-part-manifest consistency (S5), cross-branch link resolution
  and decision-record copy consistency (S3) are checked by lotar-tools' archive mode
  (`lotar check <archive-root>`), not here.

  Compiles under queryBinding="xslt" (XPath 1.0/XSLT 1.0), consistent with every other LOTAR
  Schematron profile in this project; no current().
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xml:lang="en" queryBinding="xslt">

  <title>LOTAR Archival Profile for the NAS9300 500-series archive manifest</title>

  <ns prefix="p500" uri="http://www.lotar.org/schemas/mbse/p500#"/>

  <!-- ==================================================================================
       Pattern 1 — Entry locators: archive-root-relative, inside the part's own branch (S1)
       ================================================================================== -->
  <pattern id="p500-archive-entry-locator">

    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry/p500:Manifest_Path
                  | //p500:Archive_Manifest/p500:Decision_Records/p500:Decision_Record/p500:Path
                  | //p500:Archive_Manifest/p500:Schemas/p500:Schema/p500:Path
                  | //p500:Archive_Manifest/p500:Signature/p500:Path" id="P500-ARCH-100">
      <assert test="not(starts-with(text(),'/'))" id="P500-ARCH-100a" role="error">
        [P500-ARCH-100a][I] <name/> must not be an absolute-path or network-path reference — it is
        relative to the archive root.
      </assert>
      <assert test="not(contains(text(),'\'))" id="P500-ARCH-100b" role="error">
        [P500-ARCH-100b][I] <name/> must not contain a backslash.
      </assert>
      <assert test="not(contains(substring-before(concat(text(),'/'),'/'),':'))"
              id="P500-ARCH-100c" role="error">
        [P500-ARCH-100c][I] <name/> must not carry a URI scheme or drive letter.
      </assert>
      <assert test="not(contains(concat('/',text(),'/'),'/../'))" id="P500-ARCH-100d" role="error">
        [P500-ARCH-100d][I] <name/> must not contain a ".." path segment.
      </assert>
      <assert test="not(contains(text(),'#'))" id="P500-ARCH-100e" role="error">
        [P500-ARCH-100e][I] <name/> locates a file, not an element — no "#fragment".
      </assert>
    </rule>

    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry" id="P500-ARCH-101">
      <assert test="substring-before(p500:Manifest_Path,'/') = concat('p', @part)"
              id="P500-ARCH-101a" role="error">
        [P500-ARCH-101a][M] Entry/Manifest_Path must sit in the branch folder of its own part —
        first path segment "p<value-of select="@part"/>/" (S1 layout: p510/, p520/, p550/, ...).
      </assert>
      <assert test="substring(p500:Manifest_Path, string-length(p500:Manifest_Path) - 3) = '.xml'"
              id="P500-ARCH-101b" role="error">
        [P500-ARCH-101b][M] Entry/Manifest_Path must locate the part manifest document (an .xml
        file: P510_Manifest.xml, P520_Manifest.xml, P550_Manifest.xml, ...).
      </assert>
      <assert test="not(../../p500:Package_Kind = 'link') or @part = '500'" id="P500-ARCH-101c" role="error">
        [P500-ARCH-101c][M] A metadata-only link archive (Package_Kind = "link") holds only
        series-level link sets (@part = "500"), no content branches (S6 layer 3, GR4).
      </assert>
      <assert test="not(@part = '500') or substring-before(substring-after(p500:Manifest_Path,'/'),'/') = 'links'"
              id="P500-ARCH-101d" role="error">
        [P500-ARCH-101d][M] A series-level entry (@part = "500") is a Baseline_Link_Set and sits
        under "p500/links/".
      </assert>
    </rule>

    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry/p500:Unique_object_id" id="P500-ARCH-102">
      <assert test="not(../preceding-sibling::p500:Entry/p500:Unique_object_id = .)"
              id="P500-ARCH-102a" role="error">
        [P500-ARCH-102a][M] Entry/Unique_object_id "<value-of select="."/>" appears more than once —
        object identifiers are unique within an archive.
      </assert>
    </rule>

    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry/p500:Manifest_Path" id="P500-ARCH-102m">
      <assert test="not(../preceding-sibling::p500:Entry/p500:Manifest_Path = .)"
              id="P500-ARCH-102b" role="error">
        [P500-ARCH-102b][M] Two entries locate the same part manifest "<value-of select="."/>".
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 2 — Content type consistent with the governing part (P4/D8)
       ================================================================================== -->
  <pattern id="p500-archive-entry-content-type">

    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry[@part = '510']" id="P500-ARCH-103-510">
      <assert test="p500:Content_Type = 'Requirement Model'" id="P500-ARCH-103a" role="warning">
        [P500-ARCH-103a][R] A Part 510 entry is expected to carry Content_Type "Requirement Model".
      </assert>
    </rule>
    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry[@part = '520']" id="P500-ARCH-103-520">
      <assert test="p500:Content_Type = 'Behavioral Model'" id="P500-ARCH-103b" role="warning">
        [P500-ARCH-103b][R] A Part 520 entry is expected to carry Content_Type "Behavioral Model".
      </assert>
    </rule>
    <rule context="//p500:Archive_Manifest/p500:Contents/p500:Entry[@part = '500']" id="P500-ARCH-103-500">
      <assert test="p500:Content_Type = 'Other'" id="P500-ARCH-103c" role="warning">
        [P500-ARCH-103c][R] A series-level (Part 500) entry — a Baseline_Link_Set — carries
        Content_Type "Other".
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 3 — Decision records: canonical copy under p520/_decisions/ (S3)
       ================================================================================== -->
  <pattern id="p500-archive-decision-records">

    <rule context="//p500:Archive_Manifest/p500:Decision_Records/p500:Decision_Record" id="P500-ARCH-104">
      <assert test="starts-with(p500:Path,'p520/_decisions/')" id="P500-ARCH-104a" role="error">
        [P500-ARCH-104a][M] The canonical copy of a decision record lives under "p520/_decisions/"
        (S3); every other copy in the archive is a verified duplicate of it.
      </assert>
      <assert test="substring(p500:Path, string-length(p500:Path) - 4) = '.dtmd'" id="P500-ARCH-104b" role="error">
        [P500-ARCH-104b][M] A Decision_Record locates a .dtmd file.
      </assert>
      <assert test="substring-after(p500:Path,'p520/_decisions/') = concat(p500:GUID,'.dtmd')"
              id="P500-ARCH-104c" role="error">
        [P500-ARCH-104c][M] The canonical decision record is named after its GUID:
        "p520/_decisions/<value-of select="p500:GUID"/>.dtmd".
      </assert>
      <assert test="not(../preceding-sibling::p500:Decision_Record/p500:GUID = p500:GUID)
                    and not(preceding-sibling::p500:Decision_Record/p500:GUID = p500:GUID)"
              id="P500-ARCH-104d" role="error">
        [P500-ARCH-104d][M] Decision record GUID "<value-of select="p500:GUID"/>" is listed more than
        once — one canonical copy per decision.
      </assert>
    </rule>

    <rule context="//p500:Archive_Manifest[p500:Contents/p500:Entry/@part = '520']" id="P500-ARCH-105">
      <assert test="p500:Decision_Records/p500:Decision_Record" id="P500-ARCH-105a" role="warning">
        [P500-ARCH-105a][R] The archive holds Part 520 behavioral models but lists no canonical
        decision record — every P520 scenario governed by a CDP decision needs one it can
        Implement (P520 clause §5.6/§5.7).
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 4 — Fixity values well-formed for their algorithm (PD1)
       ================================================================================== -->
  <pattern id="p500-archive-fixity">

    <rule context="//p500:Archive_Manifest//p500:Fixity | //p500:Archive_Manifest//p500:Target_Manifest_Fixity
                  | //p500:Baseline_Link_Set//p500:Target_Manifest_Fixity | //p500:Baseline_Link_Set//p500:Source_Manifest_Fixity"
          id="P500-ARCH-106">
      <assert test="not(@algorithm = 'SHA-256' or @algorithm = 'SHA3-256') or string-length(normalize-space(.)) = 64"
              id="P500-ARCH-106a" role="error">
        [P500-ARCH-106a][I] A SHA-256 / SHA3-256 digest is 64 hexadecimal characters
        (got <value-of select="string-length(normalize-space(.))"/>).
      </assert>
      <assert test="not(@algorithm = 'SHA-384' or @algorithm = 'SHA3-384') or string-length(normalize-space(.)) = 96"
              id="P500-ARCH-106b" role="error">
        [P500-ARCH-106b][I] A SHA-384 / SHA3-384 digest is 96 hexadecimal characters.
      </assert>
      <assert test="not(@algorithm = 'SHA-512' or @algorithm = 'SHA3-512') or string-length(normalize-space(.)) = 128"
              id="P500-ARCH-106c" role="error">
        [P500-ARCH-106c][I] A SHA-512 / SHA3-512 digest is 128 hexadecimal characters.
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 5 — External references: identifiers only, never self, never a locator (S6)
       ================================================================================== -->
  <pattern id="p500-archive-external-references">

    <rule context="//p500:Archive_Manifest/p500:External_References/p500:External_Reference" id="P500-ARCH-107">
      <assert test="not(substring-before(concat(p500:Target_Archive_Id,':'),':') = '') and starts-with(p500:Target_Archive_Id,'urn:lotar:')"
              id="P500-ARCH-107a" role="error">
        [P500-ARCH-107a][M] Target_Archive_Id must be a LOTAR persistent identifier
        ("urn:lotar:&lt;producer&gt;:&lt;archive-uuid&gt;[:&lt;object-id&gt;]") — nothing that is a
        path or URL crosses an archive boundary (S6 layer 1).
      </assert>
      <assert test="not(contains(p500:Target_Archive_Id,'/'))" id="P500-ARCH-107b" role="error">
        [P500-ARCH-107b][M] Target_Archive_Id must not contain a path separator — it identifies an
        archive, it does not locate one.
      </assert>
      <assert test="not(starts-with(p500:Target_Archive_Id, ../../p500:Package_Identifier))"
              id="P500-ARCH-107c" role="error">
        [P500-ARCH-107c][M] An External_Reference must not point at this archive itself
        (Package_Identifier) — references inside the archive are Traceability_Link locators in the
        part manifests, not external references.
      </assert>
      <assert test="not(p500:Relationship_Type = 'Other') or normalize-space(p500:Relationship_SubType) != ''"
              id="P500-ARCH-107d" role="error">
        [P500-ARCH-107d][M] Relationship_Type "Other" requires a Relationship_SubType from the
        organisation's extended vocabulary (GR3).
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 6 — Package-level sanity (P2/P6/P11, S4)
       ================================================================================== -->
  <pattern id="p500-archive-package">

    <rule context="//p500:Archive_Manifest" id="P500-ARCH-108">
      <assert test="not(p500:Package_Type = 'SIP') or p500:Submission_Agreement" id="P500-ARCH-108a" role="error">
        [P500-ARCH-108a][M] A SIP must reference its Submission Agreement (NAS9300-021 P6).
      </assert>
      <assert test="not(p500:Last_Modified_Date) or not(translate(p500:Last_Modified_Date,'-:TZ.','') &lt; translate(p500:Created_on,'-:TZ.',''))"
              id="P500-ARCH-108b" role="error">
        [P500-ARCH-108b][I] Last_Modified_Date must not precede Created_on.
      </assert>
      <assert test="not(p500:Package_Kind = 'link') or count(p500:Contents/p500:Entry) = 1"
              id="P500-ARCH-108c" role="error">
        [P500-ARCH-108c][M] A metadata-only link archive holds exactly one content entry, its
        Baseline_Link_Set (S6 layer 3).
      </assert>
      <assert test="p500:Package_Kind = 'link' or p500:Contents/p500:Entry[not(@part = '500')]"
              id="P500-ARCH-108d" role="error">
        [P500-ARCH-108d][M] A content archive (Package_Kind "content" or absent) holds at least one
        content branch (an Entry with @part other than "500").
      </assert>
    </rule>

  </pattern>

  <!-- ==================================================================================
       Pattern 7 — Baseline link set records (S6 layer 3)
       ================================================================================== -->
  <pattern id="p500-baseline-link-set">

    <rule context="//p500:Baseline_Link_Set/p500:Link_Record" id="P500-ARCH-109">
      <assert test="not(substring-before(concat(p500:Source_Id,'#'),'#') = substring-before(concat(p500:Target_Id,'#'),'#'))"
              id="P500-ARCH-109a" role="error">
        [P500-ARCH-109a][M] A link record relates two different objects (Source_Id = Target_Id).
      </assert>
      <assert test="not(contains(p500:Source_Id,'/')) and not(contains(p500:Target_Id,'/'))"
              id="P500-ARCH-109b" role="error">
        [P500-ARCH-109b][M] Source_Id and Target_Id are identifiers, never locators — no path
        separators.
      </assert>
      <assert test="not(p500:Relationship_Type = 'Other') or normalize-space(p500:Relationship_SubType) != ''"
              id="P500-ARCH-109c" role="error">
        [P500-ARCH-109c][M] Relationship_Type "Other" requires a Relationship_SubType (GR3).
      </assert>
      <assert test="not(translate(p500:Timestamp_Archiving,'-:TZ.','') &lt; translate(p500:Timestamp_PLM,'-:TZ.',''))"
              id="P500-ARCH-109d" role="error">
        [P500-ARCH-109d][I] Timestamp_Archiving must not precede Timestamp_PLM.
      </assert>
    </rule>

  </pattern>

</schema>
