include macros.mac
include timer.mac
include macros15.mac

movAvi macro
	push ax
	push dx
	push bx
	mov	bx, 00h
	mov ax, 00h
   	mov	ah, 02
   	mov bh, 00h
	int	10h			; seta a posicao correta
	;PRNstr aviao0
	PRNstr [Aviao.aviao0]
	
	inc		dh		;incrementa a coordenada do cursor
	mov bh, 00h
	int		10h		;muda a posição do cursor
	PRNstr [Aviao.aviao1]
	
	inc		dh		;incrementa a coordenada do cursor
	mov bh, 00h
	int		10h		;muda a posição do cursor
	PRNstr [Aviao.aviao2]
	


	
	pop	bx   
	pop	dx
	pop	ax
	
	endm
movIniBaixo macro temp; variavel temp corresponde a temporização do movimento do inimigo
	push ax
	push dx
	push bx
	
	
inimMov:	
	mov	bx, 00h
	mov ax, 00h
   	mov	ah, 02
	int	10h			; seta a posicao correta
	
	;PRNstr aviao0
	PRNstrMod [Inimigo.inimigo0]
	
	 
	inc		dh		;incrementa a coordenada do cursor
	
		
	int		10h		;muda a posição do cursor
	PRNstrMod [Inimigo.inimigo1]	 
	inc		dh		;incrementa a coordenada do cursor
	
	
	int		10h		;muda a posição do cursor
	PRNstrMod [Inimigo.inimigo2] 	
	
	
	inc dh
	
	cmp dh, 25d ; verificando as bordas.. se passou nao deixa mover
	jge fimIni
	
	mov ax,temp
	waitms ax
	
	push dx
	CLRInimFrente dh,dl ;macro pra apagar a posição atual do Inimigo
	pop dx
	
	
	jmp inimMov
	
	fimIni:
		
	push dx
	CLRInimFrente dh,dl ;macro pra apagar a posição atual do Inimigo
	pop dx
	
	pop	bx   
	pop	dx
	pop	ax
	
	endm

movPredio macro 
	push ax
	push dx
	push bx
	
PredioMov:

	mov	bx, 00h
	mov ax, 00h
   	mov	ah, 02
	int	10h		

	setPredioLateral dh,dl ; Predio lateral na posição x=dh+1 y=0d
	add	dl, 25d
	int		10h
	setPredioLateral dh,dl ; Predio lateral na posição x=dh+1 e y=25d
	
	add	dl, 25d
	int		10h
	setPredioLateral dh,dl ; Predio lateral na posição x=dh+1 e y=50d
	
	mov dl , 0d
	inc		dh
	int		10h
	
	cmp dh, 15d
	je aviini
	jmp passou1
		aviini: 
			push dx
			mov dh, 0d
			mov dl, 16d
			call set_Inimigo_pos								
			movIniBaixo 1000; Inimigo desloca-se para baixo com temporização do movimento em 10 ms
			pop dx
	passou1:
		
	cmp dh, 23d ; verificando as bordas.. se passou nao deixa mover
	jge fimPredio
	
	
	waitms 1000
	
;CLRInim dh,dl ;macro pra apagar a posição atual do Predio
jmp PredioMov

	
	fimPredio:
;CLRInim dh,dl ;macro pra apagar a posição atual do Predio


	pop	bx   
	pop	dx
	pop	ax
	
	
	
	
endm

setPredioLateral macro

	push ax
	push dx
	push bx
	mov	bx, 00h
	mov ax, 00h
   	mov	ah, 02
	int	10h			; seta a posicao correta
	;PRNstr PredioLateral
	PRNstr [PredioL.predio0]
	inc		dh		;incrementa a coordenada do cursor
	int		10h		;muda a posição do cursor
	PRNstr [PredioL.predio1]
	inc		dh		;incrementa a coordenada do cursor
	int		10h		;muda a posição do cursor	
	pop	bx   
	pop	dx
	pop	ax
	
