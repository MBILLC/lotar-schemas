# FMI 3.0.2 and SSP 2.0.1 — Controlled Vocabulary Extraction

Extracted directly from the FMI 3.0.2 specification/schemas (fmi-standard.org/docs/3.0.2/, github.com/modelica/fmi-standard) and the SSP 2.0.1 specification/schemas (ssp-standard.org/docs/2.0.1/), in support of **GR3 — Controlled Vocabularies** in Requirements.md ("Controlled vocabularies SHALL be used for certain (identified) Metadata elements ... If extended or local vocabularies are used, they SHALL be included or referenced within each Information Package").

Scope: only the *closed, enumerated* terms that each standard's own XML Schema fixes as a controlled value set (`xs:enumeration`) or that name a structurally significant, recurring concept (file role, package directory, element type). General M&S concepts already carried in Merged_Glossary_v5.md (Modelica, SSP, SSP Traceability, eFMI, DCP, etc.) are not repeated here. Where FMI and SSP define the *same* controlled term identically, this is called out once rather than duplicated (§C).

Format matches the project's existing glossary tables (Term | Definition | Source).

---

## A. FMI 3.0.2

### A.1 Variable causality (`causality` attribute, `fmi3AbstractVariable`)

| Term | Definition | Source |
|---|---|---|
| parameter | A variable set by the environment before or during initialization; its value is not changed afterward except during (re-)configuration. | FMI 3.0.2, fmi3Variable.xsd |
| calculatedParameter | A parameter whose value is calculated by the FMU during initialization and afterward remains constant, and which cannot be set by the environment. | FMI 3.0.2, fmi3Variable.xsd |
| structuralParameter | A parameter that can additionally be set during (re-)configuration mode and may change the structure (e.g. array sizes) of the FMU. | FMI 3.0.2, fmi3Variable.xsd |
| input | A variable whose value is provided by the environment / another connected component. | FMI 3.0.2, fmi3Variable.xsd |
| output | A variable computed by the FMU and provided to the environment / another connected component. | FMI 3.0.2, fmi3Variable.xsd |
| local | A variable internal to the FMU, not intended for connection; default causality. | FMI 3.0.2, fmi3Variable.xsd |
| independent | The independent variable of the model (normally time). | FMI 3.0.2, fmi3Variable.xsd |

### A.2 Variable variability (`variability` attribute)

| Term | Definition | Source |
|---|---|---|
| constant | The variable's value never changes during a simulation run. | FMI 3.0.2, fmi3Variable.xsd |
| fixed | The value only changes at initialization or (re-)configuration. | FMI 3.0.2, fmi3Variable.xsd |
| tunable | The value may change at communication points during a simulation run (e.g. via `fmi3Set{Type}`). | FMI 3.0.2, fmi3Variable.xsd |
| discrete | The value changes only at events (not continuously between them). | FMI 3.0.2, fmi3Variable.xsd |
| continuous | No restriction on when the value changes. | FMI 3.0.2, fmi3Variable.xsd |

### A.3 Variable initialization mode (`initial` attribute)

| Term | Definition | Source |
|---|---|---|
| exact | The variable's `start` value is used unmodified as its initial value. | FMI 3.0.2, fmi3Variable.xsd |
| approx | The `start` value is an initial guess, refined by an iteration/initialization algorithm. | FMI 3.0.2, fmi3Variable.xsd |
| calculated | The initial value is computed from other variables during initialization; no `start` value given. | FMI 3.0.2, fmi3Variable.xsd |

### A.4 Variable naming convention (`variableNamingConvention` attribute)

| Term | Definition | Source |
|---|---|---|
| flat | Variable names have no hierarchical/structured meaning. | FMI 3.0.2, fmi3ModelDescription.xsd |
| structured | Variable names follow the FMI structured-naming convention (dot-separated hierarchy, array indices, derivative notation, etc.). | FMI 3.0.2, fmi3ModelDescription.xsd |

### A.5 Variable data types (`ModelVariables` element choice)

