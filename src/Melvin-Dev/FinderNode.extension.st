Extension { #name : #FinderNode }

{ #category : #'*Melvin-Dev' }
FinderNode >> menu: menu shifted: aBoolean [
	menu
		add: 'Browse (b)'
		target: self
		selector: #browse.
	self addInspectMenuItem: menu.

	menu addLine.
	menu
		add: 'Expand All'
		target: self model
		selector: #expandAll.
	menu
		add: 'Collapse All'
		target: self model
		selector: #collapseAll.
	menu
		add: 'Copy All'
		target: self model
		selector: #copyAll.
	menu
		add: 'Copy All Roots'
		target: self model
		selector: #copyAllRoots.
	^menu
]
