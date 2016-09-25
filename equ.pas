unit equ;
    
interface

uses 
	basic,math,lang,programStr;

var 
    err:word;

procedure Equation(s:string);
function EquProcess(s:string):extended;
function VarPos(s:string;a:TVar):word;
procedure VarProcess(s:shortstring);
function Bool(s:string):boolean;
procedure eqn2(a,b,c:extended);
function fact(num:Longword):string;
function NumInCheck(t:tStr;endNum:word):boolean;
function gcd(t:tNum;n:word):longword;
function lcm(t:tNum;n:word):longword;

implementation

procedure Equation(s:string);
begin
	if (pos('==',s)<>0) and (pos('==',s)=poslast('==',s))
		then VarProcess(ClrSpace(s))
{   else if (pos('=',s)<>0) and (pos('=',s)=poslast('=',s)) 
		or (pos('<',s)<>0) and (pos('<',s)=poslast('<',s)) 
		or (pos('>',s)<>0) and (pos('>',s)=poslast('>',s)) 
			then writeln(bool(ClrSpace(s)))}
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

procedure BoolProcess(s:string;k:word; var n1,n2:boolean);
begin
	n1:=Bool(copy(s,1,k-1));
	n2:=Bool(copy(s,k+1,(length(s)-k)));
end;

function EquProcess(s:string):extended;
var 
	n1,n2:extended;
begin
	if (pos('+',s)<>0) and ((pos('+',s)>poslast(')',s)) or (pos('+',s)<pos('(',s))) then begin
		NumProcess(s,pos('+',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('-',s)<>0) and ((pos('-',s)>poslast(')',s)) or (pos('-',s)<pos('(',s))) then begin
		NumProcess(s,poslast('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) and (s<>'') and ((pos('*',s)>poslast(')',s)) or (pos('*',s)<pos('(',s))) then begin
		NumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) and (s<>'') and ((pos('/',s)>poslast(')',s)) or (pos('/',s)<pos('(',s))) then begin
		NumProcess(s,poslast('/',s),n1,n2);
		if (n2=0) or (n1=0) then writeln(EReport(s,ErrorId2))
		else EquProcess:=n1/n2;
	end
	else if (pos('^',s)<>0) and (s<>'') and ((pos('^',s)>poslast(')',s)) or (pos('^',s)<pos('(',s))) then begin
		NumProcess(s,pos('^',s),n1,n2);
		EquProcess:=Power(n1,n2);
	end
	else if (pos('(',s)<>0) and (pos(')',s)<>0) and (pos(')',s)-pos('(',s)>1) then 
		EquProcess:=EquProcess(copy(s,2,length(s)-2))
	else if (VarPos(s,Vars)<>0) and (Str2Num(s).check=False)
		then EquProcess:=Vars[VarPos(s,Vars)].value
	else if (Str2Num(s).Check=True) and (s<>'') then EquProcess:=Str2Num(s).value
	else exit;
end;
// Loop back EquProcess function if there is a complex Equation

function Bool(s:string):boolean;
var 
	n1,n2:extended;
	b1,b2:boolean;
begin
    bool := False;
	if (pos('|',s)<>0) then begin
		BoolProcess(s,pos('|',s),b1,b2);
        if (b1=True) or (b2=True) then bool:=True;
	end
	else if (pos('&',s)<>0) then begin
		BoolProcess(s,pos('&',s),b1,b2);
        if (b1=True) and (b2=True) then bool:=True;
	end
    else if (pos('=',s)<>0) then begin
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

function VarPos(s:string;a:TVar):word;
var i:word;
begin
	VarPos:=0;
	i:=0;
	while (s<>a[i].vname) and (i<35566) do begin
		inc(i);
		if s=a[i].vname then VarPos:=i;
	end;
end;

procedure VarProcess(s:string);
var 
	str:shortstring;
	k:word;
	eq:Extended;
begin
	k:=pos('==',s);
	str:=copy(s,1,k-1);
	eq:=EquProcess(copy(s,k+2,(length(s)-k-1)));
	ans:=eq;
	if Str2Num(s).check=False then begin
		if VarPos(str,Vars)=0 then	
		begin
			inc(VarNum);
			Vars[VarNum].vname:=str;
		end;
	Vars[VarPos(str,Vars)].value:=eq;
	writeln(str,' = ',eq:0:dec);
	end
	else writeln(EReport(str,ErrorId4))
end;

procedure eqn2(a,b,c:extended);
var 
    delta:extended;
begin
    if a<>0 then begin
	    delta:=(b*b-4*a*c);
	    if delta<0 then writeln(eqn0Text)
    	else if delta>0 then writeln(eqn2Text,'x1= ',((-b+delta)/(2*a)):0:dec,' | x2= ',((-b-delta)/(2*a)):0:dec)
        else writeln(eqn1Text,(-b/(2*a)):0:dec);
    end
    else writeln(EReport('',ErrorId1));
end;
    
function fact(num:Longword):string;
var 
	k:longword;
	count,check:word;
begin
	check:=0;fact:='';k:=1;
	while k<=num do begin
		count:=0;inc(k);
		while num mod k = 0 do begin
			num:=num div k;
			inc(count);
		end;
		if count = 1 then
			begin
				if check=0 then inc(check)
					else Fact:=Fact+' * ';
				Fact:=Fact+Num2Str(k,0);
			end
		else if count > 1 then
			begin
				if check=0 then inc(check)
					else Fact:=Fact+' * ';
				Fact:=Fact+Num2Str(k,0)+'^'+Num2Str(count,0);
			end;
	end;
end;

function NumInCheck(t:tStr;endNum:word):boolean;
var i:word;
begin
	NumInCheck:=true;
	for i:=1 to endNum do if (Str2Int(t[i]).check=false)
		or (Str2Int(t[i]).value<=0) then NumInCheck:=false;
	if NumInCheck=False then writeln(EReport('',ErrorId4));
end;

function gcd(t:tNum;n:word):longword;
var 
	i,k:longword;
	c,j:word;
begin
	k:=t[1];
	for i:=2 to n do
		if t[i]<k then k:=t[i];
	gcd:=1;
	for i:=2 to k do begin
		c:=0;
		for j:=1 to n do
			if t[j] mod i = 0 then inc(c);
		if c=n then gcd:=i;
	end;
	ans:=gcd;
end;

function lcm(t:tNum;n:word):longword;
var 
	i,k:longword;
	c,j:word;
begin
	lcm:=t[1];k:=t[1];
	for i:=2 to n do begin
		if lcm mod t[i] <> 0 then lcm:=lcm*t[i];
		if t[i]>k then k:=t[i];
	end;
	for i:=lcm-1 downto k do begin
		c:=0;
		for j:=1 to n do
			if i mod t[j] = 0 then inc(c);
		if c=n then lcm:=i;
	end;
	ans:=lcm;
end;

end.