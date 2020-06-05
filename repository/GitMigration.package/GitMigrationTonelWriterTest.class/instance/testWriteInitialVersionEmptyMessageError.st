tests - writing
testWriteInitialVersionEmptyMessageError
	| v1 |
	writer initialCommit: '1234567890'.
	writer authorMapping shortName: 'PeterUhnak' name: 'Peter Uhnak' email: 'i.uhnak@gmail.com'.
	MCCacheRepository uniqueInstance
		versionReaderForFileNamed: 'EverythingIsBurning-PeterUhnak.1.mcz'
		do: [ :v | v1 := v ].
	self should: [ writer writeVersion: v1 ] raise: Error