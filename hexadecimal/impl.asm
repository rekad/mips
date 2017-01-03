.text

# a0: current character address
# t1: current character
hex_convert:
        add     $v0, $zero, $zero       # initialize result with 0
loop:
        lb      $t1, 0($a0)             # load character
        beq     $t1, $zero, exit        # if encounter NULL char exit

        bgt     $t1, 58, is_character   # different way of converting letter to number
        addi    $t1, $t1, -48           # number = hex_val - '0'
        j       continue

is_character:
        blt     $t1, 91, is_uppercase   
        addi    $t1, $t1, -87           # number = hes_val - 'a' + 10
        j       continue

is_uppercase:
        addi    $t1, $t1, -55           # number = hex_val - 'A' + 10
        j       continue

continue:
        sll     $v0, $v0, 4             # multiply result with 16
        add     $v0, $v0, $t1           # add number to result (number is 0 to 15)
        addi    $a0, $a0, 1             # iterate to next character in the string
        j       loop                    # rerun loop
exit:
        # stack has not been changed
        jr      $ra                     # jump back to caller