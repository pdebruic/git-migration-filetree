as yet unclassified
addAuthorsToMigration: migration
	| allAuthors contactInfo |
	allAuthors := migration allAuthors.
	contactInfo := OrderedCollection new.
	allAuthors
		do: [ :author | contactInfo add: author -> (self contactInfoFor: author) ].
	migration authors: contactInfo