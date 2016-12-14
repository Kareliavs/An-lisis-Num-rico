unit funciones;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils,ParseMath, math, fpexprpars,cmatriz, FileUtil, uCmdBox, TAGraph, Forms, Controls, Graphics,
Dialogs, ComCtrls, Grids, ValEdit, ExtCtrls, ShellCtrls, EditBtn, Menus,
StdCtrls, spktoolbar, spkt_Tab, spkt_Pane, spkt_Buttons, spkt_Checkboxes;



type
  TFunciones = Class



  Public



      Function funcion(x:Double;f:String):Double;
      Function funcion2(x,y:Double;f:String):Double;
      Function falsa_posicion(A:Double;B:Double;f:String):Double;
      function derivada(x:Double;f:String):Double;
      function derivada1(x:Double;f:String;e:Double):Double;

      function derivada2(x:Double;f:String;e:Double;x0:Double):Double;
      function derivada3(x:Double;f:String;e:Double):Double;
      Function newton(x:Double;f:String;d:String):Double;
      Function biyeccion(A:Double;B:Double):Double;
      Procedure ExprTrapecio( f:String;la,lb,n:float);
      Procedure ExprSimpsonSimple( f:String;la,lb:float);
      Procedure ExprSimpson38( f:String;la,lb,n:float);
      Procedure ExprSimpson13 ( f:String;la,lb,n:float);
      function ExprEuler( f:String;x0,xf,y0,n:float):String;
      Procedure ExprHeun(   f:String;x0,xf,y0,n:float);
      Procedure ExprRungeKutta3(  f:String;x0,xf,y0,n:float);
      Procedure ExprRungeKutta4( f:String;x0,xf,y0,n:float);
      Procedure ExprBiy(  f:String;A,B,Error:float);
      Procedure ExprFP( f:String;A,B,Error:float);
      Procedure ExprSecante(  f:String;B:Integer;A,Error:float);
      Procedure ExprLagrange(  f:String;A,B,Error:float);
      Procedure ExprNewton( f,d:String;A,Error:float);
  end;



var

   A,B,Error,error2,anterior,funct,x,xn_0,xn_1,signo:Double;
  i,j,tam:Integer;
  number, zero : Integer;
  MiParse: TParseMath;
  f,d:String;



  implementation

Function TFunciones.funcion(x:Double;f:String):Double;
begin
  try
     MiParse:= TParseMath.create();
     MiParse.AddVariable( 'x', x );
     MiParse.Expression:= f;//cboFuncion.Text;
     funct:=MiParse.Evaluate();
   //  ShowMessage('x '+FloatToStr(x));
    //ShowMessage('x '+FloatToStr(funct));
    funcion:=funct;
    except

  //   ShowMessage('NO HAY RAIZ EN ESE INTERVALO');
     funcion:=0;
     Exit;

  end;



end;

Function TFunciones.funcion2(x,y:Double;f:String):Double;
begin
  try
     MiParse:= TParseMath.create();
     MiParse.AddVariable( 'x', x );
     MiParse.AddVariable( 'y', y );
     MiParse.Expression:= f;//cboFuncion.Text;
     funct:=MiParse.Evaluate();
   //  ShowMessage('x '+FloatToStr(x));
    //ShowMessage('x '+FloatToStr(funct));
    funcion2:=funct;
    except

  //   ShowMessage('NO HAY RAIZ EN ESE INTERVALO');
     funcion2:=0;
     Exit;

  end;




end;

Function TFunciones.falsa_posicion(A:Double;B:Double;f:String):Double;
begin
  x:=A-((funcion(A,f)*(B-A))/(funcion(B,f)-funcion(A,f)));
  falsa_posicion:=x;
end;

function TFunciones.derivada(x:Double;f:String):Double;
var
  h:Float;
Begin
  h:=0.01;
  derivada:=(funcion(x+h,f)-funcion(x,f))/h;
 // ShowMessage(FloatToStr(derivada));
end;

function TFunciones.derivada1(x:Double;f:String;e:Double):Double;
var
  h:Float;
Begin
  h:=e/10;
  derivada1:=x-(h*funcion(x,f))/(funcion(x+h,f)-funcion(x,f));
 // ShowMessage(FloatToStr(derivada));
end;

function TFunciones.derivada2(x:Double;f:String;e:Double;x0:Double):Double;
var
  h:Float;
