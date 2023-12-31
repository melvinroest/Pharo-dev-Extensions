Extension { #name : #BPWebElement }

{ #category : #'*Melvin-Dev' }
BPWebElement >> driver [
	^ driver
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> exeElementIsOutsideOfTopOfContainer: aContainer withMargin: aMarginNumber [
	"Todo: needs to be tested for left, right and bottom"
	
	| isElementOutsideContainer |
	isElementOutsideContainer := '
isElementOutsideContainer = (el, container, margin = 0) => {
    const eleRect = el.getBoundingClientRect()
    const containerRect = container.getBoundingClientRect()
    return eleRect.top < containerRect.top + margin
}
	'.
	
	driver executeScript: isElementOutsideContainer with: #().
	^ driver executeScript: 'return isElementOutsideContainer(arguments[0], arguments[1], arguments[2])' with: { self. aContainer. aMarginNumber }.
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
    const ele = el.getBoundingClientRect();
    const containerRect = container.getBoundingClientRect();

    return (
        ele.bottom < containerRect.top ||
        ele.top > containerRect.bottom ||
        ele.right < containerRect.left ||
        ele.left > containerRect.right
    );
};
	'.
	
	driver executeScript: isElementOutsideContainer with: #().
	^ driver executeScript: 'return isElementOutsideContainer(arguments[0], arguments[1])' with: { self. aContainer }.
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> exeIsElementOutsideContainer: aContainer withMargin: aMarginNumber [
	"Todo: needs to be tested for left, right and bottom"
	
	| isElementOutsideContainer |
	isElementOutsideContainer := '
isElementOutsideContainer = (el, container, margin = 0) => {
    const eleRect = el.getBoundingClientRect();
    const containerRect = container.getBoundingClientRect();
    console.log(eleRect.top, containerRect.top + margin)
    return (
        eleRect.top < containerRect.top + margin ||
        eleRect.bottom > containerRect.bottom - margin ||
        eleRect.left < containerRect.left + margin ||
        eleRect.right > containerRect.right - margin
    );
};
	'.
	
	driver executeScript: isElementOutsideContainer with: #().
	^ driver executeScript: 'return isElementOutsideContainer(arguments[0], arguments[1])' with: { self. aContainer. aMarginNumber }.
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> findChildren [
	^ self findElementsBy: 'xpath' with: './*'
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> getHtml [
	^ self driver executeScript: 'return arguments[0].outerHTML' with: { self }
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> logToJSConsole [
	{ self } logToJSConsole 
]

{ #category : #'*Melvin-Dev' }
BPWebElement >> visiblyClickAt: aPoint [

	| makeClickVisibleScript |
	self clickAt: aPoint.
	makeClickVisibleScript := '
makeClickVisible = (el, x, y) => { 
    const body = document.body;
    const circle = document.createElement(`div`);
    const rect = el.getBoundingClientRect();

    Object.assign(circle.style, {
        width: `10px`,
        height: `10px`,
        borderRadius: `50%`,
        backgroundColor: `transparent`,
        border: `1px solid red`,
        position: `absolute`,
        left: `${rect.left + x}px`,
        top: `${rect.top + y}px`,
        zIndex: `99999`,
        opacity: `1`,
        transition: `width 0.5s, height 0.5s, opacity 0.5s`,
        transform: `translate(-50%, -50%)`
    });

    body.appendChild(circle);

    // Trigger the animation after a brief timeout to ensure initial styles are applied
    setTimeout(() => {
        Object.assign(circle.style, {
            width: `50px`,
            height: `50px`,
            opacity: `0`
        });
    }, 10);

    // Remove the circle from the DOM after the animation completes
    setTimeout(() => {
        body.removeChild(circle);
    }, 510);  // A little over 0.5s to ensure animation completes
}
'.

	driver executeScript: makeClickVisibleScript with: #().
	driver executeScript: 'makeClickVisible(arguments[0], arguments[1], arguments[2])' with: { self. aPoint x. aPoint y }.
]
