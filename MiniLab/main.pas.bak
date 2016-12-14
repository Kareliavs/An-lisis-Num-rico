unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,parsestring,cmatriz, FileUtil, uCmdBox, TAGraph, TARadialSeries, TASeries,
  TAFuncSeries, Forms, Controls, Graphics,   TAChartUtils,
  Dialogs, ComCtrls, Grids, ValEdit, ExtCtrls, ShellCtrls, EditBtn, Menus, ParseMath,
  StdCtrls, spktoolbar, spkt_Tab, spkt_Pane, spkt_Buttons, spkt_Checkboxes, Types, TACustomSeries,
   Matrix, Inversa, NewtonG, Jacobiana, Lagrange1,
   integral,Conversor,EDO
  ;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    Plotchar: TChart;
    CmdBox: TCmdBox;
    dEdit: TDirectoryEdit;
    lblCommandHistory: TLabel;
    lblCommandHistory1: TLabel;
    lblFileManager: TLabel;
    pgcRight: TPageControl;
    Ejex: TConstantLine;
    Ejey: TConstantLine;
    Funcion: TFuncSeries;
    Plotear: TLineSeries;
    pnlArvhivos: TPanel;
    pnlCommand: TPanel;
    pnlPlot: TPanel;
    slvFiles: TShellListView;
    stvDirectories: TShellTreeView;
    spkcheckSeePlot: TSpkCheckbox;
    SpkLargeButton1: TSpkLargeButton;
    SpkLargeButton2: TSpkLargeButton;
    SpkLargeButton3: TSpkLargeButton;
    SpkLargeButton4: TSpkLargeButton;
    SpkLargeButton5: TSpkLargeButton;
    SpkPane1: TSpkPane;
    SpkPane2: TSpkPane;
    SpkPane3: TSpkPane;
    spkRdoPlotIn: TSpkRadioButton;
    spkRdoPlotEx: TSpkRadioButton;
    SpkTab1: TSpkTab;
    SpkToolbar1: TSpkToolbar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    StatusBar1: TStatusBar;
    tbtnClosePlot: TToolButton;
    tshcomandos: TTabSheet;
    tshVariables: TTabSheet;
    tBarPlot: TToolBar;
    tvwHistory: TTreeView;
    ValueListEditor1: TValueListEditor;
    procedure CmdBoxInput(ACmdBox: TCmdBox; Input: string);
    procedure dEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FuncionCalculate(const AX: Double; out AY: Double);
    procedure Label1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Notebook1ChangeBounds(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure PlotearDrawPointer(ASender: TChartSeries; ACanvas: TCanvas;
      AIndex: Integer; ACenter: TPoint);
    procedure spkcheckSeePlotClick(Sender: TObject);
    procedure Splitter2CanOffset(Sender: TObject; var NewOffset: Integer;
      var Accept: Boolean);
    procedure StaticText1Click(Sender: TObject);
    procedure tbtnClosePlotClick(Sender: TObject);
    procedure tshcomandosContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ValueListEditor2Click(Sender: TObject);
  private
    { private declarations }
    ListVar: TStringList;
    Parse: TParseMathString;
    aba,bab,x0,y0: Double;
    nan,op:Integer;
     Parse1: TParseMath;
    fx:String;

    procedure StartCommand();

  public
    function f( x: Double ): Double;
    { public declarations }
  end;

var
  frmMain: TfrmMain;
  Max, Min, h, NewX, Newy: Real;

implementation

{$R *.lfm}

{ TfrmMain }


procedure TfrmMain.dEditChange(Sender: TObject);
begin
  if DirectoryExists(dEdit.Text) then
  stvDirectories.Root:= dEdit.Text;
end;

procedure TfrmMain.StartCommand();
begin
   CmdBox.StartRead( clBlack, clWhite,  'MiniLab-->', clBlack, clWhite);
end;

procedure TfrmMain.CmdBoxInput(ACmdBox: TCmdBox; Input: string);
var FinalLine,inicio,temp,tempa,tempb: string;
  A,rpta:TAmatriz;
  i,j,start,k,aa,b,lol:Integer;
  fin:Double;
  resul:TEDO;
  resulag:TLagrange;
  ok:String;
   conv: TConversor;
  okmat2, okmat1,okmat:matriz;

  procedure AddVariable( EndVarNamePos: integer );
  var PosVar: Integer;
    const NewVar= -1;
  begin

    PosVar:= ListVar.IndexOfName( trim( Copy( FinalLine, 1, EndVarNamePos  ) ) );

    with ValueListEditor1 do
    case PosVar of
         NewVar: begin
                  ListVar.Add(  FinalLine );
                  if FinalLine[Pos( '=', FinalLine )+1]='[' then
                    Parse.AddVariableString( ListVar.Names[ ListVar.Count - 1 ], ( ListVar.ValueFromIndex[ ListVar.Count - 1 ]) )
                  else
                      Parse.AddVariable( ListVar.Names[ ListVar.Count - 1 ], StrToFloat( ListVar.ValueFromIndex[ ListVar.Count - 1 ]) );


                  Cells[ 0, RowCount - 1 ]:= ListVar.Names[ ListVar.Count - 1 ];
                  Cells[ 1, RowCount - 1 ]:= ListVar.ValueFromIndex[ ListVar.Count - 1 ];
                  RowCount:= RowCount + 1;


         end else begin
              ListVar.Delete( PosVar );
              ListVar.Insert( PosVar,  FinalLine );
              Cells[ 0, PosVar + 1 ]:= ListVar.Names[ PosVar ] ;
              Cells[ 1, PosVar + 1 ]:= ListVar.ValueFromIndex[ PosVar ];
               if FinalLine[Pos( '=', FinalLine )+1]='[' then
                    Parse.NewValuestring( ListVar.Names[ PosVar ], ( ListVar.ValueFromIndex[ PosVar ] ) )
                  else
                      Parse.NewValue( ListVar.Names[ PosVar ], StrToFloat( ListVar.ValueFromIndex[ PosVar ] ) ) ;

           //   Parse.NewValue( ListVar.Names[ PosVar ], StrToFloat( ListVar.ValueFromIndex[ PosVar ] ) ) ;

          end;

    end;


  end;

  procedure Execute();
  begin
      Parse.serExpression(Input);
      CmdBox.TextColors(clBlack,clWhite);
      CmdBox.Writeln( LineEnding +   Parse.Evaluates()   + LineEnding);
  end;

begin
  Input:= Trim(Input);
  case input of
       'help': ShowMessage( 'help ');
       'exit': Application.Terminate;
       'clear': begin CmdBox.Clear; StartCommand() end;
       'clearhistory': CmdBox.ClearHistory;

        else begin
  FinalLine:=  StringReplace ( Input, ' ', ' ', [ rfReplaceAll ] );


    //  AddVariable( Pos( '=', FinalLine ) - 1 );  //bota la x
      if FinalLine[Pos( '=', FinalLine )+1]='[' then
         begin

          A:=TAmatriz.Create;


          A.f:=1;
          A.c:=1;
          i:=Pos( '=', FinalLine )+2;

          while i< length(FinalLine)-1 do
          begin
            if FinalLine[i]= ',' then
             begin
              A.f:=A.f +1;
                i:=i+1;
                A.c:=1;
               ShowMessage('fila'+IntToStr(A.f))

             end
            else
            begin
             start:=i;
            while FinalLine[i]<> ' ' do
                begin
                i:=i+1;
                end;

             inicio:=Copy(FinalLine,start,i-start);
             A.matrix[A.f,A.c]:=StrToFloat(inicio);
             A.c:=A.c +1;
            end;
            i:=i+1;

          end;
           temp:= FinalLine[ Pos( '=', FinalLine ) - 1];
        //  m[Ord( FinalLine[ Pos( '=', FinalLine ) - 1])]:=A;



        {  with ValueListEditor1 do
          begin
                  ListVar.Add(  FinalLine );

                  //.AddVariable( ListVar.Names[ ListVar.Count - 1 ], StrToFloat( ListVar.ValueFromIndex[ ListVar.Count - 1 ]) );
                  ValueListEditor1.Cells[ 0, RowCount - 1 ]:= ListVar.Names[ ListVar.Count - 1 ];
                  ValueListEditor1.Cells[ 1, RowCount - 1 ]:= ListVar.ValueFromIndex[ ListVar.Count - 1 ];
                  RowCount:= RowCount + 1;
          end;

         }
         AddVariable( Pos( '=', FinalLine ) - 1 );
         Execute();
         end
  else
      begin
      //ShowMessage('Aqui entra');




             if Pos( '=', FinalLine ) > 0 then
              begin
                FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
                AddVariable( Pos( '=', FinalLine ) - 1 )
              end
             else if(pos('graficar',FinalLine) >0) then
              begin
                 FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
                 fx:=(copy(FinalLine,pos('(',FinalLine)+1, pos(';',FinalLine)-1-pos('(',FinalLine)));
                 delete(FinalLine,pos('(',FinalLine)+1, pos(';',FinalLine)-pos('(',FinalLine));
                 aba:=StrToFloat(copy(FinalLine,pos('(',FinalLine)+1, pos(';',FinalLine)-1-pos('(',FinalLine)));
                 delete(FinalLine,pos('(',FinalLine)+1, pos(';',FinalLine)-pos('(',FinalLine));
                 bab:=StrToFloat(copy(FinalLine,pos('(',FinalLine)+1, pos(')',FinalLine)-1-pos('(',FinalLine)));

                Funcion.Active:=False;
                  Plotear.Clear;
                  Max:=  bab;
                  Min:=  aba;
                  h:= (Max - Min) /( 10 * Max );
                  Plotear.Marks.Style:= smsValue;
                  Plotear.ShowPoints:= true;
                  NewX:= Min;

                  while NewX < Max do begin
                     Plotear.AddXY( NewX, f( NewX ) );
                     NewX:= NewX + h;
                  end;

                end
             ////////////EDO
             else if(pos('EDO',FinalLine) >0) then
              begin
              FinalLine:=  StringReplace ( Input, ' ', '', [ rfReplaceAll ] );
              fx:=(copy(FinalLine,pos('(',FinalLine)+2, pos(',',FinalLine)-3-pos('(',FinalLine)));

               delete(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-pos('(',FinalLine));
               aba:=StrToFloat(copy(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-1-pos('(',FinalLine)));
               delete(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-pos('(',FinalLine));
               bab:=StrToFloat(copy(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-1-pos('(',FinalLine)));
               delete(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-pos('(',FinalLine));
               x0:=StrToFloat(copy(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-1-pos('(',FinalLine)));
               delete(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-pos('(',FinalLine));
               nan:=StrToInt(copy(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-1-pos('(',FinalLine)));
               delete(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-pos('(',FinalLine));
               op:=StrToInt(copy(FinalLine,pos('(',FinalLine)+1, pos(')',FinalLine)-1-pos('(',FinalLine)));
               //ShowMessage(fx+' '+FloatToStr(aba)+' '+FloatToStr(bab)+' '+FloatToStr(x0)+' '+IntToStr(n)+' '+IntToStr(op));
                resul:=TEDO.create(fx,aba,bab,x0,nan);
                //Result.resFloat := resul.RK4Evaluate();
                Case op  of
                1 :resul.EulerEvaluate();
                2 :resul.HeunEvaluate();
                3 :resul.RK3Evaluate();
                4 :resul.RK4Evaluate();
                else ShowMessage('OPCION INCORRECTA 0=Euler 1=Heun 2=RK3 3=RK4');
                end;
                okmat1:=resul.MatXn;
                okmat:=resul.MatYn;
                 Execute;

                  Funcion.Active:= False;
                  Plotear.Clear;

                  Max:=  bab;
                  Min:=  aba;

                  Plotear.Marks.Style:= smsValue;
                  Plotear.ShowPoints:= true;

                  for i:=0 to nan do begin
                  Plotear.AddXY(okmat1[i][0],okmat[i][0]);
                  end;
                  CmdBox.TextColors(clBlack,clWhite);
                  CmdBox.Writeln( LineEnding + FloatToStr(okmat[i][0]) +'     '+ LineEnding);


              end
             ///Lagrange
             else if(pos('lagrange',FinalLine) >0) then
              begin

              fx:=(copy(FinalLine,pos('(',FinalLine)+2, pos(',',FinalLine)-3-pos('(',FinalLine)));

               delete(FinalLine,pos('(',FinalLine)+1, pos(',',FinalLine)-pos('(',FinalLine));
               aba:=StrToFloat(copy(FinalLine,pos('(',FinalLine)+1, pos(')',FinalLine)-1-pos('(',FinalLine)));
               conv:=TConversor.create();
               conv.CadenaAMatriz(fx);
               //ShowMessage(fx);
               lol:=conv.Columnas(fx);
               resulag:=TLagrange.create(conv.CadenaAMatriz(fx),lol,aba);
               //resulag.Evaluate();
               okmat2:=resulag.Larraya;
                 Execute;

                  Funcion.Active:= False;
                  Plotear.Clear;

                  Max:=  okmat2[0][0];
                  Min:=  okmat2[lol][0];

                  Plotear.Marks.Style:= smsValue;
                  Plotear.ShowPoints:= true;

                  for i:=0 to lol-1 do begin
                  //ShowMessage(FloatToStr(okmat2[i][0])+'   '+FloatToStr(okmat2[i][1]));
                  Plotear.AddXY(okmat2[i][0],okmat2[i][1]);
                  end;
                  CmdBox.TextColors(clBlack,clWhite);
                  //CmdBox.Writeln( LineEnding + FloatToStr(okmat2[i][1]) +'     '+ LineEnding);


              end

             else
                Execute;

      end;






        end;

  end;
  StartCommand()
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  CmdBox.StartRead( clBlack, clWhite,  'MiniLab-->', clBlack, clWhite);

  with ValueListEditor1 do begin
    Cells[ 0, 0]:= 'Nombre';
    Cells[1, 0]:= 'Valor';
    Clear;

  end;

  ListVar:= TStringList.Create;
  Parse:= TParseMathString.create();
  Parse1:= TParseMath.create();
   Parse1.AddVariable('x',0.0);
end;


procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ListVar.Destroy;
  Parse.Destroy;
  Parse1.Destroy;
end;

procedure TfrmMain.FuncionCalculate(const AX: Double; out AY: Double);
begin

end;

procedure TfrmMain.Label1Click(Sender: TObject);
begin

end;

procedure TfrmMain.Memo1Change(Sender: TObject);
begin

end;

procedure TfrmMain.Notebook1ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmMain.Panel1Click(Sender: TObject);
begin

end;

procedure TfrmMain.PlotearDrawPointer(ASender: TChartSeries; ACanvas: TCanvas;
  AIndex: Integer; ACenter: TPoint);
begin

end;

procedure TfrmMain.spkcheckSeePlotClick(Sender: TObject);
begin
  pnlPlot.Visible:= not pnlPlot.Visible;
end;

procedure TfrmMain.Splitter2CanOffset(Sender: TObject; var NewOffset: Integer;
  var Accept: Boolean);
begin

end;

procedure TfrmMain.StaticText1Click(Sender: TObject);
begin

end;

procedure TfrmMain.tbtnClosePlotClick(Sender: TObject);
begin
  spkcheckSeePlot.Checked:= False;
  pnlPlot.Visible:= False;
end;

procedure TfrmMain.tshcomandosContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TfrmMain.ValueListEditor2Click(Sender: TObject);
begin

end;

function TfrmMain.f( x: Double ): Double;
begin
     //Parse1.AddVariable('x',0.0);
     parse1.Expression:= fx;
     Parse1.NewValue('x' , x );
     Result:= Parse1.Evaluate();
end;

end.

