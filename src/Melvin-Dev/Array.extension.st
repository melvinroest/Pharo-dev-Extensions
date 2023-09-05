Extension { #name : #Array }

{ #category : #'*Melvin-Dev' }
Array >> logToJSconsole [
	| currentTimeStamp isElementVisibleJSFunction visibilityCheckScript driver |
	
	(self allSatisfy: [:each | each isKindOf: BPWebElement]) ifFalse: [
        self error: 'Not all elements are BPWebElements'
    ].

	driver := self first driver.
	
	currentTimeStamp := Time now print24.
	
	isElementVisibleJSFunction := 'isElementVisible = (element) => element.offsetWidth > 0 && element.offsetHeight > 0'.
	driver executeScript: isElementVisibleJSFunction with: #().
	
	visibilityCheckScript := 'stTemp = arguments[0].map(el => isElementVisible(el) ? el : false)'.
	driver executeScript: visibilityCheckScript with: { self }.
	
	driver executeScript: 'console.log(`--- ', currentTimeStamp,' ---`)' with: #().
	driver executeScript: 'console.log(stTemp)' with: #().
	driver executeScript: 'console.log(`----------------------`)' with: #().
	
	^ currentTimeStamp
]
