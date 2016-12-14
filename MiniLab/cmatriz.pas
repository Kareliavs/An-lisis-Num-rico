unit cmatriz;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil,Math, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids;


const
  filas=100;
  columnas=100;
type
    mtr = array of array of real;
type
    TAmatriz=class

    matrix:array[1..filas,1..columnas] of Real;
   // resul:array[1..filas,1..columnas] of Real;
    m: mtr;

    f:Integer;
    c:Integer;

  function suma(m1:TAmatriz):TAmatriz;
  function resta(m1:TAmatriz):TAmatriz;
  function mult_matriz(m1:TAmatriz):TAmatriz;
  function mult_escalar(m1:Double):TAmatriz;
  function inversa(m1:TAmatriz):TAmatriz;
  function generar_matriz(grid: TStringGrid):Boolean;
  function generar_smatriz:String;
  function traza:Double;
 // function adjunta(Orden: Integer; M: Tmatriz);
 function gauss(mat:TAmatriz;dim:Integer;det: Boolean ):TAmatriz;
  function determinante(A:TAmatriz;filas:Integer):Double;
end;

implementation

function TAmatriz.generar_smatriz():String;
var
  i,j:Integer;
  res:String;
begin
  res:='[';
  //res:=res+FloatToStr(Self.matrix[1,1])+' ';
for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c+1 do
      begin
        res:=res+FloatToStr(Self.matrix[i,j])+' ';
       // Self.matrix[i,j]:=StrToFloat(grid.Cells[j-1,i-1]);
      end;
      res:=res+', '
    end;
res:=res+']';
Result:=res;
end;

function TAmatriz.generar_matriz(grid: TStringGrid):Boolean;
var
  i,j:Integer;
begin
 SetLength(Self.m,4,5);
 //layman install in gentoo
 //emerge --ask
for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
        Self.matrix[i,j]:=StrToFloat(grid.Cells[j-1,i-1]);
     //   Self.m[i,j]:=StrToFloat(grid.Cells[j-1,i-1]);
        {1	1	2	1
0	2	3	1
0	0	3	0
0	0	0	4

        }
      end;
    end;
Result:=True;
end;

//hacer lagrange

function TAmatriz.suma(m1:TAmatriz):TAmatriz;
var
  i,j:Integer;
  m3:TAmatriz;

begin
     m3:=TAmatriz.Create;

  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
         m3.matrix[i,j]:=m1.matrix[i,j]+Self.matrix[i,j];
      end;
    end;


  Result:=m3;

end;


function TAmatriz.resta(m1:TAmatriz):TAmatriz;
var
  i,j:Integer;
  m3:TAmatriz;
begin
  m3:=TAmatriz.Create;
  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
           m3.matrix[i,j]:=Self.matrix[i,j]-m1.matrix[i,j];
      end;
    end;

  Result:=m3;

end;


function TAmatriz.mult_escalar(m1:Double):TAmatriz;
var
  i,j:Integer;
  m3:TAmatriz;

begin
  m3:=TAmatriz.Create;
  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
           m3.matrix[i,j]:=m1*Self.matrix[i,j];
      end;
    end;

  Result:=m3;

end;


function TAmatriz.inversa(m1:TAmatriz):TAmatriz;
var
  i,j:Integer;
  m3:TAmatriz;
begin
  ///verificar sitienes determinante !=0 sino no hay
  for i:= 1 to Self.f do
    begin
      for j:=1 to Self.c do
      begin
           m3.matrix[i,j]:=m1.matrix[i,j]+Self.matrix[i,j];
      end;
    end;

  Result:=m3;

end;


function TAmatriz.traza:double;
var
  i,j:Integer;
  m3:Double;

begin
  m3:=0;
  for i:= 1 to Self.f do
    begin
      m3:=m3+Self.matrix[i,i];
    end;

  Result:=m3;

end;

function TAmatriz.mult_matriz(m1:TAmatriz):TAmatriz;
var
  i,j,k:Integer;
  m3:TAmatriz;
  w:Double;
