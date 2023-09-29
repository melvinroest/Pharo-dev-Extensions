Class {
	#name : #WebElementAspectTest,
	#superclass : #TestCase,
	#category : #'Melvin-Dev'
}

{ #category : #tests }
WebElementAspectTest class >> keywordMethod: arg1 with: arg2 [ 
	^ arg1 + arg2.
]

{ #category : #tests }
WebElementAspectTest class >> simpleMethod [ 
	^ 'Simple method executed'.
]

{ #category : #tests }
WebElementAspectTest class >> threeKeywordMethod: arg1 foo: arg2 bar: arg3 [
	^ arg1, ' ', arg2 asString, ' ', arg3 asString.
]

{ #category : #tests }
WebElementAspectTest >> testWrapMethod [
	WebElementAspect wrapMethodWithDelay: #keywordMethod:with: onClass: WebElementAspectTest class.
	WebElementAspect wrapMethodWithDelay: #simpleMethod onClass: WebElementAspectTest class.
	WebElementAspect wrapMethodWithDelay: #threeKeywordMethod:foo:bar: onClass: WebElementAspectTest class.
	
	self assert: (WebElementAspectTest keywordMethod: 10 with: 20) equals: 30.
	self assert: (WebElementAspectTest simpleMethod) equals: 'Simple method executed'.
	self assert: (WebElementAspectTest threeKeywordMethod: 'Hello' foo: 42 bar: 'World') equals: 'Hello 42 World'.

	WebElementAspect resetMethod: #keywordMethod:with: in: WebElementAspectTest class.
	WebElementAspect resetMethod: #simpleMethod in: WebElementAspectTest class.
	WebElementAspect resetMethod: #threeKeywordMethod:foo:bar: in: WebElementAspectTest class.
]
