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

       ;CLRPoint

       dec dh
       mov [tiro.t_y], dh
       mov [Aviao.atirou], dh

       inc dl

       mov     ah, 02
       int     10h                     ; seta a posicao correta
       PRNstr tiroDes
       dec             dh              ;incrementa a coordenada do cursor

       waitms  50

       CLRPoint

       pop     dx
       pop     cx
       pop     bx
       pop     ax
       endm


movBom macro
       push    ax
       push    bx
       push    cx
       push    dx

       mov     bx, 9Fh
       mov ax, 00h

       mov dh, [bomba.b_y]
       mov dl, [bomba.b_x]
       mov ch, 0d
       mov cl, dh
boml1:
       dec dh
       mov [bomba.b_y], dh

       mov     ah, 02
       int     10h                     ; seta a posicao correta
       PRNstr bombaDes
       dec     dh              ;incrementa a coordenada do cursor
       waitms  30
       CLRBom
       inc   dh
       loop boml1

       pop     dx
       pop     cx
       pop     bx
       pop     ax
       endm

CLRbom macro

	     push    ax
	     push    bx
	     push    cx
	     push    dx

         mov     bx, 00h
         mov     ax, 00h
         mov     ah, 02
         mov bh, 00h
         mov dh, [bomba.b_y]
         mov dl, [bomba.b_x]

         int     10h                     ; seta a posicao correta

         PRNstr cbomba

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

       pop     dx
       pop     bx
       pop     dx
       pop     ax

       endm

movIniMesmoLocal macro ; variavel temp corresponde a temporização do movimento do inimigo
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

       waitms 50

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

       push ax
       push cx
       push dx

       mov dh ,[aviao.y]
       mov ah, 02h
       int 1ah

       mov al, 02d       ;fazendo dh * dh
       mul dh

       mov ch, al

       and ch, 00111111b ; fazer um and com 63 para nao passar da ultima coluna

       mov [random], ch

       pop dx
       pop cx
       pop ax
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

tiro Tiro_struc <>

Bomba_struc Struc
b_y db 0h
b_x db 0h
Bomba_struc Ends

bomba Bomba_struc <>

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


bufferPreenchido db 0d
tecla db 0h

pontos db 0d
bombas db 3d

Aviao Aviao_struc <>

Inimigo_struc Struc
inimigo0 db 123d, 2d,  125d, '$'
inimigo1 db 0d, 219d,  0d, '$'
inimigo2 db 0d, 31d, 0d, '$'
ipos_x db ?
ipos_y db ?
ativo db 0h
Inimigo_struc ends

Inimigo Inimigo_struc <>


linhaDebug db 35d, 35d, 35d, '$'

Prediolateral_struc Struc
predio0 db 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d,219d,219d, 219d, '$'
predio1 db 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d, 219d,219d,219d, 219d, '$'
plpos_x db ?
plpos_y db ?
Prediolateral_struc ends

PredioL Prediolateral_struc <>


gameOver db '       GAME OVER!!!!!!!!!', '$'

strPontos db '       Sua pontuacao foi: ', '$'

;LIVE db 3 ; Valor inicial de vezes que o jogador podera continuar jogando
PONT db 0 ; Posicao da memoria para armaznar a pontuacao



tiroDes db 15d, '$'
bombaDes db 78 dup (15d), '$' ;
cbomba db 78 dup(0d), '$';
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
               print 'Thiago de Andrade Souza - thiagoh',

               gotoxy 2,0
               print 'Marcos Aurelio'

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
               movAvi
               randomgen                ;gerar posicao do inimigo
               set_pos_inimigo          ;setar a posicao do inimigo
               movIniBaixo              ;desenhar o inimigo
cont:
               mov ah, 01h             ; rotina para movimentar o aviao
               int 16h
               jz  bnpr
               jnz bpr

bnpr:                                   ; buffer nao preenchido
               mov bufferPreenchido, 0d
               jmp verAtMovInim      ; verificar se existe um tiro e mover o inimigo
