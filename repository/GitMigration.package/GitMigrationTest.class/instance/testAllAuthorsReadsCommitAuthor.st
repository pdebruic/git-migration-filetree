tests - accessing
testAllAuthorsReadsCommitAuthor
	self mockVersionsForAllAuthors.
	self assert: (migration allAuthors includes: 'CommitAuthor')