endm


        .model medium
        .stack 100h
	.data
		
Aviao_struc Struc  
aviao0 db 0d, 30d, 0d,  '$'
aviao1 db 0d, 219d,  0d, '$'
aviao2 db 219d, 219d, 219d, '$'
apos_x db ?
apos_y db ?
Aviao_struc Ends 

Aviao Aviao_struc <>

Inimigo_struc Struc
inimigo0 db 219d, 219d,  219d, '$'
inimigo1 db 0d, 219d,  0d, '$'
inimigo2 db 0d, 31d, 0d, '$'
ipos_x db ?
ipos_y db ?
Inimigo_struc ends
Inimigo Inimigo_struc <>


Prediolateral_struc Struc
predio0 db 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d,219d, 219d, 219d, '$'
predio1 db 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d,219d, 219d, 219d, '$'
plpos_x db ?
plpos_y db ?	
Prediolateral_struc ends

PredioL Prediolateral_struc <>




;LIVE db 3 ; Valor inicial de vezes que o jogador podera continuar jogando
PONT db 0 ; Posicao da memoria para armaznar a pontuacao

tiro db 15d, '$'
branco db	0d, '$'
atirou db 0h

        .code
		
set_Predio_pos proc near

	mov [PredioL.plpos_y], dh
	mov [PredioL.plpos_x], dl	
	
	ret
set_Predio_pos endp		

atualiza_pos_aviao proc near
		mov [aviao.apos_y], dh
		mov [aviao.apos_x], dl
		ret
atualiza_pos_aviao endp

set_Inimigo_pos proc near		
		mov [inimigo.ipos_y], dh
		mov [inimigo.ipos_x], dl	
	ret

set_Inimigo_pos endp

CLRaviao proc near 
        push    ax
        push    bx
        push    cx
        push    dx
	mov dh, [aviao.apos_y]
	mov dl, [aviao.apos_x]
	dec dh
	dec dh
	dec dl
	dec dl
	CLRPoint dh,dl
	inc dh
	CLRPoint dh,dl
	inc dh
	inc dl
	CLRPoint dh,dl
	dec dl
	CLRPoint dh,dl
	dec dl
	CLRPoint dh,dl	
	dec dl
	CLRPoint dh,dl

	pop dx
	pop cx
	pop bx
	pop ax
	
	ret
CLRaviao endp

proc_movTir proc near
	push    ax
	push    bx
	push    cx
	push    dx		
	mov [atirou], 1h
	mov	bx, 9Fh
	mov ax, 00h
	dec dh
	inc dl
lp1:
   	mov	ah, 02
	int	10h			; seta a posicao correta
	PRNstr tiro
	dec		dh		;incrementa a coordenada do cursor
	cmp 	dh, 0h
	jb		emt
	
segue:	
	waitms	50
	CLRPoint dh, dx	
	
	mov ah, 01h  ;checa o buffer do teclado
	int 16h
		
	jnz segue1
	jz ir_fim
segue1:
	cmp dh,0h	
	jge		lp1
	jmp emt	
ir_fim:
	jmp t1	
emt:
	CLRPoint dh, dx		
	mov [atirou], 0h	
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    
    ret		 
proc_movTir	endp

;Random proc near
;	ret

;Random endp



; procedimento para mostrar inimigos na tela
;invocar_inimigo proc near


;novodesafio:
;	call Random Qual desafio será mostrado
;	cmp 
;jmp desafio1:
;jmp desafio2:

;			desafio1:
;			mov dh, 0d
;			mov dl, 0d
;			call set_Predio_pos
;			movPredio dh,dl	

			
;			mov dh, 0d
;			mov dl, 0d	
;			call set_Inimigo_pos								
;			movIniBaixo  2d, 11d , 10 ; Inimigo desloca-se a em diagonal esquerda com inclemento de 2
								  ; com temporização do movimento em 10 ms
;			jmp novodesafio 	
		
