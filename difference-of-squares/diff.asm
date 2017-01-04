.globl difference_of_squares

# a0: N
# t0: i
# t1: i squared
# t2: square_of_sums
# t3: sum_of_squares
# t4: loop condition check
# v0: result
# This can be optimized by using direct formulas for the sums
difference_of_squares:
        li      $t0, 1                  # initiialize i to 1
        li      $t2, 0                  # initialize square_of_sums to 0
        li      $t3, 0                  # initialize sum_of_squares to 0
        addi    $a0, $a0, 1             # add 1 to N for loop condition

loop:
        sltu    $t4, $t0, $a0           # is i < N + 1?
        beq     $t4, $zero, exit_loop   # if i >= N + 1 exit the loop

        add     $t2, $t2, $t0           # add i to square_of_sums
        mul     $t1, $t0, $t0           # square i
        add     $t3, $t3, $t1           # add squared i to sum of squares

        addi    $t0, $t0, 1             # increment i by 1
        j       loop
exit_loop:
        mul     $t2, $t2, $t2           # square the sum of i to get square of sums
        sub     $v0, $t2, $t3           # result = square_of_sums - sum_of_squares
        jr      $ra