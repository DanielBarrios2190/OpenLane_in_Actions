addi s0, zero, 1 #0
addi s5, zero, 8 #Verde (secs)
addi s6, zero, 15 #Rojo (secs)
addi s9, zero, 16 #Alarma (secs)
addi s7, zero, 1  
addi s8, zero, 1 
#14.1n por ciclo, 1 sec = 3F940A8 ciclos
lui s1, 0x043A3 
addi s1, s1, 0xFFFFFF04 
#s1 numero de ciclos por segundo

start:lw t0, 0x102(zero) #Leo sensor a t0
beq t0, s0, cero #Si boto un valor
j start #Si es 0 

cero: addi t4, zero, 0 
addi t5, zero, 0 
sw t5, 0xFF(zero) #Poner zero en LEDS
sw s0, 0xFE(zero) #Pasar azul LED1
sw s0, 0xFD(zero) #Pasar azul LED2

cont: addi t4, t4, 4 #t4 + 4 contador de ciclos
beq t4, s1, masuno 
lw t0, 0x102(zero) #Volver  a leer t0
beq t0, s0, cont 
j start #Dejar de contar



masuno: addi t5, t5, 1 #t5 + 1 contador de secs
sw t5, 0xFF(zero)
beq t5, s5, verde #Si ya pasaron 8 secs
beq t5, s6, rojo #Si ya pasaron 15 secs
beq t5, s9, end #Acabar post 15 secs

j otro
verde: addi s7, zero, 2
addi s8, zero, 2
j otro
rojo: addi s7, zero, 4
addi s8,zero 4
otro: sw s7, 0xFE(zero)
sw s8, 0xFD(zero)
addi t4, zero, 0
j cont

end: j end #Evitar cosas locas, reiniciar