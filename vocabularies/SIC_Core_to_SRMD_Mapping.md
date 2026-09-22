# Mapping of SIC Core to SSP LS Traceability SRMD Format

**Superseded 2026-07-24 (afternoon):** the 2026-07-20 "disregarded" status below no longer
applies — SIC Core is reinstated as a mandatory basic metadata vocabulary; this mapping is the
`org.mic-core.sic-core` Classification mechanism `LOTAR_Risk_Profile_Process_Plan_2026-07-24.md`
§3.4 builds its risk-level matrix on top of. **Note:** the ratified spec (commit `abbf540`,
2026-06-19) still shows every keyword/tier below unchanged from what was captured 2026-07-17 — no
re-verification needed on that front — but the spec itself is still self-described as not yet
normative/officially endorsed; see §1b's Alert 1 in the plan document. `SRMDSICCore.xsd` moving
out of `WaitForLater/` is task **T-24**, not yet executed — still there as of this note.

~~**Status note (confirmed 2026-07-20):** SIC Core is disregarded for the mandatory LOTAR Core
baseline for now — kept here as reference material only, not part of the current mandatory
schema set. `SRMDSICCore.xsd` remains in `WaitForLater/`.~~

Source: [SIC Core Specification](https://mic-core.github.io/SIC-Core/main/#_mapping_of_sic_core_attributes_to_the_srmd_format) (Appendix A), retrieved 2026-07-17 from the `main` branch build (asciidoc source: `docs/A___mapping_srmd.adoc` in the [MIC-Core/SIC-Core](https://github.com/MIC-Core/SIC-Core) repository).

This appendix is an optional part of the SIC Core specification. It provides an implementation of the SIC Core standard attributes in the SRMD (Simulation Resource Meta Data) format, one of the formats specified in the SSP LS (Layered Standard) Traceability specification. It is normative for any mapping to the SRMD format that uses the specified classification type.

## Introduction

The SRMD (Simulation Resource Meta Data) metadata format is one of the formats specified in the SSP LS Traceability specification. These formats form part of the Modelica Association Project SSP (System Structuring and Parametrization) provided format specifications. The SRMD format allows any metadata or other attributes to be specified as key-value pairs in an XML-based format. The format description also specifies where this metadata file should be stored in an FMU or SSP archive. The SSP LS Traceability specification is a normative reference for this appendix.

## Mapping of SIC Core attributes to the SRMD format

The `type` attribute of the `Classification` element must be specified as `org.mic-core.sic-core`. This `Classification` element must only contain `ClassificationEntry` elements with `keyword` attributes from the tables below. It should contain entries for all SIC Core attributes that are considered mandatory.

The tables show the mapping of SIC Core attributes to SRMD classification entries, separated by the different SIC Core attribute groups. The first column lists the attributes defined in SIC Core. The second column lists the conversion of the attribute names to SRMD classification entry keywords (clustered via terms separated by periods, no spaces). The third column lists the obligation level of the attribute, as defined in the SIC Core specification. The fourth column gives an abbreviated, non-normative explanation.

For composite attributes that have sub-attributes as defined in the SIC Core specification, the main attribute entry is followed by entries for each sub-attribute, with the sub-attribute name appended to the main attribute keyword after a period separator (e.g. `administrative.simulation-task` and `administrative.simulation-task.name`).

### Administrative Data

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Overall Product | `administrative.overall-product` | Recommended | Overall product associated with the simulation. |
| Overall Product Name | `administrative.overall-product.name` | Recommended | Unique master name of the overall product associated with the simulation. |
| Overall Product Version | `administrative.overall-product.version` | Recommended | Version of the overall product. |
| Overall Product Identifier | `administrative.overall-product.identifier` | Recommended | Identifier of the overall product. |
| Overall Product URL | `administrative.overall-product.url` | Optional | URL of the overall product. |
| Overall Product Full Name | `administrative.overall-product.full-name` | Optional | Full name of the overall product. |
| Specific Product | `administrative.specific-product` | Recommended | Specific product whose development or validation requires the simulation. |
| Specific Product Name | `administrative.specific-product.name` | Recommended | Unique master name of the specific product whose development or validation requires the simulation. |
| Specific Product Version | `administrative.specific-product.version` | Recommended | Version of the specific product. |
| Specific Product Identifier | `administrative.specific-product.identifier` | Recommended | Identifier of the specific product. |
| Specific Product URL | `administrative.specific-product.url` | Optional | URL of the specific product. |
| Specific Product Full Name | `administrative.specific-product.full-name` | Optional | Full name of the specific product. |
| Ordering Project | `administrative.ordering-project` | Recommended | Ordering development project. |
| Ordering Project Name | `administrative.ordering-project.name` | Recommended | Unique master name of the ordering development project. |
| Ordering Project Version | `administrative.ordering-project.version` | Recommended | Version of the ordering project. |
| Ordering Project Identifier | `administrative.ordering-project.identifier` | Recommended | Identifier of the ordering project. |
| Ordering Project URL | `administrative.ordering-project.url` | Optional | URL of the ordering project. |
| Ordering Project Full Name | `administrative.ordering-project.full-name` | Optional | Full name of the ordering project. |
| Simulation Request | `administrative.simulation-request` | Recommended | Simulation request. |
| Simulation Request Name | `administrative.simulation-request.name` | Recommended | Unique name of the simulation request. |
| Simulation Request Version | `administrative.simulation-request.version` | Recommended | Version of the simulation request. |
| Simulation Request Identifier | `administrative.simulation-request.identifier` | Recommended | Identifier of the simulation request. |
| Simulation Request URL | `administrative.simulation-request.url` | Optional | URL of the simulation request. |
| Simulation Request Full Name | `administrative.simulation-request.full-name` | Optional | Full name of the simulation request. |
| Simulation Task | `administrative.simulation-task` | Mandatory | Simulation task. |
| Simulation Task Name | `administrative.simulation-task.name` | Mandatory | Unique name of the simulation task. |
| Simulation Task Version | `administrative.simulation-task.version` | Mandatory | Version of the simulation task. |
| Simulation Task Identifier | `administrative.simulation-task.identifier` | Mandatory | Identifier of the simulation task. |
| Simulation Task URL | `administrative.simulation-task.url` | Optional | URL of the simulation task. |
| Simulation Task Full Name | `administrative.simulation-task.full-name` | Optional | Full name of the simulation task. |
| Simulation Task Confidentiality Level | `administrative.simulation-task.confidentiality` | Recommended | Classification level that defines access to the contained information. |
| Predicted Simulation Start Date | `administrative.simulation-task.date.start` | Recommended | Date when all required information is expected to be available to start simulation. |
| Requested Simulation Delivery Date | `administrative.simulation-task.date.delivery` | Recommended | Date when simulation results are requested by the ordering side. |
| Requesting Person | `administrative.contact.customer-person` | Recommended | Person who needs and will work with the simulation results on a technical level. |
| Requesting Entity | `administrative.contact.customer-entity` | Recommended | Department or external company requesting and using the simulation results. |
| Contracting Person | `administrative.contact.contractor-person` | Recommended | Person accepting the simulation request to provide the simulation service. |
| Contracting Entity | `administrative.contact.contractor-entity` | Recommended | Department or external company accepting the simulation request. |
| Simulation Task Creator Name | `administrative.simulation-task.creator` | Optional | Name or compliant identifier of the person who created the simulation task. |
| Simulation Task Creation Date | `administrative.simulation-task.date.creation` | Optional | Date when the simulation task was created in the project management system. |

### Analysis

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Item under Test | `analysis.item-under-test` | Mandatory | Product, system, component, software, or other item that is subject to simulation. |
| Item under Test Name | `analysis.item-under-test.name` | Mandatory | Name of the product, system, component, software, or other item that is subject to simulation. |
| Item under Test Version | `analysis.item-under-test.version` | Mandatory | Version of the item under test. |
| Item under Test Identifier | `analysis.item-under-test.identifier` | Mandatory | Identifier of the item under test. |
| Item under Test URL | `analysis.item-under-test.url` | Optional | URL of the item under test. |
| Item under Test Full Name | `analysis.item-under-test.full-name` | Optional | Full name of the item under test. |
| Higher Level Engineering Task | `analysis.engineering-task.higher-level` | Recommended | Higher-level engineering task that gives context for the specific task. |
| Higher Level Engineering Task Name | `analysis.engineering-task.higher-level.name` | Recommended | Name of the higher-level engineering task. |
| Higher Level Engineering Task Version | `analysis.engineering-task.higher-level.version` | Recommended | Version of the higher-level engineering task. |
| Higher Level Engineering Task Identifier | `analysis.engineering-task.higher-level.identifier` | Recommended | Identifier of the higher-level engineering task. |
| Higher Level Engineering Task URL | `analysis.engineering-task.higher-level.url` | Optional | URL of the higher-level engineering task. |
| Higher Level Engineering Task Full Name | `analysis.engineering-task.higher-level.full-name` | Optional | Full name of the higher-level engineering task. |
| Specific Engineering Task | `analysis.engineering-task.specific` | Recommended | Concrete engineering task that directly benefits from simulation results. |
| Specific Engineering Task Name | `analysis.engineering-task.specific.name` | Recommended | Name of the specific engineering task. |
| Specific Engineering Task Version | `analysis.engineering-task.specific.version` | Recommended | Version of the specific engineering task. |
| Specific Engineering Task Identifier | `analysis.engineering-task.specific.identifier` | Recommended | Identifier of the specific engineering task. |
| Specific Engineering Task URL | `analysis.engineering-task.specific.url` | Optional | URL of the specific engineering task. |
| Specific Engineering Task Full Name | `analysis.engineering-task.specific.full-name` | Optional | Full name of the specific engineering task. |
| Simulation Objective | `analysis.simulation-task.objectives` | Mandatory | Engineering question to be answered by the simulation task. |
| Simulation further Requirements | `analysis.simulation-task.further-requirements` | Recommended | Additional simulation requirements defining what to determine, confirm, or neglect. |
| Quality Criterion | `analysis.quality-aspects` | Recommended | Quality requirement to be fulfilled during simulation. |
| Verification Criterion | `analysis.verification` | Recommended | Quality requirement for verifying alignment with simulation objectives. |
| Validation Criterion | `analysis.validation` | Recommended | Quality requirement for validating alignment with requesting engineering needs. |
| Analysis Phase Verification Result | `analysis.verification` | Recommended | Result of the analysis phase closing verification. |

### Requirements

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Model Purpose and Objectives | `requirements.model.purpose-objectives` | Recommended | Individual model purposes and objectives derived from simulation objectives. |
| Modeled Entity | `requirements.model.subject-information.modeled-entity` | Recommended | Real-world entity that is to be modeled. |
| Modeled Entity Name | `requirements.model.subject-information.modeled-entity.name` | Recommended | Name of the real-world entity that is to be modeled. |
| Modeled Entity Version | `requirements.model.subject-information.modeled-entity.version` | Recommended | Version of the modeled entity. |
| Modeled Entity Identifier | `requirements.model.subject-information.modeled-entity.identifier` | Recommended | Identifier of the modeled entity. |
| Modeled Entity URL | `requirements.model.subject-information.modeled-entity.url` | Optional | URL of the modeled entity. |
| Modeled Entity Full Name | `requirements.model.subject-information.modeled-entity.full-name` | Optional | Full name of the modeled entity. |
| Required Modeled Effect | `requirements.model.effects-considered` | Recommended | Real-world physical effect that shall be considered in modeling. |
| Further Model Requirements | `requirements.model.further-model-requirements` | Recommended | Additional requirements placed on the model. |
| Simulation Model Confidentiality Level | `requirements.model.confidentiality` | Recommended | Confidentiality classification for model-related information. |
| Model Quality Requirement | `requirements.model.quality-requirements` | Optional | Quality requirement for a simulation model. |
| Entity Parameter | `requirements.parameter.subject-information.parametrized-entity` | Mandatory | Referenced parameters of the entity to be modeled. |
| Value Distribution Function | `requirements.parameter-value-distribution-function` | Recommended | Probability distribution used to describe parameter value deviations. |
| Parameter Confidentiality Level | `requirements.parameter.confidentiality` | Recommended | Confidentiality classification for parameter-related information. |
| Parameter Quality Requirement | `requirements.parameter.quality-requirements` | Optional | Quality requirement for parameter sets. |
| Test Case Requirements | `requirements.test-case` | Recommended | Requirements for simulation test cases and their objectives. |
| Test Case Confidentiality Level | `requirements.test-case.confidentiality` | Recommended | Confidentiality classification for test case-related information. |
| Test Case Quality Requirement | `requirements.test-case.quality-requirements` | Optional | Quality requirement for test cases. |
| Simulation Environment Requirement | `requirements.simulation-environment` | Recommended | Requirement placed on the simulation environment. |
| Simulation Environment Quality Requirement | `requirements.simulation-environment.quality-requirements` | Optional | Quality requirement for the simulation environment. |
| Simulation Integration Requirement | `requirements.simulation-integration` | Recommended | Requirement placed on interaction of simulation setup elements. |
| Simulation Integration Quality Requirement | `requirements.simulation-integration.quality-requirements` | Optional | Quality requirement for simulation integration. |
| Quality Assurance Requirements | `requirements.quality-assurance` | Recommended | Requirements placed on quality assurance in the requirements phase. |
| Requirements Phase Verification Result | `requirements.verification` | Recommended | Result of verification activities in the requirements phase. |

### Design

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Model Design Specification | `design.model` | Recommended | Definition of how model shall be implemented. |
| Model Design Quality Requirement | `design.model.quality-requirements` | Optional | Quality requirement for model design. |
| Parameter Design Specification | `design.parameter` | Recommended | Definition of how parameters shall be implemented. |
| Parameter Design Quality Requirement | `design.parameter.quality-requirements` | Optional | Quality requirement for parameter design. |
| Test Case Design Specification | `design.test-case` | Recommended | Definition of how test cases shall be implemented. |
| Test Case Design Quality Requirement | `design.test-case.quality-requirements` | Optional | Quality requirement for test case design. |
| Simulation Environment Design Specification | `design.simulation-environment` | Recommended | Definition of how the simulation environment shall be implemented. |
| Simulation Environment Design Quality Requirement | `design.simulation-environment.quality-requirements` | Optional | Quality requirement for simulation environment design. |
| Simulation Integration Design Specification | `design.simulation-integration` | Recommended | Definition of how simulation components shall be integrated. |
| Simulation Integration Design Quality Requirement | `design.simulation-integration.quality-requirements` | Optional | Quality requirement for simulation integration design. |
| Design Quality Assurance | `design.quality-assurance` | Recommended | Quality assurance measure in the design phase. |
| Design Verification Result | `design.verification` | Recommended | Result of verification activities in the design phase. |

### Implementation

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Simulation Model | `implementation.model` | Recommended | Implemented simulation model. |
| Simulation Model Name | `implementation.model.name` | Recommended | Name of the implemented simulation model. |
| Simulation Model Version | `implementation.model.version` | Recommended | Version of the implemented simulation model. |
| Simulation Model Identifier | `implementation.model.identifier` | Recommended | Identifier of the implemented simulation model. |
| Simulation Model URL | `implementation.model.url` | Optional | URL of the implemented simulation model. |
| Simulation Model Full Name | `implementation.model.full-name` | Optional | Full name of the implemented simulation model. |
| Simulation Model Confidentiality Level | `implementation.model.confidentiality` | Recommended | Confidentiality classification for implemented model information. |
| Simulation Model Quality | `implementation.model.quality` | Recommended | Statement describing achieved model quality after implementation. |
| Parameter | `implementation.parameter` | Recommended | Implemented parameter set. |
| Parameter Name | `implementation.parameter.name` | Recommended | Name of the implemented parameter set. |
| Parameter Version | `implementation.parameter.version` | Recommended | Version of the implemented parameter set. |
| Parameter Identifier | `implementation.parameter.identifier` | Recommended | Identifier of the implemented parameter set. |
| Parameter URL | `implementation.parameter.url` | Optional | URL of the implemented parameter set. |
| Parameter Full Name | `implementation.parameter.full-name` | Optional | Full name of the implemented parameter set. |
| Parameter Confidentiality Level | `implementation.parameter.confidentiality` | Recommended | Confidentiality classification for parameter information. |
| Parameter Quality | `implementation.parameter.quality` | Recommended | Statement describing achieved parameter quality after implementation. |
| Test Case | `implementation.test-case` | Recommended | Implemented test case. |
| Test Case Name | `implementation.test-case.name` | Recommended | Name of implemented test cases. |
| Test Case Version | `implementation.test-case.version` | Recommended | Version of the implemented test case. |
| Test Case Identifier | `implementation.test-case.identifier` | Recommended | Identifier of the implemented test case. |
| Test Case URL | `implementation.test-case.url` | Optional | URL of the implemented test case. |
| Test Case Full Name | `implementation.test-case.full-name` | Optional | Full name of the implemented test case. |
| Test Case Confidentiality Level | `implementation.test-case.confidentiality` | Recommended | Confidentiality classification for implemented test case information. |
| Test Case Quality | `implementation.test-case.quality` | Recommended | Statement describing achieved test case quality after implementation. |
| Simulation Environment | `implementation.simulation-environment` | Recommended | Implemented simulation environment. |
| Simulation Environment Name | `implementation.simulation-environment.name` | Recommended | Name of the implemented simulation environment. |
| Simulation Environment Version | `implementation.simulation-environment.version` | Recommended | Version of the implemented simulation environment. |
| Simulation Environment Identifier | `implementation.simulation-environment.identifier` | Recommended | Identifier of the implemented simulation environment. |
| Simulation Environment URL | `implementation.simulation-environment.url` | Optional | URL of the implemented simulation environment. |
| Simulation Environment Full Name | `implementation.simulation-environment.full-name` | Optional | Full name of the implemented simulation environment. |
| Simulation Environment Quality | `implementation.simulation-environment.quality` | Recommended | Statement describing achieved simulation environment quality after implementation. |
| Solver Setting | `implementation.simulation-integration.settings` | Recommended | Relevant simulation integration settings, such as solver settings. |
| Simulation Integration | `implementation.simulation-integration` | Recommended | Implemented simulation integration. |
| Simulation Integration Name | `implementation.simulation-integration.name` | Recommended | Name of the implemented simulation integration. |
| Simulation Integration Version | `implementation.simulation-integration.version` | Recommended | Version of the implemented simulation integration. |
| Simulation Integration Identifier | `implementation.simulation-integration.identifier` | Recommended | Identifier of the implemented simulation integration. |
| Simulation Integration URL | `implementation.simulation-integration.url` | Optional | URL of the implemented simulation integration. |
| Simulation Integration Full Name | `implementation.simulation-integration.full-name` | Optional | Full name of the implemented simulation integration. |
| Simulation Integration Quality | `implementation.simulation-integration.quality` | Recommended | Statement describing achieved simulation integration quality after implementation. |
| Implementation Quality Assurance Results | `implementation.quality-assurance-results` | Recommended | Results of quality assurance activities in the implementation phase. |
| Implementation Quality Verdict | `implementation.verdict` | Optional | Final implementation quality decision. |

### Execution

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Used Simulation Model | `execution.model` | Mandatory | Simulation model actually used in execution. |
| Used Simulation Model Name | `execution.model.name` | Mandatory | Name of simulation model actually used in execution. |
| Used Simulation Model Version | `execution.model.version` | Mandatory | Version of simulation model actually used in execution. |
| Used Simulation Model Identifier | `execution.model.identifier` | Mandatory | Identifier of simulation model actually used in execution. |
| Used Simulation Model URL | `execution.model.url` | Optional | URL of simulation model actually used in execution. |
| Used Simulation Model Full Name | `execution.model.full-name` | Optional | Full name of simulation model actually used in execution. |
| Used Parameter | `execution.parameter` | Mandatory | Parameter set actually used in execution. |
| Used Parameter Name | `execution.parameter.name` | Mandatory | Name of parameter set actually used in execution. |
| Used Parameter Version | `execution.parameter.version` | Mandatory | Version of parameter set actually used in execution. |
| Used Parameter Identifier | `execution.parameter.identifier` | Mandatory | Identifier of parameter set actually used in execution. |
| Used Parameter URL | `execution.parameter.url` | Optional | URL of parameter set actually used in execution. |
| Used Parameter Full Name | `execution.parameter.full-name` | Optional | Full name of parameter set actually used in execution. |
| Used Test Case | `execution.test-case` | Recommended | Test case actually used in execution. |
| Used Test Case Name | `execution.test-case.name` | Recommended | Name of test case actually used in execution. |
| Used Test Case Version | `execution.test-case.version` | Recommended | Version of test case actually used in execution. |
| Used Test Case Identifier | `execution.test-case.identifier` | Recommended | Identifier of test case actually used in execution. |
| Used Test Case URL | `execution.test-case.url` | Optional | URL of test case actually used in execution. |
| Used Test Case Full Name | `execution.test-case.full-name` | Optional | Full name of test case actually used in execution. |
| Used Tool | `execution.tool` | Mandatory | Tool actually used in execution. |
| Used Tool Name | `execution.tool.name` | Mandatory | Name of tool actually used in execution. |
| Used Tool Version | `execution.tool.version` | Mandatory | Version of tool actually used in execution. |
| Used Tool Identifier | `execution.tool.identifier` | Mandatory | Identifier of tool actually used in execution. |
| Used Tool URL | `execution.tool.url` | Optional | URL of tool actually used in execution. |
| Used Tool Full Name | `execution.tool.full-name` | Optional | Full name of tool actually used in execution. |
| Execution Raw Data | `execution.data` | Recommended | Original data resulting from simulation runs before processing. |
| Used Tool Settings | `execution.tool.settings` | Recommended | Tool-specific settings applied during execution. |
| Execution Log | `execution.log` | Optional | Chronological record of relevant execution activities. |

### Evaluation

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Evaluation Results | `evaluation.results` | Recommended | Key results produced by processing simulation output data. |
| Evaluation Quality-Assurance Results | `evaluation.quality-assurance` | Recommended | Results of quality assurance activities during evaluation. |
| Evaluation Quality Verdict | `evaluation.verdict` | Optional | Final verdict from evaluating simulation results. |

### Fulfillment

| SIC Core Name | SRMD Mapping | Obligation | Short Explanation |
| --- | --- | --- | --- |
| Task Status | `fulfillment.task-status` | Mandatory | Overall status assessment of the simulation task. |
| Quality Fulfilled | `fulfillment.quality` | Recommended | Decision whether simulation quality requirements are fulfilled. |
| Objectives Fulfilled | `fulfillment.objectives` | Recommended | Decision whether simulation objectives are fulfilled. |
| Fulfillment Evidence | `fulfillment.evidence` | Recommended | Link or reference to evidence supporting fulfillment decisions. |
| Fulfillment Date | `fulfillment.date` | Recommended | Date on which fulfillment assessment is made. |

## Related: XML Schema

The corresponding XML Schema (Appendix A, "XML SRMD-Schema for SIC Core") is saved as `SRMDSICCore.xsd` alongside this file, together with the `SRMD.xsd`/`STC.xsd` baseline it depends on (shared with the MIC Core baseline already in this project — see `SRMDMICCore.xsd` for provenance). That schema encodes this same table as Schematron rules: mandatory-attribute checks, an allowed-keyword whitelist, ISO 8601 date-format checks on the `*.date.*`/`fulfillment.date` keywords, and confidentiality-level enumeration checks (`CSC-0: public` … `CSC-3: strictly confidential`) on the `*.confidentiality` keywords.

## Related: Mapping of MIC Core to SRMD and LOTAR

For comparison, MIC Core (the smaller, cross-domain core attribute set that SIC Core specializes/extends) has its own SRMD mapping and a separate LOTAR-specific mapping — see `MIC_Core_to_LOTAR_Mapping.md` in this project. SIC Core does not currently have a published LOTAR-specific mapping (only Appendix B "Basic Subset" in the SIC Core spec, which was not requested here).
