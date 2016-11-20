unit basic;

interface
    
uses
    crt,dos,programstr;

type 
	TStr2Num = record
		Check:boolean;
		Value:extended;
	end;
	TStr2Int = record
		Check:boolean;
		Value:longint;
	end;
	TStr2Bool = record
		Check:boolean;
		Value:boolean;
	end;	

function ClrSpace (s:string):string;
function CleanSpace(s:string):string;
function Num2Str (v:extended;d:integer):String;
function Str2Num (s:string):TStr2Num;
function Str2Int (s:string):TStr2Int;
function Str2Bool (s:string):TStr2Bool;
function PosLast (ch,s:string):word;
function Date():string;
function Time():string;
procedure TxColor(TColor:byte);
procedure BgColor(Bcolor:byte);
procedure Color(tcolor,BColor:byte);
procedure Msg(s:string);
function EReport(str:string;err:string):string;
function Trim(s:string):string;
function TrimLeft(s:string):string;
function TrimRight(s:string):string;
procedure Print(s:string);

implementation

function ClrSpace (s:string):string;
var p:byte;
begin
	p:=pos(' ',s);
	while p <> 0 do begin
		delete(s,p,1);
		p:=pos(' ',s);
	end;
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

function Num2Str (v:extended;d:integer):String;
begin
	Str(v:0:d,Num2Str);
end;

function Str2Num(s:string):TStr2Num;
var err:byte;
begin
	Str2Num.Check:=False;
 	val(s,Str2Num.value,err);
	if err=0 then Str2Num.Check:=True;
end;

function Str2Int (s:string):TStr2Int;
var err:byte;
begin
	Str2Int.Check:=False;
 	val(s,Str2Int.value,err);
	if err=0 then Str2Int.Check:=True;
end;

function Str2Bool (s:string):TStr2Bool;
begin
	Str2Bool.Check:=True;
	if upcase(s)='TRUE' then Str2Bool.value:=True
		else if upcase(s)='FALSE' then Str2Bool.value:=False
			else Str2Bool.Check:=False;
end;

function PosLast (ch,s:string):word;
var k:word;
begin
	PosLast:=0;k:=1;
	for k:=1 to length(s) do
		if ch=copy(s,k,length(ch)) then PosLast:=k;
end;

function Date():string;
	var 
		Year,Month,Day,Num : word;
	begin
		GetDate(Year,Month,Day,Num);
		Date:=Num2Str(Day,0)+'/'+Num2Str(Month,0)+'/'+Num2Str(Year,0)+'.';
	end;
	
function Time():string;
	var 
		Hr,Min,Sec,Milisec : word;
	begin
		GetTime(Hr,Min,Sec,Milisec);
        Time:=Num2Str(Hr,0)+':'+Num2Str(Min,0)+':'+Num2Str(Sec,0)+'.'+Num2Str(Milisec,0);
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

function EReport(str:string;err:string):string;
begin
	if ErrHide=False then EReport:='<'+str+'>:'+err;
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
begin
	delete(s,1,5);
	s:=trimleft(s);
	writeln(s);
end;

end.