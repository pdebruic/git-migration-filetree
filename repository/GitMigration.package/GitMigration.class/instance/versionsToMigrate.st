import
versionsToMigrate
	| totalOrdering versions |
	totalOrdering := self commitOrder.
	versions := totalOrdering
		collect: [ :info | self versions detect: [ :version | version info = info ] ].
	versions removeAllSuchThat: [ :each | ignoredFileNames includes: each info name ].
	^ versions