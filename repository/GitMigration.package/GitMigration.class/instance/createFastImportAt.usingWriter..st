import
createFastImportAt: anInitialCommitish usingWriter: aWriter
	| versions |
	aWriter initialCommit: anInitialCommitish.
	self useAuthorsOn: aWriter.
	self do: [ versions := self versionsToMigrate ] displaying: 'Ordering history...'.
	self preChecksOn: versions.
	versions
		do: [ :each | aWriter writeVersion: each veryDeepCopy ]
		displayingProgress: [ :each | 'Exporting version ' , each info name ]