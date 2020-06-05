tests - accessing
testAllAuthorsContainsLocal
	| oldName |
	oldName := Author fullName.
	[ Author fullName: 'LocalUser'.
	self assert: (migration allAuthors includes: 'LocalUser') ]
		ensure: [ Author fullName: oldName ]