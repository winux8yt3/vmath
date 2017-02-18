unit plot;
    
interface
    
uses
    graph,lang,programstr,basic;

procedure ActiveGraph;
procedure ExitGraph;
procedure ClearGraph;
procedure PlotFx1(a,b:integer);

implementation

var
    GActive:Boolean=False; 
    gd,gm:integer;

procedure ActiveGraph;
begin
    if GActive=True then write(GEnabledMsg) else
    begin
	    write(GLoadMsg);
	    gd:=Detect;
        gm:=0;
        InitGraph(gd,gm,'C:\PP\BGI');
        if GraphResult<>grok then ErrInp(Num2Str(GraphResult,0),6)
        else GActive:=True;
    end;
end;

procedure ExitGraph;
begin
    if GActive=False then write(GDisabledMsg) else begin
        write(GCloseMsg);
        Closegraph;
        GActive:=False;
    end;
end;

procedure ClearGraph;
begin
    if GActive=False then write(GDisabledMsg) else begin
        ClearDevice;
        write('Cleared !');
    end;
end;

procedure XYPlot;// limit
begin
    SetColor(White);
    Line(GetMaxX div 2,15,GetMaxX div 2,GetMaxY-15);
    OuttextXY(GetMaxX div 2,7,'y');
    Line(15,GetMaxY div 2,GetMaxX-15,GetMaxY div 2);
    OuttextXY(GetMaxX-7,GetMaxY div 2,'x');
end;

procedure PlotFx1(a,b:integer);
var x1,y1,x2,y2:integer;
begin
    if GActive=False then write(GNotEnabledMsg) else
    begin
        x1:=-20;
	    y1:=(a*x1)+b;
        x2:=20;
        y2:=(a*x2)+b;
        XYPlot;
        SetColor(Yellow);
        x1:=(GetMaxX div 2)-x1*20;
        x2:=(GetMaxX div 2)-x2*20;
        y1:=(GetMaxY div 2)-y1*20;
        y2:=(GetMaxY div 2)-y2*20;
        Line(x2,y1,x1,y2);
        write(DoneMsg);
    end;
end;

end.