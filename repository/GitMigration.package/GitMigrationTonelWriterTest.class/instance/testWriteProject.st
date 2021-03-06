tests - writing
testWriteProject
	| v1 |
	writer exportDirectory: 'repository'.
	writer initialCommit: '1234567890'.
	writer authorMapping
		shortName: 'PeterUhnak'
		name: 'Peter Uhnak'
		email: 'i.uhnak@gmail.com'.
	MCCacheRepository uniqueInstance
		versionReaderForFileNamed: 'Somewhere-PeterUhnak.1.mcz'
		do: [ :v | v1 := v ].
	writer availableVersions: (Array with: v1 info).
	writer writeVersion: v1.
	self deny: (stream contents lines includes: 'M 100644 inline repository/.project').
	self assert: (stream contents lines includes: 'M 100644 inline .project').
	self assert: (stream contents lines includes: '	''srcDirectory'' : ''repository''').