"
Usage:
Use the playground to set
Use the getter in debugging code

Note: you also have object-instance based debugging and you can ask about it on Discord
"
Class {
	#name : #MDebug,
	#superclass : #Object,
	#classVars : [
		'isInDebugMode'
	],
	#category : #'Melvin-Dev'
}

{ #category : #testing }
MDebug class >> isOn [
	^ isInDebugMode
]

{ #category : #testing }
MDebug class >> isOn: aBoolean [
	isInDebugMode := aBoolean
]
