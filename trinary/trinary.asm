.text

# a0: current character address
# t1: current character
trinary_convert:
        add     $v0, $zero, $zero       # initialize result with 0
Loop:
        lb      $t1, 0($a0)             # load character
        beq     $t1, $zero, Exit        # if encounter NULL char exit
        li      $t2, 3                  # store value 3 for multiplication
        mul     $v0, $v0, $t2           # multiply result with 3
        addi    $t1, $t1, -48           # convert current character to number
        add     $v0, $v0, $t1           # add number to result (number is either 1 or 0)
        addi    $a0, $a0, 1             # iterate to next character in the string
        j       Loop                    # rerun loop
Exit:
        # stack has not been changed
        jr      $ra                     # jump back to caller
        