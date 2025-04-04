as yet unclassified
getInitialCommitHashFor: dirPath

	LibC runCommand: 'mkdir -p ' , dirPath , '/repository'.
	LibC
		runCommand:
			'cd ' , dirPath
				,
					'; git init; touch README.md; git add .; git commit -m"initial commit"'.
	^ LibC resultOfCommand: 'cd ' , dirPath , '; git --no-pager log --format="%H" -n 1'