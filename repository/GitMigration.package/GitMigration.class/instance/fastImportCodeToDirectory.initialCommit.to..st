import
fastImportCodeToDirectory: aDirectoryName initialCommit: anInitialCommitish to: aFileReference
	| writer |
	aFileReference asFileReference
		ensureDelete;
		writeStreamDo: [ :rawStream | 
			writer := GitMigrationTonelWriter new on: rawStream.
			writer exportDirectory: aDirectoryName.
			writer onEmptyMessage: onEmptyMessage.
			self createFastImportAt: anInitialCommitish usingWriter: writer ].
	^ writer commitMarks