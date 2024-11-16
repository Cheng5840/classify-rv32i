# Assignment2: Complete Applications


## ABS.s
In this file, we need to find the absolute value of an integer. 
Because the absolute value of a number means the distance between the number and zero. So I first check if the input integer is bigger than zero, if it is, we directly return the original value. Otherwise, we use zero to minus the input integer to get the absolute value, and then return.


## ARGMAX.s
In this file, we need to scan an integer array to find its maximum value and returns the position of its first occurrence.

## DOT.s
In this file, we need to simulate a strided dot product calculator. To achieve the goal, we need to calculates `sum(arr0[i * stride0] * arr1[i * stride1])`.
As we can see, there are three multiplication in the above operation. Because we don't want to use any mul instruction, we need to find an alternative of the above operation.

According to the definition of dot product, the index of vector1 will only shift right one step every round, so the stride0 in `arr0[i * stride0]` will always be one. Thus, we can easily to get the address of `arr0[i * stride0]` by adding 4*i (slli i, i, 2) to arr0 without using `mul`.

But `stride1` can be variant, so we need to handle the address carefully.
we can use a t register, for example t5, to store current address of `arr1[i * stride1]`, and before going to next round, we add 4*stride1 (slli stride1, stride1, 2) to t5.
In this way we can avoid using mul when getting the value of 
`arr1[i * stride1]`.

And the multiplication of two elements can be simulate in the form of traditional straight binary multiplication, which is multi-round addition. First, we use two registers to store multiplicand and multiplier, and one register for product. Then we check the LSB of multiplier, if it is 1, we add multiplicand to product; otherwise, we skip to next round. At the end of each round, we shift multiplicand one bit and shift multiplier one bit to get correct allignment.


We will use the same idea to implement every mul instruction in the rest of src files.


## Future work
In this project, every time we meet a mul instruction, we use nearly the same code to replace it. So, we can write a multiply.s to simulte the mul instruction and make code more readable, after this, whenever we meet mul, we just need to jump to multiply to get the product and then return.

I have tried this, but had some problems with handling the data trasferring (i.e. `sw`, `lw`). To make code more readable, 


