Class {
	#name : #MSearch,
	#superclass : #Object,
	#category : #'Melvin-Dev'
}

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCode: searchString inPackageArray: packages [

	| results |
	results := (self searchSourceCodeAndReturnEverythingFor: searchString inPackageArray: packages).
	results := (results collect: [ :method | method selector ]) asSet.
	^ results
]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCode: searchString inTagArray: tags [
	"There is no difference between a tag and a package name in the object creation code"
	"This code is an exclusive search for the package name since it won't go through all the tags"

	| results |
	results := (self searchSourceCodeAndReturnEverythingFor: searchString inTagArray: tags).
	results := (results collect: [ :method | method selector ]) asSet.
	^ results
]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inPackageArray: packages [

	^ self searchSourceCodeAndReturnEverythingFor: searchString inPackageArray: packages excludingSubstring: ''
]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inPackageArray: packages excludingSubstring: exclusion [

	| classes results allTags |
	allTags := packages flatCollect: [ :package | 
		(package includesSubstring: exclusion) 
			ifTrue: [ #() ] 
			ifFalse: [ SystemOrganization categories select: [ :each | each beginsWith: package ] ] ].

	classes := allTags flatCollect: [ :tag |
		SystemOrganization classesInCategory: tag ].

	results := classes flatCollect: [ :class |
		(class methods, class class methods) select: [ :method |
			method sourceCode includesSubstring: searchString caseSensitive: false ] ].

	^ results

]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inTagArray: tags [
	"There is no difference between a tag and a package name in the object creation code"
	"This code is an exclusive search for the package name since it won't go through all the tags"

	| classes results |
	classes := tags flatCollect: [ :tag |
		SystemOrganization classesInCategory: tag ].

	results := classes flatCollect: [ :class |
		(class methods, class class methods) select: [ :method |
			method sourceCode includesSubstring: searchString caseSensitive: false ] ].

	^ results
]
