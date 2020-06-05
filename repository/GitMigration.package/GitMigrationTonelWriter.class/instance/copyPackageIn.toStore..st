writing - memory
copyPackageIn: aVersion toStore: memoryStore
	self ensureContainsOrganization: aVersion.
	TonelWriter fileOut: aVersion on: memoryStore.
	self writePropertiesFileTo: memoryStore