begin
  m3:=TAmatriz.Create;
    w:=0;
  //falta ponerle las restricciones de 2x3 .. 3x4 ... 2x4
    for i:= 1 to m1.c do     //filas del primero
    begin
      for j:=1 to Self.f do  //columnas del segundo
      begin
        w:=0;


        for k:=1 to Self.f do  //columnas del primero
         begin
              w:=w+(Self.matrix[j,k]*m1.matrix[k,i]);
           {   ShowMessage('i: '+IntToStr(i)+' j: '+IntToStr(j)+' k : '+IntToStr(k)+' '+FloatToStr(Self.matrix[j,k])+' '+FloatToStr(m1.matrix[k,i]));
              ShowMessage(FloatToStr(Self.matrix[j,k]*m1.matrix[k,i]));
         }end;

        m3.matrix[j,i]:=w;
      end;

    end;

   { for i:= 1 to Self.f do
    begin
      for j:=1 to  m1.c  do
      begin

           ShowMessage(FloatToStr(m3.matrix[i,j]));
      end;
    end;
          }

    //hacer  todo XD

  Result:=m3;

end;

function TAmatriz.gauss(mat:TAmatriz;Dim:Integer;det: Boolean):TAmatriz;
const
    error=0.00000001;{Valor por debajo del cual el programa considerara 0}
  var
    paso,c1,c2: Integer;
    PivCorrect: Boolean;
    pivote,aux: Double;
  begin{0}
 ShowMessage(IntToStr((Dim+1) div 2+1 ));
 ShowMessage(IntToStr(Dim));
    for paso:=1 to (Dim+1 div 2 +1 ) do begin{1}
      ShowMessage(IntToStr(paso));
      PivCorrect := False;
      c1:= paso;
      while (not PivCorrect) and (c1< Dim+1 shr 1 ) do
        If abs(mat.matrix[c1,paso])>error then
          PivCorrect:=true
        else
          c1:=c1+1;
      If PivCorrect then begin{3}
        pivote:=mat.matrix[c1,paso];
        for c2:=paso to ((Dim)) do
          if c1<>paso then begin
            aux:=mat.matrix[paso,c2];
            mat.matrix[paso,c2]:= mat.matrix[c1,c2]/pivote;
            mat.matrix[c1,c2]:=aux
          end else
            mat.matrix[c1,c2]:=mat.matrix[c1,c2]/pivote;

          //por defecto el programa pasando de los 10 digitos lo redondea a 0
        {Hasta aquí ha sido solo preparar el pivote para hacer ceros por debajo
        el pivote en estos momentos es 1}
      end;{3}
     for c1:=(paso+1) to ((Dim+1) div 2 ) do begin
       aux:=mat.matrix[c1,paso];
       for c2:=paso to ((Dim)) do
         mat.matrix[c1,c2]:=mat.matrix[c1,c2]-aux*mat.matrix[paso,c2]
     end;
    end;{1}
    {Aqui la matriz ya esta escalonada (se imprime en pantalla). Se comprueba que el sistema sea determinado}
  det:=true;
 {   for c1:=1 to (Dim+1 shr 1 -1) do
      if abs( mat.matrix[c1,c1] )<error then
        det:=false;
                       }
    if det then begin
      for paso:=(Dim shr 1 ) downto 1 do begin
        pivote:=mat.matrix[paso,paso];
        mat.matrix[paso,paso]:=1;
        for c2:=(Dim shr 1) to (Dim) do
          mat.matrix[paso,c2]:= mat.matrix[paso,c2]/pivote ;
        for c1:=(paso-1) downto 1 do begin
          aux:=mat.matrix[c1,paso];
          for c2:=paso to (Dim) do
            mat.matrix[c1,c2]:= mat.matrix[c1,c2]-mat.matrix[paso,c2]*aux
        end
      end;

    end
    else
      ShowMessage('La matriz no tiene inversa');

    Result:=mat;
  end;{0}




function TAmatriz.determinante(A:TAmatriz;filas:Integer):Double;
var
  i,j,n:Integer;
  factor,det:Real;
  B:TAmatriz;

begin
  B:=TAmatriz.Create;
     if filas=2 then  { determinante de dos por dos, caso base }
        det:= A.matrix[1,1] * A.matrix[2,2] - A.matrix[1,2] * A.matrix[2,1]
     else
     begin
          det:= 0;
          for n:= 1 to filas do
          begin
               for i:= 2 to filas do
               begin
                    for j:= 1 to n-1 do
                        B.matrix[i-1,j]:= A.matrix[i,j];
                    for j:= n+1 to filas do
                        B.matrix[i-1,j-1]:= A.matrix[i,j];
               end;
               if (1+n) mod 2=0 then i:=1 //Signo
                  else i:= -1;
               det:= det + i * A.matrix[1,n] * Self.determinante(B,filas-1);
          end;

     end;
     Result:= det;




end;

end.


