initialization
initialize
	super initialize.
	authorMapping := GitMigrationAuthorMapping new.
	committerName := Author fullName.
	exportDirectory := '/'.
	fastWriter := GitFastImportFileWriter new.
	lastAuthors := Dictionary new.
	onEmptyMessage := [ self error: 'No alternative message was provided' ]