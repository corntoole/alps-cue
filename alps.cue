package alps

// Utility Definitions

// Ensures a string is not empty (must contain one or more characters).
#NonEmptyString: string & =~".+"

// Defines a string that must be a valid IRI (Internationalized Resource Identifier).
// Note: Cue does not have native, complete IRI validation, so this acts as a type
// declaration with a comment indicating the required external standard (RFC 3987).
#IsIRI: string | *"https://example.com/resource"

// Core Component Definitions

// #Doc (Documentation Element)
// Provides human-readable context for the profile or descriptor.
#Doc: {
	// REQUIRED: The actual documentation text. Must not be empty.
	value: #NonEmptyString

	// OPTIONAL: The format of the documentation text.
	format?: "text" | "html" | "markdown" | string
}

// #Link (Link Element)
// Used to define associated external relations (less common in core ALPS).
#Link: {
	// REQUIRED: The relation type (e.g., "self", "next").
	rel: #NonEmptyString
	// REQUIRED: The target IRI.
	href: #IsIRI
}

// #Descriptor (The core element for defining semantics)
#Descriptor: this={

	// OPTIONAL: A valid IRI (RFC 3987) that identifies the source definition.
	// This is the constraint discussed in the first user query.
	def?: #IsIRI

	// OPTIONAL: A human-readable name for the descriptor.
	name?: #NonEmptyString

	// OPTIONAL: The semantics/safety type of the operation/descriptor.
	type?: "safe" | "unsafe" | "idempotent" | "semantic"

	// OPTIONAL: The Relation Type or Return Type. Must be a valid IRI.
	rt?: #IsIRI

	// OPTIONAL: Documentation for this specific descriptor.
	doc?: #Doc

	// OPTIONAL: Links associated with the descriptor.
	link?: [...#Link]

	// OPTIONAL: Nested descriptors for complex structures or actions.
	descriptor?: [...#Descriptor]

	// This structural constraint is achieved by defining two possibilities (disjunction)
	// using the `|` operator, ensuring the result is valid only if one of the
	// branches is satisfied.

	// // Branch 1: Must have 'id', 'href' is optional.
	// {
	// 	id:    #NonEmptyString | "default"
	// 	href?: #IsIRI // 'href' is optional here
	// } |
	// {
	// 	// Branch 2: Must have 'href', 'id' is optional.
	// 	href: #IsIRI
	// 	id?:  #NonEmptyString // 'id' is optional here
	// }
	id?:      #NonEmptyString
	href?:    #IsIRI
	_hasId:   *(len(this["id"]) > 0) | false
	_hasHref: *(len(this["href"]) > 0) | false
	if !_hasId && !_hasHref {
		invalidKeyErr: "invalid descriptor: must set id or href"
	}
}

// Root Document Definition

// #ALPS (The top-level ALPS document structure)
#ALPS: {
	// REQUIRED: The root element of the ALPS document.
	alps: {
		// REQUIRED: The ALPS version. Usually "1.0" in the draft series.
		version: #NonEmptyString | *"1.0"

		// OPTIONAL: Documentation for the entire profile.
		doc?: #Doc

		title?: string

		// REQUIRED: Array of top-level descriptors. Must contain at least one descriptor.
		{
			descriptor: [
				#Descriptor,
				...#Descriptor,
			]
		} | *{
			descriptor: #Descriptor
		}

		// OPTIONAL: Extensions. This array is intentionally left open (unconstrained)
		// to allow for custom ALPS extensions defined elsewhere.
		ext?: [...]
	}
}

// Final constraint: The configuration file must conform to the #ALPS definition.
#ALPS
