; Two bytes for the address to be manipulated Ad01 Ad02
define	Ad01	$01
define	Ad02	$00

; Define the first byte of the screen address ($200)
	LDA	#$02
	STA	Ad01
	LDA	#$00
	STA	Ad02

; Set the Y register to 0
	LDA	#$00
	TAY


MainLoop:
	;color current pixel
	LDA	$FE 		;Get a random number
	STA	(Ad02),Y	;Color the screen Position
	;Increment Y Reg and test for overflow(Zero Flag)
	INY
	BEQ	UpdateAddress
	JMP 	MainLoop

UpdateAddress:
	;check if the full screen is filled
	LDA	Ad01
	CMP	#$05
	BEQ	End
	;else
	INC	Ad01
	JMP	MainLoop

;End program
End:
	BRK