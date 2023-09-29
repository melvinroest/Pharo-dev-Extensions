Class {
	#name : #WebElementAspect,
	#superclass : #Object,
	#category : #'Melvin-Dev'
}

{ #category : #'as yet unclassified' }
WebElementAspect class >> extractArgsFrom: argString [
	
	| tokens args |
	tokens := argString substrings: ' '.
	args := (tokens select: [ :each | each beginsWith: '__arg' ]).
	args := args collect: [ :each | $' asString, each, $' asString, '.' ].
	args := ' ' join: args.
	^ '{', args, '}'.
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> generateArgumentsFor: aMethod [
	"Generate a keyword argument list string for the given method"
	| selectorParts |
	selectorParts := aMethod selector asString.
	
	"Check if it's a unary method (no arguments)"
    (selectorParts indexOf: $:) > 0 ifFalse: [
        "Check if it's a binary method"
        selectorParts first isSpecial ifTrue: [ ^ '__argBinary' ].
        "Otherwise, it's a unary method"
        ^ '' ].
	
	selectorParts := (selectorParts substrings: ':').
	^ ' ' join: ((1 to: selectorParts size) collect: [ :i | (selectorParts at: i), ': __arg', i asString ])
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> originalMethodFor: selector in: targetClass [
	"Retrieve the original method from the global variable"
	^ Smalltalk globals at: (self storageKeyFor: selector in: targetClass) ifAbsent: [nil].
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> resetMethod: selector in: targetClass [
	| originalMethod |
	originalMethod := self originalMethodFor: selector in: targetClass.
	originalMethod ifNotNil: [
		targetClass methodDictionary at: selector put: originalMethod.
		targetClass recompile: selector ].
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> storageKeyFor: selector in: targetClass [
	"Generate a unique key for storing the original method"
	^ '_', targetClass name, '>>', selector asString.
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> storeOriginalMethod: aMethod for: selector in: targetClass [
	"Store the original method in a global variable (for simplicity's sake)"
	Smalltalk globals at: (self storageKeyFor: selector in: targetClass) put: aMethod.

]

{ #category : #'as yet unclassified' }
WebElementAspect class >> wrapMethodWithDelay: selector onClass: targetClass [
	| originalMethod keywordsWithArgs argumentList someCode originalMethodString n |
	
	self storeOriginalMethod: (targetClass compiledMethodAt: selector) for: selector in: targetClass.
	
	originalMethod := targetClass compiledMethodAt: selector.
	originalMethodString := '(', targetClass asString, '>>#', originalMethod selector asString, ')'.
	keywordsWithArgs := self generateArgumentsFor: originalMethod.
	argumentList := self extractArgsFrom: keywordsWithArgs. "{'__arg1'. '__arg2'.}"
	n := Character cr asString.

	someCode := keywordsWithArgs, n,
		n,
		'|result|', n,
		'(Delay forSeconds: 0.25) wait.', n,
		'result := ', originalMethodString,' valueWithReceiver: self arguments: (Array withAll: ', argumentList, ').', n,
		'(Delay forSeconds: 0.25) wait.', n,
		'^ result'.

	targetClass compile: someCode
]
