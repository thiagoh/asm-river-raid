include macros.mac
include timer.mac
include macros15.mac

movAvi macro
       push ax
       push dx
       push bx
       mov     bx, 00h
       mov ax, 00h
       mov     ah, 02
       mov bh, 00h
       mov dh, Aviao.y
       mov dl, Aviao.x
       int     10h                     ; seta a posicao correta
       ;PRNstr aviao0
       PRNstr [Aviao.aviao0]
       inc             dh              ;incrementa a coordenada do cursor
       mov bh, 00h
       int     10h                     ;muda a posição do cursor
       PRNstr [Aviao.aviao1]

       inc             dh              ;incrementa a coordenada do cursor
       mov bh, 00h
       int             10h             ;muda a posição do cursor
       PRNstr [Aviao.aviao2]
       pop     bx
       pop     dx
       pop     ax

       endm

CLRAviao macro

	     push    ax
	     push    bx
	     push    cx
	     push    dx

         mov     bx, 00h
         mov     ax, 00h
         mov     ah, 02
         mov bh, 00h
         mov dh, Aviao.y
         mov dl, Aviao.x
         int     10h                     ; seta a posicao correta

         PRNstr [Aviao.claviao0]
         inc             dh              ;incrementa a coordenada do cursor
         mov bh, 00h
         int     10h                     ;muda a posição do cursor
         PRNstr [Aviao.claviao1]

         inc     dh              ;incrementa a coordenada do cursor
         mov     bh, 00h
         int             10h             ;muda a posição do cursor
         PRNstr [Aviao.claviao2]

         pop     dx
	     pop     cx
	     pop     bx
 	     pop     ax
       endm

CLRInim macro

	     push    ax
	     push    bx
	     push    cx
	     push    dx

         mov     bx, 00h
         mov     ax, 00h
         mov     ah, 02
         mov bh, 00h
         mov dh, Inimigo.ipos_y
         mov dl, Inimigo.ipos_x
         dec dh
         int     10h                     ; seta a posicao correta

         PRNstr [Aviao.claviao0]

         pop     dx
	     pop     cx
	     pop     bx
 	     pop     ax
       endm


movTir macro
       push    ax
       push    bx
       push    cx
       push    dx

       mov     bx, 9Fh
       mov ax, 00h

       mov dh, [tiro.t_y]
       mov dl, [tiro.t_x]

       CLRPoint

       dec dh
       mov [tiro.t_y], dh
       mov [Aviao.atirou], dh

       inc dl

       mov     ah, 02
       int     10h                     ; seta a posicao correta
       PRNstr tiroDes
       dec             dh              ;incrementa a coordenada do cursor

       waitms  50
       ;waitms 50
       ;CLRPoint dh, dx


       CLRPoint dh, dx

   pop     dx
   pop     cx
   pop     bx
   pop     ax
       endm


movIniBaixo macro ; variavel temp corresponde a temporização do movimento do inimigo
       push ax
       push dx
       push bx
       mov dh, [inimigo.ipos_y]
       mov dl, [inimigo.ipos_x]
       mov     bx, 00h
       mov ax, 00h
       mov     ah, 02
       int     10h                     ; seta a posicao correta
       PRNstr [Inimigo.inimigo0]
       inc             dh              ;incrementa a coordenada do cursor

       waitms 50

       mov [inimigo.ipos_y], dh
       push dx
       ;CLRInimFrente dh,dl ;macro pra apagar a posição atual do Inimigo
       pop dx
       pop     bx
       pop     dx
       pop     ax

       endm

setPredioLateral macro

       push ax
       push dx
       push bx
       mov     bx, 00h
       mov ax, 00h
       mov     ah, 02
       int     10h                     ; seta a posicao correta
       ;PRNstr PredioLateral
       PRNstr [PredioL.predio0]
       inc             dh              ;incrementa a coordenada do cursor
       int             10h             ;muda a posição do cursor
       PRNstr [PredioL.predio1]
       inc             dh              ;incrementa a coordenada do cursor
       int             10h             ;muda a posição do cursor
       pop     bx
       pop     dx
       pop     ax

