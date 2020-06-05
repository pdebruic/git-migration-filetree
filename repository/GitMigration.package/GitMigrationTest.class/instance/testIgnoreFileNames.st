tests - retrieving
testIgnoreFileNames
	| versions |
	versions := migration versionsToMigrate.
	self assert: (versions anySatisfy: [ :each | each info name = 'Somewhere-PeterUhnak.2' ]).
	self assert: (versions anySatisfy: [ :each | each info name = 'Somewhere-PeterUhnak.3' ]).
	migration ignoredFileNames: #('Somewhere-PeterUhnak.2' 'Somewhere-PeterUhnak.3.mcz').
	versions := migration versionsToMigrate.
	self deny: (versions anySatisfy: [ :each | each info name = 'Somewhere-PeterUhnak.2' ]).
	self deny: (versions anySatisfy: [ :each | each info name = 'Somewhere-PeterUhnak.3' ])