as yet unclassified
migratePackageNamed: packageAndIgnoredNames inRepository: repositoryName
	| initialCommitHash migration dirPath mainPkgName packageNames ignoredNames importFileName |
	packageNames := packageAndIgnoredNames allButLast.
	ignoredNames := packageAndIgnoredNames last.
	mainPkgName := packageNames first.
	dirPath := '/opt/git/migration/' , mainPkgName .
	initialCommitHash := self getInitialCommitHashFor: dirPath.
	migration := GitMigration on: repositoryName.
	migration selectedPackageNames: packageNames.
	migration ignoredFileNames: ignoredNames.
	migration
		authors: {('PaulDeBruicker' -> #('Paul DeBruicker' 'pdebruic@gmail.com')).
		('EstebanMaringolo' -> #('Esteban Maringolo' 'pdebruic@gmail.com'))}.
	migration cacheAllVersions.
	importFileName :=  mainPkgName , '-import.txt'.
	migration
		fastImportCodeToDirectory:  '/repository'
		initialCommit: initialCommitHash trim
		to: dirPath , '/' , importFileName .
	self doFastImportResetHEADAndCommitFor: importFileName in: dirPath