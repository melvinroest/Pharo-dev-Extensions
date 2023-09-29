Extension { #name : #Array }

{ #category : #'*Melvin-Dev' }
Array >> logToJSConsole [
	| currentTimeStamp setResultScript driver |
	
	(self allSatisfy: [:each | each isKindOf: BPWebElement]) ifFalse: [
        self error: 'Not all elements are BPWebElements'
    ].

	driver := self first driver.
	
	currentTimeStamp := Time now print24.
	
	setResultScript := 'stTemp = arguments[0]'.
	driver executeScript: setResultScript with: { self }.
	
	driver executeScript: 'console.log(`--- ', currentTimeStamp,' ---`)' with: #().
	driver executeScript: 'console.log(stTemp)' with: #().
	driver executeScript: 'console.log(`----------------------`)' with: #().
	
	^ self
]
