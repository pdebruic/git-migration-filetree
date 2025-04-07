accessing
commitMessage
	^ String
		<< [ :stream | 
			| message |
			message := (info message copyWithout: Character null) withUnixLineEndings.
			message
				ifEmpty:
					[ message := ((onEmptyMessage cull: info) copyWithout: Character null) withUnixLineEndings ].
			self assert: [ message isNotEmpty ] description: [ 'Commit message must not be empty' ].
			stream << message.
			(self coauthors asSet sorted: #name ascending)
				ifNotEmpty: [ :co | 
					stream lf.
					stream lf.
					co
						do: [ :each | stream << 'Co-authored-by: ' << each name << ' <' << each email << '>' ]
						separatedBy: [ stream lf ] ] ]