////////////////////////////////////////////////////////////////////////////////////
				HECHO POR:
KARELIA ALEXANDRA VILCA SALINAS 

karelia.vilca@ucsp.edu.pe
////////////////////////////////////////////////////////////////////////////////////
				COMO USAR (EJEMPLOS)
Son válidas las siguientes expresiones

//Asignar numero a variable
x=17

//Asignar matriz a variable
o=[1 2 , 3 4]

//Funciones trigonométricas
sin(4)  o  sen(4)
cos(4)
tan(4)
cot(4)
sec(4)
csc(4)

//Expresiones
ln(4)
log(4)
sqrt(4) //raiz cuadrada
exp(1)  //e^1
power(2,3)


//Matrices
AddMat('[1 2 3 ;4 5 6 ]','[7 8 9 ;10 11 12 ]')
SubMat('[1 2 3 ;4 5 6 ]','[7 8 9 ;10 11 12 ]')
MulMat('[1 2 ;3 4 ]','[1 ;1 ]')
MulMatEsc('[1 2 ;3 4 ]',5)
InvMat('[1 2 ;3 4 ]')
DetMat('[1 2 ;3 4 ]')
TransMat('[1 2 ;3 4 ]')
TrazaMat('[1 2 ;3 4 ]')

//Eduaciones no lineales
biseccion('power(x,2)-ln(x)*power(e,x)',1,3.5,0.002)
fposicion('power(x,2)-ln(x)*power(e,x)',1,3.5,0.002)
newton('x*ln(x)-x','ln(x)',5,0.001)
secante('x*ln(x)-x',5,0.001,1) /// tipo de derivada 1
secante('x*ln(x)-x',5,0.001,2) /// tipo de derivada 2
secante('x*ln(x)-x',5,0.001,3) /// tipo de derivada 3

Jacobiana('[x ;y ]','[power(x,2)+x*y-10 ;y+3*x*power(y,2)-57 ]','[2.036 ;2.845 ]')
NGen('[x ;y ]','[power(x,2)+x*y-10 ;y+3*x*power(y,2)-57 ]','[2.036 ;2.845 ]',0.001)

//Interpolación
lagrange('[1 2 3 ;4 5 6 ]',1)


//Integrales
integral('power(x,3)-3*x-3',0,2,6,1,0) ///Trapecio integral
integral('power(x,3)-3*x-3',0,2,6,1,1) ///Trapecio area
integral('power(x,3)-3*x-3',0,2,6,2,0) ///Simpson1/3 integral
integral('power(x,3)-3*x-3',0,2,6,2,1) ///Simpson1/3 area
integral('power(x,3)-3*x-3',0,2,6,3,0) ///Simpson3/8 integral
integral('power(x,3)-3*x-3',0,2,6,3,1) ///Simpson3/8 area
integral('power(x,3)-3*x-3',0,2,6,4,0) ///Simpson3/8compuesto integral
integral('power(x,3)-3*x-3',0,2,6,4,1) ///Simpson3/8compuesto area

//EDO
EDO('x-y+1',0,0.5,1,5,1) //Euler
EDO('x-y+1',0,0.5,1,5,2) //Heun
EDO('x-y+1',0,0.5,1,5,3) //RK3
EDO('x-y+1',0,0.5,1,5,4) //RK4


///grafico cualquiera
graficar (2*x;-1;1)