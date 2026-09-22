# FMI 3.0.2, SSP 2.0.1, and SSP-LS-Traceability 1.0.0 — Recommended LOTAR Controlled Vocabulary

Single alphabetical table combining the terms recommended in FMI_SSP_Controlled_Vocabulary_Extract.md, Section D, with the SSP-LS-Traceability 1.0.0 candidates extracted in SSP_LS_Traceability_Recommended_Vocabulary.md:

- **D.1 — Reference, don't re-mint** (A.1 causality, A.2 variability, A.3 initial, A.4 variableNamingConvention, A.5 data types, A.6 interface type, A.9 dependenciesKind, B.1 connector kind, B.3 transformation types): terms already normatively fixed by the FMI/SSP schemas, to be cited rather than re-published as a LOTAR-local vocabulary.
- **D.2 — New LOTAR-local vocabulary needed** (A.10 packaging/file-role terms, B.4 file/package formats, B.5 traceability/signature vocabulary, B.6 extensibility/addressing vocabulary): terms LOTAR needs its own controlled entries for.
- **SSP-LS-Traceability** — controlled values and structurally-significant concepts from the SSP Layered Standard Traceability spec (DTMD/STMD/SRMD/STC formats, Credible Decision/Simulation Process framework, Life-cycle status and Resource kind enumerations, GlueParticle, DerivationChain, Classification).

Section D.3 ("likely not needed for archiving": A.7 status codes, A.8 Clock timing, B.2 model element types, B.7 geometry terms) is excluded, as recommended. Also excluded from the SSP-LS-Traceability side: the ~40 schema-internal DTMD/STMD phase/step element names, elements the spec marks "See SSP Specification" (Content, Metadata, Signature, Annotation/Annotations — reused unchanged from core SSP), and XLink mechanics (reused from the W3C XLink standard).

Where the same term string is defined more than once for a different attribute (e.g. `constant` as an FMI variability value, an FMI dependenciesKind value, and an SSP connector kind value; or the fifteen `Resource kind = X` / six `Life-cycle status = X` enumeration values), each definition is kept as a separate row — following the same duplicate-marking convention used in Merged_Glossary_v5.md — rather than merged, since they are not the same controlled-vocabulary field. One true duplicate was found and is flagged below: **SRMD (Simulation Resource Meta Data)**, defined independently (with slightly different wording) by both SSP 2.0.1 §4.5.4.1 and SSP-LS-Traceability 1.0.0 — the fuller SSP-LS-Traceability definition is flagged as the duplicate since it is the later-added, more detailed source.

**Data-quality note (carried from SSP_LS_Traceability_Recommended_Vocabulary.md):** the SSP-LS-Traceability spec text is internally inconsistent in two places, reproduced faithfully rather than silently corrected: (1) §9.3 states DTMD's file extension is `.stmd` (the same extension used for STMD) rather than a DTMD-specific extension — likely a copy-paste error in the source spec; (2) the `kind='rationale'` value's definition text in §5.9 is a near-verbatim repeat of the `kind='method'` definition, suggesting a drafting error rather than genuine synonymy. Flag both with the SSP-standard.org maintainers before treating either as authoritative.

