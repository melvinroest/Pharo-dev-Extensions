Class {
	#name : #WebElementAspectTest,
	#superclass : #TestCase,
	#category : #'Melvin-Dev'
}

{ #category : #'as yet unclassified' }
WebElementAspectTest class >> + argBinary [
	^ self asString, ' hi'
]

{ #category : #'as yet unclassified' }
WebElementAspectTest class >> keywordMethod: arg1 with: arg2 [ 
	^ arg1 + arg2.
]

{ #category : #'as yet unclassified' }
WebElementAspectTest class >> simpleMethod [ 
	^ 'Simple method executed'.
]

{ #category : #tests }
WebElementAspectTest >> testNormalExecution [

	| timeTaken |
	timeTaken := Time millisecondsToRun: [
   
		self assert: (WebElementAspectTest keywordMethod: 10 with: 20) equals: 30.
		self assert: (WebElementAspectTest simpleMethod) equals: 'Simple method executed'.
		self assert: (WebElementAspectTest + 'hi') equals: 'WebElementAspectTest hi'.
 
	].

	self assert: timeTaken < 200.
]

{ #category : #tests }
WebElementAspectTest >> testWrapMethod [

	| timeTaken |
	timeTaken := Time millisecondsToRun: [
   
		WebElementAspect wrapMethodWithDelay: #keywordMethod:with: onClass: WebElementAspectTest class.
		WebElementAspect wrapMethodWithDelay: #simpleMethod onClass: WebElementAspectTest class.
		WebElementAspect wrapMethodWithDelay: #+ onClass: WebElementAspectTest class.

		self assert: (WebElementAspectTest keywordMethod: 10 with: 20) equals: 30.
		self assert: (WebElementAspectTest simpleMethod) equals: 'Simple method executed'.
		self assert: (WebElementAspectTest + 'hi') equals: 'WebElementAspectTest hi'.



		WebElementAspect resetMethod: #keywordMethod:with: in: WebElementAspectTest class.
		self assert: (WebElementAspectTest class compiledMethodAt: #keywordMethod:with:) sourceCode equals: 'keywordMethod: arg1 with: arg2 
	^ arg1 + arg2.'.

		WebElementAspect resetMethod: #simpleMethod in: WebElementAspectTest class.
		self assert: (WebElementAspectTest class compiledMethodAt: #simpleMethod) sourceCode equals: 'simpleMethod 
	^ ''Simple method executed''.'.

		WebElementAspect resetMethod: #+ in: WebElementAspectTest class.
		self assert: (WebElementAspectTest class compiledMethodAt: #+) sourceCode equals: '+ argBinary
	^ self asString, '' hi'''.
 
	].

	self assert: timeTaken > 1499.
]
