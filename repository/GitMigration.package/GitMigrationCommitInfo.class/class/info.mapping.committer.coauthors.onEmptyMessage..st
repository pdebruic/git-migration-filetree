instance creation
info: aVersionInfo mapping: aMapping committer: aCommitter coauthors: aCoauthorsList onEmptyMessage: aBlock
	^ self new
		info: aVersionInfo;
		author: (aMapping at: aVersionInfo author);
		coauthors: (aCoauthorsList \ {aVersionInfo author} collect: [ :each | aMapping at: each ]);
		committer: aCommitter;
		onEmptyMessage: aBlock