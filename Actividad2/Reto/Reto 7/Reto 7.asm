//int a = 10;
@10
D=A
@16    //a en la posición 16 en la RAM
M=D

//int b = 5;
@5
D=A
@17 //b en la posición 17 de la RAM
M=D

//int p; p = &a;
@16
D=A
@18   //p en la posición 18 de la RAM
M=D

//b =*p;
@18  //p
A=M  // A = valor de p = dirección a
D=M  // D tiene el contenido de a
@17  //b
M=D
