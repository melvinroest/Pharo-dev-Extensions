Class {
	#name : #MDevelopment,
	#superclass : #Object,
	#category : #'Melvin-Dev'
}

{ #category : #'as yet unclassified' }
MDevelopment class >> copyImageDirectoryCommandOn: builder [

	<worldMenu>
	
	(builder item: 'Copy Image Directory')
		parent: #'Melvin''s Toolkit';
		order: 1.0;
		action: [ Clipboard clipboardText: FileLocator workingDirectory fullName ]
]

{ #category : #'as yet unclassified' }
MDevelopment class >> createMelvinsToolkitMenuTab: builder [
	<worldMenu>

	(builder item: 'Melvin''s Toolkit')
		order: 100

]

{ #category : #'as yet unclassified' }
MDevelopment class >> openLocalIcebergPathInItermOn: builder [

	<worldMenu>
	| path command |
	path := (SystemResolver defaultLocalDirectory / 'iceberg') fullName.
	command := 'open -a iTerm {1}' format: { path }.
	
	(builder item: 'Open Local Iceberg in iTerm')
		parent: #'Melvin''s Toolkit';
		order: 1.0;
		action: [ LibC system: command ]
]
