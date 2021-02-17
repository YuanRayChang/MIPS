.data
pattern: .word 0x0, 0x00200000,0x00004000,0x00000080,0x00000001,0x00000002,0x00000004,0x00000008,0x00000400,0x00020000,0x01000000,0x02000000,0x04000000
loopcnt0: .word 0x001e8484, 0x001e0000, 0x00100000, 0x000d0000

.text
	lw $t3, loopcnt0	# initialize a  large loopcounter (so that the snake does not crawl SUPERFAST)
	addi $t5,$0,0		# initialize the length of the display pattern (in bytes)

restart:
	addi $t4,$0,48

forward:
	beq $t5,$t4, restart
	lw $t0,0($t4)
	sw  $t0, 0x7ff0($0) # send the value to the display

	addi $t4, $t4, -4 # increment to the next address
	addi $t2, $0, 0 # clear $t2 counter
	
	lw $t6, 0x7ff4($0) # load current speed to $t6 ($t6 = 0, 4, 8, 12)
	lw $t3, loopcnt0($t6)
	
wait:
	beq $t2,$t3,forward	
	addi  $t2, $t2, 1     # increment counter
	j wait
