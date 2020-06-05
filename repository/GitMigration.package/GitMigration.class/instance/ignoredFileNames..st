accessing
ignoredFileNames: aCollection
	ignoredFileNames := aCollection collect: [ :each | each withoutSuffix: '.mcz' ]