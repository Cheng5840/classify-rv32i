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

    li t0, 0    # return result      
    li t1, 0    # loop counter   
    mv t5, a1  

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation

    slli t2, t1, 2
    add t2, a0, t2
    lw t3, 0(t2)
    beq t3, zero, next_round    
    
    lw t4, 0(t5)
    beq t4, zero, next_round


    #mul t2, t3, t4
########### mul start ##############
    li t2, 0 

mul_loop:
    beqz t4, done
    andi t6, t4, 1
    beqz t6, skip
    add t2, t2, t3

skip:
    slli t3, t3, 1
    srli t4, t4, 1
    j mul_loop

done:
########### mul end ###############

    add t0, t0, t2

next_round:
    addi t1, t1, 1
    slli t2, a4, 2
    add t5, t5, t2
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

