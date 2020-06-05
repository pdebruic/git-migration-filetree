instance creation
at: aShortName
	^ mapping
		at: aShortName
		ifAbsent: [ | short lower first |
			lower := aShortName asLowercase.
			first := nil.
			short := mapping keys
				detect: [ :ea | 
					first ifNil: [ first := ea ].
					ea asLowercase = lower ]
				ifNone: [ first ].
			^ mapping at: short ]