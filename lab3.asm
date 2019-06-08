org 100h
                      ;Lab3 #5      
start:  
    mov dx, offset KolvoElem
    mov ah,9
    int 21h  
a:
    mov ah, 01h	
    int 21h          

    cmp al, 2dh   ;proverka na minus
    je nega
    cmp al, 2fh   ;proverka na enter 
    jl enter
    
    cmp al, 30h   ; from 0                                
    jl error
    cmp al, 39h   ; to 9
    ja error
    
    sub al,30h    ; perevod simvola v chislo
    xor ah, ah 
              
    xchg ax, bx
    mov dx,0Ah  
    mul dx	   
    jo error1     ; umnozhenie na osnovanie sistemi schislenia(10)
     
    add bx,ax
    jo error1	  
loop a  

enter:
    cmp negative, 0    
    jle error      
    
    mov ax, bx
    cmp ax, 0   ;chislo elementov doljno bIUtb > 0
    jle error
    mov bx,0
      
    add ax,ax;del?  
      
    mov len, ax  
    add ax,ax
    mov len1, ax

    jmp begin 
   
nega:
   mov negative, -1
   jmp a                                         
error:   
   inc perepol   
   mov negative, 1  
   mov bx,0  
   mov dx,offset showError         ; error   db  'Symbol not correct!$'
   mov ah,9
   int 21h
   jmp start              
error1:  
     inc perepol 
     mov bx,0 
     mov dx, offset MesOverflow
     mov ah, 9
     int 21h
     jmp start                 
;########################ZAPROS ELEMENTOV MASSIVA###################################### 
begin:  
    mov ax, 03
    int 10h 
    mov dx,offset Message
    mov ah,9
    int 21h 
ta:
    mov ah, 01h	
    int 21h

    cmp al, 2dh   ;proverka na minus
    je nega1
    cmp al, 2fh   ;proverka na enter 
    jl input
    
    cmp al, 30h   ; from 0
    jl Error3
    cmp al, 39h   ; to 9
    ja Error3
    
    sub al,30h    ; perevod simvola v chislo
    xor ah, ah
    xchg ax, bx
    mov dx,0Ah  
    mul dx	
    jo Error6; Error4     ; umnozhenie na osnovanie sistemi schislenia(10)
    
    add bx,ax
    jo Error4	
    
loop ta  
    
input:
    mov ax, bx
    imul [negative]
    mov negative, 1
    mov bx,0
    
    mov mas[si], ax
    mov ax, 0
                   
    sub len, 1
    add si, 2
    
    cmp len, 0
    je Work
    
    mov dx,offset massiv
    mov ah,9
    int 21h
      
    jmp ta     
nega1:
    mov negative, -1
    jmp ta   
Error3:   
inc perepol
    mov dx,offset showError         ; error 
    mov ah,9
    int 21h
    jmp begin
Error4:  
inc perepol     
    add si,2
    mov dx, offset MesOverflow
    mov ah, 9
    int 21h        
    jmp go ; jmp begin    ;jmp go1
Error6:  
inc perepol     
    mov dx, offset MesOverflow
    mov ah, 9
    int 21h        
    jmp begin
Work:  ;PRAVILNII MASSIV!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
   mov dx, 0
   mov si, 0      
go:  ;Summiruem elementi massiva (a1-b1)+(a2-b2)+...
   mov ax, mas[si]
   add si, 2
   
   sub ax, mas[si]       
   jo Error4
   add ax, Summa
   jo Error4
   mov Summa, ax
   
   add si, 2
   cmp si, len1
   jge End    
                  
   jmp go       
End:         
     mov ax, Summa
     mov cx, perepol
     ret       
     
KolvoElem db 'Pls vvedite kolov chisel: $'
Message db 'Pls enter number: $'   
showError db 10,13,"Error!$",10,13
  massiv db 10,13,"Pls enter number: $" 
  MesOverflow db 10,13,"Overflow!$",10,13  
  perepol dw 0
  negative dw 1
  
  len dw 0 ; razmer massiva  ;0
  len1 dw 0                  ;0
  Summa dw 0               ;0
  mas dw 0                   ;0