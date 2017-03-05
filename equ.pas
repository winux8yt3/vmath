{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
unit equ;
    
interface

uses 
    basic,math,lang,programStr,plot;

var
    Vars:TVar;
    VarNum:word = 0;

function Variable(s:string;var c:string):boolean;
function Equation(s:string;var c:string):boolean;
function TrueFalse(s:string;var c:string):boolean;
function EquProcess(s:string):extended;
function VarPos(s:string):word;
procedure VarProcess(s:string;var c:string);
function VarCheck(s:string):boolean;
function Bool(s:string):boolean;
function eqn2(x,y,z:string):string;
function fact(num:int64):string;
function NumInCheck(t:tStr;endNum:word):boolean;
function ArrayGcd(a:tNum;n,p:word):longword;
function ArrayLcm(a:tNum;n,p:word):longword;

implementation

function Variable(s:string;var c:string):boolean;
begin
    Variable:=(pos(':',s)<>0) and (pos(':',s)=poslast(':',s));
    if Variable then VarProcess(CleanSpace(s),c);
end;

function EquChk(s:string):boolean;
begin
    EquChk:=((pos('*',s)<>0) or (pos('+',s)<>0) or (pos('-',s)<>0) or (pos('/',s)<>0) or (pos('^',s)<>0)) or (Str2Num(s).chk);
end;

function Equation(s:string;var c:string):boolean;
begin
    Equation:=EquChk(s);
    if Equation then c:=Num2Str(EquProcess(CleanSpace(s)));
end;

function TrueFalse(s:string;var c:string):boolean;
begin
    TrueFalse:=((pos('=',s)>0) or (pos('<',s)>0) or (pos('>',s)>0) or (pos('!',s)>0) or (pos('&',s)>0) or (pos('|',s)>0)) or Str2Bool(s).chk;
    if TrueFalse then c:=Bool2Str(bool(ClrSpace(s)));
end;

function NumProcess(s:string;k:byte; var n1,n2:extended):boolean;
begin
    NumProcess:=(k>1) and (k<length(s));
    if NumProcess then begin
        n1:=EquProcess(Trim(copy(s,1,k-1)));
        delete(s,1,k);
        n2:=EquProcess(Trim(copy(s,1,length(s))));
    end else errinp(s,1);
end;

function BoolProcess(s:string;k:byte; var n1,n2:boolean):boolean;
begin
    BoolProcess:=(k>1) and (k<length(s));
    if BoolProcess then begin
        n1:=Bool(Trim(copy(s,1,k-1)));
        delete(s,1,k);
        n2:=Bool(Trim(copy(s,1,length(s))));
    end;
end;

function EquProcess(s:string):extended;
var 
    n1,n2:extended;
begin
    if ((length(s)>0) and ((s[1]='/') or (s[1]='*'))) or not ValidStr(s) then errinp(s,1);
    if (s[1]='(') and (s[length(s)]=')') and (pos(')',s)=poslast(')',s)) and (pos('(',s)=poslast('(',s)) then s:=copy(s,2,length(s)-2);
    if err.id=0 then begin
        if Str2Num(s).chk and (s<>'') then EquProcess:=Str2Num(s).val
        else if IsVar(s) then EquProcess:=Vars[VarPos(s)].val
        else if posequ('+',s)>0 then begin
            if NumProcess(s,posequ('+',s),n1,n2) then EquProcess:=n1+n2
        end
        else if poslastequ('-',s)>0 then begin
            if NumProcess(s,poslastequ('-',s),n1,n2) then EquProcess:=n1-n2
        end
        else if (posequ('*',s)>0) and (s<>'') then begin
            if NumProcess(s,posequ('*',s),n1,n2) then EquProcess:=n1*n2
        end	
        else if (poslastequ('/',s)>0) and (s<>'') then begin
            if (NumProcess(s,poslastequ('/',s),n1,n2)) then begin
                if (n2=0) then errinp(s,2) else EquProcess:=n1/n2;
            end
        end
        else if (pos('^',s)>0) and (s<>'') then begin
            if NumProcess(s,posequ('^',s),n1,n2) then EquProcess:=Power(n1,n2)
        end else errinp(s,1);
    end;
    if err.id<>0 then exit;
end;
// Loop back EquProcess function if there is a complex Equation

function Bool(s:string):boolean;
var 
    n1,n2:extended;
    b1,b2:boolean;
begin
    if (s[1]='(') and (s[length(s)]=')') and (pos(')',s)=poslast(')',s)) and (pos('(',s)=poslast('(',s)) then s:=copy(s,2,length(s)-2);
    if (posequ('&',s)>0) then begin
        if BoolProcess(s,posequ('&',s),b1,b2) then bool:=b1 and b2;
    end;
    if (posequ('|',s)>0) then begin
        if BoolProcess(s,posequ('|',s),b1,b2) then bool:=b1 or b2;
    end
    else if (posequ('!',s)=1) then begin
        bool:=not Bool(Trim(copy(s,2,(length(s)-1))));
    end
    else if (posequ('=',s)>0) then begin
        if NumProcess(s,posequ('=',s),n1,n2) then bool:=n1=n2;
    end
    else if (posequ('<',s)>0) then begin
        if NumProcess(s,posequ('<',s),n1,n2) then bool:=n1<n2;
    end
    else if (posequ('>',s)>0) then begin
        if NumProcess(s,posequ('>',s),n1,n2) then bool:=n1>n2;
    end 
    else if Str2Bool(s).chk then bool:=Str2Bool(s).val
    else errinp(s,1);
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

procedure VarProcess(s:string;var c:string);
var 
    str:shortstring;
    k:word;
begin
    k:=pos(':',s);
    str:=CleanSpace(UPCASE(copy(s,1,k-1)));
    delete(str,1,1);
    delete(s,1,k);
    k:=0;
    c:=str+' = ';
    s:=Trim(s);
    if IsVar(str) and EquChk(s) then begin
        if VarPos(str)=0 then
        begin
            inc(VarNum);
            Vars[VarNum].vname:=str;
            Vars[VarNum].val:=0;
        end;
        Vars[VarPos(str)].val:=EquProcess(s);
        c:=c+Num2Str(EquProcess(s));
    end else errinp(str,1);
end;

function VarCheck(s:string):boolean;
var i:word;
begin
    VarCheck:=Str2Num(s).chk;
    for i:=0 to VarNum do
        if s=Vars[i].vname then VarCheck:=True;
end;

function eqn2(x,y,z:string):string;
var 
    a,b,c,delta:extended;
begin
    if (Str2Num(x).chk=True) and (Str2Num(y).chk=True) 
        and (Str2Num(z).chk=True) then 
    begin
        a:=Str2Num(x).val;
        b:=Str2Num(y).val;
        c:=Str2Num(z).val;
         if a<>0 then begin
            delta:=(b*b-4*a*c);
            if delta<0 then eqn2:=eqn0Text
            else if delta=0 then eqn2:=eqn1Text+'x1 = x2 = '+Num2Str((-b/2/a))
            else if delta>0 then begin
                eqn2:=eqn2Text;
                eqn2:=eqn2+'x1 = '+Num2Str(((-b+sqrt(delta))/2/a));
                eqn2:=eqn2+' | x2 = '+Num2Str(((-b-sqrt(delta))/2/a));
            end;
        end
        else begin 
            errinp(Num2Str(a),1);
        end;
    end
    else err.id:=1;
end;
    
function fact(num:int64):string;
var 
    t:byte;
    i,k:int64;
    chk:boolean=False;
begin
    fact:='';k:=num;
    i:=1;
    while i<k do begin
        inc(i);t:=0;
        while k mod i = 0 do begin
            k:=k div i;
            inc(t);
        end;
        if t>0 then begin
            if Chk then fact:=fact+' * ';
            Fact:=Fact+Num2Str(i);
            if t>1 then Fact:=Fact+'^'+Num2Str(t);
            if not Chk then Chk:=True;
        end;
    end;
end;

function NumInCheck(t:tStr;endNum:word):boolean;
var i:word=0;
begin
    NumInCheck:=true;
    while NumInCheck and (i<endNum) do begin
        inc(i);
        if not (Str2Int(t[i]).chk) or (Str2Int(t[i]).val<=0) or (t[i]=' ')
            then NumInCheck:=false;
    end;
    if NumInCheck=False then err.id:=4;
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