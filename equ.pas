unit equ;
    
interface

uses 
	basic,math,lang,programStr,plot;

var 
    err:word;
    Vars:TVar;
    VarNum:word = 0;

function Equation(s:string):boolean;
function EquCheck(s:string):boolean;
function EquProcess(s:string):extended;
function VarPos(s:string):word;
procedure VarProcess(s:shortstring);
function VarCheck(s:string):boolean;
function Bool(s:string):boolean;
function eqn2(x,y,z:string):string;
function fact(num:Longword):string;
function NumInCheck(t:tStr;endNum:word):boolean;
function ArrayGcd(a:tNum;n,p:word):longword;
function ArrayLcm(a:tNum;n,p:word):longword;

implementation

function Equation(s:string):boolean;
begin
	Equation:=True;
	if (pos('=',s)<>0) and (pos('=',s)=poslast('=',s))
		then VarProcess(ClrSpace(s))
    else if (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('*',s)<>0)
	    or (pos('/',s)<>0) or (pos('^',s)<>0) then begin
		   	if Trunc(EquProcess(ClrSpace(s)))=EquProcess(ClrSpace(s)) then 
				write(EquProcess(ClrSpace(s)):0:0)
					else write(EquProcess(ClrSpace(s)):0:dec);
		end
    else Equation:=False;
	end;

function TrueFalse(s:string):boolean;
begin
	TrueFalse:=True;
    if (pos('=',s)<>0) and (pos('=',s)=poslast('=',s)) 
		or (pos('<',s)<>0) and (pos('<',s)=poslast('<',s)) 
		or (pos('>',s)<>0) and (pos('>',s)=poslast('>',s)) 
			then write(bool(ClrSpace(s)))
	else TrueFalse:=False;
end;

function EquCheck(s:string):boolean;
begin
	if (StAmt('(',s)>0) and (StAmt(')',s)>0) and (StAmt('(',s)<>StAmt(')',s)) then EquCheck:=False
		else EquCheck:=True;
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
	if (pos('+',s)<>0) and ((pos('+',s)<pos('(',s)) or (pos('+',s)>pos(')',s))) then begin
		NumProcess(s,pos('+',s),n1,n2);
		EquProcess:=n1+n2;
	end
	else if (pos('-',s)<>0) and ((pos('-',s)<pos('(',s)) or (pos('-',s)>pos(')',s))) then begin
		NumProcess(s,poslast('-',s),n1,n2);
		EquProcess:=n1-n2;
	end
	else if (pos('*',s)<>0) and (s<>'') and ((pos('*',s)<pos('(',s)) or (pos('*',s)>pos(')',s))) then begin
		NumProcess(s,pos('*',s),n1,n2);
		EquProcess:=n1*n2;
	end	
	else if (pos('/',s)<>0) and (s<>'') and ((pos('/',s)<pos('(',s)) or (pos('/',s)>pos(')',s))) then begin
		NumProcess(s,poslast('/',s),n1,n2);
		if (n2=0) then write(EReport(s,ErrorId2))
		else EquProcess:=n1/n2;
	end
	else if (pos('^',s)<>0) and (s<>'') and ((pos('^',s)<pos('(',s)) or (pos('^',s)>pos(')',s))) then begin
		NumProcess(s,pos('^',s),n1,n2);
		EquProcess:=Power(n1,n2);
	end
	else if (pos('(',s)<>0) and (pos(')',s)<>0) and (pos(')',s)-pos('(',s)>0) then 
		EquProcess:=EquProcess(copy(s,2,length(s)-2))
	else if (VarPos(s)<>0) and (Str2Num(s).check=False) then EquProcess:=Vars[VarPos(s)].value
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

function VarPos(s:string):word;
var i:word;
begin
	VarPos:=0;
	i:=0;
	while (i<=VarNum) and (s=Vars[i].vname) do begin
		inc(i);	
		if s=Vars[i].vname then VarPos:=i;
	end;
end;

procedure VarProcess(s:string);
var 
	str:shortstring;
	k:word;
    Bool:boolean;
	eq:Extended;
begin
	k:=pos('=',s);
	str:=UPCASE(copy(s,1,k-1));
	eq:=EquProcess(copy(s,k+1,(length(s)-k)));
	ans:=eq;
	if (str<>'DEC') then Bool:=True;
//	for k:=1 to length(s) do if s[k] in [symbol] then Bool:=False;
	if (Upcase(s[1]) in ['A'..'Z']) and (Bool=True) then begin
		if VarPos(str)=0 then	
		begin
			inc(VarNum);
			Vars[VarNum].vname:=str;
		end;
		Vars[VarPos(str)].value:=eq;
		if trunc(eq)=eq then write(str,' = ',eq:0:0)
			else write(str,' = ',eq:0:dec);
	end
	else write(EReport(str,ErrorId4))
end;

function VarCheck(s:string):boolean;
var i:word;
begin
	if Str2Num(s).check=True then VarCheck:=True
		else VarCheck:=False;
	for i:=0 to VarNum do
		if s=Vars[i].vname then VarCheck:=True;
end;

function eqn2(x,y,z:string):string;
var 
    a,b,c,delta:extended;
begin
	if (Str2Num(x).check=True) and (Str2Num(y).check=True) 
		and (Str2Num(z).check=True) then 
	begin
		a:=Str2Num(x).value;
		b:=Str2Num(y).value;
		c:=Str2Num(z).value;
 		if a<>0 then begin
		    delta:=(b*b-4*a*c);
	    	if delta<0 then eqn2:=eqn0Text
			else if delta=0 then eqn2:=eqn1Text+Num2Str((-b/2/a),dec)
    		else if delta>0 then begin
				eqn2:=eqn2Text;
				eqn2:=eqn2+'x1= '+Num2Str(((-b+sqrt(delta))/2/a),dec);
				eqn2:=eqn2+' | x2= '+Num2Str(((-b-sqrt(delta))/2/a),dec);
			end;
    	end
    	else eqn2:=EReport(Num2Str(a,dec),ErrorId1);
	end
	else eqn2:=(EReport('',ErrorId1));
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
	for i:=1 to endNum do 
		if (Str2Int(t[i]).check=false) or (Str2Int(t[i]).value<=0) or (t[i]=' ')
			then NumInCheck:=false;
	if NumInCheck=False then write(EReport('',ErrorId4));
end;

function GCD(a,b:longword):longword;
begin
    while a<>b do
        if a>b then a:=a-b else b:=b-a;
    GCD:=a;
end;  

function LCM(a,b:longword):longword;
begin
    LCM:=(a*b) div GCD(a,b);
end;

function ArrayLCM(a:tNum;n,p:word):longword;
begin
    if p<n-2 then ArrayLCM:=LCM(a[p],ArrayLCM(a,n,p+1))
        else ArrayLCM:=LCM(a[p],a[p+1]);
end;

function ArrayGCD(a:tNum;n,p:word):longword;
begin
    if p<n-2 then ArrayGCD:=GCD(a[p],ArrayGCD(a,n,p+1))
        else ArrayGCD:=GCD(a[p],a[p+1]);
end;

end.