| Term | Definition | Source |
|---|---|---|
| Float32 / Float64 | IEEE single/double precision floating-point variable ("Real" in FMI 2.0). | FMI 3.0.2, fmi3Variable.xsd |
| Int8 / UInt8 / Int16 / UInt16 / Int32 / UInt32 / Int64 / UInt64 | Signed/unsigned integer variable of the given bit width ("Integer" in FMI 2.0, now split by width/signedness). | FMI 3.0.2, fmi3Variable.xsd |
| Boolean | A two-valued (true/false) variable. | FMI 3.0.2, fmi3Variable.xsd |
| String | A variable-length text variable. | FMI 3.0.2, fmi3Variable.xsd |
| Binary | An arbitrary-length byte-sequence variable, with an associated `mimeType`, new in FMI 3.0 (used e.g. for sensor data, images). | FMI 3.0.2, fmi3Variable.xsd |
| Enumeration | A variable restricted to a named, integer-backed set of items defined by an `EnumerationType`. | FMI 3.0.2, fmi3Variable.xsd |
| Clock | A discrete, scalar variable representing a time or event base that activates model partitions/other variables. | FMI 3.0.2, fmi3Variable.xsd |

### A.6 Interface type

| Term | Definition | Source |
|---|---|---|
| Model Exchange (ME) | FMI interface type in which the FMU exposes its state derivatives/outputs and the importer supplies its own numerical solver. | FMI 3.0.2 §1.2.1 |
| Co-Simulation (CS) | FMI interface type in which the FMU carries its own internal solver and advances itself across communication steps (`fmi3DoStep`). | FMI 3.0.2 §1.2.2 |
| Scheduled Execution (SE) | FMI interface type for real-time/embedded use in which the importer activates individual model partitions via a scheduler rather than a single `doStep`. | FMI 3.0.2 §1.2.3 |

### A.7 Execution status (`fmi3Status` return codes)

| Term | Definition | Source |
|---|---|---|
| fmi3OK | The function call was successful; output values are defined. | FMI 3.0.2 §2.2.4 |
| fmi3Warning | A non-critical problem was detected but computation may continue; output values are defined. | FMI 3.0.2 §2.2.4 |
| fmi3Discard | The call failed but the FMU state is unchanged and simulation may continue with different arguments; output values are undefined. | FMI 3.0.2 §2.2.4 |
| fmi3Error | The call failed; output values are undefined and the simulation must not continue for this instance. | FMI 3.0.2 §2.2.4 |
| fmi3Fatal | All instances of the model are irreparably corrupted; the importer must not call the FMU again. | FMI 3.0.2 §2.2.4 |

### A.8 Clock vocabulary

| Term | Definition | Source |
|---|---|---|
| intervalVariability = constant | A time-based, periodic Clock with a fixed, unchanging interval. | FMI 3.0.2 §2.2.8.2 |
| intervalVariability = fixed | A time-based, periodic Clock whose interval only changes at initialization/(re-)configuration. | FMI 3.0.2 §2.2.8.2 |
| intervalVariability = tunable | A time-based, periodic Clock whose interval can change when a tunable parameter changes. | FMI 3.0.2 §2.2.8.2 |
| intervalVariability = changing | An aperiodic Clock whose next interval is knowable only once the current one has ticked. | FMI 3.0.2 §2.2.8.2 |
| intervalVariability = countdown | An aperiodic Clock whose next interval is known as soon as the previous tick occurs. | FMI 3.0.2 §2.2.8.2 |
| intervalVariability = triggered | A Clock with no defined interval; ticks are driven externally (e.g. by another Clock or event). | FMI 3.0.2 §2.2.8.2 |
| Input Clock | A Clock variable with causality = input; the importer is the source of its activations. | FMI 3.0.2 §2.2.8.2 |
| Output Clock | A Clock variable with causality = output and intervalVariability = triggered; the importer polls its activation state. | FMI 3.0.2 §2.2.8.2 |
| Time-based Clock | A Clock whose ticks are predictable ahead of time by the importer. | FMI 3.0.2 §2.2.8.2 |
| Periodic Clock | A time-based Clock with a constant (or tunable) interval. | FMI 3.0.2 §2.2.8.2 |

