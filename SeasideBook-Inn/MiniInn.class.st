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
	|application|
	application := WAAdmin register: self asApplicationAt: 'miniInn'.
	application preferenceAt: #sessionClass put: InnSession.
	application 
		addLibrary: JQDeploymentLibrary;
	 	addLibrary: JQUiDeploymentLibrary
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

{ #category : #updating }
MiniInn >> initialRequest: aRequest [
	super initialRequest: aRequest.
	aRequest fields
		at: 'startDate'
		ifPresent: [ :value | startDate := value asDate ].
	aRequest fields 
		at: 'endDate'
		ifPresent: [ :value | endDate := value asDate ].
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

{ #category : #accessing }
MiniInn >> login [
	self session login: (self request: 'Enter your name: ')
]

{ #category : #accessing }
MiniInn >> logout [
	self session logout
]

{ #category : #hooks }
MiniInn >> renderContentOn: html [
	html document addLoadScript: (html javascript alert: 'hello' ).

	html anchor 	
			"targetBlank;"
			url: '#';
			onClick: (html jQuery: 'div.help') toggle;
			with: 'About jQuery'.
	html div 	
		class: 'help';
		style: 'display: none';
		with: 'jQuery is a fast and ...'.
	html break.
	
	self renderLogin: html.
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
			 ].
	html break.
	html break.
	(self session isLoggedIn)
		ifTrue: [ self renderSpecialPrice: html ]
]

{ #category : #accessing }
MiniInn >> renderLogin: html [
"	self session inspect."
	self session isLoggedIn
		ifTrue: [ 
			html text: 'Logged in as: ', self session user , ' '.
			html anchor 
				callback: [ self logout ];
				with: 'Logout' ]
		ifFalse: [ 
			html anchor 
				callback: [ self login ];
				with: 'Login' ]
]

{ #category : #accessing }
MiniInn >> renderSpecialPrice: html [
	html text: 'Dear ' , self session user , ', you can benefit from our special prices!'
]

{ #category : #accessing }
MiniInn >> startDate [
	^ startDate
]

{ #category : #accessing }
MiniInn >> startDate: anObject [
	startDate := anObject
]

{ #category : #updating }
MiniInn >> updateUrl: aURL [
	super updateUrl: aURL.
	startDate isNil
		ifFalse: [ aURL addField: 'startDate' value: startDate ].
	endDate isNil
		ifFalse: [ aURL addField: 'endDate' value: endDate ]
]
