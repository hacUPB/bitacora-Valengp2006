// int a = 10;
@10
D=A
@16     // a en RAM[16]
M=D

// int *p;  → p en RAM[17]

// p = &a;
@16
D=A
@17     // p en RAM[17]
M=D

// *p = 20;
@20
D=A         // D = 20
@17
A=M         // A = M[17] → dirección de a
M=D         // *p = 20 (RAM[16] = 20)