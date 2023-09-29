Extension { #name : #BPWebElement }

{ #category : #'*Melvin-Dev' }
BPWebElement >> driver [
	^ driver
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> exeGetYPositionOfElement [
	| getYPositionOfElement |
	
	getYPositionOfElement := '
getYPositionOfElement = (el) => {
	const rect = el.getBoundingClientRect();
	return rect.top;
};
	'.
	
	driver executeScript: getYPositionOfElement with: #().
	^ driver executeScript: 'return getYPositionOfElement(arguments[0])' with: { self }
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> exeIsElementOutsideContainer: aContainer [
	| isElementOutsideContainer |
	
	isElementOutsideContainer := '
isElementOutsideContainer = (el, container) => {
    const rect = el.getBoundingClientRect();
    const containerRect = container.getBoundingClientRect();

    return (
        rect.bottom < containerRect.top ||
        rect.top > containerRect.bottom ||
        rect.right < containerRect.left ||
        rect.left > containerRect.right
    );
};
	'.
	
	driver executeScript: isElementOutsideContainer with: #().
	^ driver executeScript: 'return isElementOutsideContainer(arguments[0], arguments[1])' with: { self. aContainer }.
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> getHtml [
	^ self driver executeScript: 'return arguments[0].outerHTML' with: { self }
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> logToJSConsole [
	{ self } logToJSConsole 
]
