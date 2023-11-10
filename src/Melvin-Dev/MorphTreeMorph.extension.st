Extension { #name : #MorphTreeMorph }

{ #category : #'*Melvin-Dev' }
MorphTreeMorph >> copyAll [
	
	| result |
	result := OrderedCollection new.
	self allNodeMorphs do: [ :aNodeMorph || nmContents spaceString amountOfSpaces |
		nmContents := (aNodeMorph submorphs first contents).
		amountOfSpaces := aNodeMorph indentLevel * 4. "4 seems like a good number for indentation"
		spaceString := String new: amountOfSpaces withAll: Character space.
		result add: spaceString, nmContents ].
	result := result joinUsing: String cr.
	Clipboard clipboardText: result
]

{ #category : #'*Melvin-Dev' }
MorphTreeMorph >> copyAllRoots [
	
	| result |
	result := OrderedCollection new.
	self roots do: [ :aRoot | result add: (aRoot submorphs first contents) ].
	result := result joinUsing: String cr.
	Clipboard clipboardText: result
]
