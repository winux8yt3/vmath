unit graphic;
    
interface
    
uses
    graph,lang,programstr,basic;
    
procedure ActiveGraphic;
procedure EndGraphic;

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
        write(EReport('',ErrorId6));
        exit;
    end;
end;

procedure EndGraphic;
begin
    write('Closing Graph System . . .');CloseGraph;
end;
{
procedure Fx2Draw(a,b:real);
var x0,y0:real;
begin
	x0:=a*0+b;
    y0:=/a;
    ActiveGraphic;
end;
}

end.