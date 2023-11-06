Extension { #name : #MorphTreeMorph }

{ #category : #'*Melvin-Dev' }
MorphTreeMorph >> copyAll [
	| result |
	result := OrderedCollection new.
	self roots do: [ :aRoot | result add: (aRoot submorphs first contents) ].
	result := result joinUsing: String cr.
	Clipboard clipboardText: result
]
