package examples

import (
	"github.com/corntoole/alps-cue@v0:alps"
)

a1: alps.#Alps & {
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

a2: alps.#Alps & {
	descriptor: [
		{id: "f2"},
		{href: "f3"},
	]
}

descrFail: alps.#Descriptor & {
	name: "bad descriptor"
}
