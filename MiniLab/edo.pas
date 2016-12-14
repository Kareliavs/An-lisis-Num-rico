unit EDO;

{$mode objfpc}{$H+}

interface

type
  matriz= array[0..100, 0..100] of Real;
  TEDO=Class
  private
    Ifuncion:String;
    Ia:Real;
    Ib:Real;
    Iyo:Real;
    Ino:Integer;

  public
    Expresion:String;
    Expresa:String;
    MatXn,MatYn:matriz;
    function EulerEvaluate():Real;
    function HeunEvaluate():Real;
    function RK3Evaluate():Real;
    function RK4Evaluate():Real;
    constructor create(fun:String;a,b,y:Real;n:Integer);
    destructor destroy;

  end;
implementation
uses
  Classes, SysUtils, ParseMath,math,Dialogs;

constructor TEDO.create(fun:String;a,b,y:Real;n:integer);
begin
  Ifuncion:=fun;
  Ia:=a;
  Ib:=b;
  Iyo:=y;
  Ino:=n;
end;

destructor TEDO.destroy;
begin
end;

function TEDO.EulerEvaluate():Real;
var
h,yn,xn:Real;
i:Integer;
m_function:TParseMath;
iteraciones:String;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.AddVariable('y',0);
  m_function.Expression:=Ifuncion;

  h:=(Ib-Ia)/(Ino);
  yn:=Iyo;
  xn:=Ia;
  //EDO('3*x*x+2*y-4',2,-4,8,10,3)

  MatXn[0,0]:=xn;
  MatYn[0,0]:=yn;

  for i:=1 to Ino do
  //while xn<=Ib do
  begin
     ShowMessage('Xn '+FloatToStr(xn)+' Yn '+FloatTostr(yn)+' b: '+FloatToStr(Ib)+' a: '+FloatToStr(Ia)+ ' h : '+FloatToStr(h)+' n: '+IntToStr(Ino));
     iteraciones:=iteraciones+' '+FloatToStr(yn);
     m_function.NewValue('x',xn);
     m_function.NewValue('y',yn);
     yn:=yn+h*m_function.Evaluate();
     xn:=xn+h;
     MatXn[i,0]:=xn;
     MatYn[i,0]:=yn;
  end;
  //if xn< Ib then
  (* begin
     iteraciones:=iteraciones+' '+FloatToStr(yn);
     xn:=Ib;
     m_function.NewValue('x',xn);
   //  m_function.NewValue('y',yn);
     yn:=yn+h*m_function.Evaluate();
  end;*)

  iteraciones:=iteraciones+' '+FloatToStr(yn);
  ShowMessage(iteraciones);
  Expresion:=iteraciones;
  Expresa:=iteraciones;
  EulerEvaluate:=RoundTo(yn,-6);
end;

function TEDO.HeunEvaluate():Real;
var
h,yn,yna,xn,uno,dos:Real;
i:Integer;
m_function:TParseMath;
itera,iteraciones,iterasterisco:String;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.AddVariable('y',0);
  m_function.Expression:=Ifuncion;

  h:=(Ib-Ia)/(Ino);
  xn:=Ia;
  yn:=Iyo;
  MatXn[0,0]:=xn;
  MatYn[0,0]:=yn;
  itera:=FloatToStr(yn);
  iteraciones:='Yn = '+FloatToStr(yn);
  iterasterisco:='Yn* ='+FloatToStr(yn);
  for i:=1 to Ino do
  begin
     m_function.NewValue('x',xn);
     m_function.NewValue('y',yn);
     yna:=yn+h*m_function.Evaluate();
     uno:=m_function.Evaluate();
     xn:=xn+h;
     m_function.NewValue('x',xn);
     m_function.NewValue('y',yna);
     dos:=m_function.Evaluate();
     yn:=yn+h*((uno+dos)/2);
     MatXn[i,0]:=xn;
     MatYn[i,0]:=yn;
     iterasterisco:=iterasterisco+'   '+FloatToStr(yna);
     iteraciones:=iteraciones+'   '+FloatToStr(yn);
     itera:=itera+' '+FloatToStr(yn);

  end;

  ShowMessage(iterasterisco);
  ShowMessage(iteraciones);
  Expresa:=itera;
  Expresion:= iterasterisco+#13#10+ iteraciones;
  HeunEvaluate:=RoundTo(yn,-6);
