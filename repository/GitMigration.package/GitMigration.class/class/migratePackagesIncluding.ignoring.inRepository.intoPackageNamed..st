as yet unclassified
migratePackagesIncluding: packageNameFragmentsToMatch ignoring: ignoredNames inRepository: repositoryName intoPackageNamed: newRepoName

	| initialCommitHash migration dirPath packageNames importFileName allFileNames |
	packageNames := Set new.
	allFileNames := (self findRepositoryNamed: repositoryName)
		                allFileNames.
	allFileNames do: [ :fileName | 
		(packageNameFragmentsToMatch anySatisfy: [ :prefix | 
			 '*' , prefix , '*' match: fileName ]) ifTrue: [ 
			| packageName |
			packageName := '-' join:
				               ((fileName substrings: '.') first substrings: '-')
					               allButLast.
			(ignoredNames includes: packageName) ifFalse: [ 
				packageNames add: packageName ] ] ].

	dirPath := '/opt/git/migration/' , newRepoName.
	initialCommitHash := self getInitialCommitHashFor: dirPath.
	packageNames notEmpty ifTrue: [ 
		migration := GitMigration on: repositoryName.
		migration selectedPackageNames: packageNames.
		migration ignoredFileNames: ignoredNames.
		self addAuthorsToMigration: migration.
		migration cacheAllVersions.
		importFileName := newRepoName , '-import.txt'.
		migration
			fastImportCodeToDirectory: '/repository'
			initialCommit: initialCommitHash trim
			to: dirPath , '/' , importFileName.

		self doFastImportResetHEADAndCommitFor: importFileName in: dirPath ]