bpr:                                    ; buffer preenchido
               mov ah, 0h
               int 16h
               push ax                 ;guarda a tecla no topo da pilha
               mov bufferPreenchido, 1d

verAtMovInim:                                                  ; verifica se o aviao atirou
               cmp [Aviao.atirou], 0h  ; se existe um tiro para ser desenhadopular para a rotina que desenha o resto do tiro
               jne bGoonTir            ; before go on mover tiro
               jmp movInim             ; mover inimigo

bGoonTir:
               movTir
               push dx
               mov dh, [tiro.t_y]
               cmp [inimigo.ipos_y], dh
               pop  dx
               jge  bNovoInim
               jmp movInim;

bNovoInim:                            ; before novo inimigo ( se o tiro bateu, desenhar outro inimigo)
               ;movIniMesmoLocal
               push dx
               mov dh, [tiro.t_x]
               cmp [inimigo.ipos_x], dh
               pop  dx
               je  pontoGanho
               jmp movInim;

pontoGanho:
               add [pontos], 10d
               jmp novoInim

novoInim:                               ;rotina de novo inimigo
               CLRInim                  ; apagar o antigo
               randomgen                ;gerar posicao do inimigo
               set_pos_inimigo          ;setar a posicao do inimigo
               movIniBaixo              ;desenhar o inimigo
               jmp bGoon                ;before go on


movInim:

               mov ah, 02h               ; pega a hora
               int 1ah
               mov ax, 00h
               mov al, dh                ; dh tem os segundos
               mov bl, 00h
               mov bl, 02d               ; se for multiplo de 2
               div bl
               cmp ah, 0d
               je verifMover
               jmp bGoon                ;before go on

verifMover:                             ; verifica se o aviao foi movido no periodo curto de tempo
               cmp [flagInimigo], 0d
               je  moverMesmo
               mov ah, 02h               ; pega a hora
               int 1ah
               mov ax, 00h
               mov al, dh                ; dh tem os segundos
               mov bl, 00h
               mov bl, 03d               ; se for multiplo de 3
               div bl
               cmp ah, 0d
               je  flagIni0              ; a cada 3 segundo sega a flag para 0
               jmp bGoon

moverMesmo:
               inc [flagInimigo]
               jmp movIniRot2              ; mover o inimigo


movIniRot2:                             ; rotina que movimenta o inimigo
               CLRInim
               movIniBaixo
               cmp [inimigo.ipos_y], 22d  ; se o inimigo estiver la embaixo matar este e desenhar outro
               jge verBateuAvi2               ;rotina que verifica se o inimigo bateu no aviao
               jmp bGoon                ;before go on

verBateuAvi2:                               ;rotina que verifica se o inimigo bateu no aviao
               push ax
               mov  al, [aviao.x]
               cmp  [inimigo.ipos_x], al
               pop  ax
               je   bateuAvi2
               jmp novoInim2

bateuAvi2:
               mov  ah, 02h
               mov  dh, 23d
               mov  al, [aviao.x]
               mov  dl, al
               int 10h
               prnstr linhaDebug
               waitms 1000

               dec [vida]             ; o aviao perde uma vida.. quando perder as 3 morre
               mov [bombas], 3d
               cmp [vida], 0d
               je afim

               jmp novoInim2
               ;jmp novoInim2          ;depois que bateu redesenhar o inimigo

novoInim2:                               ;rotina de novo inimigo
               CLRInim                  ; apagar o antigo
               randomgen                ;gerar posicao do inimigo
               set_pos_inimigo          ;setar a posicao do inimigo
               movIniBaixo              ;desenhar o inimigo
               jmp bGoon                ;before go on

flagIni0:
               mov [flagInimigo], 0d    ; seta a flag para o inimigo poder se movimentar da proxima vez
               jmp bGoon

bGoon:
               cmp bufferPreenchido, 1d
               je goon
               jmp cont

               ;Verificar tiro
