Class {
	#name : #BPPauseAction,
	#superclass : #BPAction,
	#category : #'Melvin-Dev'
}

{ #category : #'instance creation' }
BPPauseAction class >> driver: driver [

	^ self new initWithDriver: driver
]

{ #category : #private }
BPPauseAction >> privatePerformActionJSON [
	| jsonObject |
	
	(jsonObject := Dictionary new)
		at: 'type' put: 'pause';
		at: 'duration' put: 1000.
	
	^ Array with: jsonObject
]
