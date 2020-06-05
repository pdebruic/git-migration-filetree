writing
ensureContainsOrganization: aVersion
	aVersion snapshot definitions
		detect: #isOrganizationDefinition
		ifFound: [ :each | each ]
		ifNone: [ aVersion snapshot definitions add: (MCOrganizationDefinition categories: {aVersion package name}) ]