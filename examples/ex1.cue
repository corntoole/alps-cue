package examples

import (
	"github.com/corntoole/alps-cue@v0:alps"
)

a1: alps.#ALPS & {
	alps: {
		title: "Example 1"
		descriptor: [
			{
				id:   "search"
				type: "safe"
				rt:   "#profile-results"
			},
			{id: "query", type: "semantic"},

		]
	}
}

a2: alps.#ALPS & {
	alps: {
		title: "Example 2"
		descriptor: {id: "f2"}
	}
}

// descrFail: alps.#Descriptor & {
// 	name: "bad descriptor"
// }
