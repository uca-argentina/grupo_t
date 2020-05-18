Class {
	#name : #MoonW,
	#superclass : #Object,
	#instVars : [
		'recoilValue'
	],
	#category : #'IS2-GameTP1'
}

{ #category : #'as yet unclassified' }
MoonW class >> withRecoil: nValue [
	^self new initializeWith: nValue .
]

{ #category : #effect }
MoonW >> applyTo: aPlayer in: board [ 
	| position |
	position := 0.
	board squares reset.
	[ board nextPosition isCheckpoint ] whileFalse: [ 
	
		board playersOfCurrentPosition do: [ :player |
			player = aPlayer ifFalse: [
				board currentPosition leaves: player.

				player lapsDone == 0 & (position < recoilValue) ifTrue: [ board resetIndex ] 
				ifFalse: [
					recoilValue timesRepeat:  [ 
						board previousPosition . 
						(board currentPosition isCheckpoint) ifTrue: [ player decreaseLap ].
					]. 
				].
				board currentPosition put: player .]
		].
		position := position + 1.
	].

]

{ #category : #initialization }
MoonW >> initializeWith: value [
	recoilValue := value .
]