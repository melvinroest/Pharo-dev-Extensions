Class {
	#name : #WebScraper,
	#superclass : #Object,
	#instVars : [
		'driver'
	],
	#category : #'Melvin-Dev'
}

{ #category : #'as yet unclassified' }
WebScraper class >> commandPlusClick: anElement [
	anElement sendKeys: (BPKeys command asString).
	anElement click.
	anElement sendKeys: (BPKeys null asString).
]

{ #category : #'as yet unclassified' }
WebScraper class >> getScrollPositionWithDriver: driver andElement: webElement [
	
	^ driver executeScript: 'return arguments[0].pageYOffset' with: { webElement }.
]

{ #category : #'as yet unclassified' }
WebScraper class >> keysForRemoval [
	^ String with: BPKeys delete with: BPKeys backSpace.
]

{ #category : #'as yet unclassified' }
WebScraper class >> removeTextFromInput: anInput [
	(anInput getProperty: 'value') size timesRepeat: [ anInput sendKeys: (self keysForRemoval) ]
]

{ #category : #'as yet unclassified' }
WebScraper class >> sendKeys: someKeys fromClearInput: anInput [
			someKeys !String.
	self removeTextFromInput: anInput.
	anInput sendKeys: someKeys.
]
