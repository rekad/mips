.text

# a0: current character address
# t1: current character
binary_convert:
        add     $v0, $zero, $zero       # initialize result with 0
Loop:
        # load character
        lb      $t1, 0($a0)
        # if encounter NULL char exit
        beq     $t1, $zero, Exit
        # multiply result with 2
        sll     $v0, $v0, 1
        # convert current character to number
        addi    $t1, $t1, -48
        # add number to result (number is either 1 or 0)
        add     $v0, $v0, $t1
        # iterate to next character in the string
        addi    $a0, $a0, 1
        j       Loop
Exit:
        # jump back to caller
        # stack has not been changed
        jr      $ra
        