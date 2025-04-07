as yet unclassified
doFastImportResetHEADAndCommitFor: importFileName in: dirPath
	| commitHash |
	LibC
		runCommand: 'cd ' , dirPath , '; git fast-import < ' , importFileName.
	commitHash := LibC
		resultOfCommand: 'cd ' , dirPath , '; git --no-pager log --format="%H" -n 1'.
	LibC runCommand: 'cd ' , dirPath , '; git reset --hard ' , commitHash.
	LibC runCommand: 'cd ' , dirPath , '; git gc'