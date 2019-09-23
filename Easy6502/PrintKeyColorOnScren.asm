; Define the screen address
define 	Scr01	$01
define	Scr02	$00
	LDA	#$00
	STA	Scr02
	LDA	#$02
	STA	Scr01	

; Initialize Y register
	LDA	#$00
	TAY

; Define and Initialize the Keyboard
define	Keyb	$FF
	LDA	#$FF
	STA	Keyb

; Main Loop
loop:
	LDA	Keyb
	CMP	#$FF
	BEQ	loop 		;Keep on looping until read a key
	STA	(Scr02),Y 	;Print the correspondent color on screen
	TYA
	INY
	CMP	#$FF 		;Verify if changed page in the screen address
	PHP
	LDA	#$FF
	STA	Keyb
	PLP
	BEQ	updateScr
	JMP 	loop

;Update the screen page when Y register overflows
updateScr:
	INC 	Scr01
	LDA	Scr01
	CMP	#$06
	BEQ	end
	JMP	loop

end:
	BRK
	