tests - writing
testWriteInitialVersionEmptyMessage
	| v1 contents dtNow |
	writer initialCommit: '1234567890'.
	writer authorMapping
		shortName: 'PeterUhnak'
		name: 'Peter Uhnak'
		email: 'i.uhnak@gmail.com'.
	MCCacheRepository uniqueInstance
		versionReaderForFileNamed: 'EverythingIsBurning-PeterUhnak.1.mcz'
		do: [ :v | v1 := v ].
	writer onEmptyMessage: [ :info | 'replacement message for >' , info name , '<' ].
	writer writeVersion: v1.
	contents := stream contents.
	"hack to extract the DateAndTime now inside, which is not straightforward to test"
	dtNow := (contents lines fourth splitOn: '> ') last.
	self
		assert: (contents lines first: 8)
		equals:
			('commit refs/heads/master
mark :1
author Peter Uhnak <i.uhnak@gmail.com> 1538689956 +0000
committer Committer Bot <committerbot@example.com> {1}
data 58
replacement message for >EverythingIsBurning-PeterUhnak.1<
from 1234567890
D EverythingIsBurning' format: {dtNow}) lines