| Term | Definition | Source |
|---|---|---|
| Annotation | A generic, namespaced XML extension element (ssc:Annotation) insertable into any SSP model entity. | SSP 2.0.1 §2.1.1 |
| approx | The start value is an initial guess, refined by an iteration/initialization algorithm. (FMI initial) | FMI 3.0.2, fmi3Variable.xsd |
| binaries/ | FMU directory holding the platform-specific compiled shared libraries (.dll/.so) implementing the C-API. | FMI 3.0.2 §2.5 |
| Binary | An arbitrary-length byte-sequence variable, with an associated mimeType, new in FMI 3.0 (used e.g. for sensor data, images). | FMI 3.0.2, fmi3Variable.xsd |
| Boolean | A two-valued (true/false) variable. | FMI 3.0.2, fmi3Variable.xsd |
| BooleanMappingTransformation | A lookup-table transform remapping Boolean connection/parameter values. | SSP 2.0.1 §4.5.2.2 |
| BuildConfiguration | XML element describing how to compile a source-code FMU (new in FMI 3.0). | FMI 3.0.2 §2.4.10 |
| calculated | The initial value is computed from other variables during initialization; no start value given. (FMI initial) | FMI 3.0.2, fmi3Variable.xsd |
| calculatedParameter (FMI) | A parameter whose value is calculated by the FMU during initialization and afterward remains constant, and which cannot be set by the environment. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| calculatedParameter (SSP) | A connector for a parameter computed by the component during initialization. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| Checksum algorithm = SHA3-256 | The only currently-permitted value of SRMD's `checksumType` attribute (SHA3, 256-bit, per FIPS 202); the spec notes future algorithms may be added later, making this a closed set of one value today. | SSP-LS-Traceability 1.0.0 §8.1 |
| Classification | A `GElementCommon` sub-element attaching a set of namespaced keyword/value pairs (via repeatable `ClassificationEntry` children) to a modeling element, for uses such as searchable keywords, quality/validation levels, or variant tracking; the `type` attribute (recommended in reverse-domain-name notation) names the classification scheme. | SSP-LS-Traceability 1.0.0 §5.2.1 |
| ClassificationEntry | A single keyword/value pair within a Classification; `keyword` (mandatory) names the entry, `type` (optional, default `text/plain`) gives the MIME type of its value/content, and it may carry an `xlink:href` link instead of or alongside inline content. | SSP-LS-Traceability 1.0.0 §5.2.1.1 |
| Clock | A discrete, scalar variable representing a time or event base that activates model partitions/other variables. | FMI 3.0.2, fmi3Variable.xsd |
| Co-Simulation (CS) | FMI interface type in which the FMU carries its own internal solver and advances itself across communication steps (fmi3DoStep). | FMI 3.0.2 §1.2.2 |
| constant | A connector whose value never changes. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| constant (dependency) | The dependency is via a factor known to be constant during the whole simulation. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| constant (variability) | The variable's value never changes during a simulation run. (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| Content addressing | The URI-based mechanism (relative or absolute) by which SSP files reference other files/resources. | SSP 2.0.1 §2.3 |
| continuous | No restriction on when the value changes. (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| Credible Decision Process | The 5-phase decision-making process (Analysis of Decision Task, Definition of Sub-Tasks, Performing Sub-Tasks, Evaluation, Fulfillment) that a Simulation Request originates from and a Simulation Delivery returns to; documented via a DTMD file. | SSP-LS-Traceability 1.0.0 §2.1 |
| Credible Simulation Process | The 7-phase process (Analysis of Simulation Task, Definition of Simulation Requirements, Design Specification, Implementation, Simulation Execution, Evaluation, Fulfillment) that performs a simulation in response to a Simulation Request; documented via an STMD file. | SSP-LS-Traceability 1.0.0 §2.2 |
| Credible Simulation Process Framework | The overall procedural framework linking a Credible Decision Process and a Credible Simulation Process via a Simulation Request and Simulation Delivery, that SSP-LS-Traceability's DTMD/STMD/SRMD files exist to document. | SSP-LS-Traceability 1.0.0 §1.1, §2 |
| dependent | The unknown depends on the referenced variable in an otherwise unspecified way (most general case). (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| DerivationChain | A `GeneralInformationType` sub-element recording the provenance chain of prior file versions a GlueParticle was derived from, via repeatable `DerivationChainEntry` records (each carrying a GUID, author, file version, copyright, license, generating tool, and generation date/time) — the mechanism directly relevant to the LOTAR Provenance requirement (PD9). | SSP-LS-Traceability 1.0.0 §5.1.1 |
| discrete (dependency) | The dependency factor may change only at events. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| discrete (variability) | The value changes only at events (not continuously between them). (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| documentation/ | Optional FMU directory for human-readable documentation. | FMI 3.0.2 §2.5 |
| DTMD (Decision Task Meta Data) | The XML file format documenting a Credible Decision Process, MIME type `application/x-dtmd-decisiontask`; packaged at `extra/org.ssp-standard.ssp-traceability.stmd/DecisionTask.dtmd` inside an SSP archive. | SSP-LS-Traceability 1.0.0 §3.2, Ch. 6, §9.3 |
| Enumeration | A variable restricted to a named, integer-backed set of items defined by an EnumerationType. | FMI 3.0.2, fmi3Variable.xsd |
| EnumerationMappingTransformation | A lookup-table transform remapping Enumeration values by item name. | SSP 2.0.1 §4.5.2.4 |
| exact | The variable's start value is used unmodified as its initial value. (FMI initial) | FMI 3.0.2, fmi3Variable.xsd |
| Extension Namespace | A reverse-domain-name-notation namespace (e.g. org.modelica.ssp.*) used to avoid collisions in Annotations and extra files. | SSP 2.0.1 §2.1.3 |
| Extra Files mechanism | The reserved extra/ ZIP-entry prefix used to bundle additional, arbitrarily-formatted data/metadata into an SSP package. | SSP 2.0.1 §2.1.2 |
| fixed (dependency) | The dependency factor only changes at initialization/(re-)configuration. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| fixed (variability) | The value only changes at initialization or (re-)configuration. (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| flat | Variable names have no hierarchical/structured meaning. (FMI variableNamingConvention) | FMI 3.0.2, fmi3ModelDescription.xsd |
| Float32 / Float64 | IEEE single/double precision floating-point variable ("Real" in FMI 2.0). | FMI 3.0.2, fmi3Variable.xsd |
| FMU (Functional Mock-up Unit) | The ZIP-archive container (.fmu) that packages a model's XML description, binaries/sources, and resources. | FMI 3.0.2 §1.2 |
| GlueParticle | A bundle of process-relevant information and resources for a step of a Credible Decision or Simulation Process; its file-based representation (a conformant DTMD or STMD file — SRMD instances are explicitly excluded from this term) is called a "GlueParticle file". | SSP-LS-Traceability 1.0.0 §3.1 |
| independent | The independent variable of the model (normally time). (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| inout | A connector that is both input and output (only valid on SignalDictionaryReferences; not valid for FMI-backed components). (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| input (FMI) | A variable whose value is provided by the environment / another connected component. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| input (SSP) | A connector receiving a value into the model element. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| instantiationToken | Required unique token in modelDescription.xml (successor of FMI 2.0's guid) used by the importer to check that the correct FMU is being loaded. | FMI 3.0.2, fmi3ModelDescription.xsd |
| Int8 / UInt8 / Int16 / UInt16 / Int32 / UInt32 / Int64 / UInt64 | Signed/unsigned integer variable of the given bit width ("Integer" in FMI 2.0, now split by width/signedness). | FMI 3.0.2, fmi3Variable.xsd |
| IntegerMappingTransformation | A lookup-table transform remapping integer or Enumeration-typed values. | SSP 2.0.1 §4.5.2.3 |
| Layered Standard | A backward-compatible extension to core SSP defined via Annotations, extra files, and/or additional MIME types. | SSP 2.0.1 §2.2 |
| licenses/ | Optional FMU directory holding license text files bundled with the FMU. | FMI 3.0.2 §2.5.1.1.1 |
| Life-cycle status = Approved | The GlueParticle life-cycle state indicating the entity has been approved on the basis of prior review and validation. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Archived | The GlueParticle life-cycle state indicating the entity remains valid for this specific GlueParticle instance but is not to be reused for similar steps/phases in other GlueParticles. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Defined | The GlueParticle life-cycle state indicating the entity is considered complete and may be subject to further review or validation. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Drafted | The GlueParticle life-cycle state indicating a draft, still-in-progress and possibly incomplete entity. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Retracted | The GlueParticle life-cycle state indicating the entity has been withdrawn, considered invalid or in need of revision. | SSP-LS-Traceability 1.0.0 §5.4 |
| Life-cycle status = Validated | The GlueParticle life-cycle state indicating the entity has been reviewed and validated. | SSP-LS-Traceability 1.0.0 §5.4 |
| LinearTransformation | A target = factor × source + offset transform applied to a connection or parameter mapping value (Real/Float types only). | SSP 2.0.1 §4.5.2.1 |
| local (FMI) | A variable internal to the FMU, not intended for connection; default causality. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| local (SSP) | A connector for a model-internal variable, not intended for connection; behaves as output if connected anyway. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| MAP SSP layered standard | A layered standard defined/adopted and published by the Modelica Association Project SSP itself. | SSP 2.0.1 §2.2 |
| MetaData | A generic element attaching arbitrary typed metadata (inline or by reference) to any SSP model element. | SSP 2.0.1 §4.5.4.1 |
| MIME-type based format dispatch | The mechanism by which every SSP reference to external/potentially-external data carries a MIME type identifying its format. | SSP 2.0.1 §2.1.4 |
| Model Exchange (ME) | FMI interface type in which the FMU exposes its state derivatives/outputs and the importer supplies its own numerical solver. | FMI 3.0.2 §1.2.1 |
| modelDescription.xml | The required root XML file of an FMU, conforming to fmi3ModelDescription.xsd, describing all variables, capabilities, and structure. | FMI 3.0.2 §2.4 |
| output (FMI) | A variable computed by the FMU and provided to the environment / another connected component. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| output (SSP) | A connector providing a value out of the model element. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| parameter | A connector for a settable, fixed-during-run parameter. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| parameter (SSP) | A variable set by the environment before or during initialization; its value is not changed afterward except during (re-)configuration. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| Parameter Mapping (SSM, `.ssm`) | An XML file mapping/transforming parameter values from one naming/value scheme to another. | SSP 2.0.1 (referenced in §3, ADR-LOTAR-SSP) |
| Parameter Values (SSV, `.ssv`) | An XML file recording a self-contained, typed set of parameter values for a system or component. | SSP 2.0.1 (referenced in §3, ADR-LOTAR-SSP) |
| Resource kind = configuration | Resource is a detailed description of the simulation environment setup configuration. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = delivery | Resource contains information for the "client" about task execution and results (the Simulation/Decision Delivery). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = document | The generic/default resource kind used when no more specific `kind` value applies. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = executable | Resource is an executable file (e.g. a script, or an Office file with an executable macro). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = method | Resource describes how a process step is, or should be, performed. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = model | Resource contains a simulation model (parameterized or unparameterized; the kind does not distinguish between the two). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = parameter | Resource contains parameters or a parameter set for a simulation model. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = rationale | Resource describes why a related process step was performed the way it was, especially covering deviations, assumptions, or simplifications. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = report | Resource provides requested results in human-readable, aggregated/condensed report form. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = request | Resource contains information provided by the requesting party to perform the task. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = requirement | Resource contains a requirements document or a consistent set of requirements. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = result | Resource contains information directly answering the requester's questions or goals (use `report` instead if it is an aggregated/condensed presentation of such information). | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = specification | Resource contains a specifications document or a consistent set of specifications. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = system | Resource is, or references, the "system under test" as described in a PDM/IT system or elsewhere. | SSP-LS-Traceability 1.0.0 §5.9 |
| Resource kind = testcase | Resource describes how simulation objectives are operationally achieved via one or more test cases; a set of these can represent a technical breakdown of the simulation objectives. | SSP-LS-Traceability 1.0.0 §5.9 |
| resources/ | FMU directory for auxiliary data used by the model at run time (e.g. tables, maps). | FMI 3.0.2 §2.5 |
| ResourceType `scope` attribute | Optional attribute on a Resource indicating its global/system/subsystem/component scope level, used only where meaningful. | SSP-LS-Traceability 1.0.0 §5.9 |
| Responsible | The party (organization, role, and/or name) accountable for a given life-cycle entry — mandatory on every life-cycle state assignment. | SSP-LS-Traceability 1.0.0 §5.10 |
| Scheduled Execution (SE) | FMI interface type for real-time/embedded use in which the importer activates individual model partitions via a scheduler rather than a single doStep. | FMI 3.0.2 §1.2.3 |
| Signal Dictionary (SSB, `.ssb`) | An XML file defining a reusable, named collection of signals/connectors referenceable via SignalDictionaryReference. | SSP 2.0.1 (referenced in §3) |
| Signature (role = authenticity) | A digital signature asserting only the authenticity/origin of the referenced data or metadata. | SSP 2.0.1 §4.5.5.1 |
| Signature (role = suitability) | A digital signature additionally claiming the referenced data's suitability for a stated purpose (detailed suitability claims expected in the signature's own format). | SSP 2.0.1 §4.5.5.1 |
| sources/ | Optional FMU directory holding C source code and a BuildConfiguration for source-distributed FMUs. | FMI 3.0.2 §2.5 |
| SRMD - Simulation Resource Meta Data (SSP-LS-Traceability) | The XML file format carrying Classification/Annotation metadata (and, optionally, a checksum) about a single external data item (`data` attribute = URI of that item); MIME type `application/x-srmd-meta-data`, file extension `.srmd`. | SSP-LS-Traceability 1.0.0 §3.4, Ch. 8 |
| SRMD (SSP) | The metadata schema defined by the SSP Traceability layered standard, referenced via a MetaData element with type application/x-srmd-meta-data. | SSP 2.0.1 §4.5.4.1 |
| SRMD packaging path | The two reserved SSP "extra files" locations for SRMD instances: `extra/org.ssp-standard.ssp-traceability.srmd/resourceMetaData.srmd` (embedded in an FMU or in an SSP), or, when placed beside the resource it describes, a file named like that resource with a `.srmd` extension. | SSP-LS-Traceability 1.0.0 §9.5.2–§9.5.4 |
| STC (Simulation Traceability Common) | The shared XML Schema (`stc.xsd`) defining the common element/attribute vocabulary (Classification, LifeCycleInformation, Resource, Step, Link, etc.) used by DTMD and STMD; never instantiated as a standalone file itself. | SSP-LS-Traceability 1.0.0 §3.5, Ch. 5 |
| STMD (Simulation Task Meta Data) | The XML file format documenting a Credible Simulation Process, MIME type `application/x-stmd-simulationtask`, file extension `.stmd`; packaged at `extra/org.ssp-standard.ssp-traceability.stmd/SimulationTask.stmd` inside an SSP archive. | SSP-LS-Traceability 1.0.0 §3.3, Ch. 7, §9.4 |
| String | A variable-length text variable. | FMI 3.0.2, fmi3Variable.xsd |
| structuralParameter (FMI) | A parameter that can additionally be set during (re-)configuration mode and may change the structure (e.g. array sizes) of the FMU. (FMI causality) | FMI 3.0.2, fmi3Variable.xsd |
| structuralParameter (SSP) | A connector for a parameter that can be set during (re-)configuration mode. (SSP connector kind) | SSP 2.0.1 §5.2.1 |
| structured | Variable names follow the FMI structured-naming convention (dot-separated hierarchy, array indices, derivative notation, etc.). (FMI variableNamingConvention) | FMI 3.0.2, fmi3ModelDescription.xsd |
| System Structure Description (SSD, `.ssd`) | The XML file describing a system's hierarchy, connectors, and connections; SystemStructure.ssd is the mandatory default variant at package root. | SSP 2.0.1 §5 |
| System Structure Package (SSP, `.ssp`) | The ZIP-archive container bundling one or more SSDs together with referenced FMUs and parameter files. | SSP 2.0.1 §3 |
| terminalsAndIcons/ | Optional FMU directory holding terminalsAndIcons.xml (grouped-port/terminal and icon metadata). | FMI 3.0.2 §2.4.9/§2.5.1.2 |
| Third-party layered standard | A layered standard defined outside MAP SSP, with no MAP SSP representation as to suitability or content. | SSP 2.0.1 §2.2 |
| tunable (dependency) | The dependency factor may change at communication points. (FMI dependenciesKind) | FMI 3.0.2, fmi3VariableDependency.xsd |
| tunable (variability) | The value may change at communication points during a simulation run (e.g. via fmi3Set{Type}). (FMI variability) | FMI 3.0.2, fmi3Variable.xsd |
| unspecified | A connector whose data-flow direction is not fixed by SSP and is resolved by the underlying modeling language (used for acausal/Modelica connections); acts as a wildcard in connection validity rules. (SSP connector kind) | SSP 2.0.1 §5.2.1 / §5.3.2.1 |
| Version Mixing | The explicit SSP allowance for a single package to contain XML files and referenced FMUs conforming to different SSP/FMI versions. | SSP 2.0.1 §2.2.1 |
