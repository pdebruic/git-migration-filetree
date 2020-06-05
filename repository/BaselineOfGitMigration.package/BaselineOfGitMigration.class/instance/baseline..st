baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'GitFastWriter'
				with: [ spec repository: 'github://pdebruic/git-fast-writer-filetree/repository' ].
			spec package: 'GitMigration' with: [ spec requires: 'GitFastWriter' ].
			spec group: 'default' with: #('GitMigration') ]