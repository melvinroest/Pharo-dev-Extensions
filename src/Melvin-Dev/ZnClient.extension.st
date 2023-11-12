Extension { #name : #ZnClient }

{ #category : #'*Melvin-Dev' }
ZnClient >> asCurl [
	"Barebones implementation of an asCurl string representation"

    | command body entity |
    command := 'curl -X ', self request method.
    
    "Add headers"
    self request headers keysAndValuesDo: [ :key :value |
        command := command, ' -H "', key, ': ', value, '"' ].
    
	entity := self request entity.
   entity ifNotNil: [
		body := self request entity contents.
		((body isNotNil) and: [ body isNotEmpty ]) ifTrue: [
			command := command, ' -d ''', body asString, ''''
		].
	].

    "Include the URL"
    ^ command, ' ', self request url asString

]
