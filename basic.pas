{
	Copyright (c) Winux8YT3.
	License Under MIT License. See LICENSE in root folder for license. 
}
unit basic;

interface
    
uses
    crt,dos,programstr;

type 
	TStr2Num = record
		Chk:boolean;
		Val:extended;
	end;
	TStr2Int = record
		Chk:boolean;
		Val:longint;
	end;
	TStr2Bool = record
		Chk:boolean;
		Val:boolean;
	end;	

function ClrSpace (s:string):string;
function CleanSpace(s:string):string;
function Num2Str (v:extended):String;
function Num2Str (v:int64):String;
function Str2Num (s:string):TStr2Num;
function Str2Int (s:string):TStr2Int;
function Str2Bool (s:string):TStr2Bool;
function Bool2Str(b:boolean):string;
function PosLast (ch,s:string):word;
function Date():string;
function Time():string;
procedure TxColor(TColor:byte);
procedure BgColor(Bcolor:byte);
procedure Color(tcolor,BColor:byte);
procedure Msg(s:string);
procedure Errinp(str:string;id:byte);
function EReport():string;
function Trim(s:string):string;
function TrimLeft(s:string):string;
function TrimRight(s:string):string;
procedure Print(s:string);
function IsInt(n:extended):boolean;
function ValidStr(s:string):boolean;
function PosEqu(ch,s:string):word;
function PosLastEqu(ch,s:string):word;
function PosC(ch,s:string):word;
function IsWord(s:string):boolean;
function IsVar(s:string):boolean;

implementation

uses lang,equ;

function ClrSpace (s:string):string;
begin
	while pos(' ',s) <> 0 do delete(s,pos(' ',s),1);
	ClrSpace:=s;
end;

function CleanSpace(s:string):string;
var i:byte;
begin
	s:=Trim(s);
	if (length(s)>0) and (pos(' ',s)<>0) then 
		for i:=1 to length(s) do
			while (s[i]=' ') and (s[i+1]=' ') do delete(s,i,1);
	CleanSpace:=s;
end;

function Num2Str(v:extended):String;
begin
    if IsInt(v) then Str(v:0:0,Num2Str) 
        else str(v:0:decn,Num2Str);
end;

function Num2Str(v:int64):String;
begin
	Str(v,Num2Str);
end;

function Str2Num(s:string):TStr2Num;
var err:byte;
begin
	Str2Num.chk:=False;
 	val(s,Str2Num.val,err);
	if err=0 then Str2Num.chk:=True;
end;

function Str2Int(s:string):TStr2Int;
var err:byte;
begin
 	val(s,Str2Int.val,err);
	Str2Int.chk:=(err=0) and IsInt(Str2Int.val);
end;

function Str2Bool (s:string):TStr2Bool;
begin
	Str2Bool.chk:=True;
	if upcase(s)='TRUE' then Str2Bool.val:=True
		else if upcase(s)='FALSE' then Str2Bool.val:=False
			else Str2Bool.chk:=False;
end;

function Bool2Str(b:boolean):string;
begin
	if b then Bool2Str:='TRUE' else Bool2Str:='FALSE';
end;

function PosLast(ch,s:string):word;
var k:word;
begin
	PosLast:=0;k:=1;
	for k:=1 to length(s)+1-length(ch) do
		if ch=copy(s,k,length(ch)) then PosLast:=k;
end;

function Date():string;
	var 
		Year,Month,Day,Num : word;
	begin
		GetDate(Year,Month,Day,Num);
		Date:=Num2Str(Day)+'/'+Num2Str(Month)+'/'+Num2Str(Year)+'.';
	end;
	
function Time():string;
	var 
		Hr,Min,Sec,Milisec : word;
	begin
		GetTime(Hr,Min,Sec,Milisec);
        Time:=Num2Str(Hr)+':'+Num2Str(Min)+':'+Num2Str(Sec)+'.'+Num2Str(Milisec);
	end;

procedure TxColor(TColor:byte);
begin
	TextColor(Tcolor);
end;

procedure BgColor(Bcolor:byte);
begin
	TextBackground(Bcolor);
end;

