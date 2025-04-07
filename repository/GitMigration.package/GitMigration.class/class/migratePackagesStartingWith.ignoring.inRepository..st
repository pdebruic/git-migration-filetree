as yet unclassified
migratePackagesStartingWith: packageNamePrefixes ignoring: ignoredNames inRepository: repositoryName
	| initialCommitHash migration dirPath mainPkgName packageNames importFileName allFileNames |
	packageNames := Set new.
	allFileNames := (self findRepositoryNamed: repositoryName)
		allFileNames.
	allFileNames
		do: [ :fileName | 
			(packageNamePrefixes
				anySatisfy: [ :prefix | prefix , '*' match: fileName ])
				ifTrue: [ | packageName |
					packageName := '-'
						join: ((fileName substrings: '.') first substrings: '-') allButLast.
					(ignoredNames includes: packageName)
						ifFalse: [ packageNames add: packageName ] ] ].
	mainPkgName := packageNamePrefixes first.
	dirPath := '/opt/git/migration/' , mainPkgName.
	initialCommitHash := self getInitialCommitHashFor: dirPath.
	packageNames notEmpty
		ifTrue: [ migration := GitMigration on: repositoryName.
			migration selectedPackageNames: packageNames.
			migration ignoredFileNames: ignoredNames.
			self addAuthorsToMigration: migration.
			migration cacheAllVersions.
			importFileName := mainPkgName , '-import.txt'.
			migration
				fastImportCodeToDirectory: '/repository'
				initialCommit: initialCommitHash trim
				to: dirPath , '/' , importFileName.
			
			self doFastImportResetHEADAndCommitFor: importFileName in: dirPath ]