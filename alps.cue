package alps

#Def: {}

#Doc: {
	href:        #Href
	contentType: #ContentType
	format:      #Format
	tag:         #Tag
	value:       string
}

#Href: string

#Id: string

#Name: string

#Rel: string

#Rt: string

#Type: "semantic" | "safe" | "idempotent" | "unsafe"

#Tag: string

#Format:      "text" | "html" | "asciidoc" | "markdown"
#ContentType: string

#DescrKey: {id: string} | {href: string} | {id: string, href: string}

#Descriptor: {
	def: #Def
	doc: #Doc | [#Doc, ...#Doc]
	name:  string
	title: string
	type:  #Type
	rel:   #Rel
	tag:   #Tag
	rt:    #Rt
	#DescrKey
}

#DescriptorList: [#Descriptor]

#Alps: {
	version: *"1.0" | _|_
	descriptor: #Descriptor | [#Descriptor, ...#Descriptor]
}

a1: #Alps & {
	descriptor: [
		{
			id:   "search"
			type: "safe"
			rt:   "#profile-results"
		},
		{
			id:   "profile-results"
			type: "semantic"
		},
	]
}

a2: #Alps & {
	descriptor: [
		{id: "f2"},
		{href: "f3"},
	]
}

descrFail: #Descriptor & {
	name: "bad descriptor"
}
