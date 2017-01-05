.globl transcribe_rna

# `G` -> `C`
# `C` -> `G`
# `T` -> `A`
# `A` -> `U`

# a0: input string
# a1: output string

# t0: copy of output string address
# t1: current character
# t2: lookup table offset address
# t3: char offset
# t4: char to write
transcribe_rna:
        move    $t0, $a1                # copy of output string
        la      $t2, lookup             # store lookup table address

loop:
        lb      $t1, 0($a0)             # load current character from input
        beq     $t1, $zero, exit        # if char is NULL string is finished

        addi    $t3, $t1, -65           # offset from current character to A
        sll     $t3, $t3, 2             # offset in bytes (lookuptable are words)

        addu    $t3, $t3, $t2           # add lookuptable base address

        lb      $t4, 0($t3)             # load character from lookuptable
        sb      $t4, 0($t0)             # store character in output string

        addi    $a0, $a0, 1             # increment input string index
        addi    $t0, $t0, 1             # increment output string index
        j       loop
exit:
        sb      $zero, 0($t0)           # add NULL to output string
        jr      $ra

.data 
lookup: .word 85, 0, 71, 0, 0, 0, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65
