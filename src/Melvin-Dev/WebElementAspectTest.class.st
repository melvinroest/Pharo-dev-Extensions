Class {
	#name : #WebElementAspectTest,
	#superclass : #TestCase,
	#category : #'Melvin-Dev'
}

{ #category : #tests }
WebElementAspectTest class >> + argBinary [
	^ self asString, ' hi'
]

{ #category : #tests }
WebElementAspectTest class >> keywordMethod: arg1 with: arg2 [ 
	^ arg1 + arg2.
]

{ #category : #tests }
WebElementAspectTest class >> simpleMethod [ 
	^ 'Simple method executed'.
]

{ #category : #tests }
WebElementAspectTest >> testWrapMethod [

	"WebElementAspect wrapMethodWithDelay: #keywordMethod:with: onClass: WebElementAspectTest class.
	WebElementAspect wrapMethodWithDelay: #simpleMethod onClass: WebElementAspectTest class.
	WebElementAspect wrapMethodWithDelay: #+ onClass: WebElementAspectTest class.
	
	self assert: (WebElementAspectTest keywordMethod: 10 with: 20) equals: 30.
	self assert: (WebElementAspectTest simpleMethod) equals: 'Simple method executed'.
	self assert: (WebElementAspectTest + 'hi') equals: 'WebElementAspectTest hi'."

	1 halt.
	WebElementAspect resetMethod: #keywordMethod:with: in: WebElementAspectTest class.
	"
	keywordMethod: arg1 with: arg2 
		^ arg1 + arg2.
	"
	WebElementAspect resetMethod: #simpleMethod in: WebElementAspectTest class.
	"
	simpleMethod 
	^ 'Simple method executed'.
	"
	WebElementAspect resetMethod: #+ in: WebElementAspectTest class.
	"
	+ argBinary
		^ self asString, ' hi'
	"
]