endm
set_pos_inimigo macro
               mov [inimigo.ipos_y], 0h
               push cx
               mov ch, [random]
               mov [inimigo.ipos_x], ch
               pop cx
endm

randomgen macro
       push cx
       push dx
       mov dh ,[aviao.y]
       mov ch, [aviao.x]
       ;add ch, dh
       and ch, 36d
       mov [random], ch
       pop dx
       pop cx
       endm


.model medium
       .386
.stack 100h
.data


random db 0d
Tiro_struc Struc
t_y db 0h
t_x db 0h
Tiro_struc Ends

Aviao_struc Struc

aviao0 db 0d, 30d, 0d,  '$'
aviao1 db 0d, 219d,  0d, '$'
aviao2 db 219d, 219d, 219d, '$'

claviao0 db 0d, 0d, 0d,  '$'
claviao1 db 0d, 0d, 0d, '$'
claviao2 db 0d, 0d, 0d, '$'

x db 0h
y db 0h
atirou db 0h
Aviao_struc Ends

tiro Tiro_struc <>

bufferPreenchido db 0d
tecla db 0h

Aviao Aviao_struc <>

Inimigo_struc Struc
inimigo0 db 219d, 219d,  219d, '$'
inimigo1 db 0d, 219d,  0d, '$'
inimigo2 db 0d, 31d, 0d, '$'
ipos_x db ?
ipos_y db ?
ativo db 0h
Inimigo_struc ends

Inimigo Inimigo_struc <>


Prediolateral_struc Struc
predio0 db 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d,219d,219d, 219d, '$'
predio1 db 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d,219d,219d, 219d, '$'
plpos_x db ?
plpos_y db ?
Prediolateral_struc ends

PredioL Prediolateral_struc <>




;LIVE db 3 ; Valor inicial de vezes que o jogador podera continuar jogando
PONT db 0 ; Posicao da memoria para armaznar a pontuacao

tiroDes db 15d, '$'
branco db       0d, '$'
vida db 3d
flagInimigo dd 0d

       .code

set_Predio_pos proc near

       mov [PredioL.plpos_y], dh
       mov [PredioL.plpos_x], dl

       ret
set_Predio_pos endp

atualiza_pos_aviao proc near
               mov [aviao.y], dh
               mov [aviao.x], dl
               ret
atualiza_pos_aviao endp

INICIO  proc    far
               inicia


               CLRSCR 9Fh              ; limpa a tela


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


come:                                   ; iniciando o jogo

               CLRSCR 9Fh

               mov [Aviao.y], 22d
               mov [Aviao.x], 36d
               randomgen
               push cx
               mov ch, [random]
               set_pos_inimigo
               mov [inimigo.ativo] , 1h
               pop cx
               ;CLRAviao
               movAvi

t1:
               cmp [inimigo.ipos_y], 24d
               jb cont_t1
               randomgen
               push cx
               mov ch, [random]
               set_pos_inimigo
               pop cx
cont_t1:
               mov ah, 01h             ; rotina para movimentar o aviao
               int 16h
               jz      bnpr
               jnz bpr

bnpr:                                   ; buffer nao preenchido
               mov bufferPreenchido, 0d
               jmp     verAt
bpr:                                    ; buffer preenchido
               mov ah, 0h
               int 16h
               push ax                 ;guarda a tecla no topo da pilha
               mov bufferPreenchido, 1d

verAt:                                                  ; verifica se o aviao atirou
               cmp [Aviao.atirou], 0h  ; se existe um tiro para ser desenhadopular para a rotina que desenha o resto do tiro
               jne     desT3
               jmp t4

desT3:
               push cx
               mov ch, [tiro.t_x]
               cmp [inimigo.ipos_x], ch
               je testa_colisao_tiro
               pop cx
               movTir

t4:
               cmp [inimigo.ipos_y] , 24d ; checa se o inimigo ainda estah na tela
               jge fim_t4
               mov ah, 02h
               int 1ah
               mov ax, 00h
               mov al, dh
               mov bl, 00h
               mov bl, 03d
               div bl
               cmp ah, 0d
               je tI2
               jmp tI1