Begin
  h:=e/10;
  derivada2:=x-(funcion(x,f)*(x-x0))/(funcion(x,f)-funcion(x0,f));
  //ShowMessage(FloatToStr(derivada));
end;

function TFunciones.derivada3(x:Double;f:String;e:Double):Double;
var
  h:Float;
Begin
  h:=e/10;
  derivada3:=x-(2*h*funcion(x,f))/(funcion(x+h,f)-funcion(x-h,f));
 // ShowMessage(FloatToStr(derivada));
end;

Function TFunciones.newton(x:Double;f:String;d:String):Double;
begin
  x:=x-(funcion(x,f)/derivada(x,d));
  newton:=x;
end;

Function TFunciones.biyeccion(A:Double;B:Double):Double;
begin
  x:=(A+B)/2;
  biyeccion:=x;
end;


Procedure TFunciones.ExprTrapecio( f:String;la,lb,n:float);
var
  MiParse:TParseMath;
  i,h,resp,fa,fb,sum:Double;

begin

  MiParse:= TParseMath.create();
   MiParse.AddVariable( 'x', 0 );
   MiParse.Expression:= f;

   h:=(lb-la)/n;
    MiParse.NewValue('x',la);
  fa:=MiParse.Evaluate();
  MiParse.NewValue('x',lb);
  fb:=MiParse.Evaluate();
  sum:=0;

  i:=la+h;
  repeat
    MiParse.NewValue('x',i);
    sum:=sum+MiParse.Evaluate();
    i:=i+h;

  until i>=lb;
  resp:=RoundTo(0.5*h*(fa+fb)+h*sum,-6);

 // Result := resp;
   MiParse.destroy;

end;

Procedure TFunciones.ExprSimpsonSimple( f:String;la,lb:float);
var
  m_function:TParseMath;
  i,h,resp,fa,fb,sump,sumi:Float;

begin

  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;


  h:=(lb-la)/3;
  m_function.NewValue('x',la);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',lb);
  fb:=m_function.Evaluate();
  sump:=0;
  sumi:=0;



  sump:=(2*la+lb)/3;
  m_function.NewValue('x',sump);
    sump:=m_function.Evaluate();

  sumi:=(la+2*lb)/3;
    m_function.NewValue('x',sumi);
    sumi:=m_function.Evaluate();
  resp:=RoundTo((3*h/8)*(fa+fb)+(9*h/8)*sump+(9*h/8)*sumi,-6);
  //Result.ResFloat:=(resp);

end;

Procedure TFunciones.ExprSimpson38( f:String;la,lb,n:float);
var
  m_function:TParseMath;
  i,h,resp,fa,fb,sump,sumo,sumi:Float;
  temp:Integer;
begin

  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;




  h:=(lb-la)/n;
  m_function.NewValue('x',la);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',lb);
  fb:=m_function.Evaluate();
  sump:=0;
  sumi:=0;
  sumo:=0;


  i:=la+h;
  repeat
    m_function.NewValue('x',i);
    sumo:=sumo+m_function.Evaluate();
    i:=i+3*h;

  until (i>lb-2*h);

  i:=la+2*h;
  repeat
    m_function.NewValue('x',i);
    sumi:=sumi+m_function.Evaluate();
    i:=i+3*h;
  until (i>lb-h);

  i:=la+3*h;
  repeat
    m_function.NewValue('x',i);
    sump:=sump+m_function.Evaluate();
    i:=i+3*h;

  until (i>lb-3*h);

  resp:=RoundTo((3*h/8)*(fa+fb)+(9*h/8)*sumo+(9*h/8)*sumi+(6*h/8)*sump,-6);

  //Result.ResFloat:=(resp);
end;

Procedure TFunciones.ExprSimpson13 ( f:String;la,lb,n:float);
var
  m_function:TParseMath;
  i,h,resp,fa,fb,sump,sumi:Float;

