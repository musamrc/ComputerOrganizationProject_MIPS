.data
menumsg: .asciiz "Main Menu:\n1. Find Palindrome\n2. Reverse Vowels\n3. Find Distinct Prime\n4. Lucky Number\n5. Exit\nPlease select an option: "
userInput: .space 100
palmsg: .asciiz "Input: "
squaremsg: .asciiz "Enter an integer number: "
notsquaremsg: .asciiz " is not a square-free number\n"
squarefreemsg: .asciiz " is a square-free number and has "
squarefreemsg2: .asciiz" distinct prime factors: " 
space: .asciiz" " 
nextLine: .asciiz"\n"
myArray: .space 40
vowelArray: .space 100
outputmsg: .asciiz "Output: "
luckynumberInput1: .asciiz"Input: Enter the number of rows: "
luckynumberInput2: .asciiz"Enter the number of columns: "
luckynumberInput3: .asciiz"Enter the elements of the matrix:  "
luckynumberUnique: .asciiz"Output: The matrix should have only unique values.\n"
notfinishedmessage: .asciiz"This part of the code is not complete.\n"
.text
#index
addi $s5, $zero, 0

.globl main
main:
#print Menu Message
li $v0, 4
la $a0, menumsg
syscall

#Take menu input number
li $v0, 5
syscall
move $t0,$v0

#Move to the functions
beq $t0, 5, exit
beq $t0, 1, palindrome
beq $t0, 2, reversevowels
beq $t0, 3, squareFree
beq $t0, 4, luckyNumber

#exit program
exit:
li $v0,10
syscall

#Palindrome Question
palindrome:
li $v0, 4
la $a0, palmsg
syscall
#Take Palindrome Input
li $v0, 8
la $a0, userInput
li $a1, 50
syscall

move $a1,$a0
li $v0, 4
la $a0, notfinishedmessage
syscall
j jumpMain

#SquareFree Function
squareFree:
#Print message
li $v0, 4
la $a0, squaremsg
syscall
#Take integer input to t0
li $v0, 5
syscall
move $t0,$v0 #t0 = Input
move $s7,$t0

addi $t7,$s7,1
addi $t6,$zero,2  # i = 2
#Check individual cases

SquareLoop:
beq $t6, $t7, squarefreeTrue
add $t1,$zero,$t0
div $t1, $t1,$t6    #t0'i i'ye böl
mfhi $t5
beq $t5, $zero, divided
addi $t6,$t6,1
j SquareLoop


divided:
div $t1, $t1,$t6    #t1'i i'ye böl
mfhi $t5
beq $t5, $zero, notsquare
sb $t6, myArray($s5)
addi $s3, $s3, 1
addi $s5, $s5, 4
div $t0, $t0,$t6
j SquareLoop	


notsquare:
li $v0 ,1
move $a0, $s7  #Input value
syscall
li $v0, 4
la $a0, notsquaremsg
syscall
j jumpMain

squarefreeTrue:
li $v0 ,1
move $a0, $s7
syscall
li $v0, 4
la $a0, squarefreemsg
syscall
li $v0, 1
move $a0, $s3
syscall
li $v0, 4
la $a0, squarefreemsg2
syscall
addi $s5, $zero, 0
j while
j jumpMain

while:
beq $s2, $s3, jumpMain
lb $s4, myArray($s5)
addi $s5, $s5, 4
li $v0, 1
add  $a0, $s4, 0
syscall
li $v0, 4
la $a0, space
syscall
addi $s2, $s2, 1
la $a0, space
j while

jumpMain:
li $v0, 4
la $a0, nextLine
syscall
li $s0, 0
li $s1 0
li $s2, 0
li $s3, 0
li $s4, 0
li $s5, 0
li $s6, 0
li $s7, 0
li $t0, 0
li $t1 0
li $t2, 0
li $t3, 0
li $t4, 0
li $t5, 0
li $t6, 0
li $t7, 0
j main