tI1:
               mov ah, 02h
               int 1ah
			   mov ax, 00h
               mov al, dh
               mov bl, 00h
               mov bl, 02d
               div bl
               cmp ah, 0d
			   je tZ1
			   jmp fim_t4
	tZ1:
		       mov [flagInimigo], 0d
			   jmp fim_t4
tI2:
  			   cmp [flagInimigo], 0d
			   jne tI1
			   inc [flagInimigo]
			   ;print "bbbbbbbbb "
			   CLRInim
               movinibaixo
               push cx
               mov ch, [aviao.y]
               cmp [inimigo.ipos_y], ch ; checa se houve colisao entre o aviao e o inimigo
               pop cx
               je colisao1
fim_t4:
               cmp bufferPreenchido, 1d
               je goon
               jmp t1

               ;Verificar tiro
goon:
               ; captura a tecla do teclado
               pop ax                  ; recupera a tecla no topo da pilha
               cmp     ah, 48h
               je      cima
               cmp     ah, 50h
               je      baix
               cmp     ah, 4dh
               je      dire
               cmp     ah, 4bh
               je      esqu
               cmp     ah, 39h         ; barra de espaco eh um tiro
               je  atir
               cmp     ah, 01h         ; esq sai do jogo
               je      afim
               mov     ax, 00h         ; limpa a tecla
               jmp t1

afim:
               jmp fim

desT1:
               jmp desT2

cima:          cmp [Aviao.y], 0d       ; verificando as bordas.. se passou nao deixa mover
               jbe     t2
               CLRAviao
               dec     [Aviao.y]
               jmp desen       ; desenha o aviao

t2:
               jmp t1


baix:   cmp [Aviao.y], 22d      ; verificando as bordas.. se passou nao deixa mover
               jge     t2
               CLRAviao
               inc     [Aviao.y]
               jmp desen       ; desenha o aviao

dire:   cmp [Aviao.x], 76d      ; verificando as bordas.. se passou nao deixa mover
               jge     t2
               CLRAviao
               inc     [Aviao.x]
               jmp desen       ; desenha o aviao

esqu:   cmp [Aviao.x], 0d       ; verificando as bordas.. se passou nao deixa mover
               jbe     t2
               CLRAviao
               dec     [Aviao.x]
               jmp desen       ; desenha o aviao

atir:
               cmp [Aviao.atirou], 0h
               jne t2
               mov dh, [Aviao.y]                       ; essa e as proximas 3 linhas setam o x e y do tiro
               mov dl, [Aviao.x]
               mov [tiro.t_y], dh
               mov [tiro.t_x], dl
               mov [Aviao.atirou], dh          ; flag que diz que existe um tiro corrente(o valor eh o y do aviao)
               movTir
               push cx
               mov ch, [tiro.t_y]
               cmp [inimigo.ipos_y], ch ; checa se as coordenadar Y do tiro e do inimigo sao iguais
               pop cx
               je testa_colisao_tiro ; caso positivo checa as coordenadas X
               jmp     t2


desen:
               ;CLRSCR 9Fh
               movAvi
               cmp [inimigo.ipos_y] , 24d
               jge fim_desen
               ;movinibaixo
fim_desen:

               jmp     t2

desT2:
               movTir
               jmp t2          ; se nao casar com nada volta para o  inicio do loop
colisao1:
               push cx
               mov ch, [aviao.x]
               cmp [inimigo.ipos_x], ch
               pop cx
               je game_over
               jmp t2
perde_vida:

             cmp [vida], 1d
             je game_over
             sub [vida], 1d
             jmp t2

testa_colisao_tiro:
       push cx
       mov ch, [inimigo.ipos_x]
       cmp [tiro.t_x], ch ; checa se as coordenadas X do tiro e do inimigo sao iguais
       pop cx
       je acertou ; ACERTOU!
       jmp atir

acertou:
       push dx
       push cx
       mov dh, [Inimigo.ipos_x]
       mov dl, [Inimigo.ipos_y]
       CLRInim
       pop cx
       pop dx
       mov [Inimigo.ipos_x], 16d
       mov [Inimigo.ipos_y], 25d
       jmp cont_t1

game_over:
             CLRSCR 03h
             PRINT 'PERDEU!'

fim:
               termina

inicio  endp
       end     inicio