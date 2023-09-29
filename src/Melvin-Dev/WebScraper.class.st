Class {
	#name : #WebScraper,
	#superclass : #Object,
	#instVars : [
		'driver'
	],
	#category : #'Melvin-Dev'
}

{ #category : #'as yet unclassified' }
WebScraper class >> commandPlusClick: anElement [
	anElement sendKeys: (BPKeys command asString).
	anElement click.
	anElement sendKeys: (BPKeys null asString).
]

{ #category : #'as yet unclassified' }
WebScraper class >> getScrollPositionWithDriver: driver andElement: webElement [
	
	^ driver executeScript: 'return arguments[0].pageYOffset' with: { webElement }.
]

{ #category : #'as yet unclassified' }
WebScraper class >> installVisualClickForDriver: driver [
	
	| makeClickVisibleScript |
	makeClickVisibleScript := '
makeClickVisible = (e) => {
	const body = document.body
	const circle = document.createElement(`div`)
	const x = e.clientX
	const y = e.clientY
	console.log(x, y)

	Object.assign(circle.style, {
		width: `10px`,
		height: `10px`,
		borderRadius: `50%`,
		backgroundColor: `transparent`,
		border: `1px solid red`,
		position: `absolute`,
		left: `${x}px`,
		top: `${y}px`,
		zIndex: `2147483647`,
		pointerEvents: `none`,
		opacity: 1,
		transition: `width 1s, height 1s, opacity 1s`,
		transform: `translate(-50%, -50%)`
	});

	for (const [property, value] of Object.entries(circle.style)) {
		circle.style.setProperty(property, value, `important`);
	}

	body.insertBefore(circle, body.firstChild);

	// Trigger the animation after a brief timeout to ensure initial styles are applied
	setTimeout(() => {
		Object.assign(circle.style, {
			width: `50px`,
			height: `50px`,
			opacity: 0
		})
	}, 10)

	// Remove the circle from the DOM after the animation completes
	setTimeout(() => {
		body.removeChild(circle);
	}, 1010)
}
'.
	
	driver executeScript: makeClickVisibleScript with: #().
	driver executeScript: 'document.addEventListener(`click`, makeClickVisible, true)' with: #().
]

{ #category : #'as yet unclassified' }
WebScraper class >> keysForRemoval [
	^ String with: BPKeys delete with: BPKeys backSpace.
]

{ #category : #'as yet unclassified' }
WebScraper class >> removeTextFromInput: anInput [
	(anInput getProperty: 'value') size timesRepeat: [ anInput sendKeys: (self keysForRemoval) ]
]

{ #category : #'as yet unclassified' }
WebScraper class >> sendKeys: someKeys fromClearInput: anInput [
			someKeys !String.
	self removeTextFromInput: anInput.
	anInput sendKeys: someKeys.
]
