.text

li $a2, 0x00FF0000  #loads the color red into the register $a2
li $s2,  50         #x1 = x position of the tail
li $s3, 200         #y1 = y position of the tail
li $s0, 50          #x2 = x position of the head
li $s1, 200         #y2 = y position of the head

li $t6, 100         #limit of the x axis for painting the snake for the first time

loop:
   blt $s0, $t6, DrawPixel # while the head isnt in the first limit (100) draws a pixel in (s0,s1)

loop2:
   li $t6, 400 #new head limit,when the head gets to 100, it keeps drawing but now it erases the tail
   li $v0, 32 #sleep
   li $a0, 10 #20ms
   syscall #do the sleep

   blt $s0, $t6, DrawPixel2 #draws a pixel, and deletes the tail


   beq $s2, $t6, end #sends to the label of the end of the program



DrawPixel:

addi $s0, $s0, 1         #adds 1 to the X of the head
li $t3, 0x10000100       #t3 = first Pixel of the screen

sll   $t0, $s3, 9        #y = y * 512
addu  $t0, $t0, $s0      # (xy) t0 = x + y
sll   $t0, $t0, 2        # (xy) t0 = xy * 4
addu  $t0, $t3, $t0      # adds xy to the first pixel ( t3 )
sw    $a2, ($t0)         # put the color red ($a2) in $t0


j loop                   #goes back to the drawing loop

DrawPixel2:

addi $s0, $s0, 1         #adds 1 to the X position of the head
addi $s2, $s2, 1         #adds 1 to the X position of the tail
li $t3, 0x10000100       # t3 = first pixel of the screen

#####paint the head (in red)####
sll     $t0, $s3, 9     # y = y * 512
addu    $t0, $t0, $s0   # (xy) t1 = x + y
sll     $t0, $t0, 2     # (xy) t1 = xy * 4
addu    $t0, $t3, $t0   # adds xy to the first pixel ( t3 )
li $a2, 0x00FF0000      # change the color in a2 to red
sw  $a2, ($t0)          # put the color red ($a2) in $t0

#delete the tail( painting it in black )
sll     $t0, $s3, 9     # y = y * 512
addu    $t0, $t0, $s2   # (xy) t1 = x + y
sll     $t0, $t0, 2     # (xy) t1 = xy * 4
addu    $t0, $t3, $t0   # adds xy to the first pixel ( t3 )
li $a2, 0x10000000      # set the color in a2 to black
sw  $a2, ($t0)          # put the color black($a2) in $t0

j loop2 #goes back to the loop


end:

    ####exit########
    li $v0, 10
    syscall