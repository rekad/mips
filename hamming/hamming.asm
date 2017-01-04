.globl	hamming_distance


# a0: start of first string
# a1: start of second string
# v0: result (hamming distance)
# t0: index
# t1: current character from first string
# t2: current character from second string
hamming_distance:
        li      $v0, 0                  # init result to 0
        li      $t0, 0                  # init index to 0

loop:
        lb      $t1, 0($a0)             # load character from first string
        beq     $t1, $zero, finish      # if char == NULL exit the loop
        lb      $t2, 0($a1)             # load character from second string
        sne     $t3, $t1, $t2           # check if characters are equal
        add     $v0, $v0, $t3           # if check was true increase hamming distance
        addi    $a0, $a0, 1             # move to next character in string
        addi    $a1, $a1, 1
        j       loop
finish:
        jr      $ra