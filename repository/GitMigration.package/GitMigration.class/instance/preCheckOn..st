import
preCheckOn: aVersion
	"NOTE: do not touch snapshot without performing veryDeepCopy first"

	aVersion info message
		ifEmpty: [ self
				assert: [ onEmptyMessage isNotNil and: [ (onEmptyMessage cull: aVersion info) isNotEmpty ] ]
				description: [ 'You must provide onEmptyMessage.' ] ]