;			desafio2:
	
	
;			mov dh, 0d
;			mov dl, 25d
;			call set_Predio_pos
;			movPredio dh,dl
			
				
;			jmp novodesafio
	
;	ret

;invocar_inimigo endp





INICIO	proc	far
		inicia
	

		CLRSCR 9Fh 		; limpa a tela
		
		
		gotoxy 0,0
		print 'River Raid por: '

		gotoxy 1,0
		print 'Marcos Aurelio',

		gotoxy 2,0
		print 'Thiago Souza'

		gotoxy 3,0
		print 'Thulio Costa'

; Aguarde enquanto a tecla Enter nao for pressionada

		gotoxy 8,10
		print 'Pressione a tecla Enter'
		
		gotoxy 9,10
		print 'pra comeca a jogar.'
		
aguarde:
		mov ah, 00h
		int 16h
		cmp al,0Dh
		je  come
		jmp aguarde ; Aguardo pressionar a tecla ENTER         
          

come: 					; iniciando o jogo
	 

   		CLRSCR 9Fh
   		
   		mov	dh, 22d
   		mov dl, 36d
		call atualiza_pos_aviao		
		movAvi dh, dl
		
				
		
		
			;mov dh, 0d
			;mov dl, 0d
			;call set_Predio_pos
			;movPredio dh,dl	
			
		
				
		;mov dh, 0d
		;mov dl, 25d
	
		;call set_Inimigo_pos
		
						
		;movIniBaixo 1000 ; Inimigo desloca-se para baixo com temporização do movimento em 10 ms	
		
		
		
		;Codigo pra depuração
		;aguar:
		;mov ah, 00h
		;int 16h
		;cmp al,0Dh
		;je  inic
		;jmp aguar ; Aguardo pressionar a tecla ENTER    
        ;inic: ; iniciando o jogo

		
		
		

				
t1:		
		
		;cmp [atirou], 1h
		;je ir
				
		mov ah, 00h		; rotina para movimentar o aviao
		int 16h			
		
		;Verificar tiro
						
		; captura a tecla do teclado
		cmp	ah, 48h
		je	cima
		cmp	ah, 50h
		je	baix
		cmp	ah, 4dh
		je	dire
		cmp	ah, 4bh
		je	esqu
		cmp	ah, 39h		; barra de espaco eh um tiro
		je  atir
		cmp	ah, 01h		; esq sai do jogo
		je	afim
		
		;cmp [atirou], 1h
		;je lp1		
		
		jmp t1		; se nao casar com nada volta para o  inicio do loop
		
afim:
	 	jmp fim

dire:	cmp dl, 76d	; verificando as bordas.. se passou nao deixa mover
		jge	t1
		inc	dl
		call atualiza_pos_aviao
		;mov ah, 0h
		jmp desen	; desenha o aviao

esqu:	cmp dl, 0d	; verificando as bordas.. se passou nao deixa mover
		jbe	t1
		dec	dl
		call atualiza_pos_aviao
		;mov ah, 0h
		jmp desen	; desenha o aviao

cima:	cmp dh, 0d	; verificando as bordas.. se passou nao deixa mover
		jbe	t1
		dec	dh
		call atualiza_pos_aviao
		;mov ah, 0h
		jmp desen	; desenha o aviao

baix:	cmp dh, 22d	; verificando as bordas.. se passou nao deixa mover
		jge	t1
		call atualiza_pos_aviao
		inc	dh
		;mov ah, 0h
		jmp desen	; desenha o aviao

atir:	
		
		call proc_movTir
		;mov ah, 0h
		jmp	t1
				
desen:	
		CLRSCR 9Fh
		;call CLRAviao
		call atualiza_pos_aviao	
		movAvi
		;mov ah, 0h		
		jmp	t1		
		
		;configura obstaculos
		;mov	dh, 10d
   		;mov dl, 10d
		;call set_Predio_pos ; coloca procedimento randon


fim:
		termina

inicio	endp
	end	inicio









