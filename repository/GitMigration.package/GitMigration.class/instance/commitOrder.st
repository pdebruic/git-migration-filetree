actions
commitOrder
	"All packages to be commited in the order from first to last, across multiple packages"

	| packagePool ordering |
	packagePool := IdentitySet new.
	ordering := OrderedCollection new.
	self versionsByPackage
		keysAndValuesDo: [ :pkgName :realVersions | 
			| allVersions allRealVersions allValidVersions |
			allVersions := self topologicallySort: (self completeAncestryOfPackageNamed: pkgName).
			"add only versions that have real MCZ file"
			allRealVersions := allVersions select: [ :each | realVersions includes: each ].
			"reject versions with empty snapshot; veryDeepCopy because the version is kept in memory, but not the snapshot"
			allValidVersions := allRealVersions
				reject: [ :each | 
					| fullVersion |
					fullVersion := self versions detect: [ :v | v info = each ].
					fullVersion veryDeepCopy snapshot definitions isEmpty ].
			"			self haltIf: [ (allValidVersions = allRealVersions) not ]."
			allValidVersions
				ifEmpty: [ self notify: 'Package ' , pkgName , ' has no MCZs with code' ].
			packagePool add: allValidVersions ].
	packagePool := packagePool reject: #isEmpty.

	"pick the oldest available commit across all packages"
	[ packagePool isNotEmpty ]
		whileTrue: [ | oldestPackage version |
			oldestPackage := packagePool detectMin: [ :pkgVersions | pkgVersions first timeStamp ].
			version := oldestPackage first.
			oldestPackage removeFirst.
			ordering add: version.
			oldestPackage ifEmpty: [ packagePool remove: oldestPackage ] ].
	^ ordering