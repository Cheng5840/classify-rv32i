.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0         

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation


    mul t2, t1, a3
    slli t2, t2, 2
    add t2, a0, t2
    lw t3, 0(t2)
    beq t3, zero, next_round

    mul t2, t1, a4
    slli t2, t2, 2
    add t2, a1, t2
    lw t4, 0(t2)
    beq t4, zero, next_round

    mul t2, t3, t4

    add t0, t0, t2

next_round:
    addi t1, t1, 1
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit


# =======================================================
# FUNCTION: Multiplication Implementation
#
# Performs operation: D = a0 × a1
# Where:
#   - a0 is a int
#   - a1 is a int
#   - D is a result product
#
# Output:
#   None explicit - Result matrix D populated in-place
# =======================================================
multiply:
    li t0, 0
    mv t1, a0
    mv t2, a1

mul_loop:
    beqz t2, done
    andi t3, t2, 1
    beqz t3, skip
    add t0, t0, t1

skip:
    slli t1, t1, 1
    srli t2, t2, 1
    j mul_loop

done:
    mv a0, t0
    jr ra