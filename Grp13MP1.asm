;COMORGA MP1
;S11 Group 13
;Authors: Agustin, Gedrite H.
;         Bravante, Ralph Christian S.
;         Chua, Kyle Matthew C.
global _main
extern _printf, _scanf, _getchar, _system
section .text
_main:
    ;clear screen
    push clr
    call _system
    add esp, 4
    
    ;print input prompt
    push inPrompt
    call _printf
    add esp, 4
    
    ;scan input
    push inRad
    push scanRad
    call _scanf
    add esp, 8
    call _getchar
    
    ;load values to stack
    MOV EBX, 1d
    fld1
    fld1
    fchs
    fld qword[inRad] 
    fld qword[inRad] 
    fld1
    fld1
    fld qword[inRad]
    fld qword[inRad]
    
    push EBX
    push parenthesis
    call _printf
    add esp, 8
    
    push dword [inRad+4]
    push dword [inRad]
    push currPrompt
    call _printf
    add esp, 12
    
    push dword [inRad+4]
    push dword [inRad]
    push totPrompt
    call _printf
    add esp, 12
    
L1:   
    ;numerator*radian*radian*-1
    fxch st5
    fmul st4, st0
    fmul st4, st0
    fxch st5
    fxch st6
    fmul st4, st0
    fxch st6
    ;(denominator+1)*factorial
    fxch st7
    fadd st3, st0
    fxch st7
    fxch st3
    fmul st2, st0
    fxch st3
    ;(denominator+1)*factorial
    fxch st7
    fadd st3, st0
    fxch st7
    fxch st3
    fmul st2, st0
    fxch st3   
    ;current = numerator/denominator
    STC
    fcmovb st4
    fdiv st0, st2
    
    ;print current iteration value
    INC EBX
    push EBX
    push parenthesis
    call _printf
    add esp, 8
    
    fst qword[Value]
    push dword [Value+4]
    push dword [Value]
    push currPrompt
    call _printf
    add esp, 12 
    
    ;add to total
    fxch st1
    fadd st0, st1
    fst qword[Value]
    fxch st1
  
    ;print current total value
    push dword [Value+4]
    push dword [Value]
    push totPrompt
    call _printf
    add esp, 12
CMP EBX, 32d
JNE L1

    ;print final value
    push dword [Value+4]
    push dword [Value]
    push outPrompt
    call _printf
    add esp, 12
    
    xor eax, eax
    ret

section .data
clr db "cls",0
inPrompt db "Please input a digit in radian: ",0
outPrompt db 13, 10, "Sin value: %.12f", 13, 10, 0
currPrompt db "Iteration value: %.12f     ", 0
totPrompt db "Current computed: %.12f", 13, 10, 0
parenthesis db "(%d)   ",0
inRad dq 0.0
scanRad db "%lf", 0
Value dq 0.0