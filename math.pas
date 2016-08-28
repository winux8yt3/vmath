unit math;
    
interface

function Divide(x:longint;y:longint):Variant;
function Power(x:longint;y:longint):int64;

implementation

function Divide(x:longint;y:longint):Variant;
	begin
		Divide:=x/y;
	end;

function Power(x:variant;y:longint):variant;
	var i:longint;
	begin
		Power:=1;
		if y<>0 then 
			for i:=0 to y do Power:=Power*x;
	end;
end.