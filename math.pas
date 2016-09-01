unit math;
    
interface

uses variants;

function Divide(x:longint;y:longint):Variant;

implementation

function Divide(x:longint;y:longint):Variant;
	begin
		Divide:=x/y;
	end;
end.