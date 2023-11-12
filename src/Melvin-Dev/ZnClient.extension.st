Extension { #name : #ZnClient }

{ #category : #'*Melvin-Dev' }
ZnClient >> asCurl [
	"Barebones implementation of an asCurl string representation"

    | command |
    command := 'curl -X ', self request method.
    self request headers keysAndValuesDo: [ :key :value |
        command := command, ' -H "', key, ': ', value, '"'].
    self entity ifNotNil: [ :entity |
        command := command, ' -d ''', entity contents asString, ''''].
    ^ command, ' ', self request url asString

]
