
.globl 	is_isogram

# A: 65
# a: 97

# a0: input string address

# t0: current character
# t2: bit vector to store character occurance
# t3: character offset
# t4: bit mask
# t5: const value 1
# t6: result of bit mask & bit vector
is_isogram:
        li      $v0, 1                  # defaultreturn value is true
        lw      $t2, bit_vector
        li      $t5, 1
loop:
        lb      $t0, 0($a0)             # load current character
        beq     $t0, $zero, exit        # if char NULL string is finished

        bgt     $t0, 90, lower_case     # check if character is lowercase
        addi    $t0, $t0, 32            # transform uppercase into lowercase
lower_case:
        addi    $t3, $t0, -96           # calculate character offset
        blt     $t3, $zero, end_loop    # if not a character skip to end of loop
        bgt     $t3, 28, end_loop       # if not a character skip to end of loop

        sllv    $t4, $t5, $t3           # char bit mask = 1 << char offset
        and     $t6, $t4, $t2           # bit vector & char bit mask
        bnez    $t6, exit_false         # if char already set there is a repeat
        or      $t2, $t2, $t4           # else set char bit in bit vector
end_loop:    
        addi    $a0, $a0, 1
        j       loop
exit_false:
        li      $v0, 0
exit:
        jr      $ra

.data
bit_vector: .word 0