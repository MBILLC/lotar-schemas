# Mapping of MIC Core to LOTAR standard

Source: [MIC Core Specification](https://mic-core.github.io/MIC-Core/main/#_relationship_between_mic_core_and_lotar_specific_attributes) (Appendix B), retrieved 2026-07-17 from the `main` branch build (asciidoc source: `docs/B___mapping_lotar.adoc` in the [MIC-Core/MIC-Core](https://github.com/MIC-Core/MIC-Core) repository).

This appendix is an optional part of the MIC Core specification. It provides a mapping of the MIC Core standard attributes to the attributes of the LOTAR standard.

## Introduction

LOTAR stands for **Long-term archiving and retrieval (LOTAR)**. It was initiated by the aircraft industry.

Aircraft have very long lifecycles. There can be 80 years between the initial design for a new program and the end of life of the last one delivered. Throughout the product lifecycle, the data defined for archiving and retrieval must be provided in a standardized format that can be read and reused regardless of changes to the original IT environment. Ensuring the on-going use of the original data and models is the goal of LOTAR. The LOTAR MBSE Metadata Manifest was created to support the integration of models from multiple domains and was originally derived from the MIC and the MoSSEC (Modeling and Simulation information in a collaborative Systems Engineering Context) standards. Additional information and related LOTAR standards are in the section [Information about LOTAR](#information-about-lotar) below.

## Mapping of MIC Core attributes to the LOTAR standard

The following table shows the mapping of MIC Core attributes to LOTAR attributes. The first column lists the attributes defined in MIC Core. The second column lists the mapping to the corresponding LOTAR attribute name. The third column gives an abbreviated explanation of the attribute.

| MIC Core Name | LOTAR Mapping | Short Explanation |
| --- | --- | --- |
| Model name | `modelName` | Human-readable way of referring to the model. Usually short and clear. Not necessarily unique. |
| Model identifier | `Unique_object_id` | Unique identifier for the model. |
| Model description | `modelObjective` | Human-readable, textual, general overview. Highlights important information about the model. |
| Model supplier | `Organisation` | The responsible body and, if applicable, organizational unit within the body, that is responsible for supplying the model. |
| Model confidentiality level | `accessControl` | Protection level to apply to the model. |
| Legal restriction | `distributionMarking` | Defines the rules governing the distribution and usage of the simulation model, including licensing. |
| Release | `baselineProductID` | Unique identifier, preferably human-readable (i.e. semantically meaningful), for the release of a particular simulation model. |
| Release date | `approvalDate` | Date, and possibly time and timezone, of the release of a simulation model. Must respect ISO 8601. |
| Release type | `maturityState` | Relates to the maturity of the model. |
| Model purpose | `modelPurpose` | Purpose for which the model has been built/validated. |
| Modelled entity | `systemDesignation` | Name or description of the object represented by the simulation model. |
| Modeling choice | `method` | Explanation of the modeling choices, assumptions or simplifications made during the implementation of the model. |
| Model limitations | `validityRange` | Restrictions on the use of the model. |
| Model classification | `physicsDomain` | Keyword-based classifications of the model in terms, for example, of physics, engineering or implementation. |
| Software and hardware environment requirements | `ModelDev_Integration_Execution_Inf2` | Requirements regarding the software and hardware environment of the model. |
| Verification status | `qualityVerificationAssessmentLevel` | Indicates whether a given verification procedure has been followed to successfully reach verification criteria. |
| Validation status | `qualityValidationAssessmentLevel` | Indicates whether a given validation procedure has been followed to successfully reach validation criteria. |
| Verification & Validation procedure and criteria | `validationScenarioID` | Steps and methods followed as well as criteria to reach. Verification and validation can be covered together or separately. |
| Verification & Validation report | `modelSummaryReport` | Reports describing the results of the verification and validation. |

## Relationship between MIC Core and LOTAR specific attributes

As described in the MIC Core specification's "What is MIC Core" section, the MIC Core standard defines a set of core attributes that other standards can adopt, extend, and refine. The goal is to have a core set of aligned attributes, while giving standards the freedom to cater to their specific use cases. Therefore they also have more specific attributes, going beyond the MIC Core attributes, to support these use cases. As an example:

MIC Core has the attribute **Software and hardware environment requirements**, which fits to the LOTAR attribute **ModelDev_Integration_Execution_Inf2**. But LOTAR also has more specific attributes in this context like **devToolName**, **devToolVersion**, **devToolLicense**, **devOSname**, **devOSversion**, **devOSlicense**, **devCompilerName**, **devCompilerVersion**, **devCompilerLicense**, **devLanguage**, **CPUnumber**, **RAMsize**, and **targetToolName**.

> Note for our P520 work: this LOTAR-side attribute list lines up closely with the fields already
> in `ModelDev_Integration_Execution_Type` in `P520_SCHEMA.xsd` (`DevTool_Name`, `DevTool_Version`,
> `DevTool_License`, `DevOS_Name`, `DevOS_Version`, `DevOS_License`, `DevOS_Compiler_Name`,
> `DevOS_Compiler_Version`, `DevOS_Compiler_License`, `Dev_Language`, `CPU_Number`, `RAM_Size`,
> `Target_Tool_Name`) — useful as a naming/coverage cross-check, not part of the source document.

## Information about LOTAR

**LOTAR International (<https://lotar-international.org/>)** is a project being conducted by leading OEMs, suppliers, and solution providers in the aerospace and defense industry under the joint auspices of the Aerospace Industries Association of America (AIA), the AeroSpace and Defense Industries Association of Europe for Standardization (ASD-STAN), PDES, Inc., and the prostep ivip association. Based on ISO 14721, the Open Archival Information System (OAIS) Reference Model, the LOTAR organization is divided into domain workgroups.

*Figure (source doc): "Structure of LOTAR organisation" — `images/Lotar-structure.png`*

The business case for data preservation is more than data reuse and includes regulatory requirements, accident investigations, product support and modifications, part/design obsolescence, software fixes, and the evolution of tools.

*Figure (source doc): "Life time for data preservation" — `images/Timeline-Archiving.png`*

The Model-Based Systems Engineering (MBSE) workgroup is focused on delivering process instructions for specific model types. In addition to general modeling and quality standards, the instructions identify data standards applicable to the individual modeling domains. Examples include ReqIF, NAS-STD-7009B, FMI/SSP, SysMLv2, AP243, RDF/OWL/OSLC.

*Figure (source doc): "Modeling domains of Model-Based Systems Engineering (MBSE) workgroup" — `images/Lotar-domain-parts.png`*

---

### Related: Mapping of MIC Core attributes to the SRMD format

For reference, the MIC Core specification's other normative mapping (Appendix A) maps the same MIC Core attribute list onto SRMD (SSP Traceability) `Classification`/`ClassificationEntry` keywords instead of LOTAR field names, e.g. `Model name` → `administrative-data.model.name`, `Verification & Validation report` → `verification-validation.report`. See `SRMDMICCore.xsd` (plus `SRMD.xsd` and `STC.xsd`) saved alongside this file for the corresponding baseline XML Schema.
