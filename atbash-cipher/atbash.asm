.globl  atbash_cipher

# a0 - input string, for callee
# a1 - pointer to output string, for callee

# t0 - copy of output string
# t1 - current input char
# t2 - char counter, when reaches 5 insert space
# t3 - current output character
# t4 - cipher lookup base address
# t5 - char offset
# t6 - copy of input string
atbash_cipher:
        move    $t0, $a1                        # save copy of output string
        move    $t6, $a0                        # save copy of input string
        li      $t2, 0                          # initialize char counter
        la      $t4, cipher_lookup              # load cipher base address
loop:
        lb      $t1, 0($t6)                     # read input char
        beq     $t1, $zero, exit                # if char is NULL finish
        blt     $t1, 65, increment_input        # skip whitespace
        bgt     $t1, 96, is_lower_case          # check if already lowercase
        addi    $t1, $t1, 32                    # convert char to lowercase
is_lower_case:
        blt     $t2, 5, write_char              # if space counter is 5 add whitespace to output
        li      $t3, 32                         # 32 = SPACE
        sb      $t3, 0($t0)                     # write space in output string 
        addi    $t0, $t0, 1                     # increment output index
        li      $t2, 0                          # reset char counter
write_char:
        addi    $t5, $t1, -97                   # get char offset in alphabet
        sll     $t5, $t5, 2                     # convert offset into bytes
        add     $t5, $t5, $t4                   # add cipher base offset to char offset
        lb      $t3, 0($t5)                     # load output char from lookup
        sb      $t3, 0($t0)
        addi    $t2, $t2, 1                     # increment char counter

        addi    $t0, $t0, 1                     # increment output index
increment_input:
        addi    $t6, $t6, 1                     # increment input index
        j       loop
exit:
        sb      $zero, 0($t0)
        jr      $ra

.data
cipher_lookup: .word 122, 121, 120, 119, 118, 117, 116, 115, 114, 113, 112, 111, 110, 109, 108, 107, 106, 105, 104, 103, 102, 101, 100, 99, 98, 97