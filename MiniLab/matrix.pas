unit Matrix;

{$mode objfpc}{$H+}

interface

uses
  Classes,Dialogs, SysUtils;
type
  matriz= array[0..100, 0..100] of Real;
  TMatriz=Class
  private
  public
    function Suma(A,B : matriz; n,m:integer):matriz;
    function Resta(A,B : matriz; n,m:integer):matriz;
    function MultEsc(A: matriz;esc:Real;n,m:integer):matriz;
    function Mult(A,B: matriz;n,m,o:integer):matriz;
    function Transpuesta(A: matriz;n,m:integer):matriz;
    function Traza(A: matriz;n,m:integer):real;
    function Determinante(A: matriz;filas,col:integer):real;
    //INVERSA APARTE
    constructor create();
    destructor destroy();
  end;
var
  mat:matriz;
implementation
 constructor TMatriz.create();
begin
end;

destructor TMatriz.destroy;
begin
end;


 function TMatriz.Suma(A,B : matriz; n,m:integer):matriz;
  var
  i,j : integer;
  C:matriz;
  begin
  for i:=0 to m-1 do
     begin
      for j:=0 to n-1  do
       begin
           C[i,j]:=A[i,j]+B[i,j];//col
       end;
     end;

  Suma:=C;
  end;

  function TMatriz.Resta(A,B : matriz; n,m:integer):matriz;
  var
  i,j : integer;
  C:matriz;
  begin
  for i:=0 to m-1 do
     begin
      for j:=0 to n-1  do
       begin
           C[i,j]:=A[i,j]-B[i,j];//col
       end;
     end;
  Resta:=C;
  end;

  function TMatriz.MultEsc(A: matriz;esc:real;n,m:integer):matriz;
  var
  i,j : integer;
  C:matriz;
  begin
  for i:=0 to m-1 do
     begin
      for j:=0 to n-1  do
       begin
           C[i,j]:=A[i,j]*esc;//col
       end;
     end;
  MultEsc:=C;
  end;

  function TMatriz.Mult(A,B: matriz;n,m,o:integer):matriz;
  var
  //Determinanate por triangullarizacion
  //Inversa Gauss
  //Simpsons
  //Lagrange simple
  i,j,k : integer;
  temp:Real;
  C:matriz;
  begin
  for i:=0 to n-1 do
     begin
      for j:=0 to o-1 do
         begin
         C[j,i]:=0;
          for k:=0 to m-1  do
           begin
            //ShowMessage(FloatToStr(C[j,i])+' + '+FloatToStr(B[k,i])+' * '+FloatToStr(A[j,k]) );
            C[j,i]:=C[j,i]+(A[k,i]*B[j,k]);//col
            //ShowMessage(IntToStr(k)+' '+IntToStr(i)+' = '+ FloatToStr(temp));
           end;
          end;
      end;

  Mult:=C;
  end;
  function TMatriz.Transpuesta(A: matriz;n,m:integer):matriz;
  var
  i,j,i1,j1: integer;
  C:matriz;
  begin
  //ShowMessage(IntToStr(n));//2 i
  //ShowMessage(IntToStr(m));//3 j
  j1:=0;
  for i:=0 to n-1 do
      begin
      i1:=0;
      for j:=0 to m-1 do
         begin

          C[j1,i1]:=A[j,i];
         // ShowMessage('this is i1: '+IntToStr(i1)+' this j1 : '+ IntToStr(j1)+'  ' +FloatToStr(C[i1,j1]));
          i1:=i1+1;
          end;
          j1:=j1+1;
      end;
  Transpuesta:=C;
  end;

  function TMatriz.Traza(A: matriz;n,m:integer):Real;
  var
  i,j : integer;
  C:real;
  begin
  for i:=0 to m-1 do
     begin
       C:=A[i,i]+C;//col
     end;
  Traza:=C;
  end;
  function TMatriz.Determinante(A: matriz;filas,col:integer):Real;
  var
  i,j,n:Integer;
  factor,det:Real;
  B:matriz;

  begin

     if filas=2 then  { determinante de dos por dos, caso base }
        det:= A[0,0] * A[1,1] - A[0,1] * A[1,0]
     else
     begin
          det:= 0;
          for n:= 0 to filas-1 do
          begin
               for i:= 1 to filas-1 do
               begin
                    for j:= 0 to n-1 do
                        B[i-1,j]:= A[i,j];
                    for j:= n+1 to filas-1 do
                        B[i-1,j-1]:= A[i,j];
               end;
               if (n+2) mod 2=0 then i:=1 //Signo
                  else i:= -1;
               det:= det + i * A[0,n] * Determinante(B,filas-1,col);
          end;

     end;
     Determinante:= det;
  end;

end.



