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
	args := args collect: [ :each | each, '.' ].
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
	| originalMethodData |
	 originalMethodData := OriginalMethods at: {aClass. selector} ifAbsent: [ ^ nil ].
	^ originalMethodData at: 'compiledCode' ifAbsent: [ nil ].

]

{ #category : #'as yet unclassified' }
WebElementAspect class >> resetAllMethods [
	WebElementAspect resetMethod: #click in: BPWebElement.
	WebElementAspect resetMethod: #clear in: BPWebElement.
	WebElementAspect resetMethod: #sendKeys: in: BPWebElement.
	WebElementAspect resetMethod: #privatePerformActions: in: BPRemoteWebDriver.
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> resetMethod: selector in: aClass [
	| originalMethodData originalSourceCode |

	originalMethodData := OriginalMethods at: {aClass. selector} ifAbsent: [ ^ nil ].
	originalMethodData ifNotNil: [
		originalSourceCode := (originalMethodData at: 'sourceCode').
		aClass removeSelector: selector.
		aClass compile: originalSourceCode ].

]

{ #category : #'as yet unclassified' }
WebElementAspect class >> storeOriginalMethod: aMethod for: selector in: aClass [
	| methodData |
	methodData := Dictionary new.
	methodData at: 'selector' put: selector.
	methodData at: 'sourceCode' put: aMethod sourceCode.
	methodData at: 'compiledCode' put: aMethod.
	OriginalMethods at: {aClass. selector} put: methodData.

]

{ #category : #'as yet unclassified' }
WebElementAspect class >> wrapAllMethods [
	WebElementAspect wrapMethodWithDelay: #click onClass: BPWebElement.
	WebElementAspect wrapMethodWithDelay: #clear onClass: BPWebElement.
	WebElementAspect wrapMethodWithDelay: #sendKeys: onClass: BPWebElement.
	WebElementAspect wrapMethodWithActionDelay: #privatePerformActions: onClass: BPRemoteWebDriver.
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> wrapMethodWithActionDelay: selector onClass: targetClass [
	| originalMethod someCode n |
	
	originalMethod := targetClass compiledMethodAt: selector.
	n := Character cr asString.
	
	someCode := 'privatePerformActions: actions', n,
		n,
		'|result newActions pauseAction|', n,
		'WebScraper installVisualClickForDriver: self.', n,
		'pauseAction := (BPPauseAction driver: self withPause: 1000).', n,
		'newActions := actions flatCollect: [ :value | { value. pauseAction } ].', n,
		'result := (WebElementAspect originalMethodFor: #privatePerformActions: in: BPRemoteWebDriver) valueWithReceiver: self arguments: (Array withAll: {newActions}).', n,
		'^ result'.
	
	self storeOriginalMethod: originalMethod for: selector in: targetClass.

	targetClass compile: someCode
	
"
privatePerformActions: actions

|result newActions pauseAction|

pauseAction := (BPPauseAction driver: self).
newActions := actions flatCollect: [ :value | { value. pauseAction } ].
""result := (WebElementAspect originalMethodFor: #privatePerformActionsOriginal: in: BPWebElement) valueWithReceiver: self arguments: (Array withAll: {newActions}).""
result := self privatePerformActionsOriginal: newActions.
^ result

"
]

{ #category : #'as yet unclassified' }
WebElementAspect class >> wrapMethodWithDelay: selector onClass: targetClass [
	| originalMethod keywordsWithArgs argumentList someCode n originalMethodObjectName |
	
	originalMethod := targetClass compiledMethodAt: selector.
	originalMethodObjectName := '(', self asString, ' originalMethodFor: #', selector asString, ' in: ', targetClass asString,')'.
	keywordsWithArgs := self generateArgumentsFor: originalMethod.
	argumentList := self extractArgsFrom: keywordsWithArgs. "{'__arg1'. '__arg2'.}"
	n := Character cr asString.
	
	someCode := keywordsWithArgs, n,
		n,
		'|result|', n,
		'(Delay forSeconds: 1.25) wait.', n,
		'result := ', originalMethodObjectName, ' valueWithReceiver: self arguments: (Array withAll: ', argumentList, ').', n,
		'(Delay forSeconds: 1.25) wait.', n,
		'^ result'.
	
	self storeOriginalMethod: originalMethod for: selector in: targetClass.

	targetClass compile: someCode
]
