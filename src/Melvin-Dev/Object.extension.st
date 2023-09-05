Extension { #name : #Object }

{ #category : #'*Melvin-Dev' }
Object >> ! aType [
	^ self isType: aType
]

{ #category : #'*Melvin-Dev' }
Object >> isType: aType [
	"See also: SpTDecoratedText for inspiration"
    (self isKindOf: aType) 
        ifFalse: [ Error new signal: self printString, ' is not a ', aType name, ' object.' ].
]