### A.9 Dependency classification (`dependenciesKind`, `ModelStructure`)

| Term | Definition | Source |
|---|---|---|
| dependent | The unknown depends on the referenced variable in an otherwise unspecified way (most general case). | FMI 3.0.2, fmi3VariableDependency.xsd |
| constant | The dependency is via a factor known to be constant during the whole simulation. | FMI 3.0.2, fmi3VariableDependency.xsd |
| fixed | The dependency factor only changes at initialization/(re-)configuration. | FMI 3.0.2, fmi3VariableDependency.xsd |
| tunable | The dependency factor may change at communication points. | FMI 3.0.2, fmi3VariableDependency.xsd |
| discrete | The dependency factor may change only at events. | FMI 3.0.2, fmi3VariableDependency.xsd |

### A.10 Packaging / file-role terms

| Term | Definition | Source |
|---|---|---|
| FMU (Functional Mock-up Unit) | The ZIP-archive container (`.fmu`) that packages a model's XML description, binaries/sources, and resources. | FMI 3.0.2 §1.2 |
| modelDescription.xml | The required root XML file of an FMU, conforming to `fmi3ModelDescription.xsd`, describing all variables, capabilities, and structure. | FMI 3.0.2 §2.4 |
| binaries/ | FMU directory holding the platform-specific compiled shared libraries (.dll/.so) implementing the C-API. | FMI 3.0.2 §2.5 |
| sources/ | Optional FMU directory holding C source code and a `BuildConfiguration` for source-distributed FMUs. | FMI 3.0.2 §2.5 |
| resources/ | FMU directory for auxiliary data used by the model at run time (e.g. tables, maps). | FMI 3.0.2 §2.5 |
| documentation/ | Optional FMU directory for human-readable documentation. | FMI 3.0.2 §2.5 |
| terminalsAndIcons/ | Optional FMU directory holding `terminalsAndIcons.xml` (grouped-port/terminal and icon metadata). | FMI 3.0.2 §2.4.9/§2.5.1.2 |
| licenses/ | Optional FMU directory holding license text files bundled with the FMU. | FMI 3.0.2 §2.5.1.1.1 |
| BuildConfiguration | XML element describing how to compile a source-code FMU (new in FMI 3.0). | FMI 3.0.2 §2.4.10 |
| instantiationToken | Required unique token in modelDescription.xml (successor of FMI 2.0's `guid`) used by the importer to check that the correct FMU is being loaded. | FMI 3.0.2, fmi3ModelDescription.xsd |

---

## B. SSP 2.0.1

### B.1 Connector kind

| Term | Definition | Source |
|---|---|---|
| input | A connector receiving a value into the model element. | SSP 2.0.1 §5.2.1 |
| output | A connector providing a value out of the model element. | SSP 2.0.1 §5.2.1 |
| inout | A connector that is both input and output (only valid on SignalDictionaryReferences; not valid for FMI-backed components). | SSP 2.0.1 §5.2.1 |
| local | A connector for a model-internal variable, not intended for connection; behaves as `output` if connected anyway. | SSP 2.0.1 §5.2.1 |
| constant | A connector whose value never changes. | SSP 2.0.1 §5.2.1 |
| parameter | A connector for a settable, fixed-during-run parameter. | SSP 2.0.1 §5.2.1 |
| calculatedParameter | A connector for a parameter computed by the component during initialization. | SSP 2.0.1 §5.2.1 |
| structuralParameter | A connector for a parameter that can be set during (re-)configuration mode. | SSP 2.0.1 §5.2.1 |
| unspecified | A connector whose data-flow direction is not fixed by SSP and is resolved by the underlying modeling language (used for acausal/Modelica connections); acts as a wildcard in connection validity rules. | SSP 2.0.1 §5.2.1 / §5.3.2.1 |

### B.2 Model element types

| Term | Definition | Source |
|---|---|---|
| System | A (possibly nested) container of Components, SignalDictionaryReferences, and other Systems, plus their Connections. | SSP 2.0.1 §5.3 |
| Component | An atomic model element in a System, typically backed by a referenced FMU. | SSP 2.0.1 §5.4 |
| SignalDictionaryReference | A reference to a reusable, named collection of signals (a Signal Dictionary) usable as a system element. | SSP 2.0.1 §5.3.1/§5.5 |

### B.3 Value transformation types

| Term | Definition | Source |
|---|---|---|
| LinearTransformation | A `target = factor × source + offset` transform applied to a connection or parameter mapping value (Real/Float types only). | SSP 2.0.1 §4.5.2.1 |
| BooleanMappingTransformation | A lookup-table transform remapping Boolean connection/parameter values. | SSP 2.0.1 §4.5.2.2 |
| IntegerMappingTransformation | A lookup-table transform remapping integer or Enumeration-typed values. | SSP 2.0.1 §4.5.2.3 |
| EnumerationMappingTransformation | A lookup-table transform remapping Enumeration values by item name. | SSP 2.0.1 §4.5.2.4 |

### B.4 File / package format terms

| Term | Definition | Source |
|---|---|---|
| System Structure Package (SSP, `.ssp`) | The ZIP-archive container bundling one or more SSDs together with referenced FMUs and parameter files. | SSP 2.0.1 §3 |
| System Structure Description (SSD, `.ssd`) | The XML file describing a system's hierarchy, connectors, and connections; `SystemStructure.ssd` is the mandatory default variant at package root. | SSP 2.0.1 §5 |
| Parameter Values (SSV, `.ssv`) | An XML file recording a self-contained, typed set of parameter values for a system or component. | SSP 2.0.1 (referenced in §3, ADR-LOTAR-SSP) |
| Parameter Mapping (SSM, `.ssm`) | An XML file mapping/transforming parameter values from one naming/value scheme to another. | SSP 2.0.1 (referenced in §3, ADR-LOTAR-SSP) |
| Signal Dictionary (SSB, `.ssb`) | An XML file defining a reusable, named collection of signals/connectors referenceable via SignalDictionaryReference. | SSP 2.0.1 (referenced in §3) |

### B.5 Traceability / signature vocabulary

| Term | Definition | Source |
|---|---|---|
| Signature (role = authenticity) | A digital signature asserting only the authenticity/origin of the referenced data or metadata. | SSP 2.0.1 §4.5.5.1 |
| Signature (role = suitability) | A digital signature additionally claiming the referenced data's suitability for a stated purpose (detailed suitability claims expected in the signature's own format). | SSP 2.0.1 §4.5.5.1 |
| MetaData | A generic element attaching arbitrary typed metadata (inline or by reference) to any SSP model element. | SSP 2.0.1 §4.5.4.1 |
| SRMD (Simulation Resource Metadata) | The metadata schema defined by the SSP Traceability layered standard, referenced via a MetaData element with type `application/x-srmd-meta-data`. | SSP 2.0.1 §4.5.4.1 |
| Layered Standard | A backward-compatible extension to core SSP defined via Annotations, extra files, and/or additional MIME types. | SSP 2.0.1 §2.2 |
| MAP SSP layered standard | A layered standard defined/adopted and published by the Modelica Association Project SSP itself. | SSP 2.0.1 §2.2 |
| Third-party layered standard | A layered standard defined outside MAP SSP, with no MAP SSP representation as to suitability or content. | SSP 2.0.1 §2.2 |

