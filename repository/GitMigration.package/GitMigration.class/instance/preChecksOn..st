import
preChecksOn: aVersionList
	aVersionList do: [ :each | self preCheckOn: each ]