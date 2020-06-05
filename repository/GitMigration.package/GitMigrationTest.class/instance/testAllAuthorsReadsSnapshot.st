tests - accessing
testAllAuthorsReadsSnapshot
	self mockVersionsForAllAuthors.
	self assert: (migration allAuthors includes: 'MethodAuthor')