tests - accessing
mockVersionsForAllAuthors
	migration
		writeSlotNamed: #versionsCache
		value:
			{MCVersion
				package: (MCPackage named: 'XYZ')
				info:
					(MCVersionInfo
						name: 'Package-CommitAuthor.1'
						id: UUID new
						message: 'commit'
						date: Date today
						time: Time now
						author: 'CommitAuthor'
						ancestors: #())
				snapshot:
					(MCSnapshot
						fromDefinitions:
							{MCMethodDefinition
								className: 'Something'
								selector: #selector
								category: #''
								timeStamp: 'MethodAuthor 1/31/2001 01:23'
								source: ''})} asOrderedCollection