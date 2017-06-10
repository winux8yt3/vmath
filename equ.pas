{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
unit equ;
    
interface

uses 
    basic,math,lang,programStr,plot;

function Variable(s:string;var c:string):boolean;
function Equation(s:string;var c:string):boolean;
function TrueFalse(s:string;var c:string):boolean;
function EquProcess(s:string):extended;
function VarPos(s:string):word;
function AssignVar(s:string;k:extended):extended;
procedure VarProcess(s:string;var c:string);
function VarCheck(s:string):boolean;
function Bool(s:string):boolean;
function eqn2(x,y,z:string):string;
function fact(num:int64):string;
function NumInCheck(t:tStr;endNum:word):boolean;
function ArrayGcd(a:tNum;n,p:word):longword;
function ArrayLcm(a:tNum;n,p:word):longword;
function Mu(x,i:int64):extended;
function Mu(x,i:extended):extended;

implementation

function Variable(s:string;var c:string):boolean;
begin
    Variable:=(pos(':',s)<>0) and (pos(':',s)=poslast(':',s));
    if Variable then VarProcess(CleanSpace(s),c);
end;

function EquChk(s:string):boolean;
begin
    if s='' then EquChk:=False
    else begin
        EquChk:=Str2Num(s).chk or IsVar(s);
        if not EquChk then begin
            EquChk:=(pos('*',s)>1) or (pos('+',s)>0) or (pos('-',s)>0) or (pos('/',s)>1) or (pos('^',s)>1);
            EquChk:=EquChk or (posC('cos(',s)>0) or (posC('sin(',s)>0) or (posC('tan(',s)>0) or (posC('cot(',s)>0);
            EquChk:=EquChk or (posC('log10(',s)>0) or (posC('abs(',s)>0) or (posC('trunc(',s)>0) or (posC('int(',s)>0);
        end;
    end;
    if not EquChk then errinp(s,1);
end;

function Equation(s:string;var c:string):boolean;
begin
    Equation:=EquChk(s);
    if Equation then c:=Num2Str(EquProcess(CleanSpace(s)));
end;

function TrueFalse(s:string;var c:string):boolean;
begin
    TrueFalse:=((pos('=',s)>0) or (pos('<',s)>0) or (pos('>',s)>0) or (pos('!',s)>0) or (pos('&',s)>0) or (pos('|',s)>0)) or Str2Bool(s).chk;
    if TrueFalse then c:=Bool2Str(bool(CleanSpace(s)));
end;

function NumProcess(s:string;k:byte; var n1,n2:extended):boolean;
begin
    NumProcess:=(k>0) and (k<length(s));
    if NumProcess then begin
        n1:=EquProcess(Trim(copy(s,1,k-1)));
        delete(s,1,k);
        n2:=EquProcess(Trim(s));
        NumProcess:=True and EquChk(Num2Str(n1)) and EquChk(Num2Str(n2));
    end;
    if not NumProcess then errinp(s,1);
end;

function BoolProcess(s:string;k:byte; var n1,n2:boolean):boolean;
begin
    BoolProcess:=(k>0) and (k<length(s));
    if BoolProcess then begin
        n1:=Bool(Trim(copy(s,1,k-1)));
        delete(s,1,k);
        n2:=Bool(Trim(s));
        BoolProcess:=EquChk(Bool2Str(n1)) and EquChk(Bool2Str(n2));
    end;
    if not BoolProcess then errinp(s,1);
end;

function EquProcess(s:string):extended;
var 
    n1,n2:extended;
begin
    if (s[1]='(') and (s[length(s)]=')') and (pos(')',s)=poslast(')',s)) and (pos('(',s)=poslast('(',s)) then s:=copy(s,2,length(s)-2);
    if not(length(s)>0) then errinp(s,1);
    if err.id<>0 then exit 
    else begin
        if Str2Num(s).chk then EquProcess:=Str2Num(s).val
        else if posequ('+',s)>1 then begin
            if NumProcess(s,posequ('+',s),n1,n2) then EquProcess:=n1+n2
        end
        else if poslastequ('-',s)>1 then begin
            if NumProcess(s,poslastequ('-',s),n1,n2) then EquProcess:=n1-n2
        end
        else if (posequ('*',s)>1) then begin
            if NumProcess(s,posequ('*',s),n1,n2) then EquProcess:=n1*n2
        end	
        else if (poslastequ('/',s)>1) then begin
            if (NumProcess(s,poslastequ('/',s),n1,n2)) then begin
                if (n2=0) then errinp(s,2) else EquProcess:=n1/n2;
            end
        end
        else if (pos('^',s)>1) then begin
            if NumProcess(s,posequ('^',s),n1,n2) then EquProcess:=Power(n1,n2)
        end 
        else if UPCASE(copy(s,1,4))='COS(' then begin
            delete(s,1,3);
            EquProcess:=Cos(EquProcess(s));
        end
        else if UPCASE(copy(s,1,4))='SIN(' then begin
            delete(s,1,3);
            EquProcess:=Sin(EquProcess(s));
        end
        else if UPCASE(copy(s,1,4))='TAN(' then begin
            delete(s,1,3);
            EquProcess:=Tan(EquProcess(s));
        end
        else if UPCASE(copy(s,1,4))='COT(' then begin
            delete(s,1,3);
            EquProcess:=COT(EquProcess(s));
        end
        else if UPCASE(copy(s,1,4))='ABS(' then begin
            delete(s,1,3);
            EquProcess:=Abs(EquProcess(s));
        end
        else if UPCASE(copy(s,1,6))='LOG10(' then begin
            delete(s,1,5);
            EquProcess:=Log10(EquProcess(s));
        end
        else if UPCASE(copy(s,1,6))='TRUNC(' then begin
            delete(s,1,5);
            EquProcess:=trunc(EquProcess(s));
        end
        else if UPCASE(copy(s,1,4))='INT(' then begin
            delete(s,1,3);
            EquProcess:=int(EquProcess(s));
        end
        else if IsVar(s) then EquProcess:=Vars[VarPos(Trim(copy(s,2,length(s)-1)))].val
        else errinp(s,1);
    end;
    if err.id>0 then exit;
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
begin
    VarPos:=0;
    while (VarPos<VarNum) and (s<>Vars[VarPos].vname) do inc(VarPos);
end;

function AssignVar(s:string;k:extended):extended;
begin
    if VarPos(s)=0 then
        begin
            inc(VarNum);
            Vars[VarNum].vname:=s;
        end;
    Vars[VarPos(s)].val:=k;
    AssignVar:=k;
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
    if IsName(str) and EquChk(s) then begin
        c:=c+Num2Str(EquProcess(s));
        AssignVar(str,EquProcess(s));
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

function Mu(x,i:int64):extended;
begin
    Mu:=Power(x,i);
end;

function Mu(x,i:extended):extended;
begin
    Mu:=Power(x,i);
end;

end.