.globl is_leap_year

# a0: year
# t0: divisor
# t1: remainder of division
is_leap_year:
        li      $v0, 0                  # default: no leap year

        li      $t0, 4                  # divisor for first check
        divu    $a0, $t0                # year/4
        mfhi    $t1                     # get remainder of division
        bne     $t1, $zero, exit        # year can't be divided by 4

        # if year is not divisible by 100 it's a leap year
        li      $t0, 100                # set divisor to 100
        divu    $a0, $t0                # year/100
        mfhi    $t1                     # get remainder of division
        bne     $t1, $zero, set_true    # year can't be divided by 100

        # year was divisible by 100.
        # if it's also divisible by 400 it's still a leap year
        li      $t0, 400                # set divisor to 400
        divu    $a0, $t0                # year/400
        mfhi    $t1                     # get remainder of division
        bne     $t1, $zero, exit        # year can't be divided by 400
set_true:
        addi    $v0, $v0, 1             # set output to true
exit:
        jr      $ra