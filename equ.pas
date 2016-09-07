unit equ;
    
interface

uses basic,math,lang;

var 
    dec:word = 2;
    ans:extended;
    err:word;

procedure Equation(s:string);
function EquProcess(s:string):extended;
function Bool(s:string):boolean;
procedure cqe2(a,b,c:extended);
procedure fact(num:Longword);

implementation

procedure Equation(s:string);
begin
    if (pos('=',s)<>0) or (pos('<',s)<>0) or (pos('>',s)<>0) then
        writeln(bool(ClrSpace(s)))
    else if (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('*',s)<>0)
	    or (pos('/',s)<>0) or (pos('^',s)<>0) then
		begin
		   	ans:=EquProcess(ClrSpace(s));
		   	writeln(ans:0:dec);
		end
    else writeln(EReport(s,ErrorId1));
end;


procedure NumProcess(s:string;k:word; var n1,n2:extended);
begin
	n1:=EquProcess(copy(s,1,k-1));
	n2:=EquProcess(copy(s,k+1,(length(s)-k)));
end;

function EquProcess(s:string):extended;
var 
	n1,n2:extended;
begin
	if (pos('+',s)<>0) then begin
		NumProcess(s,pos('+',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('-',s)<>0) then begin
		NumProcess(s,poslast('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) then begin
		NumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) then begin
		NumProcess(s,poslast('/',s),n1,n2);
		EquProcess:=n1/n2;
	end	
	else if (pos('^',s)<>0) then begin
		NumProcess(s,pos('^',s),n1,n2);
		EquProcess:=Power(n1,n2);
	end
	else if (Str2Num(s).Check=True) and (s<>'') then EquProcess:=Str2Num(s).value
            else writeln(EReport(s,ErrorId1));
end;
// Loop back EquProcess function if there is a complex Equation

function Bool(s:string):boolean;
var n1,n2:extended;
begin
    bool := False;
    if (pos('=',s)<>0) then begin
        NumProcess(s,pos('=',s),n1,n2);
        if n1=n2 then bool:=True;
    end
    else if (pos('<',s)<>0) then begin
        NumProcess(s,pos('<',s),n1,n2);
        if n1<n2 then bool:=True;
    end
    else if (pos('>',s)<>0) then begin
        NumProcess(s,pos('>',s),n1,n2);
        if n1>n2 then bool:=True;
    end
end;

procedure cqe2(a,b,c:extended);
var 
    delta:extended;
begin
    if a<>0 then begin
	    delta:=(b*b-4*a*c);
	    if delta<0 then writeln(cqe0Text)
    	else if delta>0 then writeln(cqe2Text,'x1= ',((-b+delta)/(2*a)):0:dec,' | x2= ',((-b-delta)/(2*a)):0:dec)
        else writeln(cqe1Text,(-b/(2*a)):0:dec);
    end
    else writeln(EReport('',ErrorId1));
end;
    
procedure fact(num:Longword);
var 
	i,k,n:longword;
	c,count,check:word;
begin
	for k:=2 to num do begin
		n:=num;c:=0;count:=0;check:=0;
		for i:=1 to k do
			if k mod i = 0 then inc(c);
		if c=2 then
			while n mod k = 0 do begin
				n:=n div k;
				inc(count);
			end;
		if count = 1 then
			begin
				if check=0 then inc(check)
					else write('*');
				write(k);
			end
		else 
			begin
				if check=0 then inc(check)
					else write('*');	
				write(k,'^',count);
			end;
	end;
	writeln;
end;

end.