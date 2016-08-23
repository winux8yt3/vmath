unit math;
    
interface

function Plus(x:longint;y:longint):longint;
function Minus(x:longint;y:longint):longint;
function Multiply(x:longint;y:longint):longint;
function Divide(x:longint;y:longint):extended;
function DivideInt(x:longint;y:longint):longint;
function Power(x:longint;y:longint):int64;

implementation
    
function Plus(x:longint;y:longint):longint;
	begin
		Plus:=x+y;
	end;
	
function Minus(x:longint;y:longint):longint;
	begin
		Minus:=x-y;
	end;
	
function Multiply(x:longint;y:longint):longint;
	begin
		Multiply:=x*y;
	end;
	
function Divide(x:longint;y:longint):extended;
	begin
		Divide:=x/y;
	end;

function DivideInt(x:longint;y:longint):longint;
	begin
		DivideInt:=x div y;
	end;

function Power(x:longint;y:longint):int64;
	var i:longint;
	begin
		Power:=x;
		if y<>0 then begin	
			while i<=y do Power:=Power*y;
			inc(i);
		end
		else Power:=1;
	end;
end.