end;

function TEDO.RK3Evaluate():Real;
var
h,yn,yna,xn,uno,dos,tres:Real;
i:Integer;
m_function:TParseMath;
iteraciones,itera:String;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.AddVariable('y',0);
  m_function.Expression:=Ifuncion;

  h:=(Ib-Ia)/(Ino);
  xn:=Ia;
  yn:=Iyo;
  MatXn[0,0]:=xn;
  MatYn[0,0]:=yn;
  iteraciones:='Yn = '+FloatToStr(yn);
  itera:=FloatToStr(yn);
  //iterasterisco:='Yn* ='+FloatToStr(yn);
  for i:=1 to Ino do
  begin
     m_function.NewValue('x',xn);
     m_function.NewValue('y',yn);
     uno:=m_function.Evaluate();

     m_function.NewValue('x',xn+h/2);
     m_function.NewValue('y',yn+uno*h/2);
     dos:=m_function.Evaluate();

     m_function.NewValue('x',xn+h);
     m_function.NewValue('y',yn-uno*h+2*dos*h);
     tres:=m_function.Evaluate();

     yn:=yn+h*((uno+4*dos+tres)/6);
     xn:=xn+h;
     //iterasterisco:=iterasterisco+'   '+FloatToStr(yna);
     MatXn[i,0]:=xn;
     MatYn[i,0]:=yn;
     iteraciones:=iteraciones+'   '+FloatToStr(yn);
     itera:=itera+' '+FloatToStr(yn);
  end;
  //ShowMessage(iterasterisco);
  ShowMessage(iteraciones);                                // Pares// Impares
  Expresion:=iteraciones;
  Expresa:=itera;
  RK3Evaluate:=RoundTo( yn,-6);
end;
function TEDO.RK4Evaluate():Real;
var
h,yn,yna,xn,uno,dos,tres,cuatro:Real;
i:Integer;
m_function:TParseMath;
iteraciones,itera:String;
begin
  m_function:=TParseMath.create();
  m_function.AddVariable('x',0);
  m_function.AddVariable('y',0);
  m_function.Expression:=Ifuncion;

  h:=(Ib-Ia)/(Ino);
  xn:=Ia;
  yn:=Iyo;
  MatXn[0,0]:=xn;
  MatYn[0,0]:=yn;
  iteraciones:='Yn = '+FloatToStr(yn);
  itera:=FloatToStr(yn);
  //iterasterisco:='Yn* ='+FloatToStr(yn);
  for i:=1 to Ino do
  begin
     ShowMessage('Xn '+FloatToStr(xn)+' Yn '+FloatTostr(yn)+' b: '+FloatToStr(Ib)+' a: '+FloatToStr(Ia)+ ' h : '+FloatToStr(h)+' n: '+IntToStr(Ino));
     m_function.NewValue('x',xn);
     m_function.NewValue('y',yn);
     uno:=m_function.Evaluate();

     m_function.NewValue('x',xn+h/2);
     m_function.NewValue('y',yn+uno*h/2);
     dos:=m_function.Evaluate();

     m_function.NewValue('x',xn+h/2);
     m_function.NewValue('y',yn+dos*h/2);
     tres:=m_function.Evaluate();

     m_function.NewValue('x',xn+h);
     m_function.NewValue('y',yn+h*tres);
     cuatro:=m_function.Evaluate();

     yn:=yn+h*((uno+2*dos+2*tres+cuatro)/6);
     xn:=xn+h;
     //iterasterisco:=iterasterisco+'   '+FloatToStr(yna);
     MatXn[i,0]:=xn;
     MatYn[i,0]:=yn;
     iteraciones:=iteraciones+'   '+FloatToStr(yn);
      itera:=itera+' '+FloatToStr(yn);
  end;
  //ShowMessage(iterasterisco);
  ShowMessage(iteraciones);                                // Pares// Impares
  Expresion:=iteraciones;
  Expresa:=itera;
  RK4Evaluate:=RoundTo( yn,-6);
end;
end.