### B.6 Extensibility / addressing vocabulary

| Term | Definition | Source |
|---|---|---|
| Annotation | A generic, namespaced XML extension element (`ssc:Annotation`) insertable into any SSP model entity. | SSP 2.0.1 §2.1.1 |
| Extra Files mechanism | The reserved `extra/` ZIP-entry prefix used to bundle additional, arbitrarily-formatted data/metadata into an SSP package. | SSP 2.0.1 §2.1.2 |
| Extension Namespace | A reverse-domain-name-notation namespace (e.g. `org.modelica.ssp.*`) used to avoid collisions in Annotations and extra files. | SSP 2.0.1 §2.1.3 |
| MIME-type based format dispatch | The mechanism by which every SSP reference to external/potentially-external data carries a MIME type identifying its format. | SSP 2.0.1 §2.1.4 |
| Content addressing | The URI-based mechanism (relative or absolute) by which SSP files reference other files/resources. | SSP 2.0.1 §2.3 |
| Version Mixing | The explicit SSP allowance for a single package to contain XML files and referenced FMUs conforming to different SSP/FMI versions. | SSP 2.0.1 §2.2.1 |

### B.7 Structural / geometry terms

| Term | Definition | Source |
|---|---|---|
| Element | A Component, SignalDictionaryReference, or nested System contained within a System. | SSP 2.0.1 §5.3.1 |
| Connector | The named interface point of a model element, typed and given a `kind` (see B.1). | SSP 2.0.1 §5.2.1 |
| Connection | A link between two connectors (of a System and/or its Elements) permitted under the Allowed Connections rules. | SSP 2.0.1 §5.3.2 |
| ConnectorGeometry / ElementGeometry / SystemGeometry | Optional layout-only elements giving the graphical position of connectors, elements, and system canvases respectively. | SSP 2.0.1 §5.2.1.1/§5.2.2 |
| GraphicalElements | Purely graphical, non-semantic annotations (e.g. notes) on a system diagram. | SSP 2.0.1 §5.3 |
| DefaultExperiment | An SSD element carrying informational start/stop time for a default simulation run (explicitly excludes solver/step-size/tolerance, which are out of core-standard scope). | SSP 2.0.1 §5.1.1 |
| ParameterBindings | The mechanism by which parameter values or mappings are attached to a model element. | SSP 2.0.1 §5.2.3 |

