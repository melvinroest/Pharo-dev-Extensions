Class {
	#name : #WebElementAspect,
	#superclass : #Object,
	#classInstVars : [
		'OriginalMethods'
	],
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
        selectorParts first isSpecial ifTrue: [ ^ selectorParts, ' __argBinary' ].
        "Otherwise, it's a unary method"
        ^ selectorParts ].
	
	selectorParts := (selectorParts substrings: ':').
	^ ' ' join: ((1 to: selectorParts size) collect: [ :i | (selectorParts at: i), ': __arg', i asString ])
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> initialize [
	OriginalMethods := Dictionary new.
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> originalMethodFor: selector in: aClass [
	^ OriginalMethods at: {aClass. selector} ifAbsent: [ nil ].
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
WebElementAspect class >> storeOriginalMethod: aMethod for: selector in: aClass [
	OriginalMethods at: {aClass. selector} put: aMethod.

]

{ #category : #'as yet unclassified' }
WebElementAspect class >> wrapMethodWithDelay: selector onClass: targetClass [
	| originalMethod keywordsWithArgs argumentList someCode originalMethodString n |
	
	self storeOriginalMethod: (targetClass compiledMethodAt: selector) for: selector in: targetClass.
	
	originalMethod := targetClass compiledMethodAt: selector.
	originalMethodString := '(_', targetClass asString, '>>#', originalMethod selector asString, ')'.
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
