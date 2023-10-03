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
MDevelopment class >> copyLocalIcebergPathCommandOn: builder [

	<worldMenu>
	
	(builder item: 'Copy Iceberg Path')
		parent: #'Melvin''s Toolkit';
		order: 1.0;
		action: [ Clipboard clipboardText: (SystemResolver defaultLocalDirectory / 'iceberg') fullName ]
]

{ #category : #'as yet unclassified' }
MDevelopment class >> createMelvinsToolkitMenuTab: builder [
	<worldMenu>

	(builder item: 'Melvin''s Toolkit')
		order: 100

]