---

## C. Terms defined once, shared identically by both standards

SSP explicitly reuses FMI's variable-classification vocabulary rather than redefining it — a single controlled-vocabulary entry should serve both standards for:

- **causality** values (parameter, calculatedParameter, input, output, local, independent, structuralParameter) — SSP's connector `kind` is required to match FMI causality/variability combinations for FMI-backed components (§5.2.1).
- **variability** values (constant, fixed, tunable, discrete, continuous).
- **Variable/connector data types** (Float32, Float64, Int8…UInt64, Boolean, String, Binary, Enumeration, Clock) — identical type-choice group in both schemas.
- **Clock intervalVariability** values — SSP's connection-validity rules for Clock connectors defer directly to the FMI-defined intervalVariability vocabulary (§5.3.2.1).

---

## D. Recommendation for the LOTAR controlled vocabulary (GR3)

Not every term above needs to become a LOTAR-registered controlled-vocabulary element — most are already normatively fixed by the FMI/SSP schemas themselves and only need to be *referenced*, per GR3's "standardised ... vocabularies" clause, rather than re-published. Recommend:

1. **Reference, don't re-mint**: causality, variability, initial, connector kind, transformation types, interface type, and the variable-type list (A.1–A.5, A.9, B.1, B.3) should be handled in NAS9300-515/520 by *citing* the relevant FMI 3.0.2 / SSP 2.0.1 schema clause as the controlled vocabulary source, satisfying GR3's "or referenced within each Information Package" option — duplicating these tables into a LOTAR-local vocabulary risks drift as FMI/SSP versions advance.
2. **New LOTAR-local vocabulary needed**: the packaging/file-role terms (A.10, B.4, B.6) and the traceability/signature terms (B.5) are the ones LOTAR actually needs its *own* controlled entries for, because they name concepts the archive's manifest/DI layer must talk about consistently (e.g. distinguishing an ".fmu", an ".ssp", an ".ssv" as archived Content Data Object sub-types; "SRMD" and "Signature role" as values a LOTAR authentication-evidence field might carry per PD17–19 from the prior evaluation).
3. **Likely not needed for archiving**: the fine-grained execution/runtime vocabulary (A.7 status codes, A.8 Clock timing, geometry terms in B.7) describes simulation-time or presentation-time behavior, not preservation or retrieval semantics — these can be left as FMI/SSP-internal and excluded from the LOTAR controlled vocabulary unless a specific retrieval or reproducibility use case requires citing them.