procedure Color(Tcolor,BColor:byte);
begin
	TXcolor(Tcolor);
	BGcolor(BColor);
end;

procedure Msg(s:string);
begin
	write(s);readln;
end;

procedure ErrInp(str:string;id:byte);
begin
    Err.str:=str;
    Err.id:=id;
end;
function EReport():string;
	function errid(id:byte):string;
	begin
		case id of
			1	:	errid:=ErrorID1;
			2	:	errid:=ErrorID2;
			3	:	errid:=ErrorID3;
			4	:	errid:=ErrorID4;
			5	:	errid:=ErrorID5;
		end;
	end;
begin
	EReport:='';
	if not ErrHide then EReport:='<'+Err.str+'>:'+ErrorTx+' ID '+Num2Str(err.id)+':'+errid(err.id);
end;

function Trim(s:string):string;
begin
	Trim:=TrimLeft(TrimRight(s));
end;

function TrimLeft(s:string):string;
begin
	while pos(' ',s)=1 do delete(s,1,1);
	TrimLeft:=s;
end;

function TrimRight(s:string):string;
begin
	if length(s)>0 then
		while poslast(' ',s)=length(s) do delete(s,length(s),1);
	TrimRight:=s;
end;

procedure Print(s:string);
var i:byte=0;
	st:string='';
begin
	delete(s,1,pos(' ',s));
	s:=trimleft(s);
	if s<>'.' then begin
		while i<length(s) do begin
			inc(i);
			if s[i]='_' then
				while (s[i]<>' ') and (i<length(s)) do begin
					inc(i);
					st:=st+s[i];
				end;
			if (st<>'') and IsVar(st) then begin
				i:=i-length(st);
				delete(s,i,length(st)+1);
				insert(Num2Str(Vars[VarPos(st)].val),s,i);
				st:='';
			end;
		end;
		write(s);
	end else writeln;
end;

function IsInt(n:extended):boolean;
begin
	IsInt:=Trunc(n)=n;
end;

function ValidStr(s:string):boolean;
    function IsDual(c1,c2:Char):Boolean;
    var 
        Chk:boolean=True;
        k:integer=0;
		i:byte=0;
    begin
        IsDual:=s<>'';
        while IsDual and (i<length(s)) do begin
			inc(i);
            if s[i]=#34 then Chk:=not Chk;
            if Chk then begin
                if s[i]=c1 then inc(k);
                if s[i]=c2 then dec(k);
            end;
            if k<0 then IsDual:=False;
        end;
        if k>0 then IsDual:=False;
    end;
begin
    ValidStr:=(s<>'') and IsDual('(',')') and IsDual('[',']');
end;

function PosEqu(ch,s:string):word;
var k:word=0;
	t:byte=0;
begin
	PosEqu:=0;
	while (PosEqu=0) and (k<length(s)+1-length(ch)) do begin
		inc(k);
		if s[k]='(' then inc(t);
		if s[k]=')' then dec(t);
		if (t=0) and (ch=copy(s,k,length(ch))) then posEqu:=k;
	end;
end;

function PosLastEqu(ch,s:string):word;
var k:word=0;
	t:byte=0;
begin
	PosLastEqu:=0;
	for k:=1 to length(s)+1-length(ch) do begin
		if s[k]='(' then inc(t);
		if s[k]=')' then dec(t);
		if (t=0) and (ch=copy(s,k,length(ch))) then posLastEqu:=k;
	end;
end;

function PosC(ch,s:string):word;
var k:word=0;
begin
	PosC:=0;
	while (k<length(s)+1-length(ch)) and (posC=0) do begin
		inc(k);
		if upcase(ch)=upcase(copy(s,k,length(ch))) then posC:=k;
	end;
end;

function IsWord(s:string):boolean;
var i:byte;
begin
	IsWord:=True;
	for i:=1 to length(s) do
		IsWord:=IsWord and (Upcase(s[i]) in ['A'..'Z']);
end;

function IsVar(s:string):boolean;
var i:byte;
begin
	IsVar:=True;
	for i:=1 to length(s) do IsVar:=IsVar and (IsWord(s[i]) or (Str2Int(s[i]).chk));
end;

end.