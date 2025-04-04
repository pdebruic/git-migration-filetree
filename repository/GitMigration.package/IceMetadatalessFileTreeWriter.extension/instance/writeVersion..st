*GitMigration
writeVersion: aVersion
	"We have to do that to avoid writing the version info."

	| members |
	directory := (members := MCFileTreeRepository
		parseName: aVersion info name) last.
	self deleteExistingPackageStructureFor: members.
	self fileUtils ensureDirectoryExists: self packageFileDirectory.
	self initializePackageFileDirectoryCache.
	self writeFormat.
	self writePackage: aVersion package.
	[ self writeDefinitions: aVersion ]
		on: ZnInvalidUTF8
		do: [ :ex | 
			Transcript
				show: 'UTF8 encoding error in ' , aVersion info name;
				cr.
			^ self ].
	aVersion dependencies do: [ :ea | self writeVersionDependency: ea ]