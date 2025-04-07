accessing
authorsInSnapshot: aSnapshot
	| timeStamps |
	timeStamps := OrderedCollection new.
	aSnapshot definitions
		do: [ :each | 
			each isMethodDefinition
				ifTrue: [ each timeStamp ifNotNil:[:ts |  timeStamps add: ts] ].
			(each isClassDefinition and: [ (each isKindOf: MCClassTraitDefinition) not ])
				ifTrue: [ timeStamps add: each commentStamp ] ].
	^ (timeStamps collect: [ :each | each copyUpTo: Character space ]) \ #('' '<historical>')