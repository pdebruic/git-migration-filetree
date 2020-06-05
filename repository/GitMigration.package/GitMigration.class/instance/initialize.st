initialization
initialize
	super initialize.
	completeAncestryCache := Dictionary new.
	selectedPackageNames := #().
	ignoredFileNames := #().
	onEmptyMessage := [ :info | self error: 'Empty message was requested' ]