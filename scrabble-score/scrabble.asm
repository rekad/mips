.globl scrabble_score


# a0: input string address

# t0: scores lookup table base address
# t1: current character
# t2: character offset
# t3: address of score for character
# t4: score for character
scrabble_score:
        la      $t0, scores             # load lookup table base address
        li      $v0, 0                  # initialize result with 0
loop:
        lb      $t1, 0($a0)             # load current char
        beq     $t1, $zero, exit        # exit when encountering NULL
        or      $t1, $t1, 0x20          # convert to lowercase
        add     $t2, $t1, -97           # calculate offset of char in alphabet
        sll     $t2, $t2, 2             # get offset in bytes
        add     $t3, $t0, $t2           # get score address
        lw      $t4, 0($t3)             # load score
        add     $v0, $v0, $t4           # add score to total
        addi    $a0, $a0, 1             # increment string index
        j       loop
exit:
        jr      $ra


.data
scores: .word 1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10