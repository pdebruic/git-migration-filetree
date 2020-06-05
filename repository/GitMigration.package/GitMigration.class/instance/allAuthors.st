accessing
allAuthors
	allAuthors
		ifNil: [ | authorsSet |
			authorsSet := Set new.
			authorsSet add: Author fullName.
			self versions
				do: [ :each | 
					authorsSet add: each info author.
					authorsSet addAll: (self authorsInSnapshot: each veryDeepCopy snapshot) ]
				displayingProgress: [ :each | 'Loading authors... ' , each info name ].
			allAuthors := authorsSet asArray sorted ].
	^ allAuthors