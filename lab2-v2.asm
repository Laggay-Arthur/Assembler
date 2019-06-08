org 100h    

    mov ax,2
    imul len
    mov len1, ax
    
start:
    mov dx,offset Message
    mov ah,9
    int 21h 
   
a:
    mov ah, 01h	
    int 21h

    cmp al, 2dh   ;proverka na minus
    je nega
    cmp al, 2fh   ;proverka na enter 
    jl output
    
    cmp al, 30h   ; from 0
    jl error
    cmp al, 39h   ; to 9
    ja error
    
    sub al,30h     ; perevod simvola v chislo
    xor ah, ah
    xchg ax, bx
    mov dx,0Ah  
    mul dx	
    jo error1       ; umnozhenie na osnovanie sistemi schislenia(10)
    
    add bx,ax
    jo error1	
    
loop a  
    
output:
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
    
    mov dx,offset zmassiv
    mov ah,9
    int 21h
      
    jmp a     
    
nega:
    mov negative, -1
    jmp a   
    
error:
    mov dx,offset showError        ; error   db  'Symbol not correct!$'
    mov ah,9
    int 21h

    jmp start 
    
Work:   

    mov si,len1 
    mov bx, 0;mas[si]
    sub si,2 ; berem sled element
loop2:
    cmp mas[si],0   ; si - registr  dlya indexa massiva
    jng z  
    Z1:  
    cmp si,-1
    jl End   
    
    cmp bx, mas[si]
    jge  metka       ; bx >= mas[si] 
    mov bx, mas[si]  ; zapisivaem min element  
    
metka:
     jo error2
     sub si,2 ; berem sled element
     
loop loop2 
   
z:
neg mas[si] 
jmp Z1 
 
error1:
mov dx, offset MesOverflow
mov ah, 9
int 21h
jmp start 

error2:
mov dx, offset MesOverflow
mov ah, 9
int 21h
ret
 
End:
ret  


Message db 'Pls enter number: $'   
showError db 10,13,"Error!$",10,13
  zmassiv db 10,13,"Pls enter number: $"  
  MesOverflow db 10,13,"Overflow!$",10,13
  negative dw 1 
  len dw 4 ; razmer massiva 
  len1 dw 0
  mas dw 0
  