#Reverse Vowels Function
reversevowels:
#Print Ýnput: text
li $v0,4
la $a0,palmsg
syscall
#Get input from the use and store inside userInput
li $v0, 8
la $a0, userInput
li $a1, 100
syscall
#a1 = userinput , $t0 = i
move $a1,$a0
li $t0, 0     # counter for the loop
addi $s1,$zero,0 #s1 = how many vowels
li $s5,0
li $t5,0
li $t4,0
loopReverseVowel:
  lb $t1, ($a1)    # load a byte from memory into register $t1
  beq $t1, 0, endReverseVowelLoop  # if the byte is null (end of string), exit the loop
  addi $a1, $a1, 1 # increment the address to point to the next byte
  addi $t0, $t0, 1 # increment the counter  t0 = i
  #compare ASCII codes of characters
  li $t7,97 #ASCII code of a
  beq $t7,$t1,recordVowel
  li $t7,65 #ASCII code of A
  beq $t7,$t1,recordVowel
  li $t7,101 #ASCII code of e
  beq $t7,$t1,recordVowel
  li $t7,69 #ASCII code of E
  beq $t7,$t1,recordVowel
  li $t7,105 #ASCII code of i
  beq $t7,$t1,recordVowel
  li $t7,73 #ASCII code of I
  beq $t7,$t1,recordVowel
  li $t7,111 #ASCII code of o
  beq $t7,$t1,recordVowel
  li $t7,79 #ASCII code of O
  beq $t7,$t1,recordVowel
  li $t7,117 #ASCII code of u
  beq $t7,$t1,recordVowel
  li $t7,85 #ASCII code of U
  beq $t7,$t1,recordVowel
  j loopReverseVowel

recordVowel:  
  addi $s1,$s1,1  #s1 = s1 + 1 (how many vowels)
  sb $t7, vowelArray($s5)  #store characters ascii code into array
  addi $s5, $s5, 4
  j loopReverseVowel
  
endReverseVowelLoop:
li $t5,0
li $t4,4
li $t3,0
li $s6,0
move $a1,$a0
li $v0,4
la $a0,outputmsg
syscall
j changeOrders

changeOrders:
beq $t3,$t0,jumpMain
addi $t3,$t3,1
lb $t1, ($a1)
addi $a1,$a1,1
  #compare ASCII codes of characters
  li $t7,97 #ASCII code of a
  beq $t7,$t1,lastvowel
  li $t7,65 #ASCII code of A
  beq $t7,$t1,lastvowel
  li $t7,101 #ASCII code of e
  beq $t7,$t1,lastvowel
  li $t7,69 #ASCII code of E
  beq $t7,$t1,lastvowel
  li $t7,105 #ASCII code of i
  beq $t7,$t1,lastvowel
  li $t7,73 #ASCII code of I
  beq $t7,$t1,lastvowel
  li $t7,111 #ASCII code of o
  beq $t7,$t1,lastvowel
  li $t7,79 #ASCII code of O
  beq $t7,$t1,lastvowel
  li $t7,117 #ASCII code of u
  beq $t7,$t1,lastvowel
  li $t7,85 #ASCII code of U
  beq $t7,$t1,lastvowel
li $v0, 11
move $a0, $t1
syscall
j changeOrders

lastvowel:
addi $s6,$s6,1
li $t5,0
li $t2,0
mul $t5,$s1,$t4 #last vowel
mul $t2,$s6,$t4
sub $t5,$t5,$t2
lb $s4, vowelArray($t5)
li $v0, 11
move $a0, $s4
syscall
j changeOrders


luckyNumber:
#Print message
li $v0, 4
la $a0, luckynumberInput1
syscall
#Take integer input to t0
li $v0, 5
syscall
move $t0,$v0 #t0 = Input
li $v0, 4
la $a0, luckynumberInput2
syscall
li $v0, 5
syscall
move $t1, $v0
li $v0, 4
la $a0, notfinishedmessage
syscall
j jumpMain