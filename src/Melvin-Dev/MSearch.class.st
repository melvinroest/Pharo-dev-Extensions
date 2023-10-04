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
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString asPackage: aBoolean inArray: packages excludingSubstring: exclusion [

	| classes results tags |
	tags := packages.
	aBoolean ifTrue: [
		tags := packages flatCollect: [ :package | 
			exclusion ifNotNil: [ SystemOrganization categories select: [ :each | (each beginsWith: package) and: [ (each includesSubstring: exclusion) not ] ] ] ] ].

	classes := tags flatCollect: [ :tag |
		SystemOrganization classesInCategory: tag ].

	results := classes flatCollect: [ :class |
		(class methods, class class methods) select: [ :method |
			method sourceCode includesSubstring: searchString caseSensitive: false ] ].

	^ results

]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inPackageArray: packages [

	^ self searchSourceCodeAndReturnEverythingFor: searchString asPackage: true inArray: packages excludingSubstring: nil
]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inPackageArray: packages excludingSubstring: exclusion [

	^ self searchSourceCodeAndReturnEverythingFor: searchString asPackage: true inArray: packages excludingSubstring: exclusion
]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inTagArray: tags [
	
	^ self searchSourceCodeAndReturnEverythingFor: searchString asPackage: false inArray: tags excludingSubstring: nil
]

{ #category : #'as yet unclassified' }
MSearch class >> searchSourceCodeAndReturnEverythingFor: searchString inTagArray: tags excludingSubstring: exclusion [
	
	^ self searchSourceCodeAndReturnEverythingFor: searchString asPackage: false inArray: tags excludingSubstring: exclusion
]
