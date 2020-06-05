accessing
versions
	versionsCache
		ifNil: [ | versions |
			versions := OrderedCollection new.
			self versionsWithPackageNames
				do: [ :quad | 
					| fileName |
					fileName := quad last.
					(ignoredFileNames includes: (fileName allButLast: 4))
						ifFalse: [ versions add: (self versionFromFileNamed: quad last) ] ]
				displayingProgress: [ :quad | 'Loading versions metadata... ' , quad last ].
			versionsCache := versions ].
	^ versionsCache