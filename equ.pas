unit equ;
    
interface

uses basic,math,lang;

var 
    dec:word = 2;
    ans:extended;

procedure Equation(s:string);
function EquProcess(s:string):extended;

implementation
    
procedure Equation(s:string);
begin
	s:=ClrSpace(s);
	if (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('*',s)<>0) or (pos('/',s)<>0) 
		or (pos('^',s)<>0)
		then begin
			ans:=EquProcess(s);
			writeln(ans:0:dec);
		end
	else writeln('<',s,'> : ',ErrorId1);
end;


procedure EquNumProcess(s:string;k:word; var n1,n2:extended);
begin
	n1:=EquProcess(copy(s,1,k-1));
	n2:=EquProcess(copy(s,k+1,(length(s)-k)));
end;

function EquProcess(s:string):extended;
var 
	n1,n2:extended;
	err:word;
begin
	if (pos('+',s)<>0) then begin
		EquNumProcess(s,pos('+',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('-',s)<>0) then begin
		EquNumProcess(s,poslast('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) then begin
		EquNumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) then begin
		EquNumProcess(s,poslast('/',s),n1,n2);
		EquProcess:=n1/n2;
	end	
	else if (pos('^',s)<>0) then begin
		EquNumProcess(s,pos('^',s),n1,n2);
		EquProcess:=Power(n1,n2);
	end
	else EquProcess:=Str2Int(s,err);
end;
// Loop back EquProcess function if there is a complex Equation

    
end.