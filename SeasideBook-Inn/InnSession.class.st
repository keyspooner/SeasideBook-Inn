Class {
	#name : #InnSession,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'SeasideBook-Inn'
}

{ #category : #'as yet unclassified' }
InnSession >> isLoggedIn [
	^ user isNil not
]

{ #category : #'as yet unclassified' }
InnSession >> login: aString [
	user := aString
]

{ #category : #'as yet unclassified' }
InnSession >> logout [
	user := nil.

]

{ #category : #'parent/child' }
InnSession >> unregistered [
	super unregistered.
	user := nil
]

{ #category : #'as yet unclassified' }
InnSession >> user [
	^ user
]
