
org 100h

main: 
     xor cx,cx
     mov ax, a
     mov si, 3
     imul si 
     jo inc_cx
     mov di,ax
     
     mov ax,16
     mov si,4
     imul si
     jo inc_cx
     
     sub di, ax 
     mov ax,di
     jo inc_cx
     
     mov bx,d 
     mov dx,b
     sub bl,dl
     cmp bx,0
     jz exit
     
     mov ax,di
     idiv bl
     jo inc_cx
     
     int 20h
     
     inc_cx :
     inc cx
     ret
     
exit:
ret
     a dw 30
     b dw 5
     d dw 10