goon:
               ; captura a tecla do teclado
               pop ax                  ; recupera a tecla no topo da pilha
               cmp     ah, 30h         ; solta bomba
               je      bomb
               cmp     ah, 48h
               je      cima
               cmp     ah, 50h
               je      baix
               cmp     ah, 4dh
               je      dire
               cmp     ah, 4bh
               je      esqu
               cmp     ah, 39h         ; barra de espaco eh um tiro
               je      atir
               cmp     ah, 01h         ; esq sai do jogo
               je      afim
               mov     ax, 00h         ; limpa a tecla
               jmp cont

afim:
               jmp fim

desT1:
               jmp desT2

bomb:
               cmp [bombas], 0d
               jbe semBomb
               dec [bombas]
               ;print "bomba!"
               mov dh, [aviao.y]
               mov dl, [aviao.x]
               mov [bomba.b_y], dh
               mov [bomba.b_x], 0d
               movBom
               ;waitms 1000
               jmp pontoGanho
semBomb:
               jmp desen

cima:          ;cmp [Aviao.y], 0d       ; verificando as bordas.. se passou nao deixa mover
               ;jbe at2
               ;CLRAviao
               ;dec     [Aviao.y]
               jmp movIniRot
               ;jmp desen       ; desenha o aviao

at2:                                   ; atalho 2
               jmp cont

movIniRot:                              ; rotina que movimenta o inimigo
               CLRInim
               movIniBaixo
               cmp [inimigo.ipos_y], 22d  ; se o inimigo estiver la embaixo matar este e desenhar outro
               jge verBateuAvi               ;rotina que verifica se o inimigo bateu no aviao
               jmp desen

verBateuAvi:                               ;rotina que verifica se o inimigo bateu no aviao
               push ax
               mov  al, [aviao.x]
               cmp  [inimigo.ipos_x], al
               pop  ax
               je   bateuAvi
               jmp novoInim

bateuAvi:
               mov  ah, 02h
               mov  dh, 23d
               mov  al, [aviao.x]
               mov  dl, al
               int 10h
               prnstr linhaDebug
               waitms 1000

               dec [vida]        ; o aviao perde uma vida.. quando perder as 3 morre
               mov [bombas], 3d
               cmp [vida], 0d
               je afim
               ;jmp desen
               jmp novoInim

baix:   cmp [Aviao.y], 22d      ; verificando as bordas.. se passou nao deixa mover
               jge at2
               CLRAviao
               inc     [Aviao.y]
               jmp desen       ; desenha o aviao

dire:   cmp [Aviao.x], 76d      ; verificando as bordas.. se passou nao deixa mover
               jge at2
               CLRAviao
               inc     [Aviao.x]
               jmp desen       ; desenha o aviao

esqu:   cmp [Aviao.x], 0d       ; verificando as bordas.. se passou nao deixa mover
               jbe at2
               CLRAviao
               dec     [Aviao.x]
               jmp desen       ; desenha o aviao

atir:
               cmp [Aviao.atirou], 0h
               jne at2
               mov dh, [Aviao.y]                       ; essa e as proximas 3 linhas setam o x e y do tiro
               mov dl, [Aviao.x]
               mov [tiro.t_y], dh
               mov [tiro.t_x], dl
               mov [Aviao.atirou], dh          ; flag que diz que existe um tiro corrente(o valor eh o y do aviao)
               movTir
               jmp  at2

desen:
               ;CLRSCR 9Fh
               movAvi
               jmp at2

desT2:
               movTir
               jmp at2          ; se nao casar com nada volta para o  inicio do loop

fim:
               CLRSCR 3h
               mov  ah, 02h
               mov  dh, 20d
               mov  dl, 23d
               int 10h
               prnstr gameOver
               mov  ah, 02h
               mov  dh, 21d
               mov  dl, 23d
               int 10h
               prnstr strPontos
               PRN8BT pontos
               waitms 8000
               termina

inicio  endp
       end     inicio