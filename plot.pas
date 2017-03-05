{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
unit plot;

interface

uses programstr;
  
procedure ActiveGraph;
procedure ExitGraph;
procedure ClearGraph;
procedure RestartGraph;
procedure Grid(lx,ly:byte);
procedure XYPlot(lx,lY:Byte);
// procedure PlotFx1(a,b:integer); deprecated
procedure PlotFx2(a:TStr;p:byte);   // p for last entry

implementation

uses
    graph,lang,basic,equ;

var
    GActive:Boolean=False;
    XYPlotted:boolean=False;
    gd,gm:smallint;
    RootX,RootY:word;
    sizeX:byte=16;
    sizeY:byte=16;

procedure ActiveGraph;
begin
    if GActive then write(GEnabledMsg) else
    begin
	    write(GLoadMsg);
	    gd:=Detect;
        gm:=0;
        InitGraph(gd,gm,'C:\PP\BGI');
        GActive:=GraphResult=grok;
        RootX:=GetMaxX div 2;
        RootY:=GetMaxY div 2;
        if GraphResult<>grok then ErrInp(Num2Str(GraphResult),6)
        else write(DoneMsg);
    end;
end;

procedure ExitGraph;
begin
    if not GActive then write(GDisabledMsg) else begin
        write(GCloseMsg);
        Closegraph;
        GActive:=False;
    end;
end;

procedure ClearGraph;
begin
    if not GActive then write(GDisabledMsg) else begin
        ClearDevice;
        write('Cleared !');
    end;
end;

procedure RestartGraph;
begin
    if not GActive then write(GDisabledMsg) else begin
        ExitGraph;
        ActiveGraph;
    end;
end;

procedure Grid(lX,lY:byte);
Var i:integer;
Begin
    if not GActive then write(GDisabledMsg) else begin
        SetColor(LightBlue);
        SetLineStyle(DashedLn,0,NormWidth);
        if lX=0 then lx:=SizeX else SizeX:=lx;
        if lY=0 then lY:=SizeY else SizeY:=ly;
        for i:=1 to RootX div lx do begin
            Line(-lx*i,2-RootY,-lx*i,RootY-2);
            Line(lx*i,2-RootY,lx*i,RootY-2);
        end;
        for i:=1 to RootY div lY do begin
            Line(2-RootX,-lY*i,RootX-2,-lY*i);
            Line(2-RootX,lY*i,RootX-2,lY*i);
        end;
    end;
end;

procedure XYPlot(lX,lY:byte);
Begin
    if not GActive then write(GDisabledMsg) else begin
        XYPlotted:=True;
        SetFillStyle(SolidFill,Blue);
        SetViewPort(RootX,RootY,GetMaxX,GetMaxY,False);
        Bar(-RootX,-RootY,RootX,RootY);
        Grid(lx,lY);
        SetColor(White);
        SetLineStyle(SolidLn,0,ThickWidth);
        Line(0,10-RootY,0,RootY-1);
        OuttextXY(RootX-10,10,'x');
        Line(1-RootX,0,RootX-10,0);
        OuttextXY(-10,10-RootY,'y');
        SetLineStyle(Solidln,0,NormWidth);
        OutTextXY(10,10,'O');
    end;
End;

// Old, deprecated
// procedure PlotFx1(a,b:integer); 
// var x1,y1,x2,y2:integer;
// begin
//     if not GActive then write(GNotEnabledMsg) else
//     begin
//         x1:=-20;
// 	    y1:=(a*x1)+b;
//         x2:=20;
//         y2:=(a*x2)+b;
//         XYPlot;
//         SetColor(Yellow);
//         x1:=(GetMaxX div 2)-x1*20;
//         x2:=(GetMaxX div 2)-x2*20;
//         y1:=(GetMaxY div 2)-y1*20;
//         y2:=(GetMaxY div 2)-y2*20;
//         Line(x2,y1,x1,y2);
//         write(DoneMsg);
//     end;
// end;

procedure PlotFx2(a:TStr;p:byte);   // Plot Gen 2, more reliable
var x,y:Extended;
    function Coord():Extended;
    var i:byte;
    begin
        Coord:=0;
        for i:=p downto 1 do
            Coord:=Coord+(Str2Num(a[p+1-i]).val)*Mu(x,i-1);
    end;
begin
    if not GActive then write(GNotEnabledMsg) else begin
        if not XYPlotted then XYPlot(0,0);
        x:=-RootX div SizeX;
        while x<(RootX div SizeX) do begin
            x:=x+0.0005;
            y:=coord;
            if (-y*SizeY>-RootY) and (-y*SizeY<RootY) then
                PutPixel(Round(x*SizeX),-Round(y*SizeY),Yellow);
        end;
end;
end;

end.