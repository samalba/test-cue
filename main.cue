package yarn

import (
	"dagger.io/dagger"
	"dagger.io/alpine"
	"dagger.io/llb"
)

#Script: {
	// Source code of the javascript application
	source: dagger.#Artifact

	#compute: [
		llb.#Load & {
			from: alpine.#Image & {
				package: bash: "=~5.1"
				package: curl: "=~7.74"
			}
		},
		llb.#Exec & {
			args: [
				"/bin/bash",
				"--noprofile",
				"--norc",
				"-eo",
				"pipefail",
				"-c",
				"""
					ls -lah
					""",
			]
			dir: "/src"
			mount: {
				"/src": from: source
			}
		}
	]
}

debug: #Script
