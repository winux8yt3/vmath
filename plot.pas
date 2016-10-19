unit plot;
    
interface
    
uses
    graph,lang,programstr,basic;
    
procedure ActiveGraphic;
procedure PlotFx1(a,b:integer);

implementation

var 
    gd,gm:integer;

procedure ActiveGraphic;
begin
	write('Graphic Load . . .');
	gd:=Detect;
    gm:=0;
    InitGraph(gd,gm,'C:\PP\BGI');
    if GraphResult<>grok then begin
        write(EReport(Num2Str(GraphResult,0),ErrorId6));
        exit;
    end;
end;

procedure XYPlot;// limit
begin
    SetColor(White);
    Line(GetMaxX div 2,10,GetMaxX div 2,GetMaxY-10);
    OuttextXY(GetMaxX div 2,5,'y');
    Line(10,GetMaxY div 2,GetMaxX-10,GetMaxY div 2);
    OuttextXY(GetMaxX-5,GetMaxY div 2,'x');
end;

procedure PlotFx1(a,b:integer);
var x1,y1,x2,y2:integer;
begin
    x1:=-20;
	y1:=a*x1+b;
    x2:=20;
    y2:=a*x2+b;
    ActiveGraphic;
    XYPlot;
    SetColor(Yellow);
    x1:=x1+(GetMaxX div 2);
    x2:=x2+(GetMaxX div 2);
    y1:=y1+(GetMaxY div 2);
    y2:=y2+(GetMaxY div 2);
    Line(x1,y1,x2,y2);
    readln;
    closegraph;
end;

end.