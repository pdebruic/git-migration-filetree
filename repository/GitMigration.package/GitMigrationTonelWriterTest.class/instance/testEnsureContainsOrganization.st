tests - writing
testEnsureContainsOrganization
	| version store |
	"https://github.com/peteruhnak/git-migration/issues/16"
	store := writer newMemoryStore.
	version := MCVersion
		package: (MCPackage named: 'XYZ')
		info: self versionWithoutParent
		snapshot: (MCSnapshot fromDefinitions: OrderedCollection new).
	writer copyPackageIn: version toStore: store.
	self
		assert: (store / 'XYZ' / 'package.st') contents trimmed
		equals: 'Package { #name : #XYZ }'