begin
  //enviar codigo y binario hasta el domingo


  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;



  h:=(lb-la)/power(2,n);
  m_function.NewValue('x',la);
  fa:=m_function.Evaluate();
  m_function.NewValue('x',lb);
  fb:=m_function.Evaluate();
  sump:=0;
  sumi:=0;
  //for i:=
  i:=la+h;
  repeat
    m_function.NewValue('x',i);
    sumi:=sumi+m_function.Evaluate();
    i:=i+2*h;
  until i>=lb;

  i:=la+2*h;
  repeat
    m_function.NewValue('x',i);
    sump:=sump+m_function.Evaluate();
    i:=i+2*h;

  until i>=lb-h;

  resp:=RoundTo((h/3)*(fa+fb)+(2*h/3)*sump+(4*h/3)*sumi,-6);
  //Result.ResFloat:=(resp);
end;

function TFunciones.ExprEuler( f:String;x0,xf,y0,n:float):String;
var
  m_function:TParseMath;
  res:String;
  yn1,h,y,x,aprox,pendiente:Double;

begin
  res:='';


  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;

   h:=(xf-x0)/n;


   while x0<=xf  do
   begin
   yn1:=y0 +h*funcion2(x0,y0,f);
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(yn1)+'] ; ';


   x:= x0 + h;
   y0:=yn1;
   x0:=x;

   end;



 //  WriteLn(res);

 ShowMessage(res);



 // Result.ResString:=(res);
 Result:=res;
end;

Procedure TFunciones.ExprHeun(   f:String;x0,xf,y0,n:float);
var
  m_function:TParseMath;
  res:String;
  yn1,h,y,x,aprox,pendiente:Double;

begin

 res:='';

  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;

   h:=(xf-x0)/n;
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';



  // x0:= x0 + h;


   while x0+h<=xf  do
   begin



   yn1:=y0 +h*((funcion2(x0,y0,f)+funcion2(x0+h,y0+h*funcion2(x0,y0,f),f))/2);

   x:= x0 + h;
   y0:=yn1;
   x0:=x;
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';

   end;

   if x0<xf then
   begin
   yn1:=y0 +h*((funcion2(x0,y0,f)+funcion2(x0+h,y0+h*funcion2(x0,y0,f),f))/2);

   y0:=yn1;
   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';


   end;



   ShowMessage(res);

  //Result.ResFloat:=(y0);
end;

Procedure TFunciones.ExprRungeKutta3(  f:String;x0,xf,y0,n:float);
var
  m_function:TParseMath;
  res:String;
  k1,k2,k3,k4,h,y,x,temp,pendiente:Double;

begin

  res:='';

  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;

     h:=(xf-x0)/n;

   while x0+h<=xf  do
   begin

   res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';


   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
   k3 := h * funcion2(x0 + (h), y0 -k1+ (2*k2),f);

   pendiente := (k1 + 4*k2+ k3)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

      if x0<xf  then
   begin
      res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';


   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
   k3 := h * funcion2(x0 + (h), y0 -k1+ (2*k2),f);

   pendiente := (k1 + 4*k2+ k3)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;


      ShowMessage(res);



  //Result.ResFloat:=(y);
end;

Procedure TFunciones.ExprRungeKutta4( f:String;x0,xf,y0,n:float);
var
  m_function:TParseMath;
  res:String;
  k1,k2,k3,k4,h,y,x,temp,pendiente:Double;

begin
  res:='';


  m_function:= TParseMath.create();
   m_function.AddVariable( 'x', 0 );
   m_function.Expression:= f;



     h:=(xf-x0)/n;

   while (x0+h<=xf)   do
   begin
     res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';



   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
   k3 := h * funcion2(x0 + (h/2), y0 + (k2/2),f);
   k4 := h * funcion2(x0 + h, y0 + k3,f);
   pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

    if (x0<xf)  then
   begin
     res:=res+'['+FloatToStr(x0)+',';

   res:=res+FloatToStr(y0)+'] ; ';



   x:= x0 + h;
   k1 := h * funcion2(x0, y0,f);
   k2 := h * funcion2(x0 + (h/2), y0 + (k1/2),f);
   k3 := h * funcion2(x0 + (h/2), y0 + (k2/2),f);
   k4 := h * funcion2(x0 + h, y0 + k3,f);
   pendiente := (k1 + 2*k2 + 2*k3 + k4)/6;
   y := y0 + pendiente;

   x0:=x;
   y0:=y;

   end;

    ShowMessage(res);




  //Result.ResFloat:=(y);
end;


Procedure TFunciones.ExprBiy(  f:String;A,B,Error:float);
begin

     tam:=Length(FloatToStr(Error))-2;

     i:=1;

     error2:=20;
     signo:=-1;
     anterior:=0;

  while (error2>Error) do
  begin

  try

   if funcion(A,f)=0 then
    begin
    //Result.resFloat := A;

      Exit;
    end;
  if funcion(B,f)=0 then
    begin
      //Result.resFloat := B;

     Exit;
    end;
  except
   //Result.resFloat := NaN;
     Exit;
  end;
      x:=RoundTo(biyeccion(A,B),-tam);

  //    x:=RoundTo(falsa_posicion(A,B,f),-tam);

  signo:=RoundTo(funcion(A,f)*funcion(x,f),-tam);
  error2:=RoundTo( abs(anterior-x),-tam);
  anterior:=x;

  i:=i+1;
  if signo =0 then
   begin
    //Result.resFloat := x;
   Break;
   Exit;
   end;
  if signo<0 then
    B:=x
  else
    A:=x;
  end;
end;

Procedure TFunciones.ExprFP( f:String;A,B,Error:float);
begin

     tam:=Length(FloatToStr(Error))-2;

  i:=1;
  error2:=20;
      signo:=-1;
      anterior:=0;

  while (error2>Error) do
  begin

  try

   if funcion(A,f)=0 then
    begin
    //Result.resFloat := A;

      Exit;
    end;
  if funcion(B,f)=0 then
    begin
      //Result.resFloat := B;

     Exit;
    end;
  except
   //Result.resFloat := NaN;
     Exit;
  end;
   //   x:=RoundTo(biyeccion(A,B),-tam);

    x:=RoundTo(falsa_posicion(A,B,f),-tam);

  signo:=RoundTo(funcion(A,f)*funcion(x,f),-tam);
  error2:=RoundTo( abs(anterior-x),-tam);
  anterior:=x;

  i:=i+1;
  if signo =0 then
   begin
    //Result.resFloat := x;
   Break;
   Exit;
   end;
  if signo<0 then
    B:=x
  else
    A:=x;
  end;
end;

Procedure TFunciones.ExprSecante(  f:String;B:Integer;A,Error:float);
begin


     tam:=Length(FloatToStr(Error))-2;

     x:=A;
      xn_0:=x-0.1;
    // Error:=0;

      i:=1;
  error2:=20;

    while (error2>Error) do
     begin

      if funcion(x,f)=0 then
       begin
       //Result.resFloat := x;
         //ShowMessage('La raiz es:'+FloatToStr(x));
         Exit;
       end;
     if derivada(x,f)=0 then
       begin
         //Result.resFloat := NaN;
       // ShowMessage('La funcion no es continua o tiene picos');
        Exit;
       end;


     if B=1 then
       xn_1:=RoundTo(derivada1(x,f,Error),-tam);
     if B=3 then
       xn_1:=RoundTo(derivada3(x,f,Error),-tam);
     if B=2 then
       begin
        xn_1:=RoundTo(derivada2(x,f,Error,xn_0),-tam);
        error2:=RoundTo( abs(x-xn_1),-tam);
       end
     else
     begin
     error2:=RoundTo( abs(x-xn_1),-tam);
     end;
     xn_0:=x;
     x:=xn_1;
     i:=i+1;

   end;
         //Result.resFloat := x;
end;

Procedure TFunciones.ExprLagrange(  f:String;A,B,Error:float);

begin


     //Result.ResString := f;


end;

//falta ver lo de newton

Procedure TFunciones.ExprNewton( f,d:String;A,Error:float);
begin

     tam:=Length(FloatToStr(Error))-2;

    //ShowMessage('A'+FloatToStr(A));
     i:=1;
      error2:=20;
      signo:=-1;
      anterior:=0;

      x:=A;
     // Error:=0;

     while (error2>Error) do
      begin
       if funcion(x,f)=0 then
        begin
         //Result.resFloat := x;
        //  ShowMessage('La raiz es:'+FloatToStr(x));
          Exit;
        end;
      if derivada(x,f)=0 then
        begin
         //Result.resFloat := NaN;
        // ShowMessage('La funcion no es continua o tiene picos');
         Exit;
        end;
      xn_1:=RoundTo(newton(x,f,d),-tam);
      ////////ingresar la funcion derivada
      error2:=RoundTo( abs(x-xn_1),-tam);
      x:=xn_1;
      i:=i+1;

    end;
     //Result.resFloat := x;


end;




end.

