Class {
	#name : #BPPauseAction,
	#superclass : #BPAction,
	#instVars : [
		'pauseInMilliseconds'
	],
	#category : #'Melvin-Dev'
}

{ #category : #'instance creation' }
BPPauseAction class >> driver: driver withPause: aPauseInMilliSeconds [

	^ self new driver: driver withPause: aPauseInMilliSeconds
]

{ #category : #private }
BPPauseAction >> driver: aDriver withPause: aPauseInMilliSeconds [
	
	self initWithDriver: aDriver.
	pauseInMilliseconds := aPauseInMilliSeconds
]

{ #category : #private }
BPPauseAction >> privatePerformActionJSON [

	| jsonObject |
	
	(jsonObject := Dictionary new)
		at: 'type' put: 'pause';
		at: 'duration' put: pauseInMilliseconds.
	
	^ Array with: jsonObject
]
