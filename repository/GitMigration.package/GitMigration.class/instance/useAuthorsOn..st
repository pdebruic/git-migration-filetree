import
useAuthorsOn: aWriter
	(authors isNil or: [ authors isEmpty ])
		ifTrue: [ self error: 'Please provide authors.' ].
	authors
		keysAndValuesDo: [ :key :duet | 
			aWriter authorMapping
				shortName: key
				name: duet first
				email: ((duet second withoutPrefix: '<') withoutSuffix: '>') ]