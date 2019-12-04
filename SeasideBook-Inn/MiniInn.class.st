Class {
	#name : #MiniInn,
	#superclass : #WAComponent,
	#instVars : [
		'calendar1',
		'calendar2',
		'startDate',
		'endDate'
	],
	#category : #'SeasideBook-Inn'
}

{ #category : #'class initialization' }
MiniInn class >> initialize [ 
	"self initialize"
	WAAdmin register: self asApplicationAt: 'miniInn'
]

{ #category : #accessing }
MiniInn >> calendar1 [
	^ calendar1
]

{ #category : #accessing }
MiniInn >> calendar1: anObject [
	calendar1 := anObject
]

{ #category : #accessing }
MiniInn >> calendar2 [
	^ calendar2
]

{ #category : #accessing }
MiniInn >> calendar2: anObject [
	calendar2 := anObject
]

{ #category : #hooks }
MiniInn >> children [ 	
	^ Array with: calendar1 with: calendar2
]

{ #category : #accessing }
MiniInn >> endDate [
	^ endDate
]

{ #category : #accessing }
MiniInn >> endDate: anObject [
	endDate := anObject
]

{ #category : #hooks }
MiniInn >> initialize [
	super initialize.
	calendar1 := WAMiniCalendar new.
	calendar1
		canSelectBlock: [ :date | Date today < date ];
		onAnswer: [ :date | startDate := date ].
	calendar2 := WAMiniCalendar new.
	calendar2
		canSelectBlock: [ :date | startDate isNil or: [ startDate < date ] ];
		onAnswer: [ :date | endDate := date ].
]

{ #category : #hooks }
MiniInn >> renderContentOn: html [
	html heading: 'Starting Date'.
	html render: calendar1.
	html break.
	startDate isNil 
		ifFalse: [ html text: 'Selected start: ' , startDate asString ].
	html heading: 'Ending Date'.
	html render: calendar2.
	html break.
	(startDate isNil not and: [ endDate isNil not])
		ifTrue: [ 
				html text: (endDate - startDate ) days asString ,
				' days from ' , startDate asString , ' to ' ,
				endDate asString , ' '
			 ]
]

{ #category : #accessing }
MiniInn >> startDate [
	^ startDate
]

{ #category : #accessing }
MiniInn >> startDate: anObject [
	startDate := anObject
]
