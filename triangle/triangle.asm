.globl  triangle

# a0: a
# a1: b
# a2: c
triangle:
        add     $t0, $a0, $a1                   # t0 = a + b
        ble     $t0, $a2, invalid               # a + b <= c?
        add     $t0, $a0, $a2                   # t0 = a + c
        ble     $t0, $a1, invalid               # a + c <= b
        add     $t0, $a1, $a2                   # t0 = b + c
        ble     $t0, $a0, invalid               # b + c <= a

        beq     $a0, $a1, equilat_test          # a == b?
        beq     $a1, $a2, isoceles              # b == c?
        beq     $a0, $a2, isoceles              # a == c?
        j       scalene
equilat_test:
        beq     $a1, $a2, equilateral           # b == c?
        j       isoceles
scalene:
        li      $v0, 0
        j       exit
isoceles:
        li      $v0, 1
        j       exit
equilateral:
        li      $v0, 2
        j       exit
invalid:
        li      $v0, 3
exit